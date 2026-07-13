"""
Sinh so do quan he (relational schema diagram) truc tiep tu database/schema.sql.

Khac voi cac so do ERD chuan Chen (thuc the/thuoc tinh/quan he dang hinh thoi) da co
o thu muc goc, script nay ve dung 32 bang trong schema.sql duoi dang bang UML
(ten bang, cot, PK/FK) va noi FK -> PK bang mui ten, giup doi chieu truc tiep voi
code SQL da hien thuc.

Cach dung:
    python3 generate_relational_diagram.py
"""

import os
import re
import subprocess
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SCHEMA_FILE = os.path.join(SCRIPT_DIR, "schema.sql")
DOT_FILE = os.path.join(SCRIPT_DIR, "relational_schema.dot")
BASE_NAME = os.path.join(SCRIPT_DIR, "erd", "relational_schema")

# Nhom bang theo phan he nghiep vu de to mau/khung subgraph, dong bo voi complete_erd.dot
CLUSTERS = [
    ("Phần 1: Bệnh nhân & Tiếp đón", "#2B6CB0", "#F8FAFC",
     ["BENH_NHAN", "BAO_HIEM_YT", "LICH_HEN", "HO_SO_NHAP_VIEN", "BENH_AN"]),
    ("Phần 2: Chẩn đoán & Điều trị", "#319795", "#F5FDFD",
     ["CHAN_DOAN", "DON_THUOC", "CHI_TIET_DON_THUOC", "PHAC_DO_DIEU_TRI",
      "DICH_VU_YTE", "PHACDO_SUDUNG_DICHVU"]),
    ("Phần 3: Xét nghiệm & CĐHA", "#6B46C1", "#FAF5FF",
     ["THIET_BI_YTE", "DANH_MUC_XET_NGHIEM", "KET_QUA_XET_NGHIEM",
      "CHAN_DOAN_HINH_ANH", "MAU_BENH_PHAM"]),
    ("Phần 4: Nhân sự & Khoa phòng", "#DD6B20", "#FFFAF0",
     ["KHOA", "PHONG_BENH", "NHAN_VIEN", "BAC_SI", "DIEU_DUONG", "LICH_TRUC"]),
    ("Phần 5: Dược & Vật tư y tế", "#E53E3E", "#FFF5F5",
     ["NHA_CUNG_CAP", "DON_NHAP_HANG", "PHIEU_XUAT_KHO", "THUOC", "VAT_TU_YTE"]),
    ("Phần 6: Tài chính & Viện phí", "#4C51BF", "#F8FAFF",
     ["HOA_DON", "THANH_TOAN", "BOI_THUONG_BHYT", "GIAO_DICH", "HOADON_CHITIET_DICHVU"]),
]


def strip_comments(sql_text):
    """Remove '-- ...' line comments while keeping line structure intact."""
    return re.sub(r"--[^\n]*", "", sql_text)


def split_top_level(body, sep=","):
    """Split a string on `sep` but only at paren-depth 0 (so VARCHAR(50), NUMERIC(14,2)
    and PRIMARY KEY (a, b) are not split in the middle)."""
    parts = []
    depth = 0
    current = []
    for ch in body:
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        if ch == sep and depth == 0:
            parts.append("".join(current))
            current = []
        else:
            current.append(ch)
    if current:
        parts.append("".join(current))
    return [p.strip() for p in parts if p.strip()]


def parse_column(item):
    """Parse a single column definition line into a dict, or return None if this
    item is a table-level constraint (PRIMARY KEY (...) / CONSTRAINT ... CHECK)."""
    m = re.match(r"^(\w+)\s+([A-Za-z]+(?:\([0-9,\s]+\))?)(.*)$", item, re.IGNORECASE | re.DOTALL)
    if not m:
        return None
    name, col_type, rest = m.groups()
    col_type = re.sub(r"\s+", "", col_type)
    fk_match = re.search(r"REFERENCES\s+(\w+)\s*\(\s*(\w+)\s*\)", rest, re.IGNORECASE)
    return {
        "name": name,
        "type": col_type,
        "is_pk": bool(re.search(r"PRIMARY\s+KEY", rest, re.IGNORECASE)),
        "not_null": bool(re.search(r"NOT\s+NULL", rest, re.IGNORECASE)),
        "is_unique": bool(re.search(r"\bUNIQUE\b", rest, re.IGNORECASE)),
        "fk_table": fk_match.group(1) if fk_match else None,
        "fk_col": fk_match.group(2) if fk_match else None,
    }


def parse_schema(sql_text):
    """Parse CREATE TABLE / ALTER TABLE ... ADD COLUMN statements into a dict:
    { table_name: {"columns": [...], "checks": [constraint_name, ...]} }
    Raises ValueError if no CREATE TABLE statement is found (malformed input)."""
    sql_text = strip_comments(sql_text)
    statements = [s.strip() for s in sql_text.split(";") if s.strip()]

    tables = {}
    table_order = []

    create_re = re.compile(r"^CREATE\s+TABLE\s+(\w+)\s*\((.*)\)$", re.IGNORECASE | re.DOTALL)
    alter_re = re.compile(
        r"^ALTER\s+TABLE\s+(\w+)\s+ADD\s+COLUMN\s+(.*)$", re.IGNORECASE | re.DOTALL
    )

    for stmt in statements:
        create_match = create_re.match(stmt)
        if create_match:
            table_name, body = create_match.groups()
            table_name = table_name.upper()
            columns = []
            checks = []
            for item in split_top_level(body):
                pk_line = re.match(r"^PRIMARY\s+KEY\s*\(([^)]+)\)$", item, re.IGNORECASE)
                if pk_line:
                    pk_cols = {c.strip() for c in pk_line.group(1).split(",")}
                    for col in columns:
                        if col["name"] in pk_cols:
                            col["is_pk"] = True
                    continue
                check_line = re.match(r"^CONSTRAINT\s+(\w+)\s+CHECK", item, re.IGNORECASE)
                if check_line:
                    checks.append(check_line.group(1))
                    continue
                col = parse_column(item)
                if col:
                    columns.append(col)
            tables[table_name] = {"columns": columns, "checks": checks}
            table_order.append(table_name)
            continue

        alter_match = alter_re.match(stmt)
        if alter_match:
            table_name, col_def = alter_match.groups()
            table_name = table_name.upper()
            if table_name not in tables:
                raise ValueError(
                    f"ALTER TABLE {table_name} xuat hien truoc khi bang duoc CREATE TABLE."
                )
            col = parse_column(col_def.strip())
            if col:
                tables[table_name]["columns"].append(col)
            continue
        # CREATE INDEX va cac cau lenh khac: bo qua, khong anh huong den so do bang.

    if not tables:
        raise ValueError("Khong tim thay cau lenh CREATE TABLE nao trong schema.sql.")

    return tables, table_order


def is_one_to_one(table_def, column):
    """A FK column implies a 1:1 link only if it is UNIQUE, or if it is (alone) the
    entire primary key of its table. A column that is merely part of a composite PK
    (weak entity / junction table) does NOT guarantee uniqueness on its own."""
    if column["is_unique"]:
        return True
    pk_cols = [c["name"] for c in table_def["columns"] if c["is_pk"]]
    return len(pk_cols) == 1 and column["name"] in pk_cols


def html_escape(text):
    return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def build_table_node(table_name, table_def, header_color):
    rows = [
        f'<TR><TD BGCOLOR="{header_color}" COLSPAN="3">'
        f'<FONT COLOR="white" POINT-SIZE="12"><B>{html_escape(table_name)}</B></FONT></TD></TR>'
    ]
    for col in table_def["columns"]:
        tag = "PK" if col["is_pk"] else ("FK" if col["fk_table"] else "")
        tag_html = f"<B>{tag}</B>" if tag else "&nbsp;"
        name_html = html_escape(col["name"])
        if col["is_pk"]:
            name_html = f"<U><B>{name_html}</B></U>"
        elif col["fk_table"]:
            name_html = f"<I>{name_html}</I>"
        null_mark = "" if col["not_null"] or col["is_pk"] else " (null)"
        rows.append(
            "<TR>"
            f'<TD ALIGN="LEFT"><FONT POINT-SIZE="9" COLOR="#B45309">{tag_html}</FONT></TD>'
            f'<TD ALIGN="LEFT" PORT="{col["name"]}"><FONT POINT-SIZE="10">{name_html}</FONT></TD>'
            f'<TD ALIGN="LEFT"><FONT POINT-SIZE="8" COLOR="#666666">{html_escape(col["type"])}{null_mark}</FONT></TD>'
            "</TR>"
        )
    for check in table_def["checks"]:
        rows.append(
            '<TR><TD COLSPAN="3" ALIGN="LEFT">'
            f'<FONT POINT-SIZE="7" COLOR="#9F1239"><I>CHECK: {html_escape(check)}</I></FONT>'
            "</TD></TR>"
        )
    body = "\n        ".join(rows)
    return (
        f'    {table_name} [shape=plaintext, label=<\n'
        f'    <TABLE BORDER="1" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4" COLOR="#94A3B8">\n'
        f"        {body}\n"
        f"    </TABLE>>];"
    )


def generate_dot_file(tables, table_order, output_filepath):
    """Write the relational schema DOT file. Raises OSError if the file cannot be written."""
    cluster_of = {}
    for label, color, fill, names in CLUSTERS:
        for name in names:
            cluster_of[name] = (label, color, fill)

    lines = [
        "digraph RelationalSchema {",
        '    rankdir=LR;',
        '    bgcolor="#FFFFFF";',
        '    splines=ortho;',
        '    nodesep=0.6;',
        '    ranksep=1.1;',
        '    node [fontname="Arial"];',
        '    edge [fontname="Arial Bold", fontsize=10, color="#4A5568", arrowhead=normal, arrowsize=0.7];',
        "",
    ]

    for label, color, fill, names in CLUSTERS:
        cluster_id = re.sub(r"\W+", "_", label)
        lines.append(f'    subgraph cluster_{cluster_id} {{')
        lines.append(f'        label="{label}";')
        lines.append('        fontname="Arial Bold";')
        lines.append('        fontsize=14;')
        lines.append(f'        fontcolor="{color}";')
        lines.append('        style="filled,dashed";')
        lines.append(f'        fillcolor="{fill}";')
        lines.append(f'        color="{color}";')
        lines.append('        penwidth=1.5;')
        for name in names:
            if name not in tables:
                raise ValueError(f"Bang '{name}' duoc khai bao trong CLUSTERS nhung khong co trong schema.sql.")
            lines.append(build_table_node(name, tables[name], color))
        lines.append("    }")
        lines.append("")

    # Any table present in schema.sql but not assigned to a cluster still gets rendered
    unclustered = [t for t in table_order if t not in cluster_of]
    for name in unclustered:
        lines.append(build_table_node(name, tables[name], "#64748B"))

    lines.append("    // Foreign key connections")
    for table_name in table_order:
        table_def = tables[table_name]
        for col in table_def["columns"]:
            if not col["fk_table"]:
                continue
            if col["fk_table"] not in tables:
                continue
            card = "1" if is_one_to_one(table_def, col) else "N"
            lines.append(
                f'    {table_name}:{col["name"]}:e -> {col["fk_table"]}:{col["fk_col"]}:w '
                f'[taillabel="{card}", headlabel="1"];'
            )

    lines.append("}")

    try:
        with open(output_filepath, "w", encoding="utf-8") as f:
            f.write("\n".join(lines))
    except OSError as e:
        raise OSError(f"Khong the ghi file DOT '{output_filepath}': {e}") from e
    print(f"Generated DOT file: {output_filepath}")


def compile_dot_to_images(dot_filepath, base_output_name):
    """Compile DOT file to SVG and PNG using Graphviz. Returns True on success."""
    if not os.path.isfile(dot_filepath):
        print(f"Error: DOT file '{dot_filepath}' does not exist.")
        return False

    svg_output = f"{base_output_name}.svg"
    png_output = f"{base_output_name}.png"

    try:
        print(f"Compiling to SVG: {svg_output}...")
        subprocess.run(["dot", "-Tsvg", dot_filepath, "-o", svg_output], check=True)

        print(f"Compiling to PNG: {png_output}...")
        subprocess.run(["dot", "-Tpng", dot_filepath, "-o", png_output], check=True)

        print("Success! Relational schema diagram generated successfully.")
        return True
    except FileNotFoundError:
        print("Error: The 'dot' command-line tool (Graphviz) was not found on your system PATH.")
        print("Please ensure Graphviz is installed and added to your system environment variables.")
        return False
    except subprocess.CalledProcessError as e:
        print(f"Error executing Graphviz dot: {e}")
        return False
    except OSError as e:
        print(f"Unexpected OS error while running Graphviz dot: {e}")
        return False


if __name__ == "__main__":
    try:
        if not os.path.isfile(SCHEMA_FILE):
            raise FileNotFoundError(f"Khong tim thay '{SCHEMA_FILE}'.")

        print(f"Parsing {SCHEMA_FILE}...")
        with open(SCHEMA_FILE, "r", encoding="utf-8") as f:
            sql_text = f.read()

        tables, table_order = parse_schema(sql_text)
        print(f"Found {len(table_order)} tables.")

        generate_dot_file(tables, table_order, DOT_FILE)
    except (ValueError, OSError, FileNotFoundError) as e:
        print(f"Error: {e}")
        sys.exit(1)

    if not compile_dot_to_images(DOT_FILE, BASE_NAME):
        sys.exit(1)
