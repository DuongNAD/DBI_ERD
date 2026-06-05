import re
import subprocess
import os

# 1. SQL DDL Schema representing the Database Structure
# The Python script will parse this SQL syntax to generate the Entity-Relationship Diagram!
SQL_SCHEMA = """
CREATE TABLE KHOA (
    K_MaKhoa VARCHAR(50) PRIMARY KEY,
    K_TenKhoa VARCHAR(255),
    K_SoDien VARCHAR(20),
    K_ViTri VARCHAR(255)
);

CREATE TABLE PHONG_BENH (
    PB_MaPhong VARCHAR(50) PRIMARY KEY,
    PB_SoPhong VARCHAR(20),
    PB_LoaiPhong VARCHAR(50),
    PB_SucChua INT,
    PB_TrangThai VARCHAR(50),
    K_MaKhoa VARCHAR(50) REFERENCES KHOA(K_MaKhoa) -- BAO GỒM
);

CREATE TABLE NHAN_VIEN (
    NV_MaNV VARCHAR(50) PRIMARY KEY,
    NV_Ten VARCHAR(255),
    NV_NgaySinh DATE,
    NV_GioiTinh VARCHAR(10),
    NV_SDT VARCHAR(20),
    NV_CCCD VARCHAR(20),
    NV_VaiTro VARCHAR(50),
    K_MaKhoa VARCHAR(50) REFERENCES KHOA(K_MaKhoa) -- THUỘC KHOA
);

CREATE TABLE BAC_SI (
    BS_MaBS VARCHAR(50) PRIMARY KEY REFERENCES NHAN_VIEN(NV_MaNV), -- IS-A
    BS_ChuyenKhoa VARCHAR(255),
    BS_CapBac VARCHAR(50),
    BS_HocVi VARCHAR(50),
    BS_CCHN VARCHAR(50),
    BS_NamKN INT,
    K_MaKhoa VARCHAR(50) REFERENCES KHOA(K_MaKhoa) -- TRƯỞNG KHOA
);

CREATE TABLE DIEU_DUONG (
    DD_MaDD VARCHAR(50) PRIMARY KEY REFERENCES NHAN_VIEN(NV_MaNV), -- IS-A
    DD_CapBac VARCHAR(50),
    DD_CCHN VARCHAR(50)
);

CREATE TABLE LICH_TRUC (
    LT_MaLT VARCHAR(50) PRIMARY KEY,
    LT_Ngay DATE,
    LT_Ca VARCHAR(20),
    LT_TrangThai VARCHAR(50),
    LT_GhiChu TEXT,
    LT_TGBD TIMESTAMP,
    LT_TGKT TIMESTAMP,
    NV_MaNV VARCHAR(50) REFERENCES NHAN_VIEN(NV_MaNV), -- PHÂN CÔNG
    K_MaKhoa VARCHAR(50) REFERENCES KHOA(K_MaKhoa) -- QUẢN LÝ LỊCH
);
"""

# 2. Vietnamese translation dictionary for Entity and Attribute labels
TRANSLATIONS = {
    # Tables (Entities)
    "KHOA": "KHOA",
    "PHONG_BENH": "PHÒNG BỆNH",
    "NHAN_VIEN": "NHÂN VIÊN",
    "BAC_SI": "BÁC SĨ",
    "DIEU_DUONG": "ĐIỀU DƯỠNG",
    "LICH_TRUC": "LỊCH TRỰC",
    
    # Columns (Attributes)
    "K_MaKhoa": "Mã khoa",
    "K_TenKhoa": "Tên khoa",
    "K_SoDien": "Số điện thoại khoa",
    "K_ViTri": "Vị trí",
    
    "PB_MaPhong": "Mã phòng",
    "PB_SoPhong": "Số phòng",
    "PB_LoaiPhong": "Loại phòng",
    "PB_SucChua": "Sức chứa",
    "PB_TrangThai": "Trạng thái",
    
    "NV_MaNV": "Mã nhân viên",
    "NV_Ten": "Tên nhân viên",
    "NV_NgaySinh": "Ngày sinh",
    "NV_GioiTinh": "Giới tính",
    "NV_SDT": "Số điện thoại",
    "NV_CCCD": "Căn cước công dân",
    "NV_VaiTro": "Vai trò",
    
    "BS_MaBS": "Mã bác sĩ",
    "BS_ChuyenKhoa": "Chuyên khoa",
    "BS_CapBac": "Cấp bậc",
    "BS_HocVi": "Học vị",
    "BS_CCHN": "Chứng chỉ hành nghề",
    "BS_NamKN": "Năm kinh nghiệm",
    
    "DD_MaDD": "Mã điều dưỡng",
    "DD_CapBac": "Cấp bậc",
    "DD_CCHN": "Chứng chỉ hành nghề",
    
    "LT_MaLT": "Mã lịch trực",
    "LT_Ngay": "Ngày trực",
    "LT_Ca": "Ca làm việc",
    "LT_TrangThai": "Trạng thái",
    "LT_GhiChu": "Ghi chú",
    "LT_TGBD": "Thời gian bắt đầu",
    "LT_TGKT": "Thời gian kết thúc"
}

# 3. Specific Relationship Metadata (Cardinalities and Double-Line Styles)
# Format: (source_table, target_table, relationship_label) -> (source_card, target_card, total_participation_side)
# - source_table: table containing the FOREIGN KEY
# - target_table: referenced table
RELATIONSHIP_METADATA = {
    ("PHONG_BENH", "KHOA", "BAO GỒM"): ("N", "1", "source"),
    ("NHAN_VIEN", "KHOA", "THUỘC KHOA"): ("N", "1", "source"),
    ("BAC_SI", "KHOA", "TRƯỞNG KHOA"): ("1", "1", "target"),
    ("BAC_SI", "NHAN_VIEN", "IS-A"): ("1", "1", "source"),
    ("DIEU_DUONG", "NHAN_VIEN", "IS-A"): ("1", "1", "source"),
    ("LICH_TRUC", "NHAN_VIEN", "PHÂN CÔNG"): ("N", "1", "source"),
    ("LICH_TRUC", "KHOA", "QUẢN LÝ LỊCH"): ("N", "1", "source"),
}

def to_pascal_case(s):
    """Convert snake_case to PascalCase (e.g. PHONG_BENH -> PhongBenh)."""
    return "".join(word.capitalize() for word in s.split("_"))

def get_rel_id(label, table_name, ref_table):
    """Get the specific relationship node ID to match the original dot structure."""
    mapping = {
        "BAO GỒM": "BaoGom",
        "THUỘC KHOA": "ThuocKhoa",
        "TRƯỞNG KHOA": "TruongKhoa",
        "PHÂN CÔNG": "PhanCong",
        "QUẢN LÝ LỊCH": "QuanLyLich"
    }
    if label in mapping:
        return mapping[label]
    if label == "IS-A":
        if table_name == "BAC_SI":
            return "ISA1"
        if table_name == "DIEU_DUONG":
            return "ISA2"
        return "ISA"
    return f"Rel_{table_name}_{ref_table}"

def parse_sql_to_erd(sql_text):
    """
    Parse SQL CREATE TABLE statements to extract:
    - Entities (tables)
    - Attributes (columns) with PK indicators
    - Relationships (FK REFERENCES) with labels from comments
    """
    tables = {}
    relationships = []
    
    # Extract each CREATE TABLE block
    table_blocks = re.findall(r"CREATE\s+TABLE\s+(\w+)\s*\((.*?)\);", sql_text, re.DOTALL | re.IGNORECASE)
    
    for table_name, body in table_blocks:
        table_name = table_name.upper()
        entity_id = to_pascal_case(table_name)
        
        tables[table_name] = {
            "entity_id": entity_id,
            "label": TRANSLATIONS.get(table_name, table_name),
            "attributes": []
        }
        
        # Parse individual lines in the table definition
        lines = body.split("\n")
        for line in lines:
            line = line.strip()
            if not line:
                continue
            
            # Isolate comment if present
            comment = None
            if "--" in line:
                line, comment_part = line.split("--", 1)
                comment = comment_part.strip()
                line = line.strip()
                
            # Strip trailing comma
            if line.endswith(","):
                line = line[:-1].strip()
                
            # Match columns, PKs, FKs
            # Example: K_MaKhoa VARCHAR(50) PRIMARY KEY
            # Example: K_MaKhoa VARCHAR(50) REFERENCES KHOA(K_MaKhoa)
            match = re.match(
                r"^(\w+)\s+([\w()]+)(?:\s+(PRIMARY\s+KEY))?(?:\s+REFERENCES\s+(\w+)\((\w+)\))?$",
                line,
                re.IGNORECASE
            )
            
            if match:
                col_name = match.group(1)
                is_pk = bool(match.group(3))
                ref_table = match.group(4)
                
                # Check for relationships (FK Reference)
                if ref_table:
                    ref_table = ref_table.upper()
                    rel_label = comment if comment else "CÓ"
                    rel_id = get_rel_id(rel_label, table_name, ref_table)
                    
                    relationships.append({
                        "id": rel_id,
                        "label": rel_label,
                        "source_table": table_name,
                        "target_table": ref_table,
                        "source_entity": entity_id,
                        "target_entity": to_pascal_case(ref_table)
                    })
                    
                    # If this foreign key is also a Primary Key (e.g. BS_MaBS referencing NV_MaNV), keep it as attribute
                    if is_pk:
                        tables[table_name]["attributes"].append({
                            "id": col_name,
                            "label": TRANSLATIONS.get(col_name, col_name),
                            "is_pk": True
                        })
                else:
                    # Normal attribute column
                    tables[table_name]["attributes"].append({
                        "id": col_name,
                        "label": TRANSLATIONS.get(col_name, col_name),
                        "is_pk": is_pk
                    })
                    
    return tables, relationships

def generate_dot_file(tables, relationships, output_filepath):
    """Generate the Graphviz DOT syntax and write it to a file."""
    dot_lines = []
    
    # 1. Graph header & global styles
    dot_lines.append("graph ERD {")
    dot_lines.append("    layout=fdp;")
    dot_lines.append("    K=2.2;")
    dot_lines.append("    overlap=false;")
    dot_lines.append("    splines=true;")
    dot_lines.append("    sep=\"+35\";")
    dot_lines.append("    esep=\"+25\";")
    dot_lines.append("")
    dot_lines.append("    // Global settings")
    dot_lines.append("    bgcolor=\"#FFFFFF\";")
    dot_lines.append("    node [fontname=\"Arial\", fontsize=11, style=filled];")
    dot_lines.append("    edge [fontname=\"Arial Bold\", fontsize=11, color=\"#4A5568\", fontcolor=\"#1A202C\", penwidth=1.5, labeldistance=3.0];")
    dot_lines.append("")
    
    # 2. Phân hệ subgraph (Amber/Orange theme matching Part 4 of the ERD)
    dot_lines.append("    subgraph cluster_Part4 {")
    dot_lines.append("        label=\"Phân hệ Nhân sự & Khoa phòng\";")
    dot_lines.append("        fontname=\"Arial Bold\";")
    dot_lines.append("        fontsize=16;")
    dot_lines.append("        fontcolor=\"#DD6B20\";")
    dot_lines.append("        style=\"filled,dashed\";")
    dot_lines.append("        fillcolor=\"#FFFAF0\";")
    dot_lines.append("        color=\"#DD6B20\";")
    dot_lines.append("        penwidth=2.0;")
    dot_lines.append("")
    
    # 3. Entities (Tables)
    dot_lines.append("        // Entities")
    dot_lines.append("        node [shape=box, peripheries=1, penwidth=2.0, fillcolor=\"#FFFAF0\", color=\"#DD6B20\", fontcolor=\"#7B341E\", fontsize=13, style=\"filled,bold\"];")
    for table_name, table in tables.items():
        dot_lines.append(f'        {table["entity_id"]} [label="{table["label"]}"];')
    dot_lines.append("")
    
    # 4. Key Attributes (Primary Keys)
    dot_lines.append("        // Key Attributes")
    dot_lines.append("        node [shape=ellipse, peripheries=1, penwidth=1.5, fillcolor=\"#FEF3C7\", color=\"#D97706\", fontcolor=\"#78350F\", fontsize=10, style=\"filled,bold\"];")
    for table_name, table in tables.items():
        for attr in table["attributes"]:
            if attr["is_pk"]:
                dot_lines.append(f'        {attr["id"]} [label=<<u>{attr["label"]}</u>>];')
    dot_lines.append("")
    
    # 5. Normal Attributes
    dot_lines.append("        // Normal Attributes")
    dot_lines.append("        node [shape=ellipse, peripheries=1, penwidth=1.0, fillcolor=\"#FFFBEB\", color=\"#FDE047\", fontcolor=\"#78350F\", fontsize=9, style=filled];")
    for table_name, table in tables.items():
        for attr in table["attributes"]:
            if not attr["is_pk"]:
                dot_lines.append(f'        {attr["id"]} [label="{attr["label"]}"];')
    dot_lines.append("")
    
    # 6. Relationships (Diamonds)
    dot_lines.append("        // Relationships")
    dot_lines.append("        node [shape=diamond, peripheries=1, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\"];")
    
    # Collect unique relationships
    added_rel_ids = set()
    for rel in relationships:
        if rel["id"] not in added_rel_ids:
            dot_lines.append(f'        {rel["id"]} [label="{rel["label"]}"];')
            added_rel_ids.add(rel["id"])
    dot_lines.append("")
    
    # 7. Attribute Connections
    dot_lines.append("        // Attribute Connections")
    for table_name, table in tables.items():
        ent_id = table["entity_id"]
        for attr in table["attributes"]:
            dot_lines.append(f'        {ent_id} -- {attr["id"]};')
    dot_lines.append("")
    
    # 8. Relationship Connections
    dot_lines.append("        // Relationship Connections")
    for rel in relationships:
        source_table = rel["source_table"]
        target_table = rel["target_table"]
        rel_label = rel["label"]
        rel_id = rel["id"]
        source_ent = rel["source_entity"]
        target_ent = rel["target_entity"]
        
        # Determine cardinalities and total participation style
        meta = RELATIONSHIP_METADATA.get((source_table, target_table, rel_label))
        if meta:
            source_card, target_card, total_part = meta
        else:
            source_card, target_card, total_part = ("N", "1", None)
            
        # Connect Target (Referenced Table / "1" Side) to Relationship
        if total_part == "target":
            dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel="{target_card}", color="#4A5568:invis:#4A5568", penwidth=3];')
        else:
            dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel="{target_card}"];')
            
        # Connect Relationship to Source (Referencing Table / "N" or "1" Side)
        if total_part == "source":
            dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel="{source_card}", color="#4A5568:invis:#4A5568", penwidth=3];')
        else:
            dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel="{source_card}"];')
            
    dot_lines.append("    }")
    dot_lines.append("}")
    
    # Write to file
    with open(output_filepath, "w", encoding="utf-8") as f:
        f.write("\n".join(dot_lines))
    print(f"Generated DOT file: {output_filepath}")

def compile_dot_to_images(dot_filepath, base_output_name):
    """Compile DOT file to SVG and PNG using the system's Graphviz 'dot' tool."""
    svg_output = f"{base_output_name}.svg"
    png_output = f"{base_output_name}.png"
    
    try:
        # Generate SVG
        print(f"Compiling to SVG: {svg_output}...")
        subprocess.run(["dot", "-Tsvg", dot_filepath, "-o", svg_output], check=True)
        
        # Generate PNG
        print(f"Compiling to PNG: {png_output}...")
        subprocess.run(["dot", "-Tpng", dot_filepath, "-o", png_output], check=True)
        
        print("Success! ERD generated successfully.")
    except FileNotFoundError:
        print("Error: The 'dot' command-line tool (Graphviz) was not found on your system PATH.")
        print("Please ensure Graphviz is installed and added to your system environment variables.")
    except subprocess.CalledProcessError as e:
        print(f"Error executing Graphviz dot: {e}")

if __name__ == "__main__":
    dot_file = "NhanSu_KhoaPhong_Academic.dot"
    base_name = "NhanSu_KhoaPhong_Academic"
    
    # Step 1: Parse the SQL DDL
    print("Parsing SQL schema...")
    tables, relationships = parse_sql_to_erd(SQL_SCHEMA)
    
    # Step 2: Generate the Graphviz DOT code
    generate_dot_file(tables, relationships, dot_file)
    
    # Step 3: Compile DOT to SVG & PNG
    compile_dot_to_images(dot_file, base_name)
