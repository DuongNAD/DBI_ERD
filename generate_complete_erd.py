import re
import subprocess
import os

# 1. Sơ đồ SQL DDL đại diện cho cấu trúc cơ sở dữ liệu toàn bộ hệ thống
SQL_SCHEMA = """
-- ==========================================
-- === PHÂN HỆ 1: BỆNH NHÂN & TIẾP ĐÓN ===
-- ==========================================
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
    HS_PatientID_FK VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID), -- NHẬP VIỆN
    K_MaKhoa VARCHAR(50) REFERENCES KHOA(K_MaKhoa), -- ĐIỀU TRỊ TẠI
    PB_MaPhong VARCHAR(50) REFERENCES PHONG_BENH(PB_MaPhong) -- NẰM TẠI
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

-- ==========================================
-- === PHÂN HỆ 2: CHẨN ĐOÁN & ĐIỀU TRỊ ===
-- ==========================================
CREATE TABLE CHAN_DOAN (
    CD_MaChanDoan VARCHAR(50) PRIMARY KEY,
    CD_TenChanDoan VARCHAR(255),
    CD_MoTa TEXT,
    CD_NgayChanDoan DATE,
    BS_MaBS VARCHAR(50) REFERENCES BAC_SI(BS_MaBS), -- THỰC HIỆN
    BA_RecordID VARCHAR(50) REFERENCES BENH_AN(BA_RecordID) -- CÓ CHẨN ĐOÁN
);

CREATE TABLE DON_THUOC (
    DT_MaDonThuoc VARCHAR(50) PRIMARY KEY,
    DT_NgayKeDon DATE,
    DT_GhiChu TEXT,
    CD_MaChanDoan VARCHAR(50) REFERENCES CHAN_DOAN(CD_MaChanDoan), -- CÓ\\nĐƠN THUỐC
    BS_MaBS VARCHAR(50) REFERENCES BAC_SI(BS_MaBS) -- KÊ ĐƠN
);

CREATE TABLE CHI_TIET_DON_THUOC (
    CT_MaChiTiet VARCHAR(50) PRIMARY KEY,
    CT_SoLuong INT,
    CT_LieuDung VARCHAR(255),
    CT_ThoiGianSuDung VARCHAR(255),
    DT_MaDonThuoc VARCHAR(50) REFERENCES DON_THUOC(DT_MaDonThuoc), -- CÓ\\nCHI TIẾT
    TH_MaThuoc VARCHAR(50) REFERENCES THUOC(TH_MaThuoc) -- GỒM THUỐC
);

CREATE TABLE PHAC_DO_DIEU_TRI (
    PD_MaPhacDo VARCHAR(50) PRIMARY KEY,
    PD_TenPhacDo VARCHAR(255),
    PD_MoTa TEXT,
    PD_ThoiGianDieuTri VARCHAR(100),
    CD_MaChanDoan VARCHAR(50) REFERENCES CHAN_DOAN(CD_MaChanDoan), -- CÓ\\nPHÁC ĐỒ ĐIỀU TRỊ
    DV_MaDichVu VARCHAR(50) REFERENCES DICH_VU_Y_TE(DV_MaDichVu) -- SỬ DỤNG
);

CREATE TABLE DICH_VU_Y_TE (
    DV_MaDichVu VARCHAR(50) PRIMARY KEY,
    DV_TenDichVu VARCHAR(255),
    DV_GiaDichVu DECIMAL(15, 2),
    DV_MoTa TEXT,
    DV_LoaiDichVu VARCHAR(100)
);

-- ==========================================
-- === PHÂN HỆ 3: XÉT NGHIỆM & CĐHA ===
-- ==========================================
CREATE TABLE THIET_BI_Y_TE (
    TB_DeviceID VARCHAR(50) PRIMARY KEY,
    TB_TenThietBi VARCHAR(255),
    TB_LoaiThietBi VARCHAR(100),
    TB_HangSanXuat VARCHAR(255),
    TB_NgayBaoTri DATE,
    TB_TrangThai VARCHAR(50)
);

CREATE TABLE DANH_MỤC_XET_NGHIEM (
    DM_TestID VARCHAR(50) PRIMARY KEY,
    DM_TenXetNghiem VARCHAR(255),
    DM_LoaiXetNghiem VARCHAR(100),
    DM_MoTa TEXT,
    DM_DonViTinh VARCHAR(50),
    DM_GiaTien DECIMAL(15, 2)
);

CREATE TABLE MAU_BENH_PHAM (
    BP_SampleID VARCHAR(50) PRIMARY KEY,
    BP_LoaiMau VARCHAR(100),
    BP_NgayLayMau DATE,
    BP_GioLayMau TIME,
    BP_TinhTrangMau VARCHAR(100),
    BP_PatientID_FK VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID), -- LẤY TỪ
    DM_TestID VARCHAR(50) REFERENCES DANH_MỤC_XET_NGHIEM(DM_TestID) -- LẤY TỪ
);

CREATE TABLE KET_QUA_XET_NGHIEM (
    KQ_ResultID VARCHAR(50) PRIMARY KEY,
    KQ_NgayThucHien DATE,
    KQ_KetQua VARCHAR(255),
    KQ_ChiSoDo VARCHAR(255),
    KQ_GiaTriThamChieu VARCHAR(255),
    KQ_KetLuan TEXT,
    KQ_RecordID_FK VARCHAR(50) REFERENCES BENH_AN(BA_RecordID), -- CÓ KẾT QUẢ
    KQ_TestID_FK VARCHAR(50) REFERENCES DANH_MỤC_XET_NGHIEM(DM_TestID), -- THUỘC
    KQ_SampleID_FK VARCHAR(50) REFERENCES MAU_BENH_PHAM(BP_SampleID) -- TẠO TỪ MẪU
);

CREATE TABLE CHAN_DOAN_HINH_ANH (
    HA_ImagingID VARCHAR(50) PRIMARY KEY,
    HA_LoaiChanDoan VARCHAR(100),
    HA_NgayThucHien DATE,
    HA_KetQua VARCHAR(255),
    HA_HinhAnh VARCHAR(255),
    HA_KetLuan TEXT,
    HA_RecordID_FK VARCHAR(50) REFERENCES BENH_AN(BA_RecordID), -- CÓ HÌNH ẢNH
    HA_DeviceID_FK VARCHAR(50) REFERENCES THIET_BI_Y_TE(TB_DeviceID) -- THỰC HIỆN
);

-- ==========================================
-- === PHÂN HỆ 4: NHÂN SỰ & KHOA PHÒNG ===
-- ==========================================
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

-- ==========================================
-- === PHÂN HỆ 5: DƯỢC & VẬT TƯ Y TẾ ===
-- ==========================================
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

-- ==========================================
-- === PHÂN HỆ 6: TÀI CHÍNH & VIỆN PHÍ ===
-- ==========================================
CREATE TABLE HOA_DON (
    HD_MaHD VARCHAR(50) PRIMARY KEY,
    HD_MaBN VARCHAR(50),
    HD_MaTN VARCHAR(50),
    HD_TongChiPhi DECIMAL(15, 2),
    HD_TienBHYT DECIMAL(15, 2),
    HD_TienBN DECIMAL(15, 2),
    BN_PatientID VARCHAR(50) REFERENCES BENH_NHAN(BN_PatientID), -- THANH TOÁN
    HS_AdmissionID VARCHAR(50) REFERENCES HO_SO_NHAP_VIEN(HS_AdmissionID), -- PHÁT SINH
    DV_MaDichVu VARCHAR(50) REFERENCES DICH_VU_Y_TE(DV_MaDichVu) -- CHI TIẾT DỊCH VỤ
);

CREATE TABLE THANH_TOAN (
    TT_MaTT VARCHAR(50) PRIMARY KEY,
    TT_Loai VARCHAR(50),
    TT_SoTien DECIMAL(15, 2),
    TT_PhuongThuc VARCHAR(50),
    TT_MaNV VARCHAR(50),
    HD_MaHD VARCHAR(50) REFERENCES HOA_DON(HD_MaHD), -- CÓ THANH TOÁN
    NV_MaNV VARCHAR(50) REFERENCES NHAN_VIEN(NV_MaNV) -- THU TIỀN
);

CREATE TABLE BOI_THUONG_BHYT (
    BT_MaQuyetToan VARCHAR(50) PRIMARY KEY,
    BT_SoTheBHYT VARCHAR(50),
    BT_MaBenh VARCHAR(50),
    BT_TiLe DECIMAL(5, 2),
    BT_TrangThai VARCHAR(50),
    HD_MaHD VARCHAR(50) REFERENCES HOA_DON(HD_MaHD) -- ÁP DỤNG BHYT
);

CREATE TABLE GIAO_DICH (
    GD_MaGD VARCHAR(50) PRIMARY KEY,
    GD_MaThamChieu VARCHAR(100),
    GD_NguonTien VARCHAR(100),
    GD_SoTienGD DECIMAL(15, 2),
    GD_ThoiGian TIMESTAMP,
    TT_MaTT VARCHAR(50) REFERENCES THANH_TOAN(TT_MaTT), -- PHÁT SINH GD
    BT_MaQuyetToan VARCHAR(50) REFERENCES BOI_THUONG_BHYT(BT_MaQuyetToan) -- PHÁT SINH GD
);
"""

# 2. Từ điển dịch tiếng Việt cho nhãn Thực thể và Thuộc tính toàn bộ hệ thống
TRANSLATIONS = {
    # Phân hệ 1
    "BENH_NHAN": "BỆNH NHÂN",
    "BAO_HIEM_YT": "BẢO HIỂM Y TẾ",
    "LICH_HEN": "LỊCH HẸN",
    "HO_SO_NHAP_VIEN": "HỒ SƠ NHẬP VIỆN",
    "BENH_AN": "BỆNH ÁN",
    
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
    "BA_AdmissionID_FK": "Mã hồ sơ nhập viện (FK)",

    # Phân hệ 2
    "CHAN_DOAN": "CHẨN ĐOÁN",
    "DON_THUOC": "ĐƠN THUỐC",
    "CHI_TIET_DON_THUOC": "CHI TIẾT ĐƠN THUỐC",
    "PHAC_DO_DIEU_TRI": "PHÁC ĐỒ ĐIỀU TRỊ",
    "DICH_VU_Y_TE": "DỊCH VỤ Y TẾ",
    
    "CD_MaChanDoan": "Mã chẩn đoán",
    "CD_TenChanDoan": "Tên chẩn đoán",
    "CD_MoTa": "Mô tả",
    "CD_NgayChanDoan": "Ngày chẩn đoán",
    "DT_MaDonThuoc": "Mã đơn thuốc",
    "DT_NgayKeDon": "Ngày kê đơn",
    "DT_GhiChu": "Ghi chú",
    "CT_MaChiTiet": "Mã chi tiết",
    "CT_SoLuong": "Số lượng",
    "CT_LieuDung": "Liều dùng",
    "CT_ThoiGianSuDung": "Thời gian sử dụng",
    "PD_MaPhacDo": "Mã phác đồ",
    "PD_TenPhacDo": "Tên phác đồ",
    "PD_MoTa": "Mô tả",
    "PD_ThoiGianDieuTri": "Thời gian điều trị",
    "DV_MaDichVu": "Mã dịch vụ",
    "DV_TenDichVu": "Tên dịch vụ",
    "DV_GiaDichVu": "Giá dịch vụ",
    "DV_MoTa": "Mô tả",
    "DV_LoaiDichVu": "Loại dịch vụ",

    # Phân hệ 3
    "THIET_BI_Y_TE": "THIẾT BỊ Y TẾ",
    "DANH_MỤC_XET_NGHIEM": "DANH MỤC XÉT NGHIỆM",
    "MAU_BENH_PHAM": "MẪU BỆNH PHẨM",
    "KET_QUA_XET_NGHIEM": "KẾT QUẢ XÉT NGHIỆM",
    "CHAN_DOAN_HINH_ANH": "CHẨN ĐOÁN HÌNH ẢNH",
    
    "TB_DeviceID": "Mã thiết bị",
    "TB_TenThietBi": "Tên thiết bị",
    "TB_LoaiThietBi": "Loại thiết bị",
    "TB_HangSanXuat": "Hãng sản xuất",
    "TB_NgayBaoTri": "Ngày bảo trì",
    "TB_TrangThai": "Trạng thái",
    "DM_TestID": "Mã xét nghiệm",
    "DM_TenXetNghiem": "Tên xét nghiệm",
    "DM_LoaiXetNghiem": "Loại xét nghiệm",
    "DM_MoTa": "Mô tả",
    "DM_DonViTinh": "Đơn vị tính",
    "DM_GiaTien": "Giá tiền",
    "BP_SampleID": "Mã mẫu bệnh phẩm",
    "BP_LoaiMau": "Loại mẫu",
    "BP_NgayLayMau": "Ngày lấy mẫu",
    "BP_GioLayMau": "Giờ lấy mẫu",
    "BP_TinhTrangMau": "Tình trạng mẫu",
    "BP_PatientID_FK": "Mã bệnh nhân (FK)",
    "KQ_ResultID": "Mã kết quả xét nghiệm",
    "KQ_NgayThucHien": "Ngày thực hiện",
    "KQ_KetQua": "Kết quả",
    "KQ_ChiSoDo": "Chỉ số đo",
    "KQ_GiaTriThamChieu": "Giá trị tham chiếu",
    "KQ_KetLuan": "Kết luận",
    "KQ_RecordID_FK": "Mã bệnh án (FK)",
    "KQ_TestID_FK": "Mã xét nghiệm (FK)",
    "KQ_SampleID_FK": "Mã mẫu bệnh phẩm (FK)",
    "HA_ImagingID": "Mã hình ảnh",
    "HA_LoaiChanDoan": "Loại chẩn đoán",
    "HA_NgayThucHien": "Ngày thực hiện",
    "HA_KetQua": "Kết quả",
    "HA_HinhAnh": "Hình ảnh",
    "HA_KetLuan": "Kết luận",
    "HA_RecordID_FK": "Mã bệnh án (FK)",
    "HA_DeviceID_FK": "Mã thiết bị (FK)",

    # Phân hệ 4
    "KHOA": "KHOA",
    "PHONG_BENH": "PHÒNG BỆNH",
    "NHAN_VIEN": "NHÂN VIÊN",
    "BAC_SI": "BÁC SĨ",
    "DIEU_DUONG": "ĐIỀU DƯỠNG",
    "LICH_TRUC": "LỊCH TRỰC",
    
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
    "LT_TGKT": "Thời gian kết thúc",

    # Phân hệ 5
    "NHA_CUNG_CAP": "NHÀ CUNG CẤP",
    "DON_NHAP_HANG": "ĐƠN NHẬP HÀNG",
    "PHIEU_XUAT_KHO": "PHIẾU XUẤT KHO\\n(Chi tiết nhập)",
    "THUOC": "THUỐC",
    "VAT_TU_Y_TE": "VẬT TƯ Y TẾ",
    
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
    "VT_CongDung": "Công dụng",

    # Phân hệ 6
    "HOA_DON": "HÓA ĐƠN",
    "THANH_TOAN": "THANH TOÁN",
    "BOI_THUONG_BHYT": "BỒI THƯỜNG BHYT",
    "GIAO_DICH": "GIAO DỊCH",
    
    "HD_MaHD": "Mã hóa đơn",
    "HD_MaBN": "Mã bệnh nhân",
    "HD_MaTN": "Mã tiếp nhận",
    "HD_TongChiPhi": "Tổng chi phí",
    "HD_TienBHYT": "Tiền Bảo hiểm y tế",
    "HD_TienBN": "Tiền bệnh nhân",
    "TT_MaTT": "Mã thanh toán",
    "TT_Loai": "Loại",
    "TT_SoTien": "Số tiền",
    "TT_PhuongThuc": "Phương thức",
    "TT_MaNV": "Mã nhân viên",
    "BT_MaQuyetToan": "Mã quyết toán",
    "BT_SoTheBHYT": "Số thẻ Bảo hiểm y tế",
    "BT_MaBenh": "Mã bệnh",
    "BT_TiLe": "Tỷ lệ",
    "BT_TrangThai": "Trạng thái",
    "GD_MaGD": "Mã giao dịch",
    "GD_MaThamChieu": "Mã tham chiếu",
    "GD_NguonTien": "Nguồn tiền",
    "GD_SoTienGD": "Số tiền giao dịch",
    "GD_ThoiGian": "Thời gian"
}

# 3. Bản đồ ánh xạ bảng -> Cluster Phân hệ để nhóm đồ thị
TABLE_CLUSTERS = {
    # Phần 1: Bệnh nhân & Tiếp đón
    "BENH_NHAN": "Part1",
    "BAO_HIEM_YT": "Part1",
    "LICH_HEN": "Part1",
    "HO_SO_NHAP_VIEN": "Part1",
    "BENH_AN": "Part1",
    
    # Phần 2: Chẩn đoán & Điều trị
    "CHAN_DOAN": "Part2",
    "DON_THUOC": "Part2",
    "CHI_TIET_DON_THUOC": "Part2",
    "PHAC_DO_DIEU_TRI": "Part2",
    "DICH_VU_Y_TE": "Part2",
    
    # Phần 3: Xét nghiệm & CĐHA
    "THIET_BI_Y_TE": "Part3",
    "DANH_MỤC_XET_NGHIEM": "Part3",
    "MAU_BENH_PHAM": "Part3",
    "KET_QUA_XET_NGHIEM": "Part3",
    "CHAN_DOAN_HINH_ANH": "Part3",
    
    # Phần 4: Nhân sự & Khoa phòng
    "KHOA": "Part4",
    "PHONG_BENH": "Part4",
    "NHAN_VIEN": "Part4",
    "BAC_SI": "Part4",
    "DIEU_DUONG": "Part4",
    "LICH_TRUC": "Part4",
    
    # Phần 5: Dược & Vật tư y tế
    "NHA_CUNG_CAP": "Part5",
    "DON_NHAP_HANG": "Part5",
    "THUOC": "Part5",
    "VAT_TU_Y_TE": "Part5",
    "PHIEU_XUAT_KHO": "Part5",
    
    # Phần 6: Tài chính & Viện phí
    "HOA_DON": "Part6",
    "THANH_TOAN": "Part6",
    "BOI_THUONG_BHYT": "Part6",
    "GIAO_DICH": "Part6"
}

# 4. Định nghĩa thiết lập giao diện của từng Cluster
CLUSTERS_CONFIG = {
    "Part1": {
        "label": "Phân hệ Bệnh nhân & Tiếp đón",
        "fontcolor": "#2B6CB0",
        "fillcolor": "#F8FAFC",
        "color": "#2B6CB0",
        "entity_fill": "#EBF8FF",
        "entity_color": "#2B6CB0",
        "entity_font": "#1A365D",
        "attr_fill": "#F0F9FF",
        "attr_color": "#93C5FD",
        "attr_font": "#1E3A8A"
    },
    "Part2": {
        "label": "Phân hệ Chẩn đoán & Điều trị",
        "fontcolor": "#319795",
        "fillcolor": "#F5FDFD",
        "color": "#319795",
        "entity_fill": "#E6FFFA",
        "entity_color": "#319795",
        "entity_font": "#234E52",
        "attr_fill": "#F0FDF4",
        "attr_color": "#86EFAC",
        "attr_font": "#14532D"
    },
    "Part3": {
        "label": "Phân hệ Xét nghiệm & Chẩn đoán hình ảnh",
        "fontcolor": "#6B46C1",
        "fillcolor": "#FAF5FF",
        "color": "#6B46C1",
        "entity_fill": "#FAF5FF",
        "entity_color": "#6B46C1",
        "entity_font": "#4C1D95",
        "attr_fill": "#FDF4FF",
        "attr_color": "#D8B4FE",
        "attr_font": "#581C87"
    },
    "Part4": {
        "label": "Phân hệ Nhân sự & Khoa phòng",
        "fontcolor": "#DD6B20",
        "fillcolor": "#FFFAF0",
        "color": "#DD6B20",
        "entity_fill": "#FFFAF0",
        "entity_color": "#DD6B20",
        "entity_font": "#7B341E",
        "attr_fill": "#FFFBEB",
        "attr_color": "#FDE047",
        "attr_font": "#78350F"
    },
    "Part5": {
        "label": "Phân hệ Dược & Vật tư y tế",
        "fontcolor": "#E53E3E",
        "fillcolor": "#FFF5F5",
        "color": "#E53E3E",
        "entity_fill": "#FFF5F5",
        "entity_color": "#E53E3E",
        "entity_font": "#742A2A",
        "attr_fill": "#FFF1F2",
        "attr_color": "#FDA4AF",
        "attr_font": "#9F1239"
    },
    "Part6": {
        "label": "Phân hệ Tài chính & Viện phí",
        "fontcolor": "#4C51BF",
        "fillcolor": "#F8FAFF",
        "color": "#4C51BF",
        "entity_fill": "#EBF4FF",
        "entity_color": "#4C51BF",
        "entity_font": "#2C3E50",
        "attr_fill": "#EEF2FF",
        "attr_color": "#A5B4FC",
        "attr_font": "#312E81"
    }
}

# 5. Siêu dữ liệu quan hệ chi tiết bản số (bao gồm cả liên phân hệ)
RELATIONSHIP_METADATA = {
    # Phân hệ 1
    ("BAO_HIEM_YT", "BENH_NHAN", "CÓ"): ("1", "1", "source"),
    ("LICH_HEN", "BENH_NHAN", "ĐẶT"): ("N", "1", "source"),
    ("HO_SO_NHAP_VIEN", "BENH_NHAN", "NHẬP VIỆN"): ("N", "1", "source"),
    ("BENH_AN", "BENH_NHAN", "CÓ"): ("N", "1", "source"),
    ("BENH_AN", "HO_SO_NHAP_VIEN", "TẠO TỪ"): ("N", "1", "source"),
    # Phân hệ 2
    ("DON_THUOC", "CHAN_DOAN", "CÓ\nĐƠN THUỐC"): ("N", "1", "source"),
    ("CHI_TIET_DON_THUOC", "DON_THUOC", "CÓ\nCHI TIẾT"): ("N", "1", "source"),
    ("PHAC_DO_DIEU_TRI", "CHAN_DOAN", "CÓ\nPHÁC ĐỒ ĐIỀU TRỊ"): ("N", "1", "source"),
    ("PHAC_DO_DIEU_TRI", "DICH_VU_Y_TE", "SỬ DỤNG"): ("M", "N", None),
    # Phân hệ 3
    ("BENH_AN", "BENH_NHAN", "CÓ"): ("N", "1", "source"),
    ("KET_QUA_XET_NGHIEM", "BENH_AN", "CÓ KẾT QUẢ"): ("N", "1", "source"),
    ("CHAN_DOAN_HINH_ANH", "BENH_AN", "CÓ HÌNH ẢNH"): ("N", "1", "source"),
    ("CHAN_DOAN_HINH_ANH", "THIET_BI_Y_TE", "THỰC HIỆN"): ("N", "1", "source"),
    ("KET_QUA_XET_NGHIEM", "DANH_MỤC_XET_NGHIEM", "THUỘC"): ("N", "1", "source"),
    ("KET_QUA_XET_NGHIEM", "MAU_BENH_PHAM", "TẠO TỪ MẪU"): ("N", "1", "source"),
    ("MAU_BENH_PHAM", "BENH_NHAN", "LẤY TỪ"): ("N", "1", "source"),
    ("MAU_BENH_PHAM", "DANH_MỤC_XET_NGHIEM", "LẤY TỪ"): ("N", "1", "source"),
    # Phân hệ 4
    ("PHONG_BENH", "KHOA", "BAO GỒM"): ("N", "1", "source"),
    ("NHAN_VIEN", "KHOA", "THUỘC KHOA"): ("N", "1", "source"),
    ("BAC_SI", "KHOA", "TRƯỞNG KHOA"): ("1", "1", "target"),
    ("BAC_SI", "NHAN_VIEN", "IS-A"): ("1", "1", "source"),
    ("DIEU_DUONG", "NHAN_VIEN", "IS-A"): ("1", "1", "source"),
    ("LICH_TRUC", "NHAN_VIEN", "PHÂN CÔNG"): ("N", "1", "source"),
    ("LICH_TRUC", "KHOA", "QUẢN LÝ LỊCH"): ("N", "1", "source"),
    # Phân hệ 5
    ("DON_NHAP_HANG", "NHA_CUNG_CAP", "CUNG CẤP"): ("N", "1", "source"),
    ("PHIEU_XUAT_KHO", "DON_NHAP_HANG", "CHI TIẾT NHẬP"): ("N", "1", "source"),
    ("PHIEU_XUAT_KHO", "THUOC", "GỒM THUỐC"): ("N", "1", "source"),
    ("PHIEU_XUAT_KHO", "VAT_TU_Y_TE", "GỒM VẬT TƯ"): ("N", "1", "source"),
    # Phân hệ 6
    ("THANH_TOAN", "HOA_DON", "CÓ THANH TOÁN"): ("N", "1", "source"),
    ("BOI_THUONG_BHYT", "HOA_DON", "ÁP DỤNG BHYT"): ("1", "1", "source"),
    ("GIAO_DICH", "THANH_TOAN", "PHÁT SINH GD"): ("N", "1", "source"),
    ("GIAO_DICH", "BOI_THUONG_BHYT", "PHÁT SINH GD"): ("N", "1", "source"),
    
    # Quan hệ liên phân hệ (Bắc cầu)
    ("HO_SO_NHAP_VIEN", "KHOA", "ĐIỀU TRỊ TẠI"): ("N", "1", "source"),
    ("HO_SO_NHAP_VIEN", "PHONG_BENH", "NẰM TẠI"): ("N", "1", "source"),
    ("CHAN_DOAN", "BAC_SI", "THỰC HIỆN"): ("N", "1", "source"),
    ("DON_THUOC", "BAC_SI", "KÊ ĐƠN"): ("N", "1", "source"),
    ("CHI_TIET_DON_THUOC", "THUOC", "GỒM THUỐC"): ("N", "1", "source"),
    ("CHAN_DOAN", "BENH_AN", "CÓ CHẨN ĐOÁN"): ("N", "1", "source"),
    ("HOA_DON", "BENH_NHAN", "THANH TOÁN"): ("N", "1", "source"),
    ("HOA_DON", "HO_SO_NHAP_VIEN", "PHÁT SINH"): ("1", "1", "source"),
    ("THANH_TOAN", "NHAN_VIEN", "THU TIỀN"): ("N", "1", "source"),
    ("HOA_DON", "DICH_VU_Y_TE", "CHI TIẾT DỊCH VỤ"): ("N", "M", None)
}

def to_pascal_case(s):
    """Chuyển đổi dạng snake_case thành PascalCase (ví dụ: HOA_DON -> HoaDon)."""
    clean_s = s.replace("DANH_MỤC_XET_NGHIEM", "DANH_MUC_XET_NGHIEM")
    return "".join(word.capitalize() for word in clean_s.split("_"))

def get_rel_id(label, table_name, ref_table):
    """Lấy ID nút quan hệ cụ thể để khớp với cấu trúc DOT gốc."""
    mapping = {
        "CÓ": "CoInsurance" if table_name == "BAO_HIEM_YT" else "CoRecord",
        "ĐẶT": "DatAppointment",
        "NHẬP VIỆN": "NhapVien",
        "TẠO TỪ": "TaoTu",
        "CÓ KẾT QUẢ": "CoResult",
        "CÓ HÌNH ẢNH": "CoImaging",
        "THỰC HIỆN": "ThucHien" if (ref_table == "THIET_BI_Y_TE" or table_name == "CHAN_DOAN_HINH_ANH") else "ThucHienCD",
        "THUỘC": "ThuocDM",
        "TẠO TỪ MẪU": "TaoTuMau",
        "LẤY TỪ": "LayTu",
        "ĐIỀU TRỊ TẠI": "DieuTriTai",
        "NẰM TẠI": "NamTai",
        "KÊ ĐƠN": "KeDon",
        "GỒM THUỐC": "PrescribedIn" if ref_table == "THUOC" else "GomThuoc",
        "CÓ CHẨN ĐOÁN": "CoChanDoan",
        "THANH TOÁN": "ThanhToanHD" if table_name == "HOA_DON" else "ThanhToan",
        "PHÁT SINH": "PhatSinhHD",
        "THU TIỀN": "ThuTien",
        "CHI TIẾT DỊCH VỤ": "ChiTietDichVu",
        "CÓ ĐƠN THUỐC": "CoDonThuoc",
        "CÓ CHI TIẾT": "CoChiTiet",
        "CÓ PHÁC ĐỒ ĐIỀU TRỊ": "CoPhacDo",
        "SỬ DỤNG": "SuDung",
        "BAO GỒM": "BaoGom",
        "THUỘC KHOA": "ThuocKhoa",
        "TRƯỞNG KHOA": "TruongKhoa",
        "PHÂN CÔNG": "PhanCong",
        "QUẢN LÝ LỊCH": "QuanLyLich",
        "CUNG CẤP": "CungCap",
        "CHI TIẾT NHẬP": "ChiTietNhap",
        "GỒM VẬT TƯ": "GomVatTu",
        "CÓ THANH TOÁN": "CoThanhToan",
        "ÁP DỤNG BHYT": "ApDungBHYT",
    }
    # Dọn dẹp dòng xuống hàng
    clean_label = label.replace("\n", " ").replace("\\n", " ").strip()
    for k, v in mapping.items():
        if k.replace("\n", " ").strip() == clean_label:
            return v
            
    if label == "IS-A":
        if table_name == "BAC_SI":
            return "ISA1"
        if table_name == "DIEU_DUONG":
            return "ISA2"
        return "ISA"
        
    if "PHÁT SINH" in label or "PHAT SINH" in label:
        if ref_table == "THANH_TOAN":
            return "PhatSinhGD_TT"
        if ref_table == "BOI_THUONG_BHYT":
            return "PhatSinhGD_BT"
            
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
    
    # 2. Sinh các Subgraph Clusters cho từng Phân hệ
    for cluster_id, config in CLUSTERS_CONFIG.items():
        dot_lines.append(f"    subgraph cluster_{cluster_id} {{")
        dot_lines.append(f"        label=\"{config['label']}\";")
        dot_lines.append("        fontname=\"Arial Bold\";")
        dot_lines.append("        fontsize=16;")
        dot_lines.append(f"        fontcolor=\"{config['fontcolor']}\";")
        dot_lines.append("        style=\"filled,dashed\";")
        dot_lines.append(f"        fillcolor=\"{config['fillcolor']}\";")
        dot_lines.append(f"        color=\"{config['color']}\";")
        dot_lines.append("        penwidth=2.0;")
        dot_lines.append("")
        
        # Lấy danh sách các bảng thuộc cluster này
        cluster_tables = [name for name, cid in TABLE_CLUSTERS.items() if cid == cluster_id]
        
        # Vẽ các thực thể trong cluster
        dot_lines.append("        // Thực thể")
        for table_name in cluster_tables:
            if table_name in tables:
                t = tables[table_name]
                if table_name == "PHIEU_XUAT_KHO":
                    # Thực thể yếu
                    dot_lines.append(f'        {t["entity_id"]} [shape=box, peripheries=2, penwidth=2.0, fillcolor=\"{config["entity_fill"]}\", color=\"{config["entity_color"]}\", fontcolor=\"{config["entity_font"]}\", fontsize=13, style=\"filled,bold\", label=\"{t["label"]}\"];')
                else:
                    dot_lines.append(f'        {t["entity_id"]} [shape=box, peripheries=1, penwidth=2.0, fillcolor=\"{config["entity_fill"]}\", color=\"{config["entity_color"]}\", fontcolor=\"{config["entity_font"]}\", fontsize=13, style=\"filled,bold\", label=\"{t["label"]}\"];')
        dot_lines.append("")
        
        # Vẽ các thuộc tính khóa trong cluster
        dot_lines.append("        // Thuộc tính khóa")
        for table_name in cluster_tables:
            if table_name in tables:
                for attr in tables[table_name]["attributes"]:
                    if attr["is_pk"]:
                        if attr["id"] == "PXK_SoLo":
                            # Khóa bộ phận
                            dot_lines.append(f'        {attr["id"]} [shape=ellipse, peripheries=1, penwidth=1.5, fillcolor=\"#FFF1F2\", color=\"#FDA4AF\", fontcolor=\"#9F1239\", fontsize=9, style=\"filled,dashed\", label=<<font color=\"#9F1239\"><u>{attr["label"]}</u></font>>];')
                        else:
                            dot_lines.append(f'        {attr["id"]} [shape=ellipse, peripheries=1, penwidth=1.5, fillcolor=\"#FEF3C7\", color=\"#D97706\", fontcolor=\"#78350F\", fontsize=10, style=\"filled,bold\", label=<<u>{attr["label"]}</u>>];')
        dot_lines.append("")
        
        # Vẽ các thuộc tính thường trong cluster
        dot_lines.append("        // Thuộc tính thường")
        for table_name in cluster_tables:
            if table_name in tables:
                for attr in tables[table_name]["attributes"]:
                    if not attr["is_pk"]:
                        dot_lines.append(f'        {attr["id"]} [shape=ellipse, peripheries=1, penwidth=1.0, fillcolor=\"{config["attr_fill"]}\", color=\"{config["attr_color"]}\", fontcolor=\"{config["attr_font"]}\", fontsize=9, style=filled, label=\"{attr["label"]}\"];')
        dot_lines.append("")
        
        # Vẽ mối quan hệ nội bộ phân hệ (cả nguồn và đích đều thuộc cluster này)
        dot_lines.append("        // Mối quan hệ nội bộ")
        added_rel_ids = set()
        for rel in relationships:
            src_cid = TABLE_CLUSTERS.get(rel["source_table"])
            tgt_cid = TABLE_CLUSTERS.get(rel["target_table"])
            if src_cid == cluster_id and tgt_cid == cluster_id:
                if rel["id"] not in added_rel_ids:
                    if rel["id"] == "ChiTietNhap":
                        # Quan hệ xác định (hình thoi kép)
                        dot_lines.append(f'        {rel["id"]} [shape=diamond, peripheries=2, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\", label=\"{rel["label"]}\"];')
                    else:
                        dot_lines.append(f'        {rel["id"]} [shape=diamond, peripheries=1, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\", label=\"{rel["label"]}\"];')
                    added_rel_ids.add(rel["id"])
        dot_lines.append("")
        
        # Kết nối thuộc tính nội bộ
        dot_lines.append("        // Kết nối thuộc tính nội bộ")
        for table_name in cluster_tables:
            if table_name in tables:
                ent_id = tables[table_name]["entity_id"]
                for attr in tables[table_name]["attributes"]:
                    dot_lines.append(f'        {ent_id} -- {attr["id"]};')
        dot_lines.append("")
        
        # Kết nối quan hệ nội bộ
        dot_lines.append("        // Kết nối quan hệ nội bộ")
        for rel in relationships:
            src_cid = TABLE_CLUSTERS.get(rel["source_table"])
            tgt_cid = TABLE_CLUSTERS.get(rel["target_table"])
            if src_cid == cluster_id and tgt_cid == cluster_id:
                rel_label = rel["label"]
                rel_id = rel["id"]
                source_ent = rel["source_entity"]
                target_ent = rel["target_entity"]
                
                meta = RELATIONSHIP_METADATA.get((rel["source_table"], rel["target_table"], rel_label))
                if meta:
                    source_card, target_card, total_part = meta
                else:
                    source_card, target_card, total_part = ("N", "1", None)
                    
                if total_part == "target":
                    dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel=\"{target_card}\", color=\"#4A5568:invis:#4A5568\", penwidth=3];')
                else:
                    dot_lines.append(f'        {target_ent} -- {rel_id} [taillabel=\"{target_card}\"];')
                    
                if total_part == "source":
                    dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel=\"{source_card}\", color=\"#4A5568:invis:#4A5568\", penwidth=3];')
                else:
                    dot_lines.append(f'        {rel_id} -- {source_ent} [headlabel=\"{source_card}\"];')
                    
        dot_lines.append("    }")
        dot_lines.append("")
        
    # 3. Vẽ các Mối quan hệ liên phân hệ (ở cấp độ gốc đồ thị)
    dot_lines.append("    // === Các mối quan hệ liên phân hệ ===")
    dot_lines.append("    node [shape=diamond, peripheries=1, penwidth=1.5, fillcolor=\"#FAF5FF\", color=\"#6B46C1\", fontcolor=\"#4C1D95\", fontsize=11, style=\"filled,bold\"];")
    
    added_cross_rel_ids = set()
    for rel in relationships:
        src_cid = TABLE_CLUSTERS.get(rel["source_table"])
        tgt_cid = TABLE_CLUSTERS.get(rel["target_table"])
        # Nếu nguồn và đích thuộc 2 cluster khác nhau
        if src_cid != tgt_cid:
            if rel["id"] not in added_cross_rel_ids:
                dot_lines.append(f'    {rel["id"]} [label=\"{rel["label"]}\"];')
                added_cross_rel_ids.add(rel["id"])
                
    dot_lines.append("")
    
    # Kết nối các quan hệ liên phân hệ
    dot_lines.append("    // Kết nối các mối quan hệ liên phân hệ")
    for rel in relationships:
        src_cid = TABLE_CLUSTERS.get(rel["source_table"])
        tgt_cid = TABLE_CLUSTERS.get(rel["target_table"])
        if src_cid != tgt_cid:
            rel_label = rel["label"]
            rel_id = rel["id"]
            source_ent = rel["source_entity"]
            target_ent = rel["target_entity"]
            
            meta = RELATIONSHIP_METADATA.get((rel["source_table"], rel["target_table"], rel_label))
            if meta:
                source_card, target_card, total_part = meta
            else:
                source_card, target_card, total_part = ("N", "1", None)
                
            if total_part == "target":
                dot_lines.append(f'    {target_ent} -- {rel_id} [taillabel=\"{target_card}\", color=\"#4A5568:invis:#4A5568\", penwidth=3];')
            else:
                dot_lines.append(f'    {target_ent} -- {rel_id} [taillabel=\"{target_card}\"];')
                
            if total_part == "source":
                dot_lines.append(f'    {rel_id} -- {source_ent} [headlabel=\"{source_card}\", color=\"#4A5568:invis:#4A5568\", penwidth=3];')
            else:
                dot_lines.append(f'    {rel_id} -- {source_ent} [headlabel=\"{source_card}\"];')
                
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
    dot_file = "complete_erd.dot"
    base_name = "complete_erd"
    
    print("Dang phan tich so do SQL...")
    tables, relationships = parse_sql_to_erd(SQL_SCHEMA)
    generate_dot_file(tables, relationships, dot_file)
    compile_dot_to_images(dot_file, base_name)
