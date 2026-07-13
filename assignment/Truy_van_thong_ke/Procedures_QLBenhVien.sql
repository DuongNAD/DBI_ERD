-- ================================================================
--  STORED PROCEDURES - HE THONG QUAN LY BENH VIEN (QLBenhVien)
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
-- 1. sp_ThemBenhNhan: them moi mot benh nhan
-- ================================================================
IF OBJECT_ID('sp_ThemBenhNhan', 'P') IS NOT NULL DROP PROCEDURE sp_ThemBenhNhan
GO
CREATE PROCEDURE sp_ThemBenhNhan
    @BN_MaBN         VARCHAR(50),
    @BN_HoTen        NVARCHAR(255),
    @BN_NgaySinh     DATE = NULL,
    @BN_GioiTinh     NVARCHAR(10) = NULL,
    @BN_SoDienThoai  VARCHAR(20)  = NULL,
    @BN_DiaChi       NVARCHAR(255) = NULL,
    @BN_Email        VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (SELECT 1 FROM BENH_NHAN WHERE BN_MaBN = @BN_MaBN)
    BEGIN
        RAISERROR(N'Ma benh nhan %s da ton tai.', 16, 1, @BN_MaBN)
        RETURN
    END
    INSERT INTO BENH_NHAN (BN_MaBN, BN_HoTen, BN_NgaySinh, BN_GioiTinh, BN_SoDienThoai, BN_DiaChi, BN_Email)
    VALUES (@BN_MaBN, @BN_HoTen, @BN_NgaySinh, @BN_GioiTinh, @BN_SoDienThoai, @BN_DiaChi, @BN_Email)
END
GO

-- ================================================================
-- 2. sp_DatLichHen: dat lich hen kham cho benh nhan
-- ================================================================
IF OBJECT_ID('sp_DatLichHen', 'P') IS NOT NULL DROP PROCEDURE sp_DatLichHen
GO
CREATE PROCEDURE sp_DatLichHen
    @LH_MaLichHen VARCHAR(50),
    @BN_MaBN      VARCHAR(50),
    @LH_NgayHen   DATE,
    @LH_GioHen    TIME = NULL,
    @LH_LyDoKham  NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS (SELECT 1 FROM BENH_NHAN WHERE BN_MaBN = @BN_MaBN)
    BEGIN
        RAISERROR(N'Khong tim thay benh nhan %s.', 16, 1, @BN_MaBN)
        RETURN
    END
    INSERT INTO LICH_HEN (LH_MaLichHen, LH_NgayHen, LH_GioHen, LH_TrangThai, LH_LyDoKham, BN_MaBN)
    VALUES (@LH_MaLichHen, @LH_NgayHen, @LH_GioHen, N'Chờ xác nhận', @LH_LyDoKham, @BN_MaBN)
END
GO

-- ================================================================
-- 3. sp_CapNhatTrangThaiLichHen: cap nhat trang thai lich hen
-- ================================================================
IF OBJECT_ID('sp_CapNhatTrangThaiLichHen', 'P') IS NOT NULL DROP PROCEDURE sp_CapNhatTrangThaiLichHen
GO
CREATE PROCEDURE sp_CapNhatTrangThaiLichHen
    @LH_MaLichHen VARCHAR(50),
    @TrangThaiMoi NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
    UPDATE LICH_HEN SET LH_TrangThai = @TrangThaiMoi WHERE LH_MaLichHen = @LH_MaLichHen
    IF @@ROWCOUNT = 0
        RAISERROR(N'Khong tim thay lich hen %s.', 16, 1, @LH_MaLichHen)
END
GO

-- ================================================================
-- 4. sp_NhapVien: tao ho so nhap vien cho benh nhan
-- ================================================================
IF OBJECT_ID('sp_NhapVien', 'P') IS NOT NULL DROP PROCEDURE sp_NhapVien
GO
CREATE PROCEDURE sp_NhapVien
    @HS_MaHoSo        VARCHAR(50),
    @BN_MaBN          VARCHAR(50),
    @K_MaKhoa         VARCHAR(50),
    @PB_MaPhong       VARCHAR(50),
    @HS_LyDoNhapVien  NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS (SELECT 1 FROM PHONG_BENH WHERE PB_MaPhong = @PB_MaPhong AND K_MaKhoa = @K_MaKhoa)
    BEGIN
        RAISERROR(N'Phong %s khong thuoc khoa %s.', 16, 1, @PB_MaPhong, @K_MaKhoa)
        RETURN
    END
    INSERT INTO HO_SO_NHAP_VIEN (HS_MaHoSo, HS_NgayNhapVien, HS_LyDoNhapVien, HS_TrangThai, BN_MaBN, K_MaKhoa, PB_MaPhong)
    VALUES (@HS_MaHoSo, CAST(GETDATE() AS DATE), @HS_LyDoNhapVien, N'Đang điều trị', @BN_MaBN, @K_MaKhoa, @PB_MaPhong)

    UPDATE PHONG_BENH SET PB_TrangThai = N'Đang sử dụng' WHERE PB_MaPhong = @PB_MaPhong
END
GO

-- ================================================================
-- 5. sp_KeDonThuoc: tao don thuoc gan voi mot chan doan
-- ================================================================
IF OBJECT_ID('sp_KeDonThuoc', 'P') IS NOT NULL DROP PROCEDURE sp_KeDonThuoc
GO
CREATE PROCEDURE sp_KeDonThuoc
    @DT_MaDonThuoc VARCHAR(50),
    @CD_MaChanDoan VARCHAR(50),
    @BS_MaBS       VARCHAR(50),
    @DT_GhiChu     NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF NOT EXISTS (SELECT 1 FROM CHAN_DOAN WHERE CD_MaChanDoan = @CD_MaChanDoan)
    BEGIN
        RAISERROR(N'Khong tim thay chan doan %s.', 16, 1, @CD_MaChanDoan)
        RETURN
    END
    INSERT INTO DON_THUOC (DT_MaDonThuoc, DT_NgayKeDon, DT_GhiChu, CD_MaChanDoan, BS_MaBS)
    VALUES (@DT_MaDonThuoc, CAST(GETDATE() AS DATE), @DT_GhiChu, @CD_MaChanDoan, @BS_MaBS)
END
GO

-- ================================================================
-- 6. sp_ThemChiTietDonThuoc: them 1 dong thuoc vao don thuoc da co
-- ================================================================
IF OBJECT_ID('sp_ThemChiTietDonThuoc', 'P') IS NOT NULL DROP PROCEDURE sp_ThemChiTietDonThuoc
GO
CREATE PROCEDURE sp_ThemChiTietDonThuoc
    @CT_MaChiTiet VARCHAR(50),
    @DT_MaDonThuoc VARCHAR(50),
    @TH_MaThuoc    VARCHAR(50),
    @CT_SoLuong    INT,
    @CT_LieuDung   NVARCHAR(255) = NULL,
    @CT_ThoiGianSuDung NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF @CT_SoLuong <= 0
    BEGIN
        RAISERROR(N'So luong thuoc phai lon hon 0.', 16, 1)
        RETURN
    END
    INSERT INTO CHI_TIET_DON_THUOC (CT_MaChiTiet, CT_SoLuong, CT_LieuDung, CT_ThoiGianSuDung, DT_MaDonThuoc, TH_MaThuoc)
    VALUES (@CT_MaChiTiet, @CT_SoLuong, @CT_LieuDung, @CT_ThoiGianSuDung, @DT_MaDonThuoc, @TH_MaThuoc)
END
GO

-- ================================================================
-- 7. sp_TaoHoaDon: tao hoa don cho benh nhan (co the gan ho so nhap vien)
-- ================================================================
IF OBJECT_ID('sp_TaoHoaDon', 'P') IS NOT NULL DROP PROCEDURE sp_TaoHoaDon
GO
CREATE PROCEDURE sp_TaoHoaDon
    @HD_MaHD    VARCHAR(50),
    @BN_MaBN    VARCHAR(50),
    @HS_MaHoSo  VARCHAR(50) = NULL,
    @HD_TongChiPhi NUMERIC(14,2) = 0
AS
BEGIN
    SET NOCOUNT ON
    INSERT INTO HOA_DON (HD_MaHD, HD_TongChiPhi, HD_TienBHYT, HD_TienBN, BN_MaBN, HS_MaHoSo)
    VALUES (@HD_MaHD, @HD_TongChiPhi, 0, @HD_TongChiPhi, @BN_MaBN, @HS_MaHoSo)
END
GO

-- ================================================================
-- 8. sp_ThanhToanHoaDon: ghi nhan 1 lan thanh toan + tao giao dich tuong ung
-- ================================================================
IF OBJECT_ID('sp_ThanhToanHoaDon', 'P') IS NOT NULL DROP PROCEDURE sp_ThanhToanHoaDon
GO
CREATE PROCEDURE sp_ThanhToanHoaDon
    @TT_MaTT       VARCHAR(50),
    @HD_MaHD       VARCHAR(50),
    @NV_MaNV       VARCHAR(50),
    @TT_SoTien     NUMERIC(14,2),
    @TT_PhuongThuc NVARCHAR(50) = N'Tiền mặt',
    @GD_MaGD       VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF @TT_SoTien <= 0
    BEGIN
        RAISERROR(N'So tien thanh toan phai lon hon 0.', 16, 1)
        RETURN
    END

    INSERT INTO THANH_TOAN (TT_MaTT, TT_Loai, TT_SoTien, TT_PhuongThuc, HD_MaHD, NV_MaNV)
    VALUES (@TT_MaTT, N'Thanh toán viện phí', @TT_SoTien, @TT_PhuongThuc, @HD_MaHD, @NV_MaNV)

    IF @GD_MaGD IS NOT NULL
        INSERT INTO GIAO_DICH (GD_MaGD, GD_NguonTien, GD_SoTienGD, GD_ThoiGian, TT_MaTT, BT_MaQuyetToan)
        VALUES (@GD_MaGD, @TT_PhuongThuc, @TT_SoTien, GETDATE(), @TT_MaTT, NULL)
END
GO

-- ================================================================
-- 9. sp_PhanCongTruongKhoa: chi dinh bac si lam truong khoa (rang buoc 1:1)
-- ================================================================
IF OBJECT_ID('sp_PhanCongTruongKhoa', 'P') IS NOT NULL DROP PROCEDURE sp_PhanCongTruongKhoa
GO
CREATE PROCEDURE sp_PhanCongTruongKhoa
    @K_MaKhoa VARCHAR(50),
    @BS_MaBS  VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (SELECT 1 FROM KHOA WHERE BS_MaBS_TruongKhoa = @BS_MaBS AND K_MaKhoa <> @K_MaKhoa)
    BEGIN
        RAISERROR(N'Bac si %s da la truong khoa cua khoa khac.', 16, 1, @BS_MaBS)
        RETURN
    END
    UPDATE KHOA SET BS_MaBS_TruongKhoa = @BS_MaBS WHERE K_MaKhoa = @K_MaKhoa
END
GO

-- ================================================================
-- 10. sp_ThongKeDoanhThuTheoThang: thong ke doanh thu vien phi theo thang/nam
-- ================================================================
IF OBJECT_ID('sp_ThongKeDoanhThuTheoThang', 'P') IS NOT NULL DROP PROCEDURE sp_ThongKeDoanhThuTheoThang
GO
CREATE PROCEDURE sp_ThongKeDoanhThuTheoThang
    @Nam INT
AS
BEGIN
    SET NOCOUNT ON
    SELECT MONTH(gd.GD_ThoiGian) AS Thang, COUNT(*) AS SoGiaoDich, SUM(gd.GD_SoTienGD) AS TongDoanhThu
    FROM GIAO_DICH gd
    WHERE YEAR(gd.GD_ThoiGian) = @Nam
    GROUP BY MONTH(gd.GD_ThoiGian)
    ORDER BY Thang
END
GO

-- ================================================================
-- 11. sp_GhiNhanThucHienDichVu: ghi nhan quan he tam nguyen Bac si-Benh nhan-Dich vu
-- ================================================================
IF OBJECT_ID('sp_GhiNhanThucHienDichVu', 'P') IS NOT NULL DROP PROCEDURE sp_GhiNhanThucHienDichVu
GO
CREATE PROCEDURE sp_GhiNhanThucHienDichVu
    @THDV_MaThucHien VARCHAR(50),
    @BS_MaBS         VARCHAR(50),
    @BN_MaBN         VARCHAR(50),
    @DV_MaDichVu     VARCHAR(50),
    @THDV_GhiChu     NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (
        SELECT 1 FROM THUC_HIEN_DICH_VU
        WHERE BS_MaBS = @BS_MaBS AND BN_MaBN = @BN_MaBN AND DV_MaDichVu = @DV_MaDichVu
              AND THDV_NgayThucHien = CAST(GETDATE() AS DATE)
    )
    BEGIN
        RAISERROR(N'Da ghi nhan dich vu nay cho benh nhan trong hom nay.', 16, 1)
        RETURN
    END
    INSERT INTO THUC_HIEN_DICH_VU (THDV_MaThucHien, BS_MaBS, BN_MaBN, DV_MaDichVu, THDV_NgayThucHien, THDV_GhiChu)
    VALUES (@THDV_MaThucHien, @BS_MaBS, @BN_MaBN, @DV_MaDichVu, CAST(GETDATE() AS DATE), @THDV_GhiChu)
END
GO

PRINT N'Da tao xong 11 stored procedures.'
GO
