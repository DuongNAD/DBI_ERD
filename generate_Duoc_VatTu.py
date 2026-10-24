import re
import subprocess
import os

# 1. Sơ đồ SQL DDL đại diện cho cấu trúc cơ sở dữ liệu
SQL_SCHEMA = """
CREATE TABLE NHA_CUNG_CAP (
    NCC_MaNCC VARCHAR(50) PRIMARY KEY,
    NCC_TenNCC VARCHAR(255),
    NCC_SDT VARCHAR(20),
    NCC_DiaChi VARCHAR(255),
    NCC_MST VARCHAR(50)
);

CREATE TABLE DON_NHAP_HANG (
    DNH_MaDon VARCHAR(50) PRIMARY KEY,
    DNH_NgayLap DATE,
    DNH_NgayNhap DATE,
    DNH_TrangThai VARCHAR(50),
    DNH_NguoiLap VARCHAR(100),
    NCC_MaNCC VARCHAR(50) REFERENCES NHA_CUNG_CAP(NCC_MaNCC) -- CUNG CẤP
);

CREATE TABLE THUOC (
    TH_MaThuoc VARCHAR(50) PRIMARY KEY,
    TH_TenThuongMai VARCHAR(255),
    TH_HoatChat VARCHAR(255),
    TH_KhoiLuong VARCHAR(50),
    TH_NhaSanXuat VARCHAR(255),
    TH_DangBaoBi VARCHAR(100),
    TH_DangBaoChe VARCHAR(100),
    TH_HanSuDung DATE
);

CREATE TABLE VAT_TU_Y_TE (
    VT_MaVatTu VARCHAR(50) PRIMARY KEY,
    VT_TenVatTu VARCHAR(255),
    VT_DonViTinh VARCHAR(50),
    VT_ChatLieu VARCHAR(100),
    VT_CongDung TEXT
);

CREATE TABLE PHIEU_XUAT_KHO (
    DNH_MaDon VARCHAR(50) REFERENCES DON_NHAP_HANG(DNH_MaDon), -- CHI TIẾT NHẬP
    PXK_SoLo VARCHAR(50) PRIMARY KEY,
    PXK_HSD DATE,
    PXK_SL INT,
    PXK_DonGia DECIMAL(15, 2),
    PXK_ThanhTien DECIMAL(15, 2),
    TH_MaThuoc VARCHAR(50) REFERENCES THUOC(TH_MaThuoc), -- GỒM THUỐC
    VT_MaVatTu VARCHAR(50) REFERENCES VAT_TU_Y_TE(VT_MaVatTu) -- GỒM VẬT TƯ
);
"""

# 2. Từ điển dịch tiếng Việt cho nhãn Thực thể và Thuộc tính
TRANSLATIONS = {
    # Thực thể (Bảng)
    "NHA_CUNG_CAP": "NHÀ CUNG CẤP",
    "DON_NHAP_HANG": "ĐƠN NHẬP HÀNG",
    "PHIEU_XUAT_KHO": "PHIẾU XUẤT KHO\\n(Chi tiết nhập)",
    "THUOC": "THUỐC",
    "VAT_TU_Y_TE": "VẬT TƯ Y TẾ",
    
    # Thuộc tính (Cột)
    "NCC_MaNCC": "Mã nhà cung cấp",
    "NCC_TenNCC": "Tên nhà cung cấp",
    "NCC_SDT": "Số điện thoại",
    "NCC_DiaChi": "Địa chỉ",
    "NCC_MST": "Mã số thuế",
    
    "DNH_MaDon": "Mã đơn nhập",
    "DNH_NgayLap": "Ngày lập",
    "DNH_NgayNhap": "Ngày nhập",
    "DNH_TrangThai": "Trạng thái",
    "DNH_NguoiLap": "Người lập",
    
    "PXK_SoLo": "Số lô",
    "PXK_HSD": "Hạn sử dụng",
    "PXK_SL": "Số lượng",
    "PXK_DonGia": "Đơn giá",
    "PXK_ThanhTien": "Thành tiền",
    
    "TH_MaThuoc": "Mã thuốc",
    "TH_TenThuongMai": "Tên thương mại",
    "TH_HoatChat": "Hoạt chất",
    "TH_KhoiLuong": "Khối lượng",
    "TH_NhaSanXuat": "Nhà sản xuất",
    "TH_DangBaoBi": "Dạng bao bì",
    "TH_DangBaoChe": "Dạng bào chế",
    "TH_HanSuDung": "Hạn sử dụng",
    
    "VT_MaVatTu": "Mã vật tư",
    "VT_TenVatTu": "Tên vật tư",
    "VT_DonViTinh": "Đơn vị tính",
    "VT_ChatLieu": "Chất liệu",
    "VT_CongDung": "Công dụng"
}

# 3. Siêu dữ liệu quan hệ chi tiết (Bản số và kiểu hiển thị nét đôi)
RELATIONSHIP_METADATA = {
    ("DON_NHAP_HANG", "NHA_CUNG_CAP", "CUNG CẤP"): ("N", "1", "source"),
    ("PHIEU_XUAT_KHO", "DON_NHAP_HANG", "CHI TIẾT NHẬP"): ("N", "1", "source"),
    ("PHIEU_XUAT_KHO", "THUOC", "GỒM THUỐC"): ("N", "1", "source"),
    ("PHIEU_XUAT_KHO", "VAT_TU_Y_TE", "GỒM VẬT TƯ"): ("N", "1", "source")
}

def to_pascal_case(s):
    """Chuyển đổi dạng snake_case thành PascalCase (ví dụ: NHA_CUNG_CAP -> NhaCungCap)."""
    return "".join(word.capitalize() for word in s.split("_"))

def get_rel_id(label, table_name, ref_table):
    """Lấy ID nút quan hệ cụ thể để khớp với cấu trúc DOT gốc."""
    mapping = {
        "CUNG CẤP": "CungCap",
        "CHI TIẾT NHẬP": "ChiTietNhap",
        "GỒM THUỐC": "GomThuoc",
        "GỒM VẬT TƯ": "GomVatTu"
    }
    if label in mapping:
        return mapping[label]
    return f"Rel_{table_name}_{ref_table}"

def parse_sql_to_erd(sql_text):
    """Phân tích các câu lệnh SQL CREATE TABLE để trích xuất Thực thể, Thuộc tính và Quan hệ."""
    tables = {}
    relationships = []
    
    table_blocks = re.findall(r"CREATE\s+TABLE\s+(\w+)\s*\((.*?)\);", sql_text, re.DOTALL | re.IGNORECASE)
    
    for table_name, body in table_blocks:
        table_name = table_name.upper()
        entity_id = to_pascal_case(table_name)
        
        tables[table_name] = {
            "entity_id": entity_id,
            "label": TRANSLATIONS.get(table_name, table_name),
            "attributes": []
        }
        
        lines = body.split("\n")
        for line in lines:
            line = line.strip()
            if not line:
                continue
            
            comment = None
            if "--" in line:
                line, comment_part = line.split("--", 1)
                comment = comment_part.strip()
                line = line.strip()
                
            if line.endswith(","):
                line = line[:-1].strip()
                
            match = re.match(
                r"^(\w+)\s+([\w()]+)(?:\s+(PRIMARY\s+KEY))?(?:\s+REFERENCES\s+(\w+)\((\w+)\))?$",
                line,
                re.IGNORECASE
            )
            
            if match:
                col_name = match.group(1)
                is_pk = bool(match.group(3))
                ref_table = match.group(4)
                
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
                    
                    if is_pk or "_FK" in col_name:
                        tables[table_name]["attributes"].append({
                            "id": col_name,
                            "label": TRANSLATIONS.get(col_name, col_name),
                            "is_pk": is_pk
                        })
                else:
                    tables[table_name]["attributes"].append({
                        "id": col_name,
                        "label": TRANSLATIONS.get(col_name, col_name),
                        "is_pk": is_pk
                    })
                    
    return tables, relationships

def generate_dot_file(tables, relationships, output_filepath):
    """Sinh mã nguồn Graphviz DOT và lưu ra file."""
    dot_lines = []
    
    # 1. Cấu hình đồ thị & kiểu dáng chung
    dot_lines.append("graph ERD {")
    dot_lines.append("    layout=fdp;")
    dot_lines.append("    K=2.2;")
    dot_lines.append("    overlap=false;")
    dot_lines.append("    splines=true;")
    dot_lines.append("    sep=\"+35\";")
    dot_lines.append("    esep=\"+25\";")
    dot_lines.append("")
    dot_lines.append("    // Thiết lập chung")
    dot_lines.append("    bgcolor=\"#FFFFFF\";")
    dot_lines.append("    node [fontname=\"Arial\", fontsize=11, style=filled];")
    dot_lines.append("    edge [fontname=\"Arial Bold\", fontsize=11, color=\"#4A5568\", fontcolor=\"#1A202C\", penwidth=1.5, labeldistance=3.0];")
    dot_lines.append("")
    
    # 2. Cụm subgraph phân hệ (Red Theme khớp với Phần 5 của ERD)
    dot_lines.append("    subgraph cluster_Part5 {")
    dot_lines.append("        label=\"Phân hệ Dược & Vật tư y tế\";")
    dot_lines.append("        fontname=\"Arial Bold\";")
    dot_lines.append("        fontsize=16;")
    dot_lines.append("        fontcolor=\"#E53E3E\";")
    dot_lines.append("        style=\"filled,dashed\";")
    dot_lines.append("        fillcolor=\"#FFF5F5\";")
    dot_lines.append("        color=\"#E53E3E\";")
    dot_lines.append("        penwidth=2.0;")
    dot_lines.append("")
    
    # 3. Thực thể (Bảng)
    dot_lines.append("        // Thực thể")
    for table_name, table in tables.items():
        if table_name == "PHIEU_XUAT_KHO":
            # Thực thể yếu (hai viền)
            dot_lines.append(f'        {table["entity_id"]} [shape=box, peripheries=2, penwidth=2.0, fillcolor=\"#FFF5F5\", color=\"#E53E3E\", fontcolor=\"#742A2A\", fontsize=13, style=\"filled,bold\", label=\"{table["label"]}\"];')
        else:
            dot_lines.append(f'        {table["entity_id"]} [shape=box, peripheries=1, penwidth=2.0, fillcolor=\"#FFF5F5\", color=\"#E53E3E\", fontcolor=\"#742A2A\", fontsize=13, style=\"filled,bold\", label=\"{table["label"]}\"];')
    dot_lines.append("")
    
    # 4. Thuộc tính khóa (Khóa chính)
    dot_lines.append("        // Thuộc tính khóa")
    for table_name, table in tables.items():
        for attr in table["attributes"]:
            if attr["is_pk"]:
                if attr["id"] == "PXK_SoLo":
                    # Khóa bộ phận của thực thể yếu (viền nét đứt, gạch chân)
                    dot_lines.append(f'        {attr["id"]} [shape=ellipse, peripheries=1, penwidth=1.5, fillcolor=\"#FFF1F2\", color=\"#FDA4AF\", fontcolor=\"#9F1239\", fontsize=9, style=\"filled,dashed\", label=<<font color=\"#9F1239\"><u>{attr["label"]}</u></font>>];')
                else:
                    dot_lines.append(f'        {attr["id"]} [shape=ellipse, peripheries=1, penwidth=1.5, fillcolor=\"#FEF3C7\", color=\"#D97706\", fontcolor=\"#78350F\", fontsize=10, style=\"filled,bold\", label=<<u>{attr["label"]}</u>>];')
    dot_lines.append("")
    
    # 5. Thuộc tính thông thường
    dot_lines.append("        // Thuộc tính thường")
    dot_lines.append("        node [shape=ellipse, peripheries=1, penwidth=1.0, fillcolor=\"#FFF1F2\", color=\"#FDA4AF\", fontcolor=\"#9F1239\", fontsize=9, style=filled];")
    for table_name, table in tables.items():
        for attr in table["attributes"]:
            if not attr["is_pk"]:
                dot_lines.append(f'        {attr["id"]} [label=\"{attr["label"]}\"];')
    dot_lines.append("")
    
    # 6. Mối quan hệ (Hình thoi)
    dot_lines.append("        // Mối quan hệ")
    added_rel_ids = set()
    for rel in relationships:
        if rel["id"] not in added_rel_ids:
            if rel["id"] == "ChiTietNhap":
                # Quan hệ xác định (hình thoi kép)
                dot_lines.append(f'        {rel["id"]} [shape=diamond, peripheries=2, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\", label=\"{rel["label"]}\"];')
            else:
                dot_lines.append(f'        {rel["id"]} [shape=diamond, peripheries=1, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\", label=\"{rel["label"]}\"];')
            added_rel_ids.add(rel["id"])
    dot_lines.append("")
    
    # 7. Kết nối Thuộc tính với Thực thể
    dot_lines.append("        // Kết nối Thuộc tính")
    for table_name, table in tables.items():
        ent_id = table["entity_id"]
        for attr in table["attributes"]:
            dot_lines.append(f'        {ent_id} -- {attr["id"]};')
    dot_lines.append("")
    
    # 8. Kết nối Thực thể với Mối quan hệ (Bản số)
    dot_lines.append("        // Kết nối Mối quan hệ")
    for rel in relationships:
        source_table = rel["source_table"]
        target_table = rel["target_table"]
        rel_label = rel["label"]
        rel_id = rel["id"]
        source_ent = rel["source_entity"]
        target_ent = rel["target_entity"]
        
        meta = RELATIONSHIP_METADATA.get((source_table, target_table, rel_label))
        if meta:
            source_card, target_card, total_part = meta
        else:
            source_card, target_card, total_part = ("N", "1", None)
            
        # Kết nối phía Bảng đích (1 bên nhánh "1")
        if total_part == "target":
            dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel=\"{target_card}\", color=\"#4A5568:invis:#4A5568\", penwidth=3];')
        else:
            dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel=\"{target_card}\"];')
            
        # Kết nối phía Bảng nguồn (Bên nhánh "N")
        if total_part == "source":
            dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel=\"{source_card}\", color=\"#4A5568:invis:#4A5568\", penwidth=3];')
        else:
            dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel=\"{source_card}\"];')
            
    dot_lines.append("    }")
    dot_lines.append("}")
    
    with open(output_filepath, "w", encoding="utf-8") as f:
        f.write("\n".join(dot_lines))
    print(f"Da sinh file DOT: {output_filepath}")

def compile_dot_to_images(dot_filepath, base_output_name):
    """Biên dịch file DOT thành SVG và PNG bằng Graphviz 'dot'."""
    svg_output = f"{base_output_name}.svg"
    png_output = f"{base_output_name}.png"
    
    try:
        print(f"Dang bien dich sang SVG: {svg_output}...")
        subprocess.run(["dot", "-Tsvg", dot_filepath, "-o", svg_output], check=True)
        print(f"Dang bien dich sang PNG: {png_output}...")
        subprocess.run(["dot", "-Tpng", dot_filepath, "-o", png_output], check=True)
        print("Thanh cong! ERD da duoc tao lap thanh cong.")
    except FileNotFoundError:
        print("Loi: Khong tim thay cong cu Graphviz 'dot' tren PATH he thong.")
    except subprocess.CalledProcessError as e:
        print(f"Loi khi thuc thi Graphviz dot: {e}")

if __name__ == "__main__":
    dot_file = "Duoc_VatTu_Academic.dot"
    base_name = "Duoc_VatTu_Academic"
    
    print("Dang phan tich so do SQL...")
    tables, relationships = parse_sql_to_erd(SQL_SCHEMA)
    generate_dot_file(tables, relationships, dot_file)
    compile_dot_to_images(dot_file, base_name)
