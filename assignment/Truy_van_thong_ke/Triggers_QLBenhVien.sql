-- ================================================================
--  TRIGGERS - HE THONG QUAN LY BENH VIEN (QLBenhVien)
--  Chay Database_QLBenhVien.sql va Values_QLBenhVien.sql truoc.
-- ================================================================

IF DB_ID('QLBenhVien') IS NULL
BEGIN
    RAISERROR(N'Database QLBenhVien chua ton tai. Vui long chay Database_QLBenhVien.sql truoc.', 20, 1) WITH LOG
END
GO

USE QLBenhVien
GO

-- Bang phu tro luu lich su xoa benh nhan, phuc vu trigger AFTER DELETE (so 5)
IF OBJECT_ID('LICH_SU_XOA_BENH_NHAN', 'U') IS NULL
BEGIN
    CREATE TABLE LICH_SU_XOA_BENH_NHAN (
        LogID           INT IDENTITY(1,1) PRIMARY KEY,
        BN_MaBN         VARCHAR(50),
        BN_HoTen        NVARCHAR(255),
        ThoiGianXoa     DATETIME2 DEFAULT GETDATE()
    )
END
GO

-- ================================================================
-- 1. trg_CapNhatTongChiPhiHoaDon: sau khi them dich vu vao hoa don, cong don
-- ThanhTien vao HOA_DON.HD_TongChiPhi (giu du lieu tong hop luon dong bo)
-- ================================================================
IF OBJECT_ID('trg_CapNhatTongChiPhiHoaDon', 'TR') IS NOT NULL DROP TRIGGER trg_CapNhatTongChiPhiHoaDon
GO
CREATE TRIGGER trg_CapNhatTongChiPhiHoaDon
ON HOADON_CHITIET_DICHVU
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON
    UPDATE hd
    SET hd.HD_TongChiPhi = hd.HD_TongChiPhi + t.TongThem
    FROM HOA_DON hd
    JOIN (
        SELECT HD_MaHD, SUM(ThanhTien) AS TongThem
        FROM inserted
        GROUP BY HD_MaHD
    ) t ON hd.HD_MaHD = t.HD_MaHD
END
GO

-- ================================================================
-- 2. trg_KiemTraNgayRaVien: dam bao ngay ra vien khong truoc ngay nhap vien
-- ================================================================
IF OBJECT_ID('trg_KiemTraNgayRaVien', 'TR') IS NOT NULL DROP TRIGGER trg_KiemTraNgayRaVien
GO
CREATE TRIGGER trg_KiemTraNgayRaVien
ON HO_SO_NHAP_VIEN
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE HS_NgayRaVien IS NOT NULL AND HS_NgayRaVien < HS_NgayNhapVien
    )
    BEGIN
        RAISERROR(N'Ngay ra vien khong the truoc ngay nhap vien.', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

-- ================================================================
-- 3. trg_NganChanTrucTrung: khong cho 1 nhan vien co 2 lich truc cung ngay,
-- cung ca lam viec
-- ================================================================
IF OBJECT_ID('trg_NganChanTrucTrung', 'TR') IS NOT NULL DROP TRIGGER trg_NganChanTrucTrung
GO
CREATE TRIGGER trg_NganChanTrucTrung
ON LICH_TRUC
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN LICH_TRUC lt ON lt.NV_MaNV = i.NV_MaNV AND lt.LT_Ngay = i.LT_Ngay AND lt.LT_Ca = i.LT_Ca
                          AND lt.LT_MaLichTruc <> i.LT_MaLichTruc
    )
    BEGIN
        RAISERROR(N'Nhan vien da co lich truc trung ngay va ca lam viec.', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

-- ================================================================
-- 4. trg_CapNhatTrangThaiPhongKhiRaVien: khi benh nhan ra vien (HS_NgayRaVien
-- duoc gan tu NULL sang co gia tri), tra phong benh ve trang thai "Con trong"
-- ================================================================
IF OBJECT_ID('trg_CapNhatTrangThaiPhongKhiRaVien', 'TR') IS NOT NULL DROP TRIGGER trg_CapNhatTrangThaiPhongKhiRaVien
GO
CREATE TRIGGER trg_CapNhatTrangThaiPhongKhiRaVien
ON HO_SO_NHAP_VIEN
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON
    UPDATE pb
    SET pb.PB_TrangThai = N'Còn trống'
    FROM PHONG_BENH pb
    JOIN inserted i ON pb.PB_MaPhong = i.PB_MaPhong
    JOIN deleted d ON d.HS_MaHoSo = i.HS_MaHoSo
    WHERE d.HS_NgayRaVien IS NULL AND i.HS_NgayRaVien IS NOT NULL
END
GO

-- ================================================================
-- 5. trg_LogXoaBenhNhan: ghi log moi khi mot benh nhan bi xoa khoi he thong
-- ================================================================
IF OBJECT_ID('trg_LogXoaBenhNhan', 'TR') IS NOT NULL DROP TRIGGER trg_LogXoaBenhNhan
GO
CREATE TRIGGER trg_LogXoaBenhNhan
ON BENH_NHAN
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO LICH_SU_XOA_BENH_NHAN (BN_MaBN, BN_HoTen, ThoiGianXoa)
    SELECT BN_MaBN, BN_HoTen, GETDATE() FROM deleted
END
GO

-- ================================================================
-- 6. trg_NganChanThamVanBanThan: bac si khong the tu tham van chinh minh
-- (rang buoc bo sung cho quan he DE QUY THAM_VAN)
-- ================================================================
IF OBJECT_ID('trg_NganChanThamVanBanThan', 'TR') IS NOT NULL DROP TRIGGER trg_NganChanThamVanBanThan
GO
CREATE TRIGGER trg_NganChanThamVanBanThan
ON BAC_SI
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (SELECT 1 FROM inserted WHERE BS_MaBS_ThamVan = BS_MaBS)
    BEGIN
        RAISERROR(N'Bac si khong the tu tham van chinh minh.', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO

PRINT N'Da tao xong 6 triggers.'
GO
