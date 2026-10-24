import re
import subprocess
import os

# 1. Sơ đồ SQL DDL đại diện cho cấu trúc cơ sở dữ liệu
SQL_SCHEMA = """
CREATE TABLE BENH_NHAN (
    BN_PatientID VARCHAR(50) PRIMARY KEY,
    BN_HoTen VARCHAR(255),
    BN_NgaySinh DATE,
    BN_GioiTinh VARCHAR(10),
    BN_SoDienThoai VARCHAR(20),
    BN_DiaChi VARCHAR(255),
    BN_Email VARCHAR(100)
);

CREATE TABLE BAO_HIEM_YT (
    BH_InsuranceID VARCHAR(50) PRIMARY KEY,
    BH_MaSoBHYT VARCHAR(50),
    BH_NhaCungCap VARCHAR(255),
    BH_NgayHieuLuc DATE,
    BH_NgayHetHan DATE,
    BN_PatientID VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID) -- CÓ
);

CREATE TABLE LICH_HEN (
    LH_AppointmentID VARCHAR(50) PRIMARY KEY,
    LH_NgayHen DATE,
    LH_GioHen TIME,
    LH_TrangThai VARCHAR(50),
    LH_LyDoKham TEXT,
    LH_PatientID_FK VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID) -- ĐẶT
);

CREATE TABLE HO_SO_NHAP_VIEN (
    HS_AdmissionID VARCHAR(50) PRIMARY KEY,
    HS_NgayNhapVien DATE,
    HS_NgayRaVien DATE,
    HS_LyDoNhapVien TEXT,
    HS_KhoaDieuTri VARCHAR(100),
    HS_TrangThai VARCHAR(50),
    HS_PatientID_FK VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID) -- NHẬP VIỆN
);

CREATE TABLE BENH_AN (
    BA_RecordID VARCHAR(50) PRIMARY KEY,
    BA_NgayTao TIMESTAMP,
    BA_ChanDoan TEXT,
    BA_DieuTri TEXT,
    BA_GhiChu TEXT,
    BA_PatientID_FK VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID), -- CÓ
    BA_AdmissionID_FK VARCHAR(50) REFERENCES HO_SO_NHAP_VIEN(HS_AdmissionID) -- TẠO TỪ
);
"""

# 2. Từ điển dịch tiếng Việt cho nhãn Thực thể và Thuộc tính
TRANSLATIONS = {
    # Thực thể (Bảng)
    "BENH_NHAN": "BỆNH NHÂN",
    "BAO_HIEM_YT": "BẢO HIỂM Y TẾ",
    "LICH_HEN": "LỊCH HẸN",
    "HO_SO_NHAP_VIEN": "HỒ SƠ NHẬP VIỆN",
    "BENH_AN": "BỆNH ÁN",
    
    # Thuộc tính (Cột)
    "BH_InsuranceID": "Mã bảo hiểm y tế",
    "BH_MaSoBHYT": "Mã số Bảo hiểm y tế",
    "BH_NhaCungCap": "Nhà cung cấp",
    "BH_NgayHieuLuc": "Ngày hiệu lực",
    "BH_NgayHetHan": "Ngày hết hạn",
    
    "BN_PatientID": "Mã bệnh nhân",
    "BN_HoTen": "Họ và tên",
    "BN_NgaySinh": "Ngày sinh",
    "BN_GioiTinh": "Giới tính",
    "BN_SoDienThoai": "Số điện thoại",
    "BN_DiaChi": "Địa chỉ",
    "BN_Email": "Email",
    
    "LH_AppointmentID": "Mã lịch hẹn",
    "LH_NgayHen": "Ngày hẹn",
    "LH_GioHen": "Giờ hẹn",
    "LH_TrangThai": "Trạng thái",
    "LH_LyDoKham": "Lý do khám",
    "LH_PatientID_FK": "Mã bệnh nhân (FK)",
    
    "HS_AdmissionID": "Mã hồ sơ nhập viện",
    "HS_NgayNhapVien": "Ngày nhập viện",
    "HS_NgayRaVien": "Ngày ra viện",
    "HS_LyDoNhapVien": "Lý do nhập viện",
    "HS_KhoaDieuTri": "Khoa điều trị",
    "HS_TrangThai": "Trạng thái",
    "HS_PatientID_FK": "Mã bệnh nhân (FK)",
    
    "BA_RecordID": "Mã bệnh án",
    "BA_NgayTao": "Ngày tạo",
    "BA_ChanDoan": "Chẩn đoán",
    "BA_DieuTri": "Điều trị",
    "BA_GhiChu": "Ghi chú",
    "BA_PatientID_FK": "Mã bệnh nhân (FK)",
    "BA_AdmissionID_FK": "Mã hồ sơ nhập viện (FK)"
}

# 3. Siêu dữ liệu quan hệ chi tiết (Bản số và kiểu hiển thị nét đôi)
# Định dạng: (bảng_nguồn, bảng_đích, nhãn_quan_hệ) -> (bản_số_nguồn, bản_số_đích, phía_tham_gia_toàn_phần)
RELATIONSHIP_METADATA = {
    ("BAO_HIEM_YT", "BENH_NHAN", "CÓ"): ("1", "1", "source"),
    ("LICH_HEN", "BENH_NHAN", "ĐẶT"): ("N", "1", "source"),
    ("HO_SO_NHAP_VIEN", "BENH_NHAN", "NHẬP VIỆN"): ("N", "1", "source"),
    ("BENH_AN", "BENH_NHAN", "CÓ"): ("N", "1", "source"),
    ("BENH_AN", "HO_SO_NHAP_VIEN", "TẠO TỪ"): ("N", "1", "source")
}

def to_pascal_case(s):
    """Chuyển đổi dạng snake_case thành PascalCase (ví dụ: BENH_NHAN -> BenhNhan)."""
    return "".join(word.capitalize() for word in s.split("_"))

def get_rel_id(label, table_name, ref_table):
    """Lấy ID nút quan hệ cụ thể để khớp với cấu trúc DOT gốc."""
    mapping = {
        "CÓ": "CoInsurance" if table_name == "BAO_HIEM_YT" else "CoRecord",
        "ĐẶT": "DatAppointment",
        "NHẬP VIỆN": "NhapVien",
        "TẠO TỪ": "TaoTu"
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
    
    # 2. Cụm subgraph phân hệ (Theme màu xanh dương khớp với Phần 1 của ERD)
    dot_lines.append("    subgraph cluster_Part1 {")
    dot_lines.append("        label=\"Phân hệ Bệnh nhân & Tiếp đón\";")
    dot_lines.append("        fontname=\"Arial Bold\";")
    dot_lines.append("        fontsize=16;")
    dot_lines.append("        fontcolor=\"#2B6CB0\";")
    dot_lines.append("        style=\"filled,dashed\";")
    dot_lines.append("        fillcolor=\"#F8FAFC\";")
    dot_lines.append("        color=\"#2B6CB0\";")
    dot_lines.append("        penwidth=2.0;")
    dot_lines.append("")
    
    # 3. Thực thể (Bảng)
    dot_lines.append("        // Thực thể")
    dot_lines.append("        node [shape=box, peripheries=1, penwidth=2.0, fillcolor=\"#EBF8FF\", color=\"#2B6CB0\", fontcolor=\"#1A365D\", fontsize=13, style=\"filled,bold\"];")
    for table_name, table in tables.items():
        dot_lines.append(f'        {table["entity_id"]} [label="{table["label"]}"];')
    dot_lines.append("")
    
    # 4. Thuộc tính khóa (Khóa chính)
    dot_lines.append("        // Thuộc tính khóa")
    dot_lines.append("        node [shape=ellipse, peripheries=1, penwidth=1.5, fillcolor=\"#FEF3C7\", color=\"#D97706\", fontcolor=\"#78350F\", fontsize=10, style=\"filled,bold\"];")
    for table_name, table in tables.items():
        for attr in table["attributes"]:
            if attr["is_pk"]:
                dot_lines.append(f'        {attr["id"]} [label=<<u>{attr["label"]}</u>>];')
    dot_lines.append("")
    
    # 5. Thuộc tính thông thường
    dot_lines.append("        // Thuộc tính thường")
    dot_lines.append("        node [shape=ellipse, peripheries=1, penwidth=1.0, fillcolor=\"#F0F9FF\", color=\"#93C5FD\", fontcolor=\"#1E3A8A\", fontsize=9, style=filled];")
    for table_name, table in tables.items():
        for attr in table["attributes"]:
            if not attr["is_pk"]:
                dot_lines.append(f'        {attr["id"]} [label="{attr["label"]}"];')
    dot_lines.append("")
    
    # 6. Mối quan hệ (Hình thoi)
    dot_lines.append("        // Mối quan hệ")
    dot_lines.append("        node [shape=diamond, peripheries=1, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\"];")
    
    added_rel_ids = set()
    for rel in relationships:
        if rel["id"] not in added_rel_ids:
            dot_lines.append(f'        {rel["id"]} [label="{rel["label"]}"];')
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
            dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel="{target_card}", color="#4A5568:invis:#4A5568", penwidth=3];')
        else:
            dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel="{target_card}"];')
            
        # Kết nối phía Bảng nguồn (Bên nhánh "N" hoặc "1")
        if total_part == "source":
            dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel="{source_card}", color="#4A5568:invis:#4A5568", penwidth=3];')
        else:
            dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel="{source_card}"];')
            
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
    dot_file = "BenhNhan_TiepDon_Academic.dot"
    base_name = "BenhNhan_TiepDon_Academic"
    
    print("Dang phan tich so do SQL...")
    tables, relationships = parse_sql_to_erd(SQL_SCHEMA)
    generate_dot_file(tables, relationships, dot_file)
    compile_dot_to_images(dot_file, base_name)
