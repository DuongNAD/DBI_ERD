-- ================================================================
--  CAU LENH SELECT - HE THONG QUAN LY BENH VIEN (QLBenhVien)
--  Chay Database_QLBenhVien.sql va Values_QLBenhVien.sql truoc.
-- ================================================================
USE QLBenhVien
GO

-- ================================================================
-- A. SELECT CO DIEU KIEN WHERE (>= 20 cau)
-- ================================================================

-- 1. Danh sach benh nhan nu
SELECT BN_MaBN, BN_HoTen, BN_NgaySinh, BN_DiaChi
FROM BENH_NHAN
WHERE BN_GioiTinh = N'Nữ'
GO

-- 2. Benh nhan sinh truoc nam 1990
SELECT BN_MaBN, BN_HoTen, BN_NgaySinh
FROM BENH_NHAN
WHERE YEAR(BN_NgaySinh) < 1990
GO

-- 3. Hoa don co tong chi phi tren 800,000 VND
SELECT HD_MaHD, HD_TongChiPhi, HD_TienBHYT, HD_TienBN
FROM HOA_DON
WHERE HD_TongChiPhi > 800000
GO

-- 4. Bac si co tren 10 nam kinh nghiem
SELECT BS_MaBS, BS_ChuyenKhoa, BS_CapBac, BS_NamKN
FROM BAC_SI
WHERE BS_NamKN > 10
GO

-- 5. Lich hen chua duoc xac nhan
SELECT LH_MaLichHen, LH_NgayHen, LH_LyDoKham
FROM LICH_HEN
WHERE LH_TrangThai = N'Chờ xác nhận'
GO

-- 6. Ho so nhap vien dang dieu tri (chua ra vien)
SELECT HS_MaHoSo, HS_NgayNhapVien, HS_LyDoNhapVien
FROM HO_SO_NHAP_VIEN
WHERE HS_NgayRaVien IS NULL
GO

-- 7. Thuoc sap het han su dung (truoc 2027-06-01)
SELECT TH_MaThuoc, TH_TenThuongMai, TH_HanSuDung
FROM THUOC
WHERE TH_HanSuDung < '2027-06-01'
GO

-- 8. Dich vu y te co gia tren 500,000 VND
SELECT DV_MaDichVu, DV_TenDichVu, DV_GiaDichVu, DV_LoaiDichVu
FROM DICH_VU_YTE
WHERE DV_GiaDichVu > 500000
GO

-- 9. Phong benh con trong
SELECT PB_MaPhong, PB_SoPhong, PB_LoaiPhong, PB_SucChua
FROM PHONG_BENH
WHERE PB_TrangThai = N'Còn trống'
GO

-- 10. Nhan vien la Dieu duong
SELECT NV_MaNV, NV_Ten, NV_SDT
FROM NHAN_VIEN
WHERE NV_VaiTro = N'Điều dưỡng'
GO

-- 11. Ket qua xet nghiem can theo doi them
SELECT KQ_MaKetQua, KQ_NgayThucHien, KQ_KetLuan
FROM KET_QUA_XET_NGHIEM
WHERE KQ_KetLuan = N'Cần theo dõi thêm'
GO

-- 12. Thiet bi y te dang bao tri
SELECT TB_MaThietBi, TB_TenThietBi, TB_TrangThai
FROM THIET_BI_YTE
WHERE TB_TrangThai = N'Đang bảo trì'
GO

-- 13. Don thuoc ke trong thang 6/2026
SELECT DT_MaDonThuoc, DT_NgayKeDon
FROM DON_THUOC
WHERE MONTH(DT_NgayKeDon) = 6 AND YEAR(DT_NgayKeDon) = 2026
GO

-- 14. Bao hiem y te sap het han (truoc 2027-12-31)
SELECT BH_MaBHYT, BH_MaSoBHYT, BH_NgayHetHan
FROM BAO_HIEM_YT
WHERE BH_NgayHetHan <= '2027-12-31'
GO

-- 15. Hoa don chua duoc BHYT chi tra (khong co ban ghi Boi thuong)
SELECT HD_MaHD, HD_TongChiPhi
FROM HOA_DON
WHERE HD_MaHD NOT IN (SELECT HD_MaHD FROM BOI_THUONG_BHYT)
GO

-- 16. Vat tu y te dung cho "Phau thuat"
SELECT VT_MaVatTu, VT_TenVatTu, VT_CongDung
FROM VAT_TU_YTE
WHERE VT_CongDung = N'Phẫu thuật'
GO

-- 17. Chan doan hinh anh can hoi chan
SELECT HA_MaHinhAnh, HA_LoaiChanDoan, HA_KetLuan
FROM CHAN_DOAN_HINH_ANH
WHERE HA_KetLuan = N'Cần hội chẩn thêm'
GO

-- 18. Nha cung cap co ma so thue bat dau bang '030'
SELECT NCC_MaNCC, NCC_TenNCC, NCC_MST
FROM NHA_CUNG_CAP
WHERE NCC_MST LIKE '030%'
GO

-- 19. Lich truc ca dem
SELECT LT_MaLichTruc, LT_Ngay, LT_Ca, LT_TrangThai
FROM LICH_TRUC
WHERE LT_Ca = N'Ca đêm'
GO

-- 20. Giao dich co so tien tren 300,000 VND
SELECT GD_MaGD, GD_NguonTien, GD_SoTienGD
FROM GIAO_DICH
WHERE GD_SoTienGD > 300000
GO

-- 21. Benh nhan co email chua duoc cung cap
SELECT BN_MaBN, BN_HoTen
FROM BENH_NHAN
WHERE BN_Email IS NULL
GO

-- 22. Kho toa thuoc dung "1 vien/lan x 3 lan/ngay"
SELECT CT_MaChiTiet, CT_SoLuong, CT_LieuDung
FROM CHI_TIET_DON_THUOC
WHERE CT_LieuDung = N'1 viên/lần x 3 lần/ngày'
GO


-- ================================================================
-- B. SELECT KET HOP JOIN 2-5 BANG (>= 15 cau)
-- ================================================================

-- 1. Benh nhan + Bao hiem y te (JOIN 2 bang)
SELECT bn.BN_HoTen, bh.BH_MaSoBHYT, bh.BH_NhaCungCap
FROM BENH_NHAN bn
JOIN BAO_HIEM_YT bh ON bn.BN_MaBN = bh.BN_MaBN
GO

-- 2. Nhan vien + Khoa (JOIN 2 bang)
SELECT nv.NV_Ten, nv.NV_VaiTro, k.K_TenKhoa
FROM NHAN_VIEN nv
JOIN KHOA k ON nv.K_MaKhoa = k.K_MaKhoa
GO

-- 3. Bac si + Nhan vien + Khoa (JOIN 3 bang)
SELECT nv.NV_Ten AS TenBacSi, bs.BS_ChuyenKhoa, k.K_TenKhoa
FROM BAC_SI bs
JOIN NHAN_VIEN nv ON bs.BS_MaBS = nv.NV_MaNV
JOIN KHOA k ON nv.K_MaKhoa = k.K_MaKhoa
GO

-- 4. Ho so nhap vien + Benh nhan + Khoa + Phong benh (JOIN 4 bang)
SELECT bn.BN_HoTen, hs.HS_NgayNhapVien, k.K_TenKhoa, pb.PB_SoPhong
FROM HO_SO_NHAP_VIEN hs
JOIN BENH_NHAN bn ON hs.BN_MaBN = bn.BN_MaBN
JOIN KHOA k ON hs.K_MaKhoa = k.K_MaKhoa
JOIN PHONG_BENH pb ON hs.PB_MaPhong = pb.PB_MaPhong
GO

-- 5. Chan doan + Benh an + Benh nhan + Bac si (JOIN 4 bang)
SELECT bn.BN_HoTen, cd.CD_TenChanDoan, cd.CD_NgayChanDoan, nv.NV_Ten AS BacSiChanDoan
FROM CHAN_DOAN cd
JOIN BENH_AN ba ON cd.BA_MaBenhAn = ba.BA_MaBenhAn
JOIN BENH_NHAN bn ON ba.BN_MaBN = bn.BN_MaBN
JOIN NHAN_VIEN nv ON cd.BS_MaBS = nv.NV_MaNV
GO

-- 6. Don thuoc + Chi tiet don thuoc + Thuoc (JOIN 3 bang)
SELECT dt.DT_MaDonThuoc, dt.DT_NgayKeDon, th.TH_TenThuongMai, ct.CT_SoLuong, ct.CT_LieuDung
FROM DON_THUOC dt
JOIN CHI_TIET_DON_THUOC ct ON dt.DT_MaDonThuoc = ct.DT_MaDonThuoc
JOIN THUOC th ON ct.TH_MaThuoc = th.TH_MaThuoc
GO

-- 7. Phac do dieu tri + Dich vu y te (JOIN qua bang trung gian M:N)
SELECT pd.PD_TenPhacDo, dv.DV_TenDichVu, dv.DV_GiaDichVu
FROM PHACDO_SUDUNG_DICHVU psd
JOIN PHAC_DO_DIEU_TRI pd ON psd.PD_MaPhacDo = pd.PD_MaPhacDo
JOIN DICH_VU_YTE dv ON psd.DV_MaDichVu = dv.DV_MaDichVu
GO

-- 8. Ket qua xet nghiem + Benh an + Benh nhan + Danh muc xet nghiem (JOIN 4 bang)
SELECT bn.BN_HoTen, dm.DM_TenXetNghiem, kq.KQ_NgayThucHien, kq.KQ_KetLuan
FROM KET_QUA_XET_NGHIEM kq
JOIN BENH_AN ba ON kq.BA_MaBenhAn = ba.BA_MaBenhAn
JOIN BENH_NHAN bn ON ba.BN_MaBN = bn.BN_MaBN
JOIN DANH_MUC_XET_NGHIEM dm ON kq.DM_MaXetNghiem = dm.DM_MaXetNghiem
GO

-- 9. Mau benh pham + Benh nhan + Ket qua xet nghiem (JOIN 3 bang)
SELECT bn.BN_HoTen, bp.BP_LoaiMau, bp.BP_NgayLayMau, kq.KQ_MaKetQua
FROM MAU_BENH_PHAM bp
JOIN BENH_NHAN bn ON bp.BN_MaBN = bn.BN_MaBN
JOIN KET_QUA_XET_NGHIEM kq ON bp.BP_MaMauBenhPham = kq.BP_MaMauBenhPham
GO

-- 10. Chan doan hinh anh + Thiet bi y te + Benh an + Benh nhan (JOIN 4 bang)
SELECT bn.BN_HoTen, ha.HA_LoaiChanDoan, tb.TB_TenThietBi, ha.HA_NgayThucHien
FROM CHAN_DOAN_HINH_ANH ha
JOIN BENH_AN ba ON ha.BA_MaBenhAn = ba.BA_MaBenhAn
JOIN BENH_NHAN bn ON ba.BN_MaBN = bn.BN_MaBN
JOIN THIET_BI_YTE tb ON ha.TB_MaThietBi = tb.TB_MaThietBi
GO

-- 11. Hoa don + Benh nhan + Thanh toan + Nhan vien thu tien (JOIN 4 bang)
SELECT bn.BN_HoTen, hd.HD_TongChiPhi, tt.TT_SoTien, nv.NV_Ten AS NhanVienThuTien
FROM THANH_TOAN tt
JOIN HOA_DON hd ON tt.HD_MaHD = hd.HD_MaHD
JOIN BENH_NHAN bn ON hd.BN_MaBN = bn.BN_MaBN
JOIN NHAN_VIEN nv ON tt.NV_MaNV = nv.NV_MaNV
GO

-- 12. Hoa don + Boi thuong BHYT + Giao dich (JOIN 3 bang, theo huong BHYT)
SELECT hd.HD_MaHD, bt.BT_TiLe, gd.GD_SoTienGD, gd.GD_ThoiGian
FROM BOI_THUONG_BHYT bt
JOIN HOA_DON hd ON bt.HD_MaHD = hd.HD_MaHD
JOIN GIAO_DICH gd ON gd.BT_MaQuyetToan = bt.BT_MaQuyetToan
GO

-- 13. Hoa don + Chi tiet dich vu + Dich vu y te (JOIN 3 bang, qua bang trung gian)
SELECT hd.HD_MaHD, dv.DV_TenDichVu, hct.SoLuong, hct.ThanhTien
FROM HOADON_CHITIET_DICHVU hct
JOIN HOA_DON hd ON hct.HD_MaHD = hd.HD_MaHD
JOIN DICH_VU_YTE dv ON hct.DV_MaDichVu = dv.DV_MaDichVu
GO

-- 14. Don nhap hang + Nha cung cap + Phieu xuat kho + Thuoc (JOIN 4 bang)
SELECT ncc.NCC_TenNCC, dnh.DNH_NgayLap, pxk.PXK_SoLo, th.TH_TenThuongMai, pxk.PXK_SL
FROM PHIEU_XUAT_KHO pxk
JOIN DON_NHAP_HANG dnh ON pxk.DNH_MaDon = dnh.DNH_MaDon
JOIN NHA_CUNG_CAP ncc ON dnh.NCC_MaNCC = ncc.NCC_MaNCC
JOIN THUOC th ON pxk.TH_MaThuoc = th.TH_MaThuoc
GO

-- 15. Quan he TAM NGUYEN: Bac si - Benh nhan - Dich vu y te (JOIN 4 bang)
SELECT nv.NV_Ten AS BacSi, bn.BN_HoTen AS BenhNhan, dv.DV_TenDichVu, thdv.THDV_NgayThucHien
FROM THUC_HIEN_DICH_VU thdv
JOIN NHAN_VIEN nv ON thdv.BS_MaBS = nv.NV_MaNV
JOIN BENH_NHAN bn ON thdv.BN_MaBN = bn.BN_MaBN
JOIN DICH_VU_YTE dv ON thdv.DV_MaDichVu = dv.DV_MaDichVu
GO

-- 16. Quan he DE QUY: Bac si - tham van - Bac si (self-join, 5 bang tinh ca alias)
SELECT nv1.NV_Ten AS BacSiJunior, nv2.NV_Ten AS BacSiThamVan
FROM BAC_SI bs
JOIN NHAN_VIEN nv1 ON bs.BS_MaBS = nv1.NV_MaNV
JOIN BAC_SI bs2 ON bs.BS_MaBS_ThamVan = bs2.BS_MaBS
JOIN NHAN_VIEN nv2 ON bs2.BS_MaBS = nv2.NV_MaNV
GO

-- 17. Lich truc + Nhan vien + Khoa (JOIN 3 bang)
SELECT nv.NV_Ten, k.K_TenKhoa, lt.LT_Ngay, lt.LT_Ca
FROM LICH_TRUC lt
JOIN NHAN_VIEN nv ON lt.NV_MaNV = nv.NV_MaNV
JOIN KHOA k ON lt.K_MaKhoa = k.K_MaKhoa
GO


-- ================================================================
-- C. SELECT THONG KE VOI GROUP BY / HAM TONG HOP (>= 10 cau)
-- ================================================================

-- 1. So luong benh nhan theo gioi tinh
SELECT BN_GioiTinh, COUNT(*) AS SoLuong
FROM BENH_NHAN
GROUP BY BN_GioiTinh
GO

-- 2. Tong chi phi hoa don theo tung benh nhan
SELECT BN_MaBN, COUNT(*) AS SoHoaDon, SUM(HD_TongChiPhi) AS TongChiPhi
FROM HOA_DON
GROUP BY BN_MaBN
ORDER BY TongChiPhi DESC
GO

-- 3. So luong nhan vien theo tung khoa
SELECT k.K_TenKhoa, COUNT(nv.NV_MaNV) AS SoNhanVien
FROM KHOA k
LEFT JOIN NHAN_VIEN nv ON nv.K_MaKhoa = k.K_MaKhoa
GROUP BY k.K_TenKhoa
ORDER BY SoNhanVien DESC
GO

-- 4. So luot chan doan theo tung bac si
SELECT BS_MaBS, COUNT(*) AS SoLuotChanDoan
FROM CHAN_DOAN
GROUP BY BS_MaBS
ORDER BY SoLuotChanDoan DESC
GO

-- 5. Trung binh gia dich vu theo loai dich vu
SELECT DV_LoaiDichVu, AVG(DV_GiaDichVu) AS GiaTrungBinh, COUNT(*) AS SoDichVu
FROM DICH_VU_YTE
GROUP BY DV_LoaiDichVu
GO

-- 6. Tong so luong thuoc da xuat kho theo tung loai thuoc
SELECT th.TH_TenThuongMai, SUM(pxk.PXK_SL) AS TongSoLuongXuat
FROM PHIEU_XUAT_KHO pxk
JOIN THUOC th ON pxk.TH_MaThuoc = th.TH_MaThuoc
GROUP BY th.TH_TenThuongMai
ORDER BY TongSoLuongXuat DESC
GO

-- 7. So luong ho so nhap vien theo khoa dieu tri, chi lay khoa co tren 1 ho so
SELECT K_MaKhoa, COUNT(*) AS SoHoSo
FROM HO_SO_NHAP_VIEN
GROUP BY K_MaKhoa
HAVING COUNT(*) > 1
GO

-- 8. Tong tien thanh toan theo phuong thuc
SELECT TT_PhuongThuc, COUNT(*) AS SoLuotThanhToan, SUM(TT_SoTien) AS TongTien
FROM THANH_TOAN
GROUP BY TT_PhuongThuc
ORDER BY TongTien DESC
GO

-- 9. So luong dich vu ky thuat trong tung hoa don, chi lay hoa don co >= 2 dich vu
SELECT HD_MaHD, COUNT(*) AS SoDichVu, SUM(ThanhTien) AS TongTienDichVu
FROM HOADON_CHITIET_DICHVU
GROUP BY HD_MaHD
HAVING COUNT(*) >= 2
GO

-- 10. So luong xet nghiem theo loai xet nghiem
SELECT dm.DM_LoaiXetNghiem, COUNT(kq.KQ_MaKetQua) AS SoLuotXetNghiem
FROM DANH_MUC_XET_NGHIEM dm
LEFT JOIN KET_QUA_XET_NGHIEM kq ON kq.DM_MaXetNghiem = dm.DM_MaXetNghiem
GROUP BY dm.DM_LoaiXetNghiem
ORDER BY SoLuotXetNghiem DESC
GO

-- 11. So ca truc theo tung khoa va ca truc
SELECT K_MaKhoa, LT_Ca, COUNT(*) AS SoCaTruc
FROM LICH_TRUC
GROUP BY K_MaKhoa, LT_Ca
ORDER BY K_MaKhoa
GO

-- 12. So dich vu ma tung bac si da thuc hien (quan he tam nguyen)
SELECT BS_MaBS, COUNT(*) AS SoDichVuDaThucHien, COUNT(DISTINCT BN_MaBN) AS SoBenhNhanPhucVu
FROM THUC_HIEN_DICH_VU
GROUP BY BS_MaBS
ORDER BY SoDichVuDaThucHien DESC
GO
