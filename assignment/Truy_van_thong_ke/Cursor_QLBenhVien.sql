-- ================================================================
--  CURSOR - HE THONG QUAN LY BENH VIEN (QLBenhVien)
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
-- 1. Duyet danh sach benh nhan dang dieu tri noi tru va in canh bao
-- so ngay nam vien qua lau (> 10 ngay)
-- ================================================================
DECLARE @HS_MaHoSo VARCHAR(50), @BN_HoTen NVARCHAR(255), @NgayNhapVien DATE, @SoNgay INT

DECLARE cur_BenhNhanNoiTru CURSOR FOR
    SELECT hs.HS_MaHoSo, bn.BN_HoTen, hs.HS_NgayNhapVien
    FROM HO_SO_NHAP_VIEN hs
    JOIN BENH_NHAN bn ON hs.BN_MaBN = bn.BN_MaBN
    WHERE hs.HS_NgayRaVien IS NULL

OPEN cur_BenhNhanNoiTru
FETCH NEXT FROM cur_BenhNhanNoiTru INTO @HS_MaHoSo, @BN_HoTen, @NgayNhapVien

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SoNgay = DATEDIFF(DAY, @NgayNhapVien, GETDATE())
    IF @SoNgay > 10
        PRINT N'Canh bao: Benh nhan ' + @BN_HoTen + N' (Ho so ' + @HS_MaHoSo + N') da nam vien ' + CAST(@SoNgay AS NVARCHAR(10)) + N' ngay.'
    FETCH NEXT FROM cur_BenhNhanNoiTru INTO @HS_MaHoSo, @BN_HoTen, @NgayNhapVien
END

CLOSE cur_BenhNhanNoiTru
DEALLOCATE cur_BenhNhanNoiTru
GO

-- ================================================================
-- 2. Duyet hoa don chua duoc BHYT chi tra va in danh sach nhac nho
-- ================================================================
DECLARE @HD_MaHD VARCHAR(50), @TongChiPhi NUMERIC(14,2)

DECLARE cur_HoaDonChuaBHYT CURSOR FOR
    SELECT HD_MaHD, HD_TongChiPhi
    FROM HOA_DON
    WHERE HD_MaHD NOT IN (SELECT HD_MaHD FROM BOI_THUONG_BHYT)

OPEN cur_HoaDonChuaBHYT
FETCH NEXT FROM cur_HoaDonChuaBHYT INTO @HD_MaHD, @TongChiPhi

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Hoa don ' + @HD_MaHD + N' (Tong: ' + CAST(@TongChiPhi AS NVARCHAR(20)) + N') chua co ho so BHYT chi tra.'
    FETCH NEXT FROM cur_HoaDonChuaBHYT INTO @HD_MaHD, @TongChiPhi
END

CLOSE cur_HoaDonChuaBHYT
DEALLOCATE cur_HoaDonChuaBHYT
GO

-- ================================================================
-- 3. Doi chieu va cap nhat lai HD_TongChiPhi cua tung hoa don dua tren
-- tong ThanhTien thuc te trong HOADON_CHITIET_DICHVU (neu lech nhau)
-- ================================================================
DECLARE @HD_MaHD2 VARCHAR(50), @TongTinhLai NUMERIC(14,2), @TongHienTai NUMERIC(14,2)

DECLARE cur_DoiChieuHoaDon CURSOR FOR
    SELECT hd.HD_MaHD, hd.HD_TongChiPhi, SUM(hct.ThanhTien)
    FROM HOA_DON hd
    JOIN HOADON_CHITIET_DICHVU hct ON hd.HD_MaHD = hct.HD_MaHD
    GROUP BY hd.HD_MaHD, hd.HD_TongChiPhi

OPEN cur_DoiChieuHoaDon
FETCH NEXT FROM cur_DoiChieuHoaDon INTO @HD_MaHD2, @TongHienTai, @TongTinhLai

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @TongHienTai <> @TongTinhLai
        PRINT N'Hoa don ' + @HD_MaHD2 + N': chenh lech ' + CAST(@TongHienTai AS NVARCHAR(20))
              + N' (dang luu) vs ' + CAST(@TongTinhLai AS NVARCHAR(20)) + N' (tinh tu chi tiet dich vu).'
    FETCH NEXT FROM cur_DoiChieuHoaDon INTO @HD_MaHD2, @TongHienTai, @TongTinhLai
END

CLOSE cur_DoiChieuHoaDon
DEALLOCATE cur_DoiChieuHoaDon
GO

-- ================================================================
-- 4. Duyet danh sach thuoc sap het han su dung (trong vong 60 ngay ke tu
-- ngay het han xa nhat trong du lieu mau) va in canh bao
-- ================================================================
DECLARE @TH_MaThuoc VARCHAR(50), @TenThuoc NVARCHAR(255), @HanSuDung DATE

DECLARE cur_ThuocSapHetHan CURSOR FOR
    SELECT TH_MaThuoc, TH_TenThuongMai, TH_HanSuDung
    FROM THUOC
    WHERE TH_HanSuDung IS NOT NULL
    ORDER BY TH_HanSuDung

OPEN cur_ThuocSapHetHan
FETCH NEXT FROM cur_ThuocSapHetHan INTO @TH_MaThuoc, @TenThuoc, @HanSuDung

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Thuoc ' + @TenThuoc + N' (' + @TH_MaThuoc + N') het han vao ' + CONVERT(NVARCHAR(20), @HanSuDung, 103)
    FETCH NEXT FROM cur_ThuocSapHetHan INTO @TH_MaThuoc, @TenThuoc, @HanSuDung
END

CLOSE cur_ThuocSapHetHan
DEALLOCATE cur_ThuocSapHetHan
GO

-- ================================================================
-- 5. Duyet chuoi tham van (quan he DE QUY) tu bac si "junior" len bac si
-- "senior" ma ho tham van, in ra chuoi tham van
-- ================================================================
DECLARE @BS_MaBS VARCHAR(50), @TenBS NVARCHAR(255), @ThamVan VARCHAR(50)

DECLARE cur_ChuoiThamVan CURSOR FOR
    SELECT bs.BS_MaBS, nv.NV_Ten, bs.BS_MaBS_ThamVan
    FROM BAC_SI bs
    JOIN NHAN_VIEN nv ON bs.BS_MaBS = nv.NV_MaNV
    WHERE bs.BS_MaBS_ThamVan IS NOT NULL

OPEN cur_ChuoiThamVan
FETCH NEXT FROM cur_ChuoiThamVan INTO @BS_MaBS, @TenBS, @ThamVan

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @TenThamVan NVARCHAR(255)
    SELECT @TenThamVan = nv.NV_Ten FROM NHAN_VIEN nv WHERE nv.NV_MaNV = @ThamVan
    PRINT N'Bac si ' + @TenBS + N' tham van y kien cua bac si ' + @TenThamVan
    FETCH NEXT FROM cur_ChuoiThamVan INTO @BS_MaBS, @TenBS, @ThamVan
END

CLOSE cur_ChuoiThamVan
DEALLOCATE cur_ChuoiThamVan
GO

PRINT N'Da chay xong 5 cursor minh hoa.'
GO
