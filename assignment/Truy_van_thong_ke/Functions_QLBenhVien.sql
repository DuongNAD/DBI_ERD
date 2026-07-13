-- ================================================================
--  FUNCTIONS - HE THONG QUAN LY BENH VIEN (QLBenhVien)
--  Chay Database_QLBenhVien.sql va Values_QLBenhVien.sql truoc.
-- ================================================================

IF DB_ID('QLBenhVien') IS NULL
BEGIN
    RAISERROR(N'Database QLBenhVien chua ton tai. Vui long chay Database_QLBenhVien.sql truoc.', 20, 1) WITH LOG
END
GO

USE QLBenhVien
GO

-- ================================================================
-- 1. fn_TinhTuoiBenhNhan: tinh tuoi benh nhan theo ngay hien tai
-- ================================================================
IF OBJECT_ID('fn_TinhTuoiBenhNhan', 'FN') IS NOT NULL DROP FUNCTION fn_TinhTuoiBenhNhan
GO
CREATE FUNCTION fn_TinhTuoiBenhNhan (@BN_MaBN VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @Tuoi INT
    SELECT @Tuoi = DATEDIFF(YEAR, BN_NgaySinh, GETDATE())
           - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, BN_NgaySinh, GETDATE()), BN_NgaySinh) > GETDATE()
                  THEN 1 ELSE 0 END
    FROM BENH_NHAN
    WHERE BN_MaBN = @BN_MaBN
    RETURN @Tuoi
END
GO

-- ================================================================
-- 2. fn_TongChiPhiBenhNhan: tong chi phi tren tat ca hoa don cua 1 benh nhan
-- ================================================================
IF OBJECT_ID('fn_TongChiPhiBenhNhan', 'FN') IS NOT NULL DROP FUNCTION fn_TongChiPhiBenhNhan
GO
CREATE FUNCTION fn_TongChiPhiBenhNhan (@BN_MaBN VARCHAR(50))
RETURNS NUMERIC(14,2)
AS
BEGIN
    DECLARE @Tong NUMERIC(14,2)
    SELECT @Tong = SUM(HD_TongChiPhi) FROM HOA_DON WHERE BN_MaBN = @BN_MaBN
    RETURN ISNULL(@Tong, 0)
END
GO

-- ================================================================
-- 3. fn_SoNgayNamVien: so ngay nam vien cua 1 ho so nhap vien
-- ================================================================
IF OBJECT_ID('fn_SoNgayNamVien', 'FN') IS NOT NULL DROP FUNCTION fn_SoNgayNamVien
GO
CREATE FUNCTION fn_SoNgayNamVien (@HS_MaHoSo VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @SoNgay INT
    SELECT @SoNgay = DATEDIFF(DAY, HS_NgayNhapVien, ISNULL(HS_NgayRaVien, CAST(GETDATE() AS DATE)))
    FROM HO_SO_NHAP_VIEN
    WHERE HS_MaHoSo = @HS_MaHoSo
    RETURN @SoNgay
END
GO

-- ================================================================
-- 4. fn_KiemTraConBHYT: kiem tra benh nhan con BHYT hieu luc hay khong (1/0)
-- ================================================================
IF OBJECT_ID('fn_KiemTraConBHYT', 'FN') IS NOT NULL DROP FUNCTION fn_KiemTraConBHYT
GO
CREATE FUNCTION fn_KiemTraConBHYT (@BN_MaBN VARCHAR(50))
RETURNS BIT
AS
BEGIN
    DECLARE @KetQua BIT = 0
    IF EXISTS (
        SELECT 1 FROM BAO_HIEM_YT
        WHERE BN_MaBN = @BN_MaBN AND BH_NgayHetHan >= CAST(GETDATE() AS DATE)
    )
        SET @KetQua = 1
    RETURN @KetQua
END
GO

-- ================================================================
-- 5. fn_LayTenKhoa: tra ve ten khoa theo ma khoa
-- ================================================================
IF OBJECT_ID('fn_LayTenKhoa', 'FN') IS NOT NULL DROP FUNCTION fn_LayTenKhoa
GO
CREATE FUNCTION fn_LayTenKhoa (@K_MaKhoa VARCHAR(50))
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @Ten NVARCHAR(255)
    SELECT @Ten = K_TenKhoa FROM KHOA WHERE K_MaKhoa = @K_MaKhoa
    RETURN @Ten
END
GO

-- ================================================================
-- 6. fn_TongTienDaThanhToan: tong tien da thanh toan cho 1 hoa don
-- ================================================================
IF OBJECT_ID('fn_TongTienDaThanhToan', 'FN') IS NOT NULL DROP FUNCTION fn_TongTienDaThanhToan
GO
CREATE FUNCTION fn_TongTienDaThanhToan (@HD_MaHD VARCHAR(50))
RETURNS NUMERIC(14,2)
AS
BEGIN
    DECLARE @Tong NUMERIC(14,2)
    SELECT @Tong = SUM(TT_SoTien) FROM THANH_TOAN WHERE HD_MaHD = @HD_MaHD
    RETURN ISNULL(@Tong, 0)
END
GO

-- ================================================================
-- 7. fn_XepLoaiHoaDon: xep loai hoa don theo tong chi phi
-- ================================================================
IF OBJECT_ID('fn_XepLoaiHoaDon', 'FN') IS NOT NULL DROP FUNCTION fn_XepLoaiHoaDon
GO
CREATE FUNCTION fn_XepLoaiHoaDon (@HD_MaHD VARCHAR(50))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @Tong NUMERIC(14,2)
    DECLARE @Loai NVARCHAR(20)
    SELECT @Tong = HD_TongChiPhi FROM HOA_DON WHERE HD_MaHD = @HD_MaHD

    SET @Loai = CASE
        WHEN @Tong IS NULL THEN N'Không xác định'
        WHEN @Tong < 500000 THEN N'Nhỏ'
        WHEN @Tong < 2000000 THEN N'Trung bình'
        ELSE N'Lớn'
    END
    RETURN @Loai
END
GO

-- ================================================================
-- 8. fn_SoBenhNhanDangDieuTri: dem so benh nhan dang dieu tri noi tru
-- ================================================================
IF OBJECT_ID('fn_SoBenhNhanDangDieuTri', 'FN') IS NOT NULL DROP FUNCTION fn_SoBenhNhanDangDieuTri
GO
CREATE FUNCTION fn_SoBenhNhanDangDieuTri ()
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT
    SELECT @SoLuong = COUNT(DISTINCT BN_MaBN) FROM HO_SO_NHAP_VIEN WHERE HS_NgayRaVien IS NULL
    RETURN @SoLuong
END
GO

-- ================================================================
-- 9. fn_DanhSachChanDoanCuaBenhNhan: ham bang (table-valued) - tra ve moi chan
-- doan cua 1 benh nhan kem ten bac si (JOIN Ben trong ham)
-- ================================================================
IF OBJECT_ID('fn_DanhSachChanDoanCuaBenhNhan', 'FN') IS NOT NULL DROP FUNCTION fn_DanhSachChanDoanCuaBenhNhan
GO
CREATE FUNCTION fn_DanhSachChanDoanCuaBenhNhan (@BN_MaBN VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT cd.CD_MaChanDoan, cd.CD_TenChanDoan, cd.CD_NgayChanDoan, nv.NV_Ten AS TenBacSi
    FROM CHAN_DOAN cd
    JOIN BENH_AN ba ON cd.BA_MaBenhAn = ba.BA_MaBenhAn
    JOIN NHAN_VIEN nv ON cd.BS_MaBS = nv.NV_MaNV
    WHERE ba.BN_MaBN = @BN_MaBN
)
GO

-- ================================================================
-- 10. fn_DemSoDichVuBacSiThucHien: dem so dich vu 1 bac si da thuc hien
-- (dua tren quan he TAM NGUYEN THUC_HIEN_DICH_VU)
-- ================================================================
IF OBJECT_ID('fn_DemSoDichVuBacSiThucHien', 'FN') IS NOT NULL DROP FUNCTION fn_DemSoDichVuBacSiThucHien
GO
CREATE FUNCTION fn_DemSoDichVuBacSiThucHien (@BS_MaBS VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @SoLuong INT
    SELECT @SoLuong = COUNT(*) FROM THUC_HIEN_DICH_VU WHERE BS_MaBS = @BS_MaBS
    RETURN ISNULL(@SoLuong, 0)
END
GO

PRINT N'Da tao xong 10 functions.'
GO
