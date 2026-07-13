# Cơ sở dữ liệu Hệ thống Quản lý Bệnh viện

Tài liệu này mô tả chi tiết mô hình dữ liệu của hệ thống, được suy ra từ sơ đồ ERD chuẩn Chen
(`complete_erd.dot` ở thư mục gốc repo) và hiện thực hóa thành schema quan hệ tại
[`schema.sql`](./schema.sql).

## Nội dung thư mục

```
database/
├── README.md                       Tài liệu này
├── schema.sql                      Toàn bộ DDL (CREATE TABLE) cho 30 thực thể + bảng trung gian
├── generate_relational_diagram.py  Sinh so_do_quan_he/*.svg,.png truc tiep tu schema.sql
├── relational_schema.dot           DOT nguồn của sơ đồ quan hệ (sinh tự động, có thể xoá/tạo lại)
└── erd/                            Sơ đồ ERD dạng SVG (conceptual + relational)
    ├── part1_benhnhan_tiepdon.svg
    ├── part2_chandoan_dieutri.svg
    ├── part3_xetnghiem_cdha.svg
    ├── part4_nhansu_khoaphong.svg
    ├── part5_duoc_vattu.svg
    ├── part6_taichinh_vienphi.svg
    ├── complete_erd.svg
    └── relational_schema.svg / .png   Sơ đồ quan hệ (bảng + PK/FK) sinh từ schema.sql
```

### Hai loại sơ đồ, hai mục đích khác nhau

- **ERD chuẩn Chen** (`part1..6`, `complete_erd`): mô hình khái niệm — thực thể, thuộc tính (hình
  oval riêng), quan hệ (hình thoi). Phù hợp để trình bày/phân tích nghiệp vụ.
- **Sơ đồ quan hệ** (`relational_schema.svg`): mô hình vật lý — đúng 33 bảng thật sự có trong
  `schema.sql`, mỗi bảng hiển thị tên cột, kiểu dữ liệu, đánh dấu `PK`/`FK`, và mũi tên nối khóa
  ngoại → khóa chính kèm cardinality (`1`/`N`). Sinh tự động bằng
  [`generate_relational_diagram.py`](./generate_relational_diagram.py), nên **luôn khớp với code
  SQL hiện tại** — sửa `schema.sql` xong chỉ cần chạy lại script là sơ đồ tự cập nhật theo.

Muốn xem trực quan cả 6 phần + sơ đồ toàn cảnh cùng chú thích ký hiệu Chen, mở
[`../view_erds.html`](../view_erds.html) — file này đã được đồng bộ để hiển thị đủ 6 phân hệ.

## Tổng quan mô hình

6 phân hệ nghiệp vụ, 30 thực thể:

| # | Phân hệ | Thực thể | Sơ đồ |
|---|---------|----------|-------|
| 1 | Bệnh nhân & Tiếp đón | Bệnh nhân, Bảo hiểm y tế, Lịch hẹn, Hồ sơ nhập viện, Bệnh án | `erd/part1_benhnhan_tiepdon.svg` |
| 2 | Chẩn đoán & Điều trị | Chẩn đoán, Đơn thuốc, Chi tiết đơn thuốc, Phác đồ điều trị, Dịch vụ y tế | `erd/part2_chandoan_dieutri.svg` |
| 3 | Xét nghiệm & CĐHA | Thiết bị y tế, Danh mục xét nghiệm, Kết quả xét nghiệm, Chẩn đoán hình ảnh, Mẫu bệnh phẩm | `erd/part3_xetnghiem_cdha.svg` |
| 4 | Nhân sự & Khoa phòng | Khoa, Phòng bệnh, Nhân viên, Bác sĩ, Điều dưỡng, Lịch trực | `erd/part4_nhansu_khoaphong.svg` |
| 5 | Dược & Vật tư y tế | Nhà cung cấp, Đơn nhập hàng, Phiếu xuất kho, Thuốc, Vật tư y tế | `erd/part5_duoc_vattu.svg` |
| 6 | Tài chính & Viện phí | Hóa đơn, Thanh toán, Bồi thường BHYT, Giao dịch | `erd/part6_taichinh_vienphi.svg` |

Bệnh nhân & Bệnh án là điểm liên thông trung tâm nối 6 phân hệ (xem `erd/complete_erd.svg`).

## Quy ước chung

- Mọi khóa chính đều là mã nghiệp vụ dạng chuỗi (`VARCHAR(50)`, ví dụ `BN0001`), theo đúng quy ước
  đã dùng trong `generate_erd_from_sql.py`.
- Dialect mục tiêu: **PostgreSQL**. Phần lớn cú pháp tương thích MySQL 8+; nếu dùng MySQL cần đổi
  `TEXT`→giữ nguyên (MySQL hỗ trợ), `TIMESTAMP`→giữ nguyên, nhưng bỏ cú pháp
  `ALTER TABLE ... ADD COLUMN ... UNIQUE` (MySQL yêu cầu tách UNIQUE thành `ADD CONSTRAINT` riêng).
- Tất cả bảng đã được kiểm tra cú pháp cấu trúc bằng SQLite trước khi bàn giao (33/33 câu
  `CREATE TABLE` chạy thành công); các câu `ALTER TABLE ... UNIQUE` và
  `ALTER TABLE ... ADD CONSTRAINT ... CHECK` chỉ thất bại trên SQLite do giới hạn riêng của SQLite
  (không hỗ trợ 2 cú pháp này qua ALTER TABLE), không phải lỗi cú pháp SQL chuẩn — cả hai đều hợp lệ
  trên PostgreSQL.

## Các quyết định thiết kế đáng chú ý

### 0. Quan hệ đệ quy và tam nguyên
Mô hình gốc (`complete_erd.dot`) chỉ có quan hệ nhị nguyên (1:1/1:N/M:N). Để minh họa đầy đủ các
loại quan hệ trong phân tích ERD, đã bổ sung:
- **Đệ quy (recursive)**: `BAC_SI.BS_MaBS_ThamVan` tự tham chiếu tới `BAC_SI(BS_MaBS)` — một bác sĩ
  có thể tham vấn (0..1) một bác sĩ khác; một bác sĩ có thể được (0..N) đồng nghiệp khác tham vấn.
- **Tam nguyên (ternary)**: bảng `THUC_HIEN_DICH_VU` nối đồng thời `BAC_SI`, `BENH_NHAN`,
  `DICH_VU_YTE` — ghi nhận "bác sĩ nào thực hiện dịch vụ nào cho bệnh nhân nào". Không thể tách
  thành 2 quan hệ nhị nguyên độc lập mà không mất thông tin (ví dụ tách `BAC_SI`–`BENH_NHAN` và
  `BENH_NHAN`–`DICH_VU_YTE` riêng sẽ không còn biết chính xác bác sĩ nào thực hiện dịch vụ nào).

### 1. Thực thể yếu (weak entity): `PHIEU_XUAT_KHO`
Trong sơ đồ gốc, "PHIẾU XUẤT KHO (Chi tiết nhập)" là thực thể yếu phụ thuộc vào `DON_NHAP_HANG`,
với khóa bộ phận (partial key) là **Số lô**. Khóa chính đầy đủ = `(DNH_MaDon, PXK_SoLo)`.

Một phiếu xuất kho chỉ có thể chứa **đúng một trong hai**: một lô Thuốc hoặc một lô Vật tư y tế
(không phải cả hai) — ràng buộc này được thực hiện bằng `CHECK` constraint
`chk_phieuxuatkho_mot_loai`.

### 2. Quan hệ M:N → bảng trung gian
- `PHAC_DO_DIEU_TRI` (M) — `SỬ DỤNG` — `DICH_VU_YTE` (N) ⇒ bảng `PHACDO_SUDUNG_DICHVU`.
- `DICH_VU_YTE` (M) — `CHI TIẾT DỊCH VỤ` — `HOA_DON` (N) ⇒ bảng `HOADON_CHITIET_DICHVU`
  (có thêm `SoLuong`, `ThanhTien` để ghi chi tiết từng dòng dịch vụ trên hóa đơn — mở rộng hợp lý so
  với sơ đồ gốc vì hóa đơn cần biết số lượng/thành tiền từng dịch vụ).

### 3. Nguồn gốc đa hình (polymorphic source) của `GIAO_DICH`
Sơ đồ gốc cho phép `GIAO_DICH` phát sinh từ **hoặc** `THANH_TOAN` **hoặc** `BOI_THUONG_BHYT`. Cả hai
khóa ngoại `TT_MaTT` và `BT_MaQuyetToan` đều nullable, ràng buộc `CHECK` đảm bảo đúng một trong hai
luôn được set (`chk_giaodich_mot_nguon`).

### 4. Khóa ngoại vòng (circular FK): `KHOA` ⇄ `BAC_SI`
Sơ đồ gốc có quan hệ **TRƯỞNG KHOA** (1:1, ràng buộc toàn phần phía `KHOA` — mọi khoa đều phải có
đúng 1 trưởng khoa). Đặt khóa ngoại đúng chuẩn phải nằm ở `KHOA` trỏ tới `BAC_SI`, nhưng điều này tạo
chu trình phụ thuộc:

```
KHOA → BAC_SI → NHÂN_VIÊN → KHOA
```

Không thể tạo cả 3 bảng cùng lúc nếu ràng buộc `NOT NULL` được áp cho cả 3 khóa ngoại trong vòng.
Giải pháp trong `schema.sql`:
1. Tạo `KHOA` trước, không có cột trưởng khoa.
2. Tạo `NHAN_VIEN`, `BAC_SI` tham chiếu tới `KHOA` bình thường.
3. Thêm cột `KHOA.BS_MaBS_TruongKhoa` bằng `ALTER TABLE` sau cùng, để **nullable** (ràng buộc "toàn
   phần" của mô hình khái niệm được nới lỏng ở tầng vật lý — đây là đánh đổi thực tế thường gặp khi
   hiện thực hóa quan hệ vòng; ứng dụng/quy trình nghiệp vụ chịu trách nhiệm đảm bảo mọi khoa cuối
   cùng đều được gán trưởng khoa).

Tương tự, các khóa ngoại liên phân hệ khác cũng được thêm bằng `ALTER TABLE` ở cuối file
(`HO_SO_NHAP_VIEN.K_MaKhoa`, `HO_SO_NHAP_VIEN.PB_MaPhong`, `CHAN_DOAN.BS_MaBS`,
`DON_THUOC.BS_MaBS`, `CHI_TIET_DON_THUOC.TH_MaThuoc`) vì các phân hệ liên quan (4, 5) được định
nghĩa sau các phân hệ tham chiếu tới chúng (1, 2) trong file.

### 5. Chuẩn hóa các khóa ngoại "để trống trong sơ đồ gốc"
Một số thuộc tính trong `complete_erd.dot` chỉ mô tả bằng text (ví dụ `HS_KhoaDieuTri` = "Khoa điều
trị") thay vì khóa ngoại tường minh, trong khi sơ đồ vẫn vẽ quan hệ (`Khoa -- ĐIỀU TRỊ TẠI -- Hồ sơ
nhập viện`). `schema.sql` chuẩn hóa các trường hợp này thành khóa ngoại thật (`K_MaKhoa`,
`PB_MaPhong` trên `HO_SO_NHAP_VIEN`) để đảm bảo toàn vẹn tham chiếu thay vì lưu chuỗi tự do.

## Bảng tổng hợp quan hệ chính (cardinality)

| Quan hệ | Bên 1 | Bên N/M | Ràng buộc toàn phần | Hiện thực hóa |
|---|---|---|---|---|
| CÓ (bảo hiểm) | BAO_HIEM_YT | BENH_NHAN | BAO_HIEM_YT | FK `BAO_HIEM_YT.BN_MaBN` NOT NULL UNIQUE |
| ĐẶT | BENH_NHAN | LICH_HEN (N) | LICH_HEN | FK `LICH_HEN.BN_MaBN` NOT NULL |
| NHẬP VIỆN | BENH_NHAN | HO_SO_NHAP_VIEN (N) | HO_SO_NHAP_VIEN | FK `HO_SO_NHAP_VIEN.BN_MaBN` NOT NULL |
| CÓ (bệnh án) | BENH_NHAN | BENH_AN (N) | BENH_AN | FK `BENH_AN.BN_MaBN` NOT NULL |
| TẠO TỪ | BENH_AN (N) | HO_SO_NHAP_VIEN | không (2 phía partial) | FK `BENH_AN.HS_MaHoSo` nullable |
| CÓ ĐƠN THUỐC | CHAN_DOAN | DON_THUOC (N) | DON_THUOC | FK `DON_THUOC.CD_MaChanDoan` NOT NULL |
| CÓ CHI TIẾT | DON_THUOC | CHI_TIET_DON_THUOC (N) | CHI_TIET_DON_THUOC | FK NOT NULL |
| CÓ PHÁC ĐỒ | CHAN_DOAN | PHAC_DO_DIEU_TRI (N) | PHAC_DO_DIEU_TRI | FK NOT NULL |
| SỬ DỤNG | PHAC_DO_DIEU_TRI (M) | DICH_VU_YTE (N) | — | bảng `PHACDO_SUDUNG_DICHVU` |
| THỰC HIỆN (CĐHA) | THIET_BI_YTE | CHAN_DOAN_HINH_ANH (N) | CHAN_DOAN_HINH_ANH | FK NOT NULL |
| THUỘC (danh mục XN) | DANH_MUC_XET_NGHIEM | KET_QUA_XET_NGHIEM (N) | KET_QUA_XET_NGHIEM | FK NOT NULL |
| TẠO TỪ MẪU | KET_QUA_XET_NGHIEM (N) | MAU_BENH_PHAM | KET_QUA_XET_NGHIEM | FK NOT NULL |
| BAO GỒM | KHOA | PHONG_BENH (N) | PHONG_BENH | FK NOT NULL |
| THUỘC KHOA | KHOA | NHAN_VIEN (N) | NHAN_VIEN | FK NOT NULL |
| TRƯỞNG KHOA | KHOA | BAC_SI | KHOA (nới lỏng — xem mục 4) | FK `KHOA.BS_MaBS_TruongKhoa` nullable |
| IS-A | NHAN_VIEN | BAC_SI / DIEU_DUONG | — | PK trùng FK (table inheritance) |
| PHÂN CÔNG | NHAN_VIEN | LICH_TRUC (N) | LICH_TRUC | FK NOT NULL |
| QUẢN LÝ LỊCH | KHOA | LICH_TRUC (N) | LICH_TRUC | FK NOT NULL |
| CUNG CẤP | NHA_CUNG_CAP | DON_NHAP_HANG (N) | DON_NHAP_HANG | FK NOT NULL |
| CHI TIẾT NHẬP | DON_NHAP_HANG | PHIEU_XUAT_KHO (N, weak) | PHIEU_XUAT_KHO | FK định danh, PK ghép |
| CÓ THANH TOÁN | HOA_DON | THANH_TOAN (N) | THANH_TOAN | FK NOT NULL |
| ÁP DỤNG BHYT | HOA_DON | BOI_THUONG_BHYT | BOI_THUONG_BHYT | FK NOT NULL UNIQUE |
| PHÁT SINH GD | THANH_TOAN / BOI_THUONG_BHYT | GIAO_DICH (N) | GIAO_DICH | 2 FK nullable + CHECK (xem mục 3) |
| CHI TIẾT DỊCH VỤ | DICH_VU_YTE (M) | HOA_DON (N) | — | bảng `HOADON_CHITIET_DICHVU` |
| ĐIỀU TRỊ TẠI | KHOA | HO_SO_NHAP_VIEN (N) | HO_SO_NHAP_VIEN | FK NOT NULL |
| NẰM TẠI | PHONG_BENH | HO_SO_NHAP_VIEN (N) | HO_SO_NHAP_VIEN | FK NOT NULL |
| THỰC HIỆN (chẩn đoán) | BAC_SI | CHAN_DOAN (N) | CHAN_DOAN | FK NOT NULL |
| KÊ ĐƠN | BAC_SI | DON_THUOC (N) | DON_THUOC | FK NOT NULL |
| GỒM THUỐC | THUOC | CHI_TIET_DON_THUOC (N) | CHI_TIET_DON_THUOC | FK NOT NULL |
| CÓ CHẨN ĐOÁN | BENH_AN | CHAN_DOAN (N) | CHAN_DOAN | FK `CHAN_DOAN.BA_MaBenhAn` NOT NULL |
| THANH TOÁN (HĐ) | BENH_NHAN | HOA_DON (N) | HOA_DON | FK NOT NULL |
| PHÁT SINH (HĐ) | HO_SO_NHAP_VIEN | HOA_DON | không bắt buộc phía HOA_DON | FK `HOA_DON.HS_MaHoSo` nullable |
| THU TIỀN | NHAN_VIEN | THANH_TOAN (N) | THANH_TOAN | FK NOT NULL |
| CÓ KẾT QUẢ | BENH_AN | KET_QUA_XET_NGHIEM (N) | KET_QUA_XET_NGHIEM | FK NOT NULL |
| CÓ HÌNH ẢNH | BENH_AN | CHAN_DOAN_HINH_ANH (N) | CHAN_DOAN_HINH_ANH | FK NOT NULL |
| LẤY TỪ | BENH_NHAN | MAU_BENH_PHAM (N) | MAU_BENH_PHAM | FK NOT NULL |

## Cách sử dụng

```bash
# PostgreSQL
createdb hospital_db
psql -d hospital_db -f schema.sql

# Sinh lại sơ đồ quan hệ (erd/relational_schema.svg + .png) sau khi sửa schema.sql
# Yêu cầu Graphviz: brew install graphviz (macOS) / apt install graphviz (Linux)
python3 generate_relational_diagram.py

# Sinh lại sơ đồ ERD của riêng phân hệ Nhân sự & Khoa phòng từ SQL mẫu
# (script độc lập, không phụ thuộc schema.sql ở trên):
python3 ../generate_erd_from_sql.py
```

Muốn cập nhật sơ đồ SVG trong `erd/` sau khi sửa `complete_erd.dot` hoặc các file `.dot` khác ở
thư mục gốc, chạy lại Graphviz rồi copy file `.svg` tương ứng vào đây, ví dụ:

```bash
dot -Tsvg ../complete_erd.dot -o erd/complete_erd.svg
```
