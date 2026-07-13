-- ================================================================
--  VIEWS - HE THONG QUAN LY BENH VIEN (QLBenhVien)
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
-- 1. vw_DanhSachBenhNhanDayDu: benh nhan + tinh trang BHYT
-- ================================================================
IF OBJECT_ID('vw_DanhSachBenhNhanDayDu', 'V') IS NOT NULL DROP VIEW vw_DanhSachBenhNhanDayDu
GO
CREATE VIEW vw_DanhSachBenhNhanDayDu AS
SELECT
    bn.BN_MaBN, bn.BN_HoTen, bn.BN_NgaySinh, bn.BN_GioiTinh, bn.BN_SoDienThoai,
    bh.BH_MaSoBHYT, bh.BH_NhaCungCap, bh.BH_NgayHetHan,
    CASE WHEN bh.BN_MaBN IS NULL THEN N'Không có BHYT' ELSE N'Có BHYT' END AS TinhTrangBHYT
FROM BENH_NHAN bn
LEFT JOIN BAO_HIEM_YT bh ON bn.BN_MaBN = bh.BN_MaBN
GO

-- ================================================================
-- 2. vw_ChiTietHoSoNhapVien: ho so nhap vien + benh nhan + khoa + phong
-- ================================================================
IF OBJECT_ID('vw_ChiTietHoSoNhapVien', 'V') IS NOT NULL DROP VIEW vw_ChiTietHoSoNhapVien
GO
CREATE VIEW vw_ChiTietHoSoNhapVien AS
SELECT
    hs.HS_MaHoSo, bn.BN_HoTen, hs.HS_NgayNhapVien, hs.HS_NgayRaVien, hs.HS_TrangThai,
    k.K_TenKhoa, pb.PB_SoPhong, pb.PB_LoaiPhong
FROM HO_SO_NHAP_VIEN hs
JOIN BENH_NHAN bn ON hs.BN_MaBN = bn.BN_MaBN
JOIN KHOA k ON hs.K_MaKhoa = k.K_MaKhoa
JOIN PHONG_BENH pb ON hs.PB_MaPhong = pb.PB_MaPhong
GO

-- ================================================================
-- 3. vw_DonThuocChiTiet: don thuoc + chi tiet + ten thuoc + bac si ke don
-- ================================================================
IF OBJECT_ID('vw_DonThuocChiTiet', 'V') IS NOT NULL DROP VIEW vw_DonThuocChiTiet
GO
CREATE VIEW vw_DonThuocChiTiet AS
SELECT
    dt.DT_MaDonThuoc, dt.DT_NgayKeDon, nv.NV_Ten AS BacSiKeDon,
    th.TH_TenThuongMai, ct.CT_SoLuong, ct.CT_LieuDung, ct.CT_ThoiGianSuDung
FROM DON_THUOC dt
JOIN NHAN_VIEN nv ON dt.BS_MaBS = nv.NV_MaNV
JOIN CHI_TIET_DON_THUOC ct ON dt.DT_MaDonThuoc = ct.DT_MaDonThuoc
JOIN THUOC th ON ct.TH_MaThuoc = th.TH_MaThuoc
GO

-- ================================================================
-- 4. vw_HoaDonTongHop: hoa don + benh nhan + tong da thanh toan + con no
-- ================================================================
IF OBJECT_ID('vw_HoaDonTongHop', 'V') IS NOT NULL DROP VIEW vw_HoaDonTongHop
GO
CREATE VIEW vw_HoaDonTongHop AS
SELECT
    hd.HD_MaHD, bn.BN_HoTen, hd.HD_TongChiPhi, hd.HD_TienBHYT, hd.HD_TienBN,
    ISNULL(tt.DaThanhToan, 0) AS DaThanhToan,
    hd.HD_TienBN - ISNULL(tt.DaThanhToan, 0) AS ConLai
FROM HOA_DON hd
JOIN BENH_NHAN bn ON hd.BN_MaBN = bn.BN_MaBN
OUTER APPLY (
    SELECT SUM(TT_SoTien) AS DaThanhToan FROM THANH_TOAN WHERE HD_MaHD = hd.HD_MaHD
) tt
GO

-- ================================================================
-- 5. vw_LichTrucNhanVien: lich truc + nhan vien + khoa
-- ================================================================
IF OBJECT_ID('vw_LichTrucNhanVien', 'V') IS NOT NULL DROP VIEW vw_LichTrucNhanVien
GO
CREATE VIEW vw_LichTrucNhanVien AS
SELECT
    lt.LT_MaLichTruc, nv.NV_Ten, nv.NV_VaiTro, k.K_TenKhoa, lt.LT_Ngay, lt.LT_Ca, lt.LT_TrangThai
FROM LICH_TRUC lt
JOIN NHAN_VIEN nv ON lt.NV_MaNV = nv.NV_MaNV
JOIN KHOA k ON lt.K_MaKhoa = k.K_MaKhoa
GO

-- ================================================================
-- 6. vw_KetQuaXetNghiemChiTiet: ket qua xet nghiem + benh nhan + danh muc
-- ================================================================
IF OBJECT_ID('vw_KetQuaXetNghiemChiTiet', 'V') IS NOT NULL DROP VIEW vw_KetQuaXetNghiemChiTiet
GO
CREATE VIEW vw_KetQuaXetNghiemChiTiet AS
SELECT
    kq.KQ_MaKetQua, bn.BN_HoTen, dm.DM_TenXetNghiem, kq.KQ_NgayThucHien, kq.KQ_KetQua, kq.KQ_KetLuan
FROM KET_QUA_XET_NGHIEM kq
JOIN BENH_AN ba ON kq.BA_MaBenhAn = ba.BA_MaBenhAn
JOIN BENH_NHAN bn ON ba.BN_MaBN = bn.BN_MaBN
JOIN DANH_MUC_XET_NGHIEM dm ON kq.DM_MaXetNghiem = dm.DM_MaXetNghiem
GO

-- ================================================================
-- 7. vw_BacSiThamVan: minh hoa quan he DE QUY - bac si va nguoi tham van
-- ================================================================
IF OBJECT_ID('vw_BacSiThamVan', 'V') IS NOT NULL DROP VIEW vw_BacSiThamVan
GO
CREATE VIEW vw_BacSiThamVan AS
SELECT
    nv1.NV_Ten AS BacSi, bs.BS_ChuyenKhoa,
    nv2.NV_Ten AS ThamVanBoi, bs2.BS_ChuyenKhoa AS ChuyenKhoaThamVan
FROM BAC_SI bs
JOIN NHAN_VIEN nv1 ON bs.BS_MaBS = nv1.NV_MaNV
LEFT JOIN BAC_SI bs2 ON bs.BS_MaBS_ThamVan = bs2.BS_MaBS
LEFT JOIN NHAN_VIEN nv2 ON bs2.BS_MaBS = nv2.NV_MaNV
GO

-- ================================================================
-- 8. vw_ThucHienDichVuTamNguyen: minh hoa quan he TAM NGUYEN
-- ================================================================
IF OBJECT_ID('vw_ThucHienDichVuTamNguyen', 'V') IS NOT NULL DROP VIEW vw_ThucHienDichVuTamNguyen
GO
CREATE VIEW vw_ThucHienDichVuTamNguyen AS
SELECT
    thdv.THDV_MaThucHien, nv.NV_Ten AS BacSi, bn.BN_HoTen AS BenhNhan,
    dv.DV_TenDichVu, dv.DV_GiaDichVu, thdv.THDV_NgayThucHien
FROM THUC_HIEN_DICH_VU thdv
JOIN NHAN_VIEN nv ON thdv.BS_MaBS = nv.NV_MaNV
JOIN BENH_NHAN bn ON thdv.BN_MaBN = bn.BN_MaBN
JOIN DICH_VU_YTE dv ON thdv.DV_MaDichVu = dv.DV_MaDichVu
GO

PRINT N'Da tao xong 8 views.'
GO
