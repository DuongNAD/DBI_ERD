-- ================================================================
--  UPDATE / DELETE MAU - HE THONG QUAN LY BENH VIEN (QLBenhVien)
--  Chay Database_QLBenhVien.sql va Values_QLBenhVien.sql truoc.
-- ================================================================
USE QLBenhVien
GO

-- ================================================================
-- A. CAU LENH UPDATE (>= 6 cau)
-- ================================================================

-- 1. Cap nhat trang thai lich hen da qua ngay hen thanh "Đã khám"
UPDATE LICH_HEN
SET LH_TrangThai = N'Đã khám'
WHERE LH_NgayHen < CAST(GETDATE() AS DATE) AND LH_TrangThai = N'Đã xác nhận'
GO

-- 2. Cap nhat gia dich vu "Khám nội tổng quát" tang 10%
UPDATE DICH_VU_YTE
SET DV_GiaDichVu = DV_GiaDichVu * 1.1
WHERE DV_TenDichVu = N'Khám nội tổng quát'
GO

-- 3. Cap nhat trang thai thiet bi da bao tri xong
UPDATE THIET_BI_YTE
SET TB_TrangThai = N'Hoạt động tốt'
WHERE TB_MaThietBi = 'TB008'
GO

-- 4. Cap nhat so dien thoai benh nhan
UPDATE BENH_NHAN
SET BN_SoDienThoai = '0909999999'
WHERE BN_MaBN = 'BN0001'
GO

-- 5. Cap nhat trang thai don nhap hang thanh "Đã nhập kho" cho cac don qua 30 ngay
UPDATE DON_NHAP_HANG
SET DNH_TrangThai = N'Đã nhập kho'
WHERE DNH_NgayLap < DATEADD(DAY, -30, CAST(GETDATE() AS DATE)) AND DNH_TrangThai = N'Đang xử lý'
GO

-- 6. Cap nhat trang thai boi thuong BHYT da qua 90 ngay thanh "Đã quyết toán"
UPDATE BOI_THUONG_BHYT
SET BT_TrangThai = N'Đã quyết toán'
WHERE BT_TrangThai = N'Đang xử lý'
GO

-- 7. Tang cap bac cho dieu duong co CCHN bat dau bang 'CCHN-DD-20'
UPDATE DIEU_DUONG
SET DD_CapBac = N'Điều dưỡng đại học'
WHERE DD_CCHN LIKE 'CCHN-DD-20%'
GO


-- ================================================================
-- B. CAU LENH DELETE (>= 6 cau)
-- Luu y thu tu xoa: phai xoa BANG CON truoc BANG CHA de khong vi pham FK.
-- ================================================================

-- 1. Xoa cac giao dich phat sinh tu thanh toan tam ung da huy (vi du minh hoa)
DELETE FROM GIAO_DICH
WHERE TT_MaTT IN (SELECT TT_MaTT FROM THANH_TOAN WHERE TT_Loai = N'Tạm ứng' AND TT_SoTien = 0)
GO

-- 2. Xoa cac lich hen da bi huy qua 180 ngay (don dep du lieu cu)
DELETE FROM LICH_HEN
WHERE LH_TrangThai = N'Đã hủy' AND LH_NgayHen < DATEADD(DAY, -180, CAST(GETDATE() AS DATE))
GO

-- 3. Xoa chi tiet don thuoc co so luong bang 0 (du lieu nhap sai)
DELETE FROM CHI_TIET_DON_THUOC
WHERE CT_SoLuong = 0
GO

-- 4. Xoa cac dong trung gian phac do - dich vu khong con phac do tuong ung
DELETE FROM PHACDO_SUDUNG_DICHVU
WHERE PD_MaPhacDo NOT IN (SELECT PD_MaPhacDo FROM PHAC_DO_DIEU_TRI)
GO

-- 5. Xoa phieu xuat kho da het han su dung qua 5 nam (thanh ly kho)
DELETE FROM PHIEU_XUAT_KHO
WHERE PXK_HSD IS NOT NULL AND PXK_HSD < DATEADD(YEAR, -5, CAST(GETDATE() AS DATE))
GO

-- 6. Xoa lich truc co trang thai "Chờ duyệt" qua 60 ngay khong duoc xu ly
DELETE FROM LICH_TRUC
WHERE LT_TrangThai = N'Chờ duyệt' AND LT_Ngay < DATEADD(DAY, -60, CAST(GETDATE() AS DATE))
GO

-- 7. Xoa mau benh pham co tinh trang "Cần lấy lại" va da qua 30 ngay (mau khong con gia tri)
DELETE FROM MAU_BENH_PHAM
WHERE BP_TinhTrangMau = N'Cần lấy lại' AND BP_NgayLayMau < DATEADD(DAY, -30, CAST(GETDATE() AS DATE))
GO

PRINT N'Da chay xong cac cau lenh UPDATE/DELETE mau.'
GO
