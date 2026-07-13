-- ================================================================
--  DATABASE ASSIGNMENT - HE THONG QUAN LY BENH VIEN (QLBenhVien)
--  DBMS: Microsoft SQL Server (T-SQL)
--  Sinh ra tu mo hinh ERD chuan Chen (6 phan he, 30 thuc the + quan he
--  de quy + quan he tam nguyen). Xem database/README.md o thu muc goc
--  repo de biet day du ly do thiet ke.
-- ================================================================

IF DB_ID('QLBenhVien') IS NOT NULL
BEGIN
    ALTER DATABASE QLBenhVien SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE QLBenhVien
END
GO

CREATE DATABASE QLBenhVien
GO

USE QLBenhVien
GO

-- ================================================================
-- PHAN HE 1: BENH NHAN & TIEP DON
-- ================================================================

CREATE TABLE BENH_NHAN (
    BN_MaBN         VARCHAR(50)   PRIMARY KEY,
    BN_HoTen        NVARCHAR(255) NOT NULL,
    BN_NgaySinh     DATE,
    BN_GioiTinh     NVARCHAR(10),
    BN_SoDienThoai  VARCHAR(20),
    BN_DiaChi       NVARCHAR(255),
    BN_Email        VARCHAR(255)
)
GO

-- Quan he CO (BAO_HIEM_YT 1 -- 1 BENH_NHAN), total tren BAO_HIEM_YT.
CREATE TABLE BAO_HIEM_YT (
    BH_MaBHYT       VARCHAR(50)   PRIMARY KEY,
    BH_MaSoBHYT     VARCHAR(50)   NOT NULL UNIQUE,
    BH_NhaCungCap   NVARCHAR(255),
    BH_NgayHieuLuc  DATE,
    BH_NgayHetHan   DATE,
    BN_MaBN         VARCHAR(50)   NOT NULL UNIQUE REFERENCES BENH_NHAN(BN_MaBN)
)
GO

-- Quan he DAT (BENH_NHAN 1 -- N LICH_HEN), total tren LICH_HEN.
CREATE TABLE LICH_HEN (
    LH_MaLichHen    VARCHAR(50)   PRIMARY KEY,
    LH_NgayHen      DATE          NOT NULL,
    LH_GioHen       TIME,
    LH_TrangThai    NVARCHAR(50),
    LH_LyDoKham     NVARCHAR(255),
    BN_MaBN         VARCHAR(50)   NOT NULL REFERENCES BENH_NHAN(BN_MaBN)
)
GO

-- Quan he NHAP_VIEN (BENH_NHAN 1 -- N HO_SO_NHAP_VIEN), total tren HO_SO_NHAP_VIEN.
-- FK toi KHOA / PHONG_BENH (phan he 4) duoc them o cuoi file de tranh phu thuoc vong.
CREATE TABLE HO_SO_NHAP_VIEN (
    HS_MaHoSo         VARCHAR(50)   PRIMARY KEY,
    HS_NgayNhapVien   DATE          NOT NULL,
    HS_NgayRaVien     DATE,
    HS_LyDoNhapVien   NVARCHAR(255),
    HS_TrangThai      NVARCHAR(50),
    BN_MaBN           VARCHAR(50)   NOT NULL REFERENCES BENH_NHAN(BN_MaBN)
)
GO

-- Quan he CO (BENH_NHAN 1 -- N BENH_AN), total tren BENH_AN.
-- Quan he TAO_TU (BENH_AN N -- 1 HO_SO_NHAP_VIEN), partial ca hai phia => cot nullable.
CREATE TABLE BENH_AN (
    BA_MaBenhAn     VARCHAR(50)   PRIMARY KEY,
    BA_NgayTao      DATE          NOT NULL,
    BA_ChanDoan     NVARCHAR(MAX),
    BA_DieuTri      NVARCHAR(MAX),
    BA_GhiChu       NVARCHAR(MAX),
    BN_MaBN         VARCHAR(50)   NOT NULL REFERENCES BENH_NHAN(BN_MaBN),
    HS_MaHoSo       VARCHAR(50)   REFERENCES HO_SO_NHAP_VIEN(HS_MaHoSo)
)
GO


-- ================================================================
-- PHAN HE 2: CHAN DOAN & DIEU TRI
-- ================================================================

-- Quan he CO_CHAN_DOAN (BENH_AN 1 -- N CHAN_DOAN), total tren CHAN_DOAN.
-- Quan he THUC_HIEN (BAC_SI 1 -- N CHAN_DOAN): FK BS_MaBS them o cuoi file.
CREATE TABLE CHAN_DOAN (
    CD_MaChanDoan   VARCHAR(50)   PRIMARY KEY,
    CD_TenChanDoan  NVARCHAR(255) NOT NULL,
    CD_MoTa         NVARCHAR(MAX),
    CD_NgayChanDoan DATE          NOT NULL,
    BA_MaBenhAn     VARCHAR(50)   NOT NULL REFERENCES BENH_AN(BA_MaBenhAn)
)
GO

-- Quan he CO_DON_THUOC (CHAN_DOAN 1 -- N DON_THUOC), total tren DON_THUOC.
-- Quan he KE_DON (BAC_SI 1 -- N DON_THUOC): FK BS_MaBS them o cuoi file.
CREATE TABLE DON_THUOC (
    DT_MaDonThuoc   VARCHAR(50)   PRIMARY KEY,
    DT_NgayKeDon    DATE          NOT NULL,
    DT_GhiChu       NVARCHAR(MAX),
    CD_MaChanDoan   VARCHAR(50)   NOT NULL REFERENCES CHAN_DOAN(CD_MaChanDoan)
)
GO

-- Quan he CO_CHI_TIET (DON_THUOC 1 -- N CHI_TIET_DON_THUOC), total tren CHI_TIET_DON_THUOC.
-- Quan he GOM_THUOC (THUOC 1 -- N CHI_TIET_DON_THUOC): FK TH_MaThuoc them o cuoi file.
CREATE TABLE CHI_TIET_DON_THUOC (
    CT_MaChiTiet        VARCHAR(50)   PRIMARY KEY,
    CT_SoLuong          INT           NOT NULL,
    CT_LieuDung         NVARCHAR(255),
    CT_ThoiGianSuDung    NVARCHAR(255),
    DT_MaDonThuoc       VARCHAR(50)   NOT NULL REFERENCES DON_THUOC(DT_MaDonThuoc)
)
GO

-- Quan he CO_PHAC_DO (CHAN_DOAN 1 -- N PHAC_DO_DIEU_TRI), total tren PHAC_DO_DIEU_TRI.
CREATE TABLE PHAC_DO_DIEU_TRI (
    PD_MaPhacDo         VARCHAR(50)   PRIMARY KEY,
    PD_TenPhacDo        NVARCHAR(255) NOT NULL,
    PD_MoTa             NVARCHAR(MAX),
    PD_ThoiGianDieuTri  NVARCHAR(100),
    CD_MaChanDoan       VARCHAR(50)   NOT NULL REFERENCES CHAN_DOAN(CD_MaChanDoan)
)
GO

CREATE TABLE DICH_VU_YTE (
    DV_MaDichVu     VARCHAR(50)   PRIMARY KEY,
    DV_TenDichVu    NVARCHAR(255) NOT NULL,
    DV_GiaDichVu    NUMERIC(14,2) NOT NULL,
    DV_MoTa         NVARCHAR(MAX),
    DV_LoaiDichVu   NVARCHAR(100)
)
GO

-- Quan he SU_DUNG (PHAC_DO_DIEU_TRI M -- N DICH_VU_YTE): bang trung gian.
CREATE TABLE PHACDO_SUDUNG_DICHVU (
    PD_MaPhacDo     VARCHAR(50)   NOT NULL REFERENCES PHAC_DO_DIEU_TRI(PD_MaPhacDo),
    DV_MaDichVu     VARCHAR(50)   NOT NULL REFERENCES DICH_VU_YTE(DV_MaDichVu),
    PRIMARY KEY (PD_MaPhacDo, DV_MaDichVu)
)
GO


-- ================================================================
-- PHAN HE 3: XET NGHIEM & CHAN DOAN HINH ANH
-- ================================================================

CREATE TABLE THIET_BI_YTE (
    TB_MaThietBi    VARCHAR(50)   PRIMARY KEY,
    TB_TenThietBi   NVARCHAR(255) NOT NULL,
    TB_LoaiThietBi  NVARCHAR(100),
    TB_HangSanXuat  NVARCHAR(255),
    TB_NgayBaoTri   DATE,
    TB_TrangThai    NVARCHAR(50)
)
GO

CREATE TABLE DANH_MUC_XET_NGHIEM (
    DM_MaXetNghiem      VARCHAR(50)   PRIMARY KEY,
    DM_TenXetNghiem     NVARCHAR(255) NOT NULL,
    DM_LoaiXetNghiem    NVARCHAR(100),
    DM_MoTa             NVARCHAR(MAX),
    DM_DonViTinh        NVARCHAR(50),
    DM_GiaTien          NUMERIC(14,2)
)
GO

-- Quan he LAY_TU (BENH_NHAN 1 -- N MAU_BENH_PHAM), total tren MAU_BENH_PHAM.
CREATE TABLE MAU_BENH_PHAM (
    BP_MaMauBenhPham    VARCHAR(50)   PRIMARY KEY,
    BP_LoaiMau          NVARCHAR(100),
    BP_NgayLayMau       DATE          NOT NULL,
    BP_GioLayMau        TIME,
    BP_TinhTrangMau     NVARCHAR(100),
    BN_MaBN             VARCHAR(50)   NOT NULL REFERENCES BENH_NHAN(BN_MaBN)
)
GO

-- Quan he CO_KET_QUA (BENH_AN 1 -- N KET_QUA_XET_NGHIEM), total tren KET_QUA_XET_NGHIEM.
-- Quan he THUOC (DANH_MUC_XET_NGHIEM 1 -- N KET_QUA_XET_NGHIEM), total tren KET_QUA_XET_NGHIEM.
-- Quan he TAO_TU_MAU (KET_QUA_XET_NGHIEM N -- 1 MAU_BENH_PHAM).
CREATE TABLE KET_QUA_XET_NGHIEM (
    KQ_MaKetQua             VARCHAR(50)   PRIMARY KEY,
    KQ_NgayThucHien         DATE          NOT NULL,
    KQ_KetQua               NVARCHAR(MAX),
    KQ_ChiSoDo              NVARCHAR(100),
    KQ_GiaTriThamChieu      NVARCHAR(100),
    KQ_KetLuan              NVARCHAR(MAX),
    BA_MaBenhAn             VARCHAR(50)   NOT NULL REFERENCES BENH_AN(BA_MaBenhAn),
    DM_MaXetNghiem          VARCHAR(50)   NOT NULL REFERENCES DANH_MUC_XET_NGHIEM(DM_MaXetNghiem),
    BP_MaMauBenhPham        VARCHAR(50)   NOT NULL REFERENCES MAU_BENH_PHAM(BP_MaMauBenhPham)
)
GO

-- Quan he CO_HINH_ANH (BENH_AN 1 -- N CHAN_DOAN_HINH_ANH), total tren CHAN_DOAN_HINH_ANH.
-- Quan he THUC_HIEN (THIET_BI_YTE 1 -- N CHAN_DOAN_HINH_ANH), total tren CHAN_DOAN_HINH_ANH.
CREATE TABLE CHAN_DOAN_HINH_ANH (
    HA_MaHinhAnh        VARCHAR(50)   PRIMARY KEY,
    HA_LoaiChanDoan     NVARCHAR(100),
    HA_NgayThucHien     DATE          NOT NULL,
    HA_KetQua           NVARCHAR(MAX),
    HA_HinhAnh          NVARCHAR(255),
    HA_KetLuan          NVARCHAR(MAX),
    BA_MaBenhAn         VARCHAR(50)   NOT NULL REFERENCES BENH_AN(BA_MaBenhAn),
    TB_MaThietBi        VARCHAR(50)   NOT NULL REFERENCES THIET_BI_YTE(TB_MaThietBi)
)
GO


-- ================================================================
-- PHAN HE 4: NHAN SU & KHOA PHONG
-- ================================================================

CREATE TABLE KHOA (
    K_MaKhoa    VARCHAR(50)   PRIMARY KEY,
    K_TenKhoa   NVARCHAR(255) NOT NULL,
    K_SoDien    VARCHAR(20),
    K_ViTri     NVARCHAR(255)
    -- Cot K_MaBS_TruongKhoa duoc them bang ALTER TABLE o cuoi file de tranh
    -- phu thuoc vong: KHOA -> BAC_SI -> NHAN_VIEN -> KHOA.
)
GO

-- Quan he BAO_GOM (KHOA 1 -- N PHONG_BENH), total tren PHONG_BENH.
CREATE TABLE PHONG_BENH (
    PB_MaPhong      VARCHAR(50)   PRIMARY KEY,
    PB_SoPhong      VARCHAR(20)   NOT NULL,
    PB_LoaiPhong    NVARCHAR(50),
    PB_SucChua      INT,
    PB_TrangThai    NVARCHAR(50),
    K_MaKhoa        VARCHAR(50)   NOT NULL REFERENCES KHOA(K_MaKhoa)
)
GO

-- Quan he THUOC_KHOA (KHOA 1 -- N NHAN_VIEN), total tren NHAN_VIEN.
CREATE TABLE NHAN_VIEN (
    NV_MaNV     VARCHAR(50)   PRIMARY KEY,
    NV_Ten      NVARCHAR(255) NOT NULL,
    NV_NgaySinh DATE,
    NV_GioiTinh NVARCHAR(10),
    NV_SDT      VARCHAR(20),
    NV_CCCD     VARCHAR(20)   UNIQUE,
    NV_VaiTro   NVARCHAR(50),
    K_MaKhoa    VARCHAR(50)   NOT NULL REFERENCES KHOA(K_MaKhoa)
)
GO

-- IS-A: BAC_SI la chuyen mon hoa cua NHAN_VIEN (PK cung la FK).
-- Quan he DE QUY: THAM_VAN (BAC_SI -- BAC_SI), 1 -- N, partial ca hai phia.
CREATE TABLE BAC_SI (
    BS_MaBS             VARCHAR(50)   PRIMARY KEY REFERENCES NHAN_VIEN(NV_MaNV),
    BS_ChuyenKhoa       NVARCHAR(255),
    BS_CapBac           NVARCHAR(50),
    BS_HocVi            NVARCHAR(50),
    BS_CCHN             VARCHAR(50),
    BS_NamKN            INT,
    BS_MaBS_ThamVan     VARCHAR(50)   REFERENCES BAC_SI(BS_MaBS)
)
GO

-- IS-A: DIEU_DUONG la chuyen mon hoa cua NHAN_VIEN (PK cung la FK).
CREATE TABLE DIEU_DUONG (
    DD_MaDD     VARCHAR(50)   PRIMARY KEY REFERENCES NHAN_VIEN(NV_MaNV),
    DD_CapBac   NVARCHAR(50),
    DD_CCHN     VARCHAR(50)
)
GO

-- Quan he PHAN_CONG (NHAN_VIEN 1 -- N LICH_TRUC) va QUAN_LY_LICH (KHOA 1 -- N LICH_TRUC),
-- total tren LICH_TRUC o ca hai quan he.
CREATE TABLE LICH_TRUC (
    LT_MaLichTruc   VARCHAR(50)   PRIMARY KEY,
    LT_Ngay         DATE          NOT NULL,
    LT_Ca           NVARCHAR(20),
    LT_TrangThai    NVARCHAR(50),
    LT_GhiChu       NVARCHAR(MAX),
    LT_TGBD         DATETIME2,
    LT_TGKT         DATETIME2,
    NV_MaNV         VARCHAR(50)   NOT NULL REFERENCES NHAN_VIEN(NV_MaNV),
    K_MaKhoa        VARCHAR(50)   NOT NULL REFERENCES KHOA(K_MaKhoa)
)
GO


-- ================================================================
-- PHAN HE 5: DUOC & VAT TU Y TE
-- ================================================================

CREATE TABLE NHA_CUNG_CAP (
    NCC_MaNCC       VARCHAR(50)   PRIMARY KEY,
    NCC_TenNCC      NVARCHAR(255) NOT NULL,
    NCC_SDT         VARCHAR(20),
    NCC_DiaChi      NVARCHAR(255),
    NCC_MST         VARCHAR(50)   UNIQUE
)
GO

-- Quan he CUNG_CAP (NHA_CUNG_CAP 1 -- N DON_NHAP_HANG), total tren DON_NHAP_HANG.
CREATE TABLE DON_NHAP_HANG (
    DNH_MaDon       VARCHAR(50)   PRIMARY KEY,
    DNH_NgayLap     DATE          NOT NULL,
    DNH_NgayNhap    DATE,
    DNH_TrangThai   NVARCHAR(50),
    DNH_NguoiLap    NVARCHAR(255),
    NCC_MaNCC       VARCHAR(50)   NOT NULL REFERENCES NHA_CUNG_CAP(NCC_MaNCC)
)
GO

CREATE TABLE THUOC (
    TH_MaThuoc          VARCHAR(50)   PRIMARY KEY,
    TH_TenThuongMai     NVARCHAR(255) NOT NULL,
    TH_HoatChat         NVARCHAR(255),
    TH_KhoiLuong        NVARCHAR(50),
    TH_NhaSanXuat       NVARCHAR(255),
    TH_DangBaoBi        NVARCHAR(100),
    TH_DangBaoChe       NVARCHAR(100),
    TH_HanSuDung        DATE
)
GO

CREATE TABLE VAT_TU_YTE (
    VT_MaVatTu      VARCHAR(50)   PRIMARY KEY,
    VT_TenVatTu     NVARCHAR(255) NOT NULL,
    VT_DonViTinh    NVARCHAR(50),
    VT_ChatLieu     NVARCHAR(100),
    VT_CongDung     NVARCHAR(255)
)
GO

-- Thuc the yeu: PHIEU_XUAT_KHO phu thuoc vao DON_NHAP_HANG, khoa bo phan la So lo.
-- Moi phieu ung voi DUY NHAT 1 THUOC hoac 1 VAT_TU_YTE (khong ca hai) -> CHECK.
CREATE TABLE PHIEU_XUAT_KHO (
    DNH_MaDon       VARCHAR(50)   NOT NULL REFERENCES DON_NHAP_HANG(DNH_MaDon),
    PXK_SoLo        VARCHAR(50)   NOT NULL,
    PXK_HSD         DATE,
    PXK_SL          INT           NOT NULL,
    PXK_DonGia      NUMERIC(14,2),
    PXK_ThanhTien   NUMERIC(14,2),
    TH_MaThuoc      VARCHAR(50)   REFERENCES THUOC(TH_MaThuoc),
    VT_MaVatTu      VARCHAR(50)   REFERENCES VAT_TU_YTE(VT_MaVatTu),
    PRIMARY KEY (DNH_MaDon, PXK_SoLo),
    CONSTRAINT chk_phieuxuatkho_mot_loai CHECK (
        (TH_MaThuoc IS NOT NULL AND VT_MaVatTu IS NULL) OR
        (TH_MaThuoc IS NULL AND VT_MaVatTu IS NOT NULL)
    )
)
GO


-- ================================================================
-- PHAN HE 6: TAI CHINH & VIEN PHI
-- ================================================================

-- Quan he THANH_TOAN_HD (BENH_NHAN 1 -- N HOA_DON), total tren HOA_DON.
-- Quan he PHAT_SINH_HD (HO_SO_NHAP_VIEN 1 -- 1 HOA_DON): HS_MaHoSo nullable
-- (hoa don ngoai tru khong gan voi dot nhap vien nao).
CREATE TABLE HOA_DON (
    HD_MaHD         VARCHAR(50)   PRIMARY KEY,
    HD_TongChiPhi   NUMERIC(14,2) NOT NULL,
    HD_TienBHYT     NUMERIC(14,2) DEFAULT 0,
    HD_TienBN       NUMERIC(14,2) DEFAULT 0,
    BN_MaBN         VARCHAR(50)   NOT NULL REFERENCES BENH_NHAN(BN_MaBN),
    HS_MaHoSo       VARCHAR(50)   REFERENCES HO_SO_NHAP_VIEN(HS_MaHoSo)
)
GO

-- Quan he CO_THANH_TOAN (HOA_DON 1 -- N THANH_TOAN), total tren THANH_TOAN.
-- Quan he THU_TIEN (NHAN_VIEN 1 -- N THANH_TOAN), total tren THANH_TOAN.
CREATE TABLE THANH_TOAN (
    TT_MaTT         VARCHAR(50)   PRIMARY KEY,
    TT_Loai         NVARCHAR(50),
    TT_SoTien       NUMERIC(14,2) NOT NULL,
    TT_PhuongThuc   NVARCHAR(50),
    HD_MaHD         VARCHAR(50)   NOT NULL REFERENCES HOA_DON(HD_MaHD),
    NV_MaNV         VARCHAR(50)   NOT NULL REFERENCES NHAN_VIEN(NV_MaNV)
)
GO

-- Quan he AP_DUNG_BHYT (HOA_DON 1 -- 1 BOI_THUONG_BHYT), total tren BOI_THUONG_BHYT.
CREATE TABLE BOI_THUONG_BHYT (
    BT_MaQuyetToan  VARCHAR(50)   PRIMARY KEY,
    BT_SoTheBHYT    VARCHAR(50),
    BT_MaBenh       VARCHAR(50),
    BT_TiLe         NUMERIC(5,2),
    BT_TrangThai    NVARCHAR(50),
    HD_MaHD         VARCHAR(50)   NOT NULL UNIQUE REFERENCES HOA_DON(HD_MaHD)
)
GO

-- GIAO_DICH phat sinh tu DUY NHAT mot THANH_TOAN hoac mot BOI_THUONG_BHYT.
CREATE TABLE GIAO_DICH (
    GD_MaGD         VARCHAR(50)   PRIMARY KEY,
    GD_MaThamChieu  NVARCHAR(100),
    GD_NguonTien    NVARCHAR(100),
    GD_SoTienGD     NUMERIC(14,2) NOT NULL,
    GD_ThoiGian     DATETIME2,
    TT_MaTT         VARCHAR(50)   REFERENCES THANH_TOAN(TT_MaTT),
    BT_MaQuyetToan  VARCHAR(50)   REFERENCES BOI_THUONG_BHYT(BT_MaQuyetToan),
    CONSTRAINT chk_giaodich_mot_nguon CHECK (
        (TT_MaTT IS NOT NULL AND BT_MaQuyetToan IS NULL) OR
        (TT_MaTT IS NULL AND BT_MaQuyetToan IS NOT NULL)
    )
)
GO

-- Quan he CHI_TIET_DICH_VU (DICH_VU_YTE M -- N HOA_DON): bang trung gian.
CREATE TABLE HOADON_CHITIET_DICHVU (
    HD_MaHD         VARCHAR(50)   NOT NULL REFERENCES HOA_DON(HD_MaHD),
    DV_MaDichVu     VARCHAR(50)   NOT NULL REFERENCES DICH_VU_YTE(DV_MaDichVu),
    SoLuong         INT           NOT NULL DEFAULT 1,
    ThanhTien       NUMERIC(14,2),
    PRIMARY KEY (HD_MaHD, DV_MaDichVu)
)
GO


-- ================================================================
-- LIEN KET GIUA CAC PHAN HE + QUAN HE TAM NGUYEN
-- (them sau khi tat ca bang lien quan da ton tai)
-- ================================================================

-- HO_SO_NHAP_VIEN can khoa dieu tri va phong benh nam tai (Phan he 1 <-> 4).
ALTER TABLE HO_SO_NHAP_VIEN
    ADD K_MaKhoa VARCHAR(50) NOT NULL REFERENCES KHOA(K_MaKhoa)
GO

ALTER TABLE HO_SO_NHAP_VIEN
    ADD PB_MaPhong VARCHAR(50) NOT NULL REFERENCES PHONG_BENH(PB_MaPhong)
GO

-- CHAN_DOAN va DON_THUOC can bac si thuc hien / ke don (Phan he 2 <-> 4).
ALTER TABLE CHAN_DOAN
    ADD BS_MaBS VARCHAR(50) NOT NULL REFERENCES BAC_SI(BS_MaBS)
GO

ALTER TABLE DON_THUOC
    ADD BS_MaBS VARCHAR(50) NOT NULL REFERENCES BAC_SI(BS_MaBS)
GO

-- CHI_TIET_DON_THUOC can thuoc cu the (Phan he 2 <-> 5).
ALTER TABLE CHI_TIET_DON_THUOC
    ADD TH_MaThuoc VARCHAR(50) NOT NULL REFERENCES THUOC(TH_MaThuoc)
GO

-- KHOA can truong khoa (bac si dung dau) - phu thuoc vong KHOA -> BAC_SI -> NHAN_VIEN -> KHOA,
-- nen de nullable va thiet lap bang UPDATE sau khi da co du lieu Nhan su.
ALTER TABLE KHOA
    ADD BS_MaBS_TruongKhoa VARCHAR(50) UNIQUE REFERENCES BAC_SI(BS_MaBS)
GO

-- Bo sung them rang buoc CHECK cho cac cot so lieu quan trong (dam bao gia tri hop le).
ALTER TABLE DICH_VU_YTE
    ADD CONSTRAINT chk_dichvu_gia CHECK (DV_GiaDichVu >= 0)
GO

ALTER TABLE HOA_DON
    ADD CONSTRAINT chk_hoadon_tongchiphi CHECK (HD_TongChiPhi >= 0)
GO

ALTER TABLE CHI_TIET_DON_THUOC
    ADD CONSTRAINT chk_chitietdonthuoc_soluong CHECK (CT_SoLuong > 0)
GO

-- Quan he TAM NGUYEN: THUC_HIEN_DICH_VU noi dong thoi BAC_SI - BENH_NHAN - DICH_VU_YTE,
-- ghi nhan "bac si nao thuc hien dich vu nao cho benh nhan nao". Khong the tach thanh 2 quan he
-- nhi nguyen ma khong mat thong tin.
CREATE TABLE THUC_HIEN_DICH_VU (
    THDV_MaThucHien     VARCHAR(50)   PRIMARY KEY,
    BS_MaBS             VARCHAR(50)   NOT NULL REFERENCES BAC_SI(BS_MaBS),
    BN_MaBN             VARCHAR(50)   NOT NULL REFERENCES BENH_NHAN(BN_MaBN),
    DV_MaDichVu         VARCHAR(50)   NOT NULL REFERENCES DICH_VU_YTE(DV_MaDichVu),
    THDV_NgayThucHien   DATE          NOT NULL,
    THDV_GhiChu         NVARCHAR(MAX),
    CONSTRAINT uq_thuchiendichvu UNIQUE (BS_MaBS, BN_MaBN, DV_MaDichVu, THDV_NgayThucHien)
)
GO


-- ================================================================
-- INDEX GOI Y CHO CAC KHOA NGOAI THUONG DUOC TRUY VAN
-- ================================================================

CREATE INDEX idx_lichhen_benhnhan          ON LICH_HEN(BN_MaBN)
GO
CREATE INDEX idx_hosonhapvien_benhnhan     ON HO_SO_NHAP_VIEN(BN_MaBN)
GO
CREATE INDEX idx_benhan_benhnhan           ON BENH_AN(BN_MaBN)
GO
CREATE INDEX idx_chandoan_benhan           ON CHAN_DOAN(BA_MaBenhAn)
GO
CREATE INDEX idx_ketquaxn_benhan           ON KET_QUA_XET_NGHIEM(BA_MaBenhAn)
GO
CREATE INDEX idx_chandoanhinhanh_benhan    ON CHAN_DOAN_HINH_ANH(BA_MaBenhAn)
GO
CREATE INDEX idx_nhanvien_khoa             ON NHAN_VIEN(K_MaKhoa)
GO
CREATE INDEX idx_lichtruc_nhanvien         ON LICH_TRUC(NV_MaNV)
GO
CREATE INDEX idx_hoadon_benhnhan           ON HOA_DON(BN_MaBN)
GO
CREATE INDEX idx_thanhtoan_hoadon          ON THANH_TOAN(HD_MaHD)
GO
CREATE INDEX idx_bacsi_thamvan             ON BAC_SI(BS_MaBS_ThamVan)
GO
CREATE INDEX idx_thuchiendv_bacsi          ON THUC_HIEN_DICH_VU(BS_MaBS)
GO
CREATE INDEX idx_thuchiendv_benhnhan       ON THUC_HIEN_DICH_VU(BN_MaBN)
GO
CREATE INDEX idx_thuchiendv_dichvu         ON THUC_HIEN_DICH_VU(DV_MaDichVu)
GO

PRINT 'Da tao xong 33 bang cho CSDL QLBenhVien.'
GO
