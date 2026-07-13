-- ================================================================
--  DU LIEU MAU - HE THONG QUAN LY BENH VIEN (QLBenhVien)
--  Chay Database_QLBenhVien.sql truoc khi chay file nay.
-- ================================================================
USE QLBenhVien
GO

-- ================================================================
-- 1. KHOA
-- ================================================================
INSERT INTO KHOA (K_MaKhoa, K_TenKhoa, K_SoDien, K_ViTri) VALUES
    ('KH01', N'Khoa Nội tổng hợp', '0920000137', N'Tòa nhà B, tầng 2'),
    ('KH02', N'Khoa Ngoại tổng hợp', '0920000274', N'Tòa nhà C, tầng 3'),
    ('KH03', N'Khoa Nhi', '0920000411', N'Tòa nhà D, tầng 4'),
    ('KH04', N'Khoa Sản', '0920000548', N'Tòa nhà E, tầng 5'),
    ('KH05', N'Khoa Cấp cứu', '0920000685', N'Tòa nhà A, tầng 6'),
    ('KH06', N'Khoa Tim mạch', '0920000822', N'Tòa nhà B, tầng 1'),
    ('KH07', N'Khoa Thần kinh', '0920000959', N'Tòa nhà C, tầng 2'),
    ('KH08', N'Khoa Tai Mũi Họng', '0920001096', N'Tòa nhà D, tầng 3'),
    ('KH09', N'Khoa Chẩn đoán hình ảnh', '0920001233', N'Tòa nhà E, tầng 4'),
    ('KH10', N'Khoa Xét nghiệm', '0920001370', N'Tòa nhà A, tầng 5')
GO

-- ================================================================
-- 2. PHONG_BENH
-- ================================================================
INSERT INTO PHONG_BENH (PB_MaPhong, PB_SoPhong, PB_LoaiPhong, PB_SucChua, PB_TrangThai, K_MaKhoa) VALUES
    ('PB001', '101', N'Phòng dịch vụ', 5, N'Còn trống', 'KH02'),
    ('PB002', '102', N'Phòng VIP', 6, N'Còn trống', 'KH03'),
    ('PB003', '103', N'Phòng hồi sức', 4, N'Đang sử dụng', 'KH04'),
    ('PB004', '104', N'Phòng thường', 5, N'Còn trống', 'KH05'),
    ('PB005', '105', N'Phòng dịch vụ', 6, N'Còn trống', 'KH06'),
    ('PB006', '106', N'Phòng VIP', 4, N'Đang sử dụng', 'KH07'),
    ('PB007', '107', N'Phòng hồi sức', 5, N'Còn trống', 'KH08'),
    ('PB008', '108', N'Phòng thường', 6, N'Còn trống', 'KH09'),
    ('PB009', '109', N'Phòng dịch vụ', 4, N'Đang sử dụng', 'KH10'),
    ('PB010', '110', N'Phòng VIP', 5, N'Còn trống', 'KH01'),
    ('PB011', '111', N'Phòng hồi sức', 6, N'Còn trống', 'KH02'),
    ('PB012', '112', N'Phòng thường', 4, N'Đang sử dụng', 'KH03'),
    ('PB013', '113', N'Phòng dịch vụ', 5, N'Còn trống', 'KH04'),
    ('PB014', '114', N'Phòng VIP', 6, N'Còn trống', 'KH05'),
    ('PB015', '115', N'Phòng hồi sức', 4, N'Đang sử dụng', 'KH06'),
    ('PB016', '116', N'Phòng thường', 5, N'Còn trống', 'KH07'),
    ('PB017', '117', N'Phòng dịch vụ', 6, N'Còn trống', 'KH08'),
    ('PB018', '118', N'Phòng VIP', 4, N'Đang sử dụng', 'KH09'),
    ('PB019', '119', N'Phòng hồi sức', 5, N'Còn trống', 'KH10'),
    ('PB020', '120', N'Phòng thường', 6, N'Còn trống', 'KH01')
GO

-- ================================================================
-- 3. NHAN_VIEN
-- ================================================================
INSERT INTO NHAN_VIEN (NV_MaNV, NV_Ten, NV_NgaySinh, NV_GioiTinh, NV_SDT, NV_CCCD, NV_VaiTro, K_MaKhoa) VALUES
    ('NV001', N'Trần Hữu Bình', '1971-02-02', N'Nam', '0920000137', '07901000977', N'Bác sĩ', 'KH02'),
    ('NV002', N'Lê Thu Dung', '1972-03-03', N'Nữ', '0920000274', '07901001954', N'Bác sĩ', 'KH03'),
    ('NV003', N'Phạm Minh Dũng', '1973-04-04', N'Nam', '0920000411', '07901002931', N'Bác sĩ', 'KH04'),
    ('NV004', N'Hoàng Diệu Hà', '1974-05-05', N'Nữ', '0920000548', '07901003908', N'Bác sĩ', 'KH05'),
    ('NV005', N'Huỳnh Thành Hùng', '1975-06-06', N'Nam', '0920000685', '07901004885', N'Bác sĩ', 'KH06'),
    ('NV006', N'Phan Hồng Lan', '1976-07-07', N'Nữ', '0920000822', '07901005862', N'Bác sĩ', 'KH07'),
    ('NV007', N'Vũ Văn Long', '1977-08-08', N'Nam', '0920000959', '07901006839', N'Bác sĩ', 'KH08'),
    ('NV008', N'Võ Ngọc Mai', '1978-09-09', N'Nữ', '0920001096', '07901007816', N'Bác sĩ', 'KH09'),
    ('NV009', N'Đặng Đức Phong', '1979-10-10', N'Nam', '0920001233', '07901008793', N'Bác sĩ', 'KH10'),
    ('NV010', N'Bùi Kim Nhung', '1980-11-11', N'Nữ', '0920001370', '07901009770', N'Bác sĩ', 'KH01'),
    ('NV011', N'Đỗ Quang Sơn', '1981-12-12', N'Nam', '0920001507', '07901010747', N'Bác sĩ', 'KH02'),
    ('NV012', N'Hồ Bảo Phương', '1982-01-13', N'Nữ', '0920001644', '07901011724', N'Bác sĩ', 'KH03'),
    ('NV013', N'Ngô Công Tuấn', '1983-02-14', N'Nam', '0920001781', '07901012701', N'Bác sĩ', 'KH04'),
    ('NV014', N'Dương Thị Thảo', '1984-03-15', N'Nữ', '0920001918', '07901013678', N'Bác sĩ', 'KH05'),
    ('NV015', N'Lý Hữu Vinh', '1985-04-16', N'Nam', '0920002055', '07901014655', N'Bác sĩ', 'KH06'),
    ('NV016', N'Nguyễn Thu Trinh', '1986-05-17', N'Nữ', '0920002192', '07901015632', N'Điều dưỡng', 'KH07'),
    ('NV017', N'Trần Minh Kiên', '1987-06-18', N'Nam', '0920002329', '07901016609', N'Điều dưỡng', 'KH08'),
    ('NV018', N'Lê Diệu Vân', '1988-07-19', N'Nữ', '0920002466', '07901017586', N'Điều dưỡng', 'KH09'),
    ('NV019', N'Phạm Thành Trung', '1989-08-20', N'Nam', '0920002603', '07901018563', N'Điều dưỡng', 'KH10'),
    ('NV020', N'Hoàng Hồng Anh', '1990-09-21', N'Nữ', '0920002740', '07901019540', N'Điều dưỡng', 'KH01'),
    ('NV021', N'Huỳnh Văn Bình', '1991-10-22', N'Nam', '0920002877', '07901020517', N'Điều dưỡng', 'KH02'),
    ('NV022', N'Phan Ngọc Dung', '1992-11-23', N'Nữ', '0920003014', '07901021494', N'Điều dưỡng', 'KH03'),
    ('NV023', N'Vũ Đức Dũng', '1993-12-24', N'Nam', '0920003151', '07901022471', N'Điều dưỡng', 'KH04'),
    ('NV024', N'Võ Kim Hà', '1994-01-25', N'Nữ', '0920003288', '07901023448', N'Điều dưỡng', 'KH05'),
    ('NV025', N'Đặng Quang Hùng', '1995-02-26', N'Nam', '0920003425', '07901024425', N'Điều dưỡng', 'KH06'),
    ('NV026', N'Bùi Bảo Lan', '1996-03-27', N'Nữ', '0920003562', '07901025402', N'Điều dưỡng', 'KH07'),
    ('NV027', N'Đỗ Công Long', '1997-04-01', N'Nam', '0920003699', '07901026379', N'Điều dưỡng', 'KH08'),
    ('NV028', N'Hồ Thị Mai', '1998-05-02', N'Nữ', '0920003836', '07901027356', N'Điều dưỡng', 'KH09'),
    ('NV029', N'Ngô Hữu Phong', '1999-06-03', N'Nam', '0920003973', '07901028333', N'Điều dưỡng', 'KH10'),
    ('NV030', N'Dương Thu Nhung', '1970-07-04', N'Nữ', '0920004110', '07901029310', N'Điều dưỡng', 'KH01')
GO

-- ================================================================
-- 4. BAC_SI
-- ================================================================
INSERT INTO BAC_SI (BS_MaBS, BS_ChuyenKhoa, BS_CapBac, BS_HocVi, BS_CCHN, BS_NamKN, BS_MaBS_ThamVan) VALUES
    ('NV001', N'Ngoại khoa', N'Bác sĩ CKI', N'Thạc sĩ Y khoa', 'CCHN-1001', 4, NULL),
    ('NV002', N'Nhi khoa', N'Bác sĩ CKII', N'Tiến sĩ Y khoa', 'CCHN-1002', 5, NULL),
    ('NV003', N'Sản phụ khoa', N'Thạc sĩ', N'Cử nhân Y khoa', 'CCHN-1003', 6, NULL),
    ('NV004', N'Tim mạch', N'Tiến sĩ', N'Thạc sĩ Y khoa', 'CCHN-1004', 7, NULL),
    ('NV005', N'Thần kinh', N'Bác sĩ', N'Tiến sĩ Y khoa', 'CCHN-1005', 8, NULL),
    ('NV006', N'Tai Mũi Họng', N'Bác sĩ CKI', N'Cử nhân Y khoa', 'CCHN-1006', 9, 'NV001'),
    ('NV007', N'Chẩn đoán hình ảnh', N'Bác sĩ CKII', N'Thạc sĩ Y khoa', 'CCHN-1007', 10, 'NV002'),
    ('NV008', N'Xét nghiệm', N'Thạc sĩ', N'Tiến sĩ Y khoa', 'CCHN-1008', 11, 'NV003'),
    ('NV009', N'Hồi sức cấp cứu', N'Tiến sĩ', N'Cử nhân Y khoa', 'CCHN-1009', 12, 'NV004'),
    ('NV010', N'Nội tổng quát', N'Bác sĩ', N'Thạc sĩ Y khoa', 'CCHN-1010', 13, 'NV005'),
    ('NV011', N'Ngoại khoa', N'Bác sĩ CKI', N'Tiến sĩ Y khoa', 'CCHN-1011', 14, 'NV001'),
    ('NV012', N'Nhi khoa', N'Bác sĩ CKII', N'Cử nhân Y khoa', 'CCHN-1012', 15, 'NV002'),
    ('NV013', N'Sản phụ khoa', N'Thạc sĩ', N'Thạc sĩ Y khoa', 'CCHN-1013', 16, 'NV003'),
    ('NV014', N'Tim mạch', N'Tiến sĩ', N'Tiến sĩ Y khoa', 'CCHN-1014', 17, 'NV004'),
    ('NV015', N'Thần kinh', N'Bác sĩ', N'Cử nhân Y khoa', 'CCHN-1015', 18, 'NV005')
GO

-- ================================================================
-- 5. DIEU_DUONG
-- ================================================================
INSERT INTO DIEU_DUONG (DD_MaDD, DD_CapBac, DD_CCHN) VALUES
    ('NV016', N'Điều dưỡng cao đẳng', 'CCHN-DD-2001'),
    ('NV017', N'Điều dưỡng đại học', 'CCHN-DD-2002'),
    ('NV018', N'Điều dưỡng trung cấp', 'CCHN-DD-2003'),
    ('NV019', N'Điều dưỡng cao đẳng', 'CCHN-DD-2004'),
    ('NV020', N'Điều dưỡng đại học', 'CCHN-DD-2005'),
    ('NV021', N'Điều dưỡng trung cấp', 'CCHN-DD-2006'),
    ('NV022', N'Điều dưỡng cao đẳng', 'CCHN-DD-2007'),
    ('NV023', N'Điều dưỡng đại học', 'CCHN-DD-2008'),
    ('NV024', N'Điều dưỡng trung cấp', 'CCHN-DD-2009'),
    ('NV025', N'Điều dưỡng cao đẳng', 'CCHN-DD-2010'),
    ('NV026', N'Điều dưỡng đại học', 'CCHN-DD-2011'),
    ('NV027', N'Điều dưỡng trung cấp', 'CCHN-DD-2012'),
    ('NV028', N'Điều dưỡng cao đẳng', 'CCHN-DD-2013'),
    ('NV029', N'Điều dưỡng đại học', 'CCHN-DD-2014'),
    ('NV030', N'Điều dưỡng trung cấp', 'CCHN-DD-2015')
GO

-- ================================================================
-- 6. LICH_TRUC
-- ================================================================
INSERT INTO LICH_TRUC (LT_MaLichTruc, LT_Ngay, LT_Ca, LT_TrangThai, LT_GhiChu, LT_TGBD, LT_TGKT, NV_MaNV, K_MaKhoa) VALUES
    ('LT001', '2026-02-02', N'Ca chiều', N'Đã duyệt', N'Trực chính', '2026-02-02 14:00:00', '2026-02-02 22:00:00', 'NV002', 'KH02'),
    ('LT002', '2026-03-03', N'Ca đêm', N'Đã duyệt', NULL, '2026-03-03 22:00:00', '2026-03-03 30:00:00', 'NV003', 'KH03'),
    ('LT003', '2026-04-04', N'Ca sáng', N'Đã duyệt', N'Trực chính', '2026-04-04 06:00:00', '2026-04-04 14:00:00', 'NV004', 'KH04'),
    ('LT004', '2026-05-05', N'Ca chiều', N'Chờ duyệt', NULL, '2026-05-05 14:00:00', '2026-05-05 22:00:00', 'NV005', 'KH05'),
    ('LT005', '2026-06-06', N'Ca đêm', N'Đã duyệt', N'Trực chính', '2026-06-06 22:00:00', '2026-06-06 30:00:00', 'NV006', 'KH06'),
    ('LT006', '2026-07-07', N'Ca sáng', N'Đã duyệt', NULL, '2026-07-07 06:00:00', '2026-07-07 14:00:00', 'NV007', 'KH07'),
    ('LT007', '2026-08-08', N'Ca chiều', N'Đã duyệt', N'Trực chính', '2026-08-08 14:00:00', '2026-08-08 22:00:00', 'NV008', 'KH08'),
    ('LT008', '2026-09-09', N'Ca đêm', N'Chờ duyệt', NULL, '2026-09-09 22:00:00', '2026-09-09 30:00:00', 'NV009', 'KH09'),
    ('LT009', '2026-10-10', N'Ca sáng', N'Đã duyệt', N'Trực chính', '2026-10-10 06:00:00', '2026-10-10 14:00:00', 'NV010', 'KH10'),
    ('LT010', '2026-11-11', N'Ca chiều', N'Đã duyệt', NULL, '2026-11-11 14:00:00', '2026-11-11 22:00:00', 'NV011', 'KH01'),
    ('LT011', '2026-12-12', N'Ca đêm', N'Đã duyệt', N'Trực chính', '2026-12-12 22:00:00', '2026-12-12 30:00:00', 'NV012', 'KH02'),
    ('LT012', '2026-01-13', N'Ca sáng', N'Chờ duyệt', NULL, '2026-01-13 06:00:00', '2026-01-13 14:00:00', 'NV013', 'KH03'),
    ('LT013', '2026-02-14', N'Ca chiều', N'Đã duyệt', N'Trực chính', '2026-02-14 14:00:00', '2026-02-14 22:00:00', 'NV014', 'KH04'),
    ('LT014', '2026-03-15', N'Ca đêm', N'Đã duyệt', NULL, '2026-03-15 22:00:00', '2026-03-15 30:00:00', 'NV015', 'KH05'),
    ('LT015', '2026-04-16', N'Ca sáng', N'Đã duyệt', N'Trực chính', '2026-04-16 06:00:00', '2026-04-16 14:00:00', 'NV016', 'KH06'),
    ('LT016', '2026-05-17', N'Ca chiều', N'Chờ duyệt', NULL, '2026-05-17 14:00:00', '2026-05-17 22:00:00', 'NV017', 'KH07'),
    ('LT017', '2026-06-18', N'Ca đêm', N'Đã duyệt', N'Trực chính', '2026-06-18 22:00:00', '2026-06-18 30:00:00', 'NV018', 'KH08'),
    ('LT018', '2026-07-19', N'Ca sáng', N'Đã duyệt', NULL, '2026-07-19 06:00:00', '2026-07-19 14:00:00', 'NV019', 'KH09'),
    ('LT019', '2026-08-20', N'Ca chiều', N'Đã duyệt', N'Trực chính', '2026-08-20 14:00:00', '2026-08-20 22:00:00', 'NV020', 'KH10'),
    ('LT020', '2026-09-21', N'Ca đêm', N'Chờ duyệt', NULL, '2026-09-21 22:00:00', '2026-09-21 30:00:00', 'NV021', 'KH01'),
    ('LT021', '2026-10-22', N'Ca sáng', N'Đã duyệt', N'Trực chính', '2026-10-22 06:00:00', '2026-10-22 14:00:00', 'NV022', 'KH02'),
    ('LT022', '2026-11-23', N'Ca chiều', N'Đã duyệt', NULL, '2026-11-23 14:00:00', '2026-11-23 22:00:00', 'NV023', 'KH03'),
    ('LT023', '2026-12-24', N'Ca đêm', N'Đã duyệt', N'Trực chính', '2026-12-24 22:00:00', '2026-12-24 30:00:00', 'NV024', 'KH04'),
    ('LT024', '2026-01-25', N'Ca sáng', N'Chờ duyệt', NULL, '2026-01-25 06:00:00', '2026-01-25 14:00:00', 'NV025', 'KH05'),
    ('LT025', '2026-02-26', N'Ca chiều', N'Đã duyệt', N'Trực chính', '2026-02-26 14:00:00', '2026-02-26 22:00:00', 'NV026', 'KH06')
GO

-- ================================================================
-- 7. BENH_NHAN
-- ================================================================
INSERT INTO BENH_NHAN (BN_MaBN, BN_HoTen, BN_NgaySinh, BN_GioiTinh, BN_SoDienThoai, BN_DiaChi, BN_Email) VALUES
    ('BN0001', N'Phạm Đức Sơn', '1951-02-02', N'Nam', '0920027537', N'11 Lê Lợi, Quận 3, TP.HCM', 'benhnhan0001@email.com'),
    ('BN0002', N'Hoàng Kim Phương', '1952-03-03', N'Nữ', '0920027674', N'12 Trần Hưng Đạo, Quận 5, TP.HCM', 'benhnhan0002@email.com'),
    ('BN0003', N'Huỳnh Quang Tuấn', '1953-04-04', N'Nam', '0920027811', N'13 Hai Bà Trưng, Quận 7, TP.HCM', 'benhnhan0003@email.com'),
    ('BN0004', N'Phan Bảo Thảo', '1954-05-05', N'Nữ', '0920027948', N'14 Cách Mạng Tháng Tám, Quận 10, TP.HCM', 'benhnhan0004@email.com'),
    ('BN0005', N'Vũ Công Vinh', '1955-06-06', N'Nam', '0920028085', N'15 Điện Biên Phủ, Bình Thạnh, TP.HCM', 'benhnhan0005@email.com'),
    ('BN0006', N'Võ Thị Trinh', '1956-07-07', N'Nữ', '0920028222', N'16 Phạm Văn Đồng, Thủ Đức, TP.HCM', 'benhnhan0006@email.com'),
    ('BN0007', N'Đặng Hữu Kiên', '1957-08-08', N'Nam', '0920028359', N'17 Nguyễn Văn Cừ, Gò Vấp, TP.HCM', 'benhnhan0007@email.com'),
    ('BN0008', N'Bùi Thu Vân', '1958-09-09', N'Nữ', '0920028496', N'18 Lý Thường Kiệt, Tân Bình, TP.HCM', 'benhnhan0008@email.com'),
    ('BN0009', N'Đỗ Minh Trung', '1959-10-10', N'Nam', '0920028633', N'19 Tô Hiến Thành, Phú Nhuận, TP.HCM', 'benhnhan0009@email.com'),
    ('BN0010', N'Hồ Diệu Anh', '1960-11-11', N'Nữ', '0920028770', N'20 Nguyễn Trãi, Quận 1, TP.HCM', 'benhnhan0010@email.com'),
    ('BN0011', N'Ngô Thành Bình', '1961-12-12', N'Nam', '0920028907', N'21 Lê Lợi, Quận 3, TP.HCM', 'benhnhan0011@email.com'),
    ('BN0012', N'Dương Hồng Dung', '1962-01-13', N'Nữ', '0920029044', N'22 Trần Hưng Đạo, Quận 5, TP.HCM', 'benhnhan0012@email.com'),
    ('BN0013', N'Lý Văn Dũng', '1963-02-14', N'Nam', '0920029181', N'23 Hai Bà Trưng, Quận 7, TP.HCM', 'benhnhan0013@email.com'),
    ('BN0014', N'Nguyễn Ngọc Hà', '1964-03-15', N'Nữ', '0920029318', N'24 Cách Mạng Tháng Tám, Quận 10, TP.HCM', 'benhnhan0014@email.com'),
    ('BN0015', N'Trần Đức Hùng', '1965-04-16', N'Nam', '0920029455', N'25 Điện Biên Phủ, Bình Thạnh, TP.HCM', 'benhnhan0015@email.com'),
    ('BN0016', N'Lê Kim Lan', '1966-05-17', N'Nữ', '0920029592', N'26 Phạm Văn Đồng, Thủ Đức, TP.HCM', 'benhnhan0016@email.com'),
    ('BN0017', N'Phạm Quang Long', '1967-06-18', N'Nam', '0920029729', N'27 Nguyễn Văn Cừ, Gò Vấp, TP.HCM', 'benhnhan0017@email.com'),
    ('BN0018', N'Hoàng Bảo Mai', '1968-07-19', N'Nữ', '0920029866', N'28 Lý Thường Kiệt, Tân Bình, TP.HCM', 'benhnhan0018@email.com'),
    ('BN0019', N'Huỳnh Công Phong', '1969-08-20', N'Nam', '0920030003', N'29 Tô Hiến Thành, Phú Nhuận, TP.HCM', 'benhnhan0019@email.com'),
    ('BN0020', N'Phan Thị Nhung', '1970-09-21', N'Nữ', '0920030140', N'30 Nguyễn Trãi, Quận 1, TP.HCM', 'benhnhan0020@email.com')
GO

-- ================================================================
-- 8. BAO_HIEM_YT
-- ================================================================
INSERT INTO BAO_HIEM_YT (BH_MaBHYT, BH_MaSoBHYT, BH_NhaCungCap, BH_NgayHieuLuc, BH_NgayHetHan, BN_MaBN) VALUES
    ('BH001', 'DN4000000001', N'Bảo Việt', '2024-01-01', '2027-12-31', 'BN0002'),
    ('BH002', 'DN4000000002', N'PVI', '2024-01-01', '2027-12-31', 'BN0003'),
    ('BH003', 'DN4000000003', N'Manulife', '2024-01-01', '2027-12-31', 'BN0004'),
    ('BH004', 'DN4000000004', N'Prudential', '2024-01-01', '2027-12-31', 'BN0005'),
    ('BH005', 'DN4000000005', N'BHXH Việt Nam', '2024-01-01', '2027-12-31', 'BN0006'),
    ('BH006', 'DN4000000006', N'Bảo Việt', '2024-01-01', '2027-12-31', 'BN0007'),
    ('BH007', 'DN4000000007', N'PVI', '2024-01-01', '2027-12-31', 'BN0008'),
    ('BH008', 'DN4000000008', N'Manulife', '2024-01-01', '2027-12-31', 'BN0009'),
    ('BH009', 'DN4000000009', N'Prudential', '2024-01-01', '2027-12-31', 'BN0010'),
    ('BH010', 'DN4000000010', N'BHXH Việt Nam', '2024-01-01', '2027-12-31', 'BN0011'),
    ('BH011', 'DN4000000011', N'Bảo Việt', '2024-01-01', '2027-12-31', 'BN0012'),
    ('BH012', 'DN4000000012', N'PVI', '2024-01-01', '2027-12-31', 'BN0013')
GO

-- ================================================================
-- 9. LICH_HEN
-- ================================================================
INSERT INTO LICH_HEN (LH_MaLichHen, LH_NgayHen, LH_GioHen, LH_TrangThai, LH_LyDoKham, BN_MaBN) VALUES
    ('LH0001', '2026-02-02', '8:30:00', N'Chờ xác nhận', N'Tái khám', 'BN0002'),
    ('LH0002', '2026-03-03', '9:00:00', N'Đã hủy', N'Khám chuyên khoa', 'BN0003'),
    ('LH0003', '2026-04-04', '10:30:00', N'Đã khám', N'Tư vấn dinh dưỡng', 'BN0004'),
    ('LH0004', '2026-05-05', '11:00:00', N'Đã xác nhận', N'Khám thai định kỳ', 'BN0005'),
    ('LH0005', '2026-06-06', '12:30:00', N'Chờ xác nhận', N'Khám tổng quát', 'BN0006'),
    ('LH0006', '2026-07-07', '13:00:00', N'Đã hủy', N'Tái khám', 'BN0007'),
    ('LH0007', '2026-08-08', '14:30:00', N'Đã khám', N'Khám chuyên khoa', 'BN0008'),
    ('LH0008', '2026-09-09', '15:00:00', N'Đã xác nhận', N'Tư vấn dinh dưỡng', 'BN0009'),
    ('LH0009', '2026-10-10', '16:30:00', N'Chờ xác nhận', N'Khám thai định kỳ', 'BN0010'),
    ('LH0010', '2026-11-11', '7:00:00', N'Đã hủy', N'Khám tổng quát', 'BN0011'),
    ('LH0011', '2026-12-12', '8:30:00', N'Đã khám', N'Tái khám', 'BN0012'),
    ('LH0012', '2026-01-13', '9:00:00', N'Đã xác nhận', N'Khám chuyên khoa', 'BN0013'),
    ('LH0013', '2026-02-14', '10:30:00', N'Chờ xác nhận', N'Tư vấn dinh dưỡng', 'BN0014'),
    ('LH0014', '2026-03-15', '11:00:00', N'Đã hủy', N'Khám thai định kỳ', 'BN0015'),
    ('LH0015', '2026-04-16', '12:30:00', N'Đã khám', N'Khám tổng quát', 'BN0016'),
    ('LH0016', '2026-05-17', '13:00:00', N'Đã xác nhận', N'Tái khám', 'BN0017'),
    ('LH0017', '2026-06-18', '14:30:00', N'Chờ xác nhận', N'Khám chuyên khoa', 'BN0018'),
    ('LH0018', '2026-07-19', '15:00:00', N'Đã hủy', N'Tư vấn dinh dưỡng', 'BN0019'),
    ('LH0019', '2026-08-20', '16:30:00', N'Đã khám', N'Khám thai định kỳ', 'BN0020'),
    ('LH0020', '2026-09-21', '7:00:00', N'Đã xác nhận', N'Khám tổng quát', 'BN0001')
GO

-- ================================================================
-- 10. HO_SO_NHAP_VIEN
-- ================================================================
INSERT INTO HO_SO_NHAP_VIEN (HS_MaHoSo, HS_NgayNhapVien, HS_NgayRaVien, HS_LyDoNhapVien, HS_TrangThai, BN_MaBN, K_MaKhoa, PB_MaPhong) VALUES
    ('HS001', '2026-02-02', '2026-03-03', N'Phẫu thuật theo lịch', N'Đã ra viện', 'BN0002', 'KH02', 'PB002'),
    ('HS002', '2026-03-03', '2026-04-04', N'Theo dõi nội trú', N'Đã ra viện', 'BN0003', 'KH03', 'PB003'),
    ('HS003', '2026-04-04', NULL, N'Sinh con', N'Đang điều trị', 'BN0004', 'KH04', 'PB004'),
    ('HS004', '2026-05-05', '2026-06-06', N'Điều trị nội khoa', N'Đã ra viện', 'BN0005', 'KH05', 'PB005'),
    ('HS005', '2026-06-06', '2026-07-07', N'Cấp cứu tai nạn', N'Đã ra viện', 'BN0006', 'KH06', 'PB006'),
    ('HS006', '2026-07-07', NULL, N'Phẫu thuật theo lịch', N'Đang điều trị', 'BN0007', 'KH07', 'PB007'),
    ('HS007', '2026-08-08', '2026-09-09', N'Theo dõi nội trú', N'Đã ra viện', 'BN0008', 'KH08', 'PB008'),
    ('HS008', '2026-09-09', '2026-10-10', N'Sinh con', N'Đã ra viện', 'BN0009', 'KH09', 'PB009'),
    ('HS009', '2026-10-10', NULL, N'Điều trị nội khoa', N'Đang điều trị', 'BN0010', 'KH10', 'PB010'),
    ('HS010', '2026-11-11', '2026-12-12', N'Cấp cứu tai nạn', N'Đã ra viện', 'BN0011', 'KH01', 'PB011'),
    ('HS011', '2026-12-12', '2026-01-13', N'Phẫu thuật theo lịch', N'Đã ra viện', 'BN0012', 'KH02', 'PB012'),
    ('HS012', '2026-01-13', NULL, N'Theo dõi nội trú', N'Đang điều trị', 'BN0013', 'KH03', 'PB013'),
    ('HS013', '2026-02-14', '2026-03-15', N'Sinh con', N'Đã ra viện', 'BN0014', 'KH04', 'PB014'),
    ('HS014', '2026-03-15', '2026-04-16', N'Điều trị nội khoa', N'Đã ra viện', 'BN0015', 'KH05', 'PB015'),
    ('HS015', '2026-04-16', NULL, N'Cấp cứu tai nạn', N'Đang điều trị', 'BN0016', 'KH06', 'PB016')
GO

-- ================================================================
-- 11. BENH_AN
-- ================================================================
INSERT INTO BENH_AN (BA_MaBenhAn, BA_NgayTao, BA_ChanDoan, BA_DieuTri, BA_GhiChu, BN_MaBN, HS_MaHoSo) VALUES
    ('BA0001', '2026-02-02', N'Chẩn đoán sơ bộ #1', N'Phác đồ điều trị ban đầu #1', N'Theo dõi thêm', 'BN0002', NULL),
    ('BA0002', '2026-03-03', N'Chẩn đoán sơ bộ #2', N'Phác đồ điều trị ban đầu #2', NULL, 'BN0003', NULL),
    ('BA0003', '2026-04-04', N'Chẩn đoán sơ bộ #3', N'Phác đồ điều trị ban đầu #3', N'Theo dõi thêm', 'BN0004', 'HS004'),
    ('BA0004', '2026-05-05', N'Chẩn đoán sơ bộ #4', N'Phác đồ điều trị ban đầu #4', NULL, 'BN0005', NULL),
    ('BA0005', '2026-06-06', N'Chẩn đoán sơ bộ #5', N'Phác đồ điều trị ban đầu #5', N'Theo dõi thêm', 'BN0006', NULL),
    ('BA0006', '2026-07-07', N'Chẩn đoán sơ bộ #6', N'Phác đồ điều trị ban đầu #6', NULL, 'BN0007', 'HS007'),
    ('BA0007', '2026-08-08', N'Chẩn đoán sơ bộ #7', N'Phác đồ điều trị ban đầu #7', N'Theo dõi thêm', 'BN0008', NULL),
    ('BA0008', '2026-09-09', N'Chẩn đoán sơ bộ #8', N'Phác đồ điều trị ban đầu #8', NULL, 'BN0009', NULL),
    ('BA0009', '2026-10-10', N'Chẩn đoán sơ bộ #9', N'Phác đồ điều trị ban đầu #9', N'Theo dõi thêm', 'BN0010', 'HS010'),
    ('BA0010', '2026-11-11', N'Chẩn đoán sơ bộ #10', N'Phác đồ điều trị ban đầu #10', NULL, 'BN0011', NULL),
    ('BA0011', '2026-12-12', N'Chẩn đoán sơ bộ #11', N'Phác đồ điều trị ban đầu #11', N'Theo dõi thêm', 'BN0012', NULL),
    ('BA0012', '2026-01-13', N'Chẩn đoán sơ bộ #12', N'Phác đồ điều trị ban đầu #12', NULL, 'BN0013', 'HS013'),
    ('BA0013', '2026-02-14', N'Chẩn đoán sơ bộ #13', N'Phác đồ điều trị ban đầu #13', N'Theo dõi thêm', 'BN0014', NULL),
    ('BA0014', '2026-03-15', N'Chẩn đoán sơ bộ #14', N'Phác đồ điều trị ban đầu #14', NULL, 'BN0015', NULL),
    ('BA0015', '2026-04-16', N'Chẩn đoán sơ bộ #15', N'Phác đồ điều trị ban đầu #15', N'Theo dõi thêm', 'BN0016', 'HS001'),
    ('BA0016', '2026-05-17', N'Chẩn đoán sơ bộ #16', N'Phác đồ điều trị ban đầu #16', NULL, 'BN0017', NULL),
    ('BA0017', '2026-06-18', N'Chẩn đoán sơ bộ #17', N'Phác đồ điều trị ban đầu #17', N'Theo dõi thêm', 'BN0018', NULL),
    ('BA0018', '2026-07-19', N'Chẩn đoán sơ bộ #18', N'Phác đồ điều trị ban đầu #18', NULL, 'BN0019', 'HS004'),
    ('BA0019', '2026-08-20', N'Chẩn đoán sơ bộ #19', N'Phác đồ điều trị ban đầu #19', N'Theo dõi thêm', 'BN0020', NULL),
    ('BA0020', '2026-09-21', N'Chẩn đoán sơ bộ #20', N'Phác đồ điều trị ban đầu #20', NULL, 'BN0001', NULL)
GO

-- ================================================================
-- 12. CHAN_DOAN
-- ================================================================
INSERT INTO CHAN_DOAN (CD_MaChanDoan, CD_TenChanDoan, CD_MoTa, CD_NgayChanDoan, BA_MaBenhAn, BS_MaBS) VALUES
    ('CD0001', N'Tăng huyết áp', N'Ghi nhận triệu chứng lâm sàng #1', '2026-02-03', 'BA0002', 'NV002'),
    ('CD0002', N'Đái tháo đường type 2', N'Ghi nhận triệu chứng lâm sàng #2', '2026-03-04', 'BA0003', 'NV003'),
    ('CD0003', N'Viêm dạ dày', N'Ghi nhận triệu chứng lâm sàng #3', '2026-04-05', 'BA0004', 'NV004'),
    ('CD0004', N'Gãy xương cẳng tay', N'Ghi nhận triệu chứng lâm sàng #4', '2026-05-06', 'BA0005', 'NV005'),
    ('CD0005', N'Sốt xuất huyết', N'Ghi nhận triệu chứng lâm sàng #5', '2026-06-07', 'BA0006', 'NV006'),
    ('CD0006', N'Viêm ruột thừa', N'Ghi nhận triệu chứng lâm sàng #6', '2026-07-08', 'BA0007', 'NV007'),
    ('CD0007', N'Hen phế quản', N'Ghi nhận triệu chứng lâm sàng #7', '2026-08-09', 'BA0008', 'NV008'),
    ('CD0008', N'Rối loạn tiền đình', N'Ghi nhận triệu chứng lâm sàng #8', '2026-09-10', 'BA0009', 'NV009'),
    ('CD0009', N'Thoái hóa cột sống', N'Ghi nhận triệu chứng lâm sàng #9', '2026-10-11', 'BA0010', 'NV010'),
    ('CD0010', N'Viêm phổi', N'Ghi nhận triệu chứng lâm sàng #10', '2026-11-12', 'BA0011', 'NV011'),
    ('CD0011', N'Tăng huyết áp', N'Ghi nhận triệu chứng lâm sàng #11', '2026-12-13', 'BA0012', 'NV012'),
    ('CD0012', N'Đái tháo đường type 2', N'Ghi nhận triệu chứng lâm sàng #12', '2026-01-14', 'BA0013', 'NV013'),
    ('CD0013', N'Viêm dạ dày', N'Ghi nhận triệu chứng lâm sàng #13', '2026-02-15', 'BA0014', 'NV014'),
    ('CD0014', N'Gãy xương cẳng tay', N'Ghi nhận triệu chứng lâm sàng #14', '2026-03-16', 'BA0015', 'NV015'),
    ('CD0015', N'Sốt xuất huyết', N'Ghi nhận triệu chứng lâm sàng #15', '2026-04-17', 'BA0016', 'NV001'),
    ('CD0016', N'Viêm ruột thừa', N'Ghi nhận triệu chứng lâm sàng #16', '2026-05-18', 'BA0017', 'NV002'),
    ('CD0017', N'Hen phế quản', N'Ghi nhận triệu chứng lâm sàng #17', '2026-06-19', 'BA0018', 'NV003'),
    ('CD0018', N'Rối loạn tiền đình', N'Ghi nhận triệu chứng lâm sàng #18', '2026-07-20', 'BA0019', 'NV004'),
    ('CD0019', N'Thoái hóa cột sống', N'Ghi nhận triệu chứng lâm sàng #19', '2026-08-21', 'BA0020', 'NV005'),
    ('CD0020', N'Viêm phổi', N'Ghi nhận triệu chứng lâm sàng #20', '2026-09-22', 'BA0001', 'NV006')
GO

-- ================================================================
-- 13. NHA_CUNG_CAP
-- ================================================================
INSERT INTO NHA_CUNG_CAP (NCC_MaNCC, NCC_TenNCC, NCC_SDT, NCC_DiaChi, NCC_MST) VALUES
    ('NCC01', N'Công ty Dược phẩm Traphaco', '0920041237', N'14 Cách Mạng Tháng Tám, Quận 10, TP.HCM', '0301000001'),
    ('NCC02', N'Công ty CP Dược Hậu Giang', '0920041374', N'15 Điện Biên Phủ, Bình Thạnh, TP.HCM', '0301000002'),
    ('NCC03', N'Công ty TNHH Zuellig Pharma', '0920041511', N'16 Phạm Văn Đồng, Thủ Đức, TP.HCM', '0301000003'),
    ('NCC04', N'Công ty CP Vật tư Y tế Việt Nam', '0920041648', N'17 Nguyễn Văn Cừ, Gò Vấp, TP.HCM', '0301000004'),
    ('NCC05', N'Công ty TNHH B.Braun Việt Nam', '0920041785', N'18 Lý Thường Kiệt, Tân Bình, TP.HCM', '0301000005'),
    ('NCC06', N'Công ty CP Dược phẩm OPC', '0920041922', N'19 Tô Hiến Thành, Phú Nhuận, TP.HCM', '0301000006'),
    ('NCC07', N'Công ty TNHH Thiết bị Y tế Phương Đông', '0920042059', N'20 Nguyễn Trãi, Quận 1, TP.HCM', '0301000007'),
    ('NCC08', N'Công ty CP Xuất nhập khẩu Y tế Domesco', '0920042196', N'21 Lê Lợi, Quận 3, TP.HCM', '0301000008')
GO

-- ================================================================
-- 14. DON_NHAP_HANG
-- ================================================================
INSERT INTO DON_NHAP_HANG (DNH_MaDon, DNH_NgayLap, DNH_NgayNhap, DNH_TrangThai, DNH_NguoiLap, NCC_MaNCC) VALUES
    ('DNH001', '2026-02-02', '2026-03-04', N'Đã nhập kho', N'Ngô Thành Bình', 'NCC02'),
    ('DNH002', '2026-03-03', '2026-04-05', N'Đang xử lý', N'Dương Hồng Dung', 'NCC03'),
    ('DNH003', '2026-04-04', '2026-05-06', N'Đã nhập kho', N'Lý Văn Dũng', 'NCC04'),
    ('DNH004', '2026-05-05', '2026-06-07', N'Đang xử lý', N'Nguyễn Ngọc Hà', 'NCC05'),
    ('DNH005', '2026-06-06', '2026-07-08', N'Đã nhập kho', N'Trần Đức Hùng', 'NCC06'),
    ('DNH006', '2026-07-07', '2026-08-09', N'Đang xử lý', N'Lê Kim Lan', 'NCC07'),
    ('DNH007', '2026-08-08', '2026-09-10', N'Đã nhập kho', N'Phạm Quang Long', 'NCC08'),
    ('DNH008', '2026-09-09', '2026-10-11', N'Đang xử lý', N'Hoàng Bảo Mai', 'NCC01'),
    ('DNH009', '2026-10-10', '2026-11-12', N'Đã nhập kho', N'Huỳnh Công Phong', 'NCC02'),
    ('DNH010', '2026-11-11', '2026-12-13', N'Đang xử lý', N'Phan Thị Nhung', 'NCC03'),
    ('DNH011', '2026-12-12', '2026-01-14', N'Đã nhập kho', N'Vũ Hữu Sơn', 'NCC04'),
    ('DNH012', '2026-01-13', '2026-02-15', N'Đang xử lý', N'Võ Thu Phương', 'NCC05')
GO

-- ================================================================
-- 15. THUOC
-- ================================================================
INSERT INTO THUOC (TH_MaThuoc, TH_TenThuongMai, TH_HoatChat, TH_KhoiLuong, TH_NhaSanXuat, TH_DangBaoBi, TH_DangBaoChe, TH_HanSuDung) VALUES
    ('TH001', N'Paracetamol 500mg', N'Paracetamol', N'100mg', N'Dược Hậu Giang', N'Hộp 100 viên', N'Viên nang', '2027-02-02'),
    ('TH002', N'Amoxicillin 500mg', N'Amoxicillin', N'150mg', N'Domesco', N'Lọ 30 viên', N'Dung dịch tiêm', '2027-03-03'),
    ('TH003', N'Augmentin 625mg', N'Amoxicillin/Clavulanate', N'200mg', N'OPC', N'Ống tiêm', N'Siro', '2027-04-04'),
    ('TH004', N'Omeprazole 20mg', N'Omeprazole', N'250mg', N'Sanofi Việt Nam', N'Chai 100ml', N'Viên sủi', '2027-05-05'),
    ('TH005', N'Losartan 50mg', N'Losartan', N'300mg', N'Traphaco', N'Vỉ 10 viên', N'Viên nén', '2027-06-06'),
    ('TH006', N'Metformin 850mg', N'Metformin', N'350mg', N'Dược Hậu Giang', N'Hộp 100 viên', N'Viên nang', '2027-07-07'),
    ('TH007', N'Salbutamol 100mcg', N'Salbutamol', N'400mg', N'Domesco', N'Lọ 30 viên', N'Dung dịch tiêm', '2027-08-08'),
    ('TH008', N'Cephalexin 500mg', N'Cephalexin', N'450mg', N'OPC', N'Ống tiêm', N'Siro', '2027-09-09'),
    ('TH009', N'Diclofenac 50mg', N'Diclofenac', N'500mg', N'Sanofi Việt Nam', N'Chai 100ml', N'Viên sủi', '2027-10-10'),
    ('TH010', N'Vitamin C 500mg', N'Ascorbic acid', N'50mg', N'Traphaco', N'Vỉ 10 viên', N'Viên nén', '2027-11-11'),
    ('TH011', N'Aspirin 81mg', N'Acetylsalicylic acid', N'100mg', N'Dược Hậu Giang', N'Hộp 100 viên', N'Viên nang', '2027-12-12'),
    ('TH012', N'Atorvastatin 20mg', N'Atorvastatin', N'150mg', N'Domesco', N'Lọ 30 viên', N'Dung dịch tiêm', '2027-01-13'),
    ('TH013', N'Cetirizine 10mg', N'Cetirizine', N'200mg', N'OPC', N'Ống tiêm', N'Siro', '2027-02-14'),
    ('TH014', N'Ciprofloxacin 500mg', N'Ciprofloxacin', N'250mg', N'Sanofi Việt Nam', N'Chai 100ml', N'Viên sủi', '2027-03-15'),
    ('TH015', N'Insulin Mixtard 30', N'Insulin', N'300mg', N'Traphaco', N'Vỉ 10 viên', N'Viên nén', '2027-04-16'),
    ('TH016', N'Furosemide 40mg', N'Furosemide', N'350mg', N'Dược Hậu Giang', N'Hộp 100 viên', N'Viên nang', '2027-05-17'),
    ('TH017', N'Prednisolone 5mg', N'Prednisolone', N'400mg', N'Domesco', N'Lọ 30 viên', N'Dung dịch tiêm', '2027-06-18'),
    ('TH018', N'Clopidogrel 75mg', N'Clopidogrel', N'450mg', N'OPC', N'Ống tiêm', N'Siro', '2027-07-19'),
    ('TH019', N'Ondansetron 4mg', N'Ondansetron', N'500mg', N'Sanofi Việt Nam', N'Chai 100ml', N'Viên sủi', '2027-08-20'),
    ('TH020', N'Domperidone 10mg', N'Domperidone', N'50mg', N'Traphaco', N'Vỉ 10 viên', N'Viên nén', '2027-09-21')
GO

-- ================================================================
-- 16. VAT_TU_YTE
-- ================================================================
INSERT INTO VAT_TU_YTE (VT_MaVatTu, VT_TenVatTu, VT_DonViTinh, VT_ChatLieu, VT_CongDung) VALUES
    ('VT001', N'Khẩu trang y tế 3 lớp', N'Cái', N'Vải không dệt', N'Phòng hộ cá nhân'),
    ('VT002', N'Găng tay y tế', N'Hộp', N'Cao su latex', N'Phòng hộ cá nhân'),
    ('VT003', N'Bơm kim tiêm 5ml', N'Cái', N'Nhựa y tế', N'Tiêm truyền'),
    ('VT004', N'Bông băng y tế', N'Hộp', N'Bông gòn', N'Sát trùng vết thương'),
    ('VT005', N'Gạc vô trùng', N'Cái', N'Vải cotton', N'Băng bó vết thương'),
    ('VT006', N'Dây truyền dịch', N'Hộp', N'Nhựa PVC', N'Truyền dịch'),
    ('VT007', N'Ống nghe y tế', N'Cái', N'Kim loại/Cao su', N'Khám lâm sàng'),
    ('VT008', N'Nhiệt kế điện tử', N'Hộp', N'Nhựa/Điện tử', N'Đo thân nhiệt'),
    ('VT009', N'Máy đo huyết áp', N'Cái', N'Điện tử', N'Đo huyết áp'),
    ('VT010', N'Kim luồn tĩnh mạch', N'Hộp', N'Nhựa y tế', N'Truyền dịch'),
    ('VT011', N'Túi đựng nước tiểu', N'Cái', N'Nhựa PVC', N'Theo dõi bài tiết'),
    ('VT012', N'Chỉ khâu phẫu thuật', N'Hộp', N'Sợi tổng hợp', N'Phẫu thuật'),
    ('VT013', N'Dao mổ vô trùng', N'Cái', N'Thép không gỉ', N'Phẫu thuật'),
    ('VT014', N'Ống nội khí quản', N'Hộp', N'Nhựa y tế', N'Hồi sức cấp cứu'),
    ('VT015', N'Máy đo đường huyết', N'Cái', N'Điện tử', N'Xét nghiệm tại giường')
GO

-- ================================================================
-- 17. PHIEU_XUAT_KHO
-- ================================================================
INSERT INTO PHIEU_XUAT_KHO (DNH_MaDon, PXK_SoLo, PXK_HSD, PXK_SL, PXK_DonGia, PXK_ThanhTien, TH_MaThuoc, VT_MaVatTu) VALUES
    ('DNH002', 'LO0001', '2027-02-02', 53, 6000, 318000, NULL, 'VT002'),
    ('DNH003', 'LO0002', '2027-03-03', 56, 7000, 392000, 'TH003', NULL),
    ('DNH004', 'LO0003', '2027-04-04', 59, 8000, 472000, NULL, 'VT004'),
    ('DNH005', 'LO0004', '2027-05-05', 62, 9000, 558000, 'TH005', NULL),
    ('DNH006', 'LO0005', '2027-06-06', 65, 10000, 650000, NULL, 'VT006'),
    ('DNH007', 'LO0006', '2027-07-07', 68, 11000, 748000, 'TH007', NULL),
    ('DNH008', 'LO0007', '2027-08-08', 71, 12000, 852000, NULL, 'VT008'),
    ('DNH009', 'LO0008', '2027-09-09', 74, 13000, 962000, 'TH009', NULL),
    ('DNH010', 'LO0009', '2027-10-10', 77, 14000, 1078000, NULL, 'VT010'),
    ('DNH011', 'LO0010', '2027-11-11', 80, 15000, 1200000, 'TH011', NULL),
    ('DNH012', 'LO0011', '2027-12-12', 83, 16000, 1328000, NULL, 'VT012'),
    ('DNH001', 'LO0012', '2027-01-13', 86, 17000, 1462000, 'TH013', NULL),
    ('DNH002', 'LO0013', '2027-02-14', 89, 18000, 1602000, NULL, 'VT014'),
    ('DNH003', 'LO0014', '2027-03-15', 92, 19000, 1748000, 'TH015', NULL),
    ('DNH004', 'LO0015', '2027-04-16', 95, 20000, 1900000, NULL, 'VT001'),
    ('DNH005', 'LO0016', '2027-05-17', 98, 21000, 2058000, 'TH017', NULL),
    ('DNH006', 'LO0017', '2027-06-18', 101, 22000, 2222000, NULL, 'VT003'),
    ('DNH007', 'LO0018', '2027-07-19', 104, 23000, 2392000, 'TH019', NULL),
    ('DNH008', 'LO0019', '2027-08-20', 107, 24000, 2568000, NULL, 'VT005'),
    ('DNH009', 'LO0020', '2027-09-21', 110, 5000, 550000, 'TH001', NULL)
GO

-- ================================================================
-- 18. DON_THUOC
-- ================================================================
INSERT INTO DON_THUOC (DT_MaDonThuoc, DT_NgayKeDon, DT_GhiChu, CD_MaChanDoan, BS_MaBS) VALUES
    ('DT001', '2026-02-04', N'Uống sau ăn', 'CD0002', 'NV002'),
    ('DT002', '2026-03-05', NULL, 'CD0003', 'NV003'),
    ('DT003', '2026-04-06', N'Uống sau ăn', 'CD0004', 'NV004'),
    ('DT004', '2026-05-07', NULL, 'CD0005', 'NV005'),
    ('DT005', '2026-06-08', N'Uống sau ăn', 'CD0006', 'NV006'),
    ('DT006', '2026-07-09', NULL, 'CD0007', 'NV007'),
    ('DT007', '2026-08-10', N'Uống sau ăn', 'CD0008', 'NV008'),
    ('DT008', '2026-09-11', NULL, 'CD0009', 'NV009'),
    ('DT009', '2026-10-12', N'Uống sau ăn', 'CD0010', 'NV010'),
    ('DT010', '2026-11-13', NULL, 'CD0011', 'NV011'),
    ('DT011', '2026-12-14', N'Uống sau ăn', 'CD0012', 'NV012'),
    ('DT012', '2026-01-15', NULL, 'CD0013', 'NV013'),
    ('DT013', '2026-02-16', N'Uống sau ăn', 'CD0014', 'NV014'),
    ('DT014', '2026-03-17', NULL, 'CD0015', 'NV015'),
    ('DT015', '2026-04-18', N'Uống sau ăn', 'CD0016', 'NV001')
GO

-- ================================================================
-- 19. CHI_TIET_DON_THUOC
-- ================================================================
INSERT INTO CHI_TIET_DON_THUOC (CT_MaChiTiet, CT_SoLuong, CT_LieuDung, CT_ThoiGianSuDung, DT_MaDonThuoc, TH_MaThuoc) VALUES
    ('CT0001', 2, N'1 viên/lần x 3 lần/ngày', N'4 ngày', 'DT002', 'TH002'),
    ('CT0002', 3, N'2 viên/lần x 2 lần/ngày', N'5 ngày', 'DT003', 'TH003'),
    ('CT0003', 1, N'1 viên/lần x 1 lần/ngày', N'6 ngày', 'DT004', 'TH004'),
    ('CT0004', 2, N'1 viên/lần x 2 lần/ngày', N'7 ngày', 'DT005', 'TH005'),
    ('CT0005', 3, N'1 viên/lần x 3 lần/ngày', N'8 ngày', 'DT006', 'TH006'),
    ('CT0006', 1, N'2 viên/lần x 2 lần/ngày', N'9 ngày', 'DT007', 'TH007'),
    ('CT0007', 2, N'1 viên/lần x 1 lần/ngày', N'3 ngày', 'DT008', 'TH008'),
    ('CT0008', 3, N'1 viên/lần x 2 lần/ngày', N'4 ngày', 'DT009', 'TH009'),
    ('CT0009', 1, N'1 viên/lần x 3 lần/ngày', N'5 ngày', 'DT010', 'TH010'),
    ('CT0010', 2, N'2 viên/lần x 2 lần/ngày', N'6 ngày', 'DT011', 'TH011'),
    ('CT0011', 3, N'1 viên/lần x 1 lần/ngày', N'7 ngày', 'DT012', 'TH012'),
    ('CT0012', 1, N'1 viên/lần x 2 lần/ngày', N'8 ngày', 'DT013', 'TH013'),
    ('CT0013', 2, N'1 viên/lần x 3 lần/ngày', N'9 ngày', 'DT014', 'TH014'),
    ('CT0014', 3, N'2 viên/lần x 2 lần/ngày', N'3 ngày', 'DT015', 'TH015'),
    ('CT0015', 1, N'1 viên/lần x 1 lần/ngày', N'4 ngày', 'DT001', 'TH016'),
    ('CT0016', 2, N'1 viên/lần x 2 lần/ngày', N'5 ngày', 'DT002', 'TH017'),
    ('CT0017', 3, N'1 viên/lần x 3 lần/ngày', N'6 ngày', 'DT003', 'TH018'),
    ('CT0018', 1, N'2 viên/lần x 2 lần/ngày', N'7 ngày', 'DT004', 'TH019'),
    ('CT0019', 2, N'1 viên/lần x 1 lần/ngày', N'8 ngày', 'DT005', 'TH020'),
    ('CT0020', 3, N'1 viên/lần x 2 lần/ngày', N'9 ngày', 'DT006', 'TH001'),
    ('CT0021', 1, N'1 viên/lần x 3 lần/ngày', N'3 ngày', 'DT007', 'TH002'),
    ('CT0022', 2, N'2 viên/lần x 2 lần/ngày', N'4 ngày', 'DT008', 'TH003'),
    ('CT0023', 3, N'1 viên/lần x 1 lần/ngày', N'5 ngày', 'DT009', 'TH004'),
    ('CT0024', 1, N'1 viên/lần x 2 lần/ngày', N'6 ngày', 'DT010', 'TH005'),
    ('CT0025', 2, N'1 viên/lần x 3 lần/ngày', N'7 ngày', 'DT011', 'TH006')
GO

-- ================================================================
-- 20. DICH_VU_YTE
-- ================================================================
INSERT INTO DICH_VU_YTE (DV_MaDichVu, DV_TenDichVu, DV_GiaDichVu, DV_MoTa, DV_LoaiDichVu) VALUES
    ('DV001', N'Khám nội tổng quát', 150000, N'Dịch vụ khám nội tổng quát', N'Khám bệnh'),
    ('DV002', N'Khám ngoại tổng quát', 150000, N'Dịch vụ khám ngoại tổng quát', N'Khám bệnh'),
    ('DV003', N'Siêu âm ổ bụng', 250000, N'Dịch vụ siêu âm ổ bụng', N'Chẩn đoán hình ảnh'),
    ('DV004', N'Chụp X-quang ngực', 200000, N'Dịch vụ chụp x-quang ngực', N'Chẩn đoán hình ảnh'),
    ('DV005', N'Chụp CT-Scanner sọ não', 1500000, N'Dịch vụ chụp ct-scanner sọ não', N'Chẩn đoán hình ảnh'),
    ('DV006', N'Chụp MRI cột sống', 2500000, N'Dịch vụ chụp mri cột sống', N'Chẩn đoán hình ảnh'),
    ('DV007', N'Xét nghiệm công thức máu', 100000, N'Dịch vụ xét nghiệm công thức máu', N'Xét nghiệm'),
    ('DV008', N'Xét nghiệm sinh hóa máu', 180000, N'Dịch vụ xét nghiệm sinh hóa máu', N'Xét nghiệm'),
    ('DV009', N'Xét nghiệm nước tiểu', 80000, N'Dịch vụ xét nghiệm nước tiểu', N'Xét nghiệm'),
    ('DV010', N'Đo điện tim ECG', 120000, N'Dịch vụ đo điện tim ecg', N'Thăm dò chức năng'),
    ('DV011', N'Nội soi dạ dày', 800000, N'Dịch vụ nội soi dạ dày', N'Thủ thuật'),
    ('DV012', N'Phẫu thuật ruột thừa', 8000000, N'Dịch vụ phẫu thuật ruột thừa', N'Phẫu thuật'),
    ('DV013', N'Bó bột gãy xương', 500000, N'Dịch vụ bó bột gãy xương', N'Thủ thuật'),
    ('DV014', N'Truyền dịch', 150000, N'Dịch vụ truyền dịch', N'Điều trị'),
    ('DV015', N'Vật lý trị liệu', 200000, N'Dịch vụ vật lý trị liệu', N'Phục hồi chức năng'),
    ('DV016', N'Tiêm chủng vắc-xin', 300000, N'Dịch vụ tiêm chủng vắc-xin', N'Dự phòng'),
    ('DV017', N'Khám thai định kỳ', 200000, N'Dịch vụ khám thai định kỳ', N'Sản khoa'),
    ('DV018', N'Đỡ đẻ thường', 5000000, N'Dịch vụ đỡ đẻ thường', N'Sản khoa'),
    ('DV019', N'Hồi sức cấp cứu', 1000000, N'Dịch vụ hồi sức cấp cứu', N'Cấp cứu'),
    ('DV020', N'Tư vấn dinh dưỡng', 100000, N'Dịch vụ tư vấn dinh dưỡng', N'Tư vấn')
GO

-- ================================================================
-- 21. PHAC_DO_DIEU_TRI
-- ================================================================
INSERT INTO PHAC_DO_DIEU_TRI (PD_MaPhacDo, PD_TenPhacDo, PD_MoTa, PD_ThoiGianDieuTri, CD_MaChanDoan) VALUES
    ('PD001', N'Phác đồ điều trị Tăng huyết áp', N'Kết hợp thuốc và theo dõi cho phác đồ #1', N'8 ngày', 'CD0002'),
    ('PD002', N'Phác đồ điều trị Đái tháo đường type 2', N'Kết hợp thuốc và theo dõi cho phác đồ #2', N'9 ngày', 'CD0003'),
    ('PD003', N'Phác đồ điều trị Viêm dạ dày', N'Kết hợp thuốc và theo dõi cho phác đồ #3', N'10 ngày', 'CD0004'),
    ('PD004', N'Phác đồ điều trị Gãy xương cẳng tay', N'Kết hợp thuốc và theo dõi cho phác đồ #4', N'11 ngày', 'CD0005'),
    ('PD005', N'Phác đồ điều trị Sốt xuất huyết', N'Kết hợp thuốc và theo dõi cho phác đồ #5', N'12 ngày', 'CD0006'),
    ('PD006', N'Phác đồ điều trị Viêm ruột thừa', N'Kết hợp thuốc và theo dõi cho phác đồ #6', N'13 ngày', 'CD0007'),
    ('PD007', N'Phác đồ điều trị Hen phế quản', N'Kết hợp thuốc và theo dõi cho phác đồ #7', N'14 ngày', 'CD0008'),
    ('PD008', N'Phác đồ điều trị Rối loạn tiền đình', N'Kết hợp thuốc và theo dõi cho phác đồ #8', N'15 ngày', 'CD0009'),
    ('PD009', N'Phác đồ điều trị Thoái hóa cột sống', N'Kết hợp thuốc và theo dõi cho phác đồ #9', N'16 ngày', 'CD0010'),
    ('PD010', N'Phác đồ điều trị Viêm phổi', N'Kết hợp thuốc và theo dõi cho phác đồ #10', N'17 ngày', 'CD0011'),
    ('PD011', N'Phác đồ điều trị Tăng huyết áp', N'Kết hợp thuốc và theo dõi cho phác đồ #11', N'18 ngày', 'CD0012'),
    ('PD012', N'Phác đồ điều trị Đái tháo đường type 2', N'Kết hợp thuốc và theo dõi cho phác đồ #12', N'19 ngày', 'CD0013'),
    ('PD013', N'Phác đồ điều trị Viêm dạ dày', N'Kết hợp thuốc và theo dõi cho phác đồ #13', N'20 ngày', 'CD0014'),
    ('PD014', N'Phác đồ điều trị Gãy xương cẳng tay', N'Kết hợp thuốc và theo dõi cho phác đồ #14', N'7 ngày', 'CD0015'),
    ('PD015', N'Phác đồ điều trị Sốt xuất huyết', N'Kết hợp thuốc và theo dõi cho phác đồ #15', N'8 ngày', 'CD0016')
GO

-- ================================================================
-- 22. PHACDO_SUDUNG_DICHVU
-- ================================================================
INSERT INTO PHACDO_SUDUNG_DICHVU (PD_MaPhacDo, DV_MaDichVu) VALUES
    ('PD002', 'DV005'),
    ('PD003', 'DV008'),
    ('PD004', 'DV011'),
    ('PD005', 'DV014'),
    ('PD006', 'DV017'),
    ('PD007', 'DV020'),
    ('PD008', 'DV003'),
    ('PD009', 'DV006'),
    ('PD010', 'DV009'),
    ('PD011', 'DV012'),
    ('PD012', 'DV015'),
    ('PD013', 'DV018'),
    ('PD014', 'DV001'),
    ('PD015', 'DV004'),
    ('PD001', 'DV007'),
    ('PD002', 'DV010'),
    ('PD003', 'DV013'),
    ('PD004', 'DV016'),
    ('PD005', 'DV019'),
    ('PD006', 'DV002')
GO

-- ================================================================
-- 23. THIET_BI_YTE
-- ================================================================
INSERT INTO THIET_BI_YTE (TB_MaThietBi, TB_TenThietBi, TB_LoaiThietBi, TB_HangSanXuat, TB_NgayBaoTri, TB_TrangThai) VALUES
    ('TB001', N'Máy X-quang kỹ thuật số', N'Chẩn đoán hình ảnh', N'Siemens', '2026-02-02', N'Hoạt động tốt'),
    ('TB002', N'Máy CT-Scanner 64 lát cắt', N'Chẩn đoán hình ảnh', N'GE Healthcare', '2026-03-03', N'Hoạt động tốt'),
    ('TB003', N'Máy MRI 1.5 Tesla', N'Chẩn đoán hình ảnh', N'Philips', '2026-04-04', N'Hoạt động tốt'),
    ('TB004', N'Máy siêu âm 4D', N'Chẩn đoán hình ảnh', N'Samsung Medison', '2026-05-05', N'Đang bảo trì'),
    ('TB005', N'Máy nội soi tiêu hóa', N'Nội soi', N'Olympus', '2026-06-06', N'Hoạt động tốt'),
    ('TB006', N'Máy xét nghiệm sinh hóa tự động', N'Xét nghiệm', N'Roche', '2026-07-07', N'Hoạt động tốt'),
    ('TB007', N'Máy xét nghiệm huyết học', N'Xét nghiệm', N'Sysmex', '2026-08-08', N'Hoạt động tốt'),
    ('TB008', N'Máy thở', N'Hồi sức cấp cứu', N'Drager', '2026-09-09', N'Đang bảo trì'),
    ('TB009', N'Máy theo dõi bệnh nhân (Monitor)', N'Hồi sức cấp cứu', N'Mindray', '2026-10-10', N'Hoạt động tốt'),
    ('TB010', N'Máy điện tim ECG', N'Thăm dò chức năng', N'Nihon Kohden', '2026-11-11', N'Hoạt động tốt'),
    ('TB011', N'Máy đo mật độ xương', N'Chẩn đoán hình ảnh', N'Hologic', '2026-12-12', N'Hoạt động tốt'),
    ('TB012', N'Máy chụp nhũ ảnh (Mammography)', N'Chẩn đoán hình ảnh', N'Hologic', '2026-01-13', N'Đang bảo trì')
GO

-- ================================================================
-- 24. DANH_MUC_XET_NGHIEM
-- ================================================================
INSERT INTO DANH_MUC_XET_NGHIEM (DM_MaXetNghiem, DM_TenXetNghiem, DM_LoaiXetNghiem, DM_MoTa, DM_DonViTinh, DM_GiaTien) VALUES
    ('DM001', N'Công thức máu toàn phần', N'Huyết học', N'Xét nghiệm công thức máu toàn phần', N'mẫu', 60000),
    ('DM002', N'Đường huyết lúc đói', N'Sinh hóa', N'Xét nghiệm đường huyết lúc đói', N'mg/dL', 70000),
    ('DM003', N'Chức năng gan (AST/ALT)', N'Sinh hóa', N'Xét nghiệm chức năng gan (ast/alt)', N'U/L', 80000),
    ('DM004', N'Chức năng thận (Ure/Creatinin)', N'Sinh hóa', N'Xét nghiệm chức năng thận (ure/creatinin)', N'mg/dL', 90000),
    ('DM005', N'Mỡ máu (Lipid profile)', N'Sinh hóa', N'Xét nghiệm mỡ máu (lipid profile)', N'mg/dL', 100000),
    ('DM006', N'Tổng phân tích nước tiểu', N'Nước tiểu', N'Xét nghiệm tổng phân tích nước tiểu', N'mẫu', 110000),
    ('DM007', N'HbA1c', N'Sinh hóa', N'Xét nghiệm hba1c', N'%', 120000),
    ('DM008', N'Điện giải đồ', N'Sinh hóa', N'Xét nghiệm điện giải đồ', N'mmol/L', 130000),
    ('DM009', N'Đông máu toàn bộ', N'Huyết học', N'Xét nghiệm đông máu toàn bộ', N'giây', 140000),
    ('DM010', N'Test nhanh Dengue (Sốt xuất huyết)', N'Miễn dịch', N'Xét nghiệm test nhanh dengue (sốt xuất huyết)', N'mẫu', 150000),
    ('DM011', N'Kháng nguyên viêm gan B (HBsAg)', N'Miễn dịch', N'Xét nghiệm kháng nguyên viêm gan b (hbsag)', N'mẫu', 160000),
    ('DM012', N'HIV Combo test', N'Miễn dịch', N'Xét nghiệm hiv combo test', N'mẫu', 170000),
    ('DM013', N'Nhóm máu ABO/Rh', N'Huyết học', N'Xét nghiệm nhóm máu abo/rh', N'mẫu', 180000),
    ('DM014', N'CRP (Protein phản ứng C)', N'Sinh hóa', N'Xét nghiệm crp (protein phản ứng c)', N'mg/L', 190000),
    ('DM015', N'Troponin T', N'Sinh hóa', N'Xét nghiệm troponin t', N'ng/L', 200000),
    ('DM016', N'Beta-hCG (thử thai)', N'Miễn dịch', N'Xét nghiệm beta-hcg (thử thai)', N'mẫu', 210000),
    ('DM017', N'Cấy máu tìm vi khuẩn', N'Vi sinh', N'Xét nghiệm cấy máu tìm vi khuẩn', N'mẫu', 220000),
    ('DM018', N'Soi tươi dịch âm đạo', N'Vi sinh', N'Xét nghiệm soi tươi dịch âm đạo', N'mẫu', 230000)
GO

-- ================================================================
-- 25. MAU_BENH_PHAM
-- ================================================================
INSERT INTO MAU_BENH_PHAM (BP_MaMauBenhPham, BP_LoaiMau, BP_NgayLayMau, BP_GioLayMau, BP_TinhTrangMau, BN_MaBN) VALUES
    ('BP001', N'Nước tiểu', '2026-02-05', '7:00:00', N'Đạt yêu cầu', 'BN0002'),
    ('BP002', N'Máu mao mạch', '2026-03-06', '8:30:00', N'Đạt yêu cầu', 'BN0003'),
    ('BP003', N'Dịch não tủy', '2026-04-07', '9:00:00', N'Đạt yêu cầu', 'BN0004'),
    ('BP004', N'Đàm', '2026-05-08', '10:30:00', N'Đạt yêu cầu', 'BN0005'),
    ('BP005', N'Máu tĩnh mạch', '2026-06-09', '11:00:00', N'Cần lấy lại', 'BN0006'),
    ('BP006', N'Nước tiểu', '2026-07-10', '12:30:00', N'Đạt yêu cầu', 'BN0007'),
    ('BP007', N'Máu mao mạch', '2026-08-11', '13:00:00', N'Đạt yêu cầu', 'BN0008'),
    ('BP008', N'Dịch não tủy', '2026-09-12', '14:30:00', N'Đạt yêu cầu', 'BN0009'),
    ('BP009', N'Đàm', '2026-10-13', '15:00:00', N'Đạt yêu cầu', 'BN0010'),
    ('BP010', N'Máu tĩnh mạch', '2026-11-14', '16:30:00', N'Cần lấy lại', 'BN0011'),
    ('BP011', N'Nước tiểu', '2026-12-15', '17:00:00', N'Đạt yêu cầu', 'BN0012'),
    ('BP012', N'Máu mao mạch', '2026-01-16', '6:30:00', N'Đạt yêu cầu', 'BN0013'),
    ('BP013', N'Dịch não tủy', '2026-02-17', '7:00:00', N'Đạt yêu cầu', 'BN0014'),
    ('BP014', N'Đàm', '2026-03-18', '8:30:00', N'Đạt yêu cầu', 'BN0015'),
    ('BP015', N'Máu tĩnh mạch', '2026-04-19', '9:00:00', N'Cần lấy lại', 'BN0016'),
    ('BP016', N'Nước tiểu', '2026-05-20', '10:30:00', N'Đạt yêu cầu', 'BN0017'),
    ('BP017', N'Máu mao mạch', '2026-06-21', '11:00:00', N'Đạt yêu cầu', 'BN0018'),
    ('BP018', N'Dịch não tủy', '2026-07-22', '12:30:00', N'Đạt yêu cầu', 'BN0019')
GO

-- ================================================================
-- 26. KET_QUA_XET_NGHIEM
-- ================================================================
INSERT INTO KET_QUA_XET_NGHIEM (KQ_MaKetQua, KQ_NgayThucHien, KQ_KetQua, KQ_ChiSoDo, KQ_GiaTriThamChieu, KQ_KetLuan, BA_MaBenhAn, DM_MaXetNghiem, BP_MaMauBenhPham) VALUES
    ('KQ001', '2026-02-06', N'Kết quả đo lần 1', N'6.1', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0002', 'DM002', 'BP002'),
    ('KQ002', '2026-03-07', N'Kết quả đo lần 2', N'7.2', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0003', 'DM003', 'BP003'),
    ('KQ003', '2026-04-08', N'Kết quả đo lần 3', N'8.3', N'Bình thường: 4.0 - 10.0', N'Cần theo dõi thêm', 'BA0004', 'DM004', 'BP004'),
    ('KQ004', '2026-05-09', N'Kết quả đo lần 4', N'9.4', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0005', 'DM005', 'BP005'),
    ('KQ005', '2026-06-10', N'Kết quả đo lần 5', N'10.5', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0006', 'DM006', 'BP006'),
    ('KQ006', '2026-07-11', N'Kết quả đo lần 6', N'11.6', N'Bình thường: 4.0 - 10.0', N'Cần theo dõi thêm', 'BA0007', 'DM007', 'BP007'),
    ('KQ007', '2026-08-12', N'Kết quả đo lần 7', N'12.7', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0008', 'DM008', 'BP008'),
    ('KQ008', '2026-09-13', N'Kết quả đo lần 8', N'13.8', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0009', 'DM009', 'BP009'),
    ('KQ009', '2026-10-14', N'Kết quả đo lần 9', N'14.9', N'Bình thường: 4.0 - 10.0', N'Cần theo dõi thêm', 'BA0010', 'DM010', 'BP010'),
    ('KQ010', '2026-11-15', N'Kết quả đo lần 10', N'5.0', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0011', 'DM011', 'BP011'),
    ('KQ011', '2026-12-16', N'Kết quả đo lần 11', N'6.1', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0012', 'DM012', 'BP012'),
    ('KQ012', '2026-01-17', N'Kết quả đo lần 12', N'7.2', N'Bình thường: 4.0 - 10.0', N'Cần theo dõi thêm', 'BA0013', 'DM013', 'BP013'),
    ('KQ013', '2026-02-18', N'Kết quả đo lần 13', N'8.3', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0014', 'DM014', 'BP014'),
    ('KQ014', '2026-03-19', N'Kết quả đo lần 14', N'9.4', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0015', 'DM015', 'BP015'),
    ('KQ015', '2026-04-20', N'Kết quả đo lần 15', N'10.5', N'Bình thường: 4.0 - 10.0', N'Cần theo dõi thêm', 'BA0016', 'DM016', 'BP016'),
    ('KQ016', '2026-05-21', N'Kết quả đo lần 16', N'11.6', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0017', 'DM017', 'BP017'),
    ('KQ017', '2026-06-22', N'Kết quả đo lần 17', N'12.7', N'Bình thường: 4.0 - 10.0', N'Trong giới hạn bình thường', 'BA0018', 'DM018', 'BP018'),
    ('KQ018', '2026-07-23', N'Kết quả đo lần 18', N'13.8', N'Bình thường: 4.0 - 10.0', N'Cần theo dõi thêm', 'BA0019', 'DM001', 'BP001')
GO

-- ================================================================
-- 27. CHAN_DOAN_HINH_ANH
-- ================================================================
INSERT INTO CHAN_DOAN_HINH_ANH (HA_MaHinhAnh, HA_LoaiChanDoan, HA_NgayThucHien, HA_KetQua, HA_HinhAnh, HA_KetLuan, BA_MaBenhAn, TB_MaThietBi) VALUES
    ('HA001', N'Siêu âm ổ bụng', '2026-02-07', N'Hình ảnh ghi nhận lần 1', N'/images/cdha_001.dcm', N'Không phát hiện bất thường', 'BA0002', 'TB002'),
    ('HA002', N'CT-Scanner sọ não', '2026-03-08', N'Hình ảnh ghi nhận lần 2', N'/images/cdha_002.dcm', N'Không phát hiện bất thường', 'BA0003', 'TB003'),
    ('HA003', N'MRI cột sống', '2026-04-09', N'Hình ảnh ghi nhận lần 3', N'/images/cdha_003.dcm', N'Cần hội chẩn thêm', 'BA0004', 'TB004'),
    ('HA004', N'Siêu âm tim', '2026-05-10', N'Hình ảnh ghi nhận lần 4', N'/images/cdha_004.dcm', N'Không phát hiện bất thường', 'BA0005', 'TB005'),
    ('HA005', N'X-quang ngực', '2026-06-11', N'Hình ảnh ghi nhận lần 5', N'/images/cdha_005.dcm', N'Không phát hiện bất thường', 'BA0006', 'TB006'),
    ('HA006', N'Siêu âm ổ bụng', '2026-07-12', N'Hình ảnh ghi nhận lần 6', N'/images/cdha_006.dcm', N'Cần hội chẩn thêm', 'BA0007', 'TB007'),
    ('HA007', N'CT-Scanner sọ não', '2026-08-13', N'Hình ảnh ghi nhận lần 7', N'/images/cdha_007.dcm', N'Không phát hiện bất thường', 'BA0008', 'TB008'),
    ('HA008', N'MRI cột sống', '2026-09-14', N'Hình ảnh ghi nhận lần 8', N'/images/cdha_008.dcm', N'Không phát hiện bất thường', 'BA0009', 'TB009'),
    ('HA009', N'Siêu âm tim', '2026-10-15', N'Hình ảnh ghi nhận lần 9', N'/images/cdha_009.dcm', N'Cần hội chẩn thêm', 'BA0010', 'TB010'),
    ('HA010', N'X-quang ngực', '2026-11-16', N'Hình ảnh ghi nhận lần 10', N'/images/cdha_010.dcm', N'Không phát hiện bất thường', 'BA0011', 'TB011'),
    ('HA011', N'Siêu âm ổ bụng', '2026-12-17', N'Hình ảnh ghi nhận lần 11', N'/images/cdha_011.dcm', N'Không phát hiện bất thường', 'BA0012', 'TB012'),
    ('HA012', N'CT-Scanner sọ não', '2026-01-18', N'Hình ảnh ghi nhận lần 12', N'/images/cdha_012.dcm', N'Cần hội chẩn thêm', 'BA0013', 'TB001')
GO

-- ================================================================
-- 28. HOA_DON
-- ================================================================
INSERT INTO HOA_DON (HD_MaHD, HD_TongChiPhi, HD_TienBHYT, HD_TienBN, BN_MaBN, HS_MaHoSo) VALUES
    ('HD001', 637000, 509600.0, 127400.0, 'BN0002', NULL),
    ('HD002', 774000, 619200.0, 154800.0, 'BN0003', 'HS003'),
    ('HD003', 911000, 0, 911000, 'BN0004', NULL),
    ('HD004', 1048000, 838400.0, 209600.0, 'BN0005', 'HS005'),
    ('HD005', 1185000, 948000.0, 237000.0, 'BN0006', NULL),
    ('HD006', 1322000, 0, 1322000, 'BN0007', 'HS007'),
    ('HD007', 1459000, 1167200.0, 291800.0, 'BN0008', NULL),
    ('HD008', 1596000, 1276800.0, 319200.0, 'BN0009', 'HS009'),
    ('HD009', 1733000, 0, 1733000, 'BN0010', NULL),
    ('HD010', 1870000, 1496000.0, 374000.0, 'BN0011', 'HS011'),
    ('HD011', 2007000, 1605600.0, 401400.0, 'BN0012', NULL),
    ('HD012', 2144000, 0, 2144000, 'BN0013', 'HS013'),
    ('HD013', 2281000, 1824800.0, 456200.0, 'BN0014', NULL),
    ('HD014', 2418000, 1934400.0, 483600.0, 'BN0015', 'HS015'),
    ('HD015', 2555000, 0, 2555000, 'BN0016', NULL),
    ('HD016', 2692000, 2153600.0, 538400.0, 'BN0017', 'HS002'),
    ('HD017', 2829000, 2263200.0, 565800.0, 'BN0018', NULL),
    ('HD018', 2966000, 0, 2966000, 'BN0019', 'HS004')
GO

-- ================================================================
-- 29. THANH_TOAN
-- ================================================================
INSERT INTO THANH_TOAN (TT_MaTT, TT_Loai, TT_SoTien, TT_PhuongThuc, HD_MaHD, NV_MaNV) VALUES
    ('TT001', N'Thanh toán viện phí', 250000, N'Chuyển khoản', 'HD002', 'NV002'),
    ('TT002', N'Thanh toán viện phí', 300000, N'Thẻ ngân hàng', 'HD003', 'NV003'),
    ('TT003', N'Thanh toán viện phí', 350000, N'Ví điện tử', 'HD004', 'NV004'),
    ('TT004', N'Tạm ứng', 400000, N'Tiền mặt', 'HD005', 'NV005'),
    ('TT005', N'Thanh toán viện phí', 450000, N'Chuyển khoản', 'HD006', 'NV006'),
    ('TT006', N'Thanh toán viện phí', 500000, N'Thẻ ngân hàng', 'HD007', 'NV007'),
    ('TT007', N'Thanh toán viện phí', 550000, N'Ví điện tử', 'HD008', 'NV008'),
    ('TT008', N'Tạm ứng', 600000, N'Tiền mặt', 'HD009', 'NV009'),
    ('TT009', N'Thanh toán viện phí', 650000, N'Chuyển khoản', 'HD010', 'NV010'),
    ('TT010', N'Thanh toán viện phí', 700000, N'Thẻ ngân hàng', 'HD011', 'NV011'),
    ('TT011', N'Thanh toán viện phí', 750000, N'Ví điện tử', 'HD012', 'NV012'),
    ('TT012', N'Tạm ứng', 800000, N'Tiền mặt', 'HD013', 'NV013'),
    ('TT013', N'Thanh toán viện phí', 850000, N'Chuyển khoản', 'HD014', 'NV014'),
    ('TT014', N'Thanh toán viện phí', 900000, N'Thẻ ngân hàng', 'HD015', 'NV015'),
    ('TT015', N'Thanh toán viện phí', 950000, N'Ví điện tử', 'HD016', 'NV016'),
    ('TT016', N'Tạm ứng', 1000000, N'Tiền mặt', 'HD017', 'NV017'),
    ('TT017', N'Thanh toán viện phí', 1050000, N'Chuyển khoản', 'HD018', 'NV018'),
    ('TT018', N'Thanh toán viện phí', 1100000, N'Thẻ ngân hàng', 'HD001', 'NV019')
GO

-- ================================================================
-- 30. BOI_THUONG_BHYT
-- ================================================================
INSERT INTO BOI_THUONG_BHYT (BT_MaQuyetToan, BT_SoTheBHYT, BT_MaBenh, BT_TiLe, BT_TrangThai, HD_MaHD) VALUES
    ('BT001', 'DN4000000001', 'ICD0001', 80.0, N'Đã quyết toán', 'HD002'),
    ('BT002', 'DN4000000002', 'ICD0002', 80.0, N'Đang xử lý', 'HD003'),
    ('BT003', 'DN4000000003', 'ICD0003', 80.0, N'Đã quyết toán', 'HD004'),
    ('BT004', 'DN4000000004', 'ICD0004', 80.0, N'Đang xử lý', 'HD005'),
    ('BT005', 'DN4000000005', 'ICD0005', 80.0, N'Đã quyết toán', 'HD006'),
    ('BT006', 'DN4000000006', 'ICD0006', 80.0, N'Đang xử lý', 'HD007'),
    ('BT007', 'DN4000000007', 'ICD0007', 80.0, N'Đã quyết toán', 'HD008'),
    ('BT008', 'DN4000000008', 'ICD0008', 80.0, N'Đang xử lý', 'HD009'),
    ('BT009', 'DN4000000009', 'ICD0009', 80.0, N'Đã quyết toán', 'HD010'),
    ('BT010', 'DN4000000010', 'ICD0010', 80.0, N'Đang xử lý', 'HD011')
GO

-- ================================================================
-- 31. GIAO_DICH
-- ================================================================
INSERT INTO GIAO_DICH (GD_MaGD, GD_MaThamChieu, GD_NguonTien, GD_SoTienGD, GD_ThoiGian, TT_MaTT, BT_MaQuyetToan) VALUES
    ('GD001', 'REF100001', N'Cổng BHXH', 130000, '2026-02-08 9:00:00', NULL, 'BT002'),
    ('GD002', 'REF100002', N'Ngân hàng BIDV', 160000, '2026-03-09 10:00:00', 'TT003', NULL),
    ('GD003', 'REF100003', N'Cổng BHXH', 190000, '2026-04-10 11:00:00', NULL, 'BT004'),
    ('GD004', 'REF100004', N'Cổng BHXH', 220000, '2026-05-11 12:00:00', 'TT005', NULL),
    ('GD005', 'REF100005', N'Cổng BHXH', 250000, '2026-06-12 13:00:00', NULL, 'BT006'),
    ('GD006', 'REF100006', N'Ngân hàng Vietcombank', 280000, '2026-07-13 14:00:00', 'TT007', NULL),
    ('GD007', 'REF100007', N'Cổng BHXH', 310000, '2026-08-14 15:00:00', NULL, 'BT008'),
    ('GD008', 'REF100008', N'Ví MoMo', 340000, '2026-09-15 16:00:00', 'TT009', NULL),
    ('GD009', 'REF100009', N'Cổng BHXH', 370000, '2026-10-16 17:00:00', NULL, 'BT010'),
    ('GD010', 'REF100010', N'Tiền mặt tại quầy', 400000, '2026-11-17 8:00:00', 'TT011', NULL),
    ('GD011', 'REF100011', N'Cổng BHXH', 430000, '2026-12-18 9:00:00', NULL, 'BT002'),
    ('GD012', 'REF100012', N'Ngân hàng BIDV', 460000, '2026-01-19 10:00:00', 'TT013', NULL),
    ('GD013', 'REF100013', N'Cổng BHXH', 490000, '2026-02-20 11:00:00', NULL, 'BT004'),
    ('GD014', 'REF100014', N'Cổng BHXH', 520000, '2026-03-21 12:00:00', 'TT015', NULL),
    ('GD015', 'REF100015', N'Cổng BHXH', 550000, '2026-04-22 13:00:00', NULL, 'BT006'),
    ('GD016', 'REF100016', N'Ngân hàng Vietcombank', 580000, '2026-05-23 14:00:00', 'TT017', NULL),
    ('GD017', 'REF100017', N'Cổng BHXH', 610000, '2026-06-24 15:00:00', NULL, 'BT008'),
    ('GD018', 'REF100018', N'Ví MoMo', 640000, '2026-07-25 16:00:00', 'TT001', NULL),
    ('GD019', 'REF100019', N'Cổng BHXH', 670000, '2026-08-26 17:00:00', NULL, 'BT010'),
    ('GD020', 'REF100020', N'Tiền mặt tại quầy', 700000, '2026-09-27 8:00:00', 'TT003', NULL)
GO

-- ================================================================
-- 32. HOADON_CHITIET_DICHVU
-- ================================================================
INSERT INTO HOADON_CHITIET_DICHVU (HD_MaHD, DV_MaDichVu, SoLuong, ThanhTien) VALUES
    ('HD002', 'DV008', 2, 360000),
    ('HD003', 'DV013', 3, 1500000),
    ('HD004', 'DV018', 1, 5000000),
    ('HD005', 'DV003', 2, 500000),
    ('HD006', 'DV008', 3, 540000),
    ('HD007', 'DV013', 1, 500000),
    ('HD008', 'DV018', 2, 10000000),
    ('HD009', 'DV003', 3, 750000),
    ('HD010', 'DV008', 1, 180000),
    ('HD011', 'DV013', 2, 1000000),
    ('HD012', 'DV018', 3, 15000000),
    ('HD013', 'DV003', 1, 250000),
    ('HD014', 'DV008', 2, 360000),
    ('HD015', 'DV013', 3, 1500000),
    ('HD016', 'DV018', 1, 5000000),
    ('HD017', 'DV003', 2, 500000),
    ('HD018', 'DV008', 3, 540000),
    ('HD001', 'DV013', 1, 500000),
    ('HD002', 'DV018', 2, 10000000),
    ('HD003', 'DV003', 3, 750000),
    ('HD004', 'DV008', 1, 180000),
    ('HD005', 'DV013', 2, 1000000),
    ('HD006', 'DV018', 3, 15000000),
    ('HD007', 'DV003', 1, 250000),
    ('HD008', 'DV008', 2, 360000)
GO

-- ================================================================
-- 33. THUC_HIEN_DICH_VU (quan he TAM NGUYEN)
-- ================================================================
INSERT INTO THUC_HIEN_DICH_VU (THDV_MaThucHien, BS_MaBS, BN_MaBN, DV_MaDichVu, THDV_NgayThucHien, THDV_GhiChu) VALUES
    ('THDV001', 'NV002', 'BN0005', 'DV010', '2026-02-09', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV002', 'NV003', 'BN0008', 'DV017', '2026-03-10', NULL),
    ('THDV003', 'NV004', 'BN0011', 'DV004', '2026-04-11', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV004', 'NV005', 'BN0014', 'DV011', '2026-05-12', NULL),
    ('THDV005', 'NV006', 'BN0017', 'DV018', '2026-06-13', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV006', 'NV007', 'BN0020', 'DV005', '2026-07-14', NULL),
    ('THDV007', 'NV008', 'BN0003', 'DV012', '2026-08-15', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV008', 'NV009', 'BN0006', 'DV019', '2026-09-16', NULL),
    ('THDV009', 'NV010', 'BN0009', 'DV006', '2026-10-17', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV010', 'NV011', 'BN0012', 'DV013', '2026-11-18', NULL),
    ('THDV011', 'NV012', 'BN0015', 'DV020', '2026-12-19', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV012', 'NV013', 'BN0018', 'DV007', '2026-01-20', NULL),
    ('THDV013', 'NV014', 'BN0001', 'DV014', '2026-02-21', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV014', 'NV015', 'BN0004', 'DV001', '2026-03-22', NULL),
    ('THDV015', 'NV001', 'BN0007', 'DV008', '2026-04-23', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV016', 'NV002', 'BN0010', 'DV015', '2026-05-24', NULL),
    ('THDV017', 'NV003', 'BN0013', 'DV002', '2026-06-25', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV018', 'NV004', 'BN0016', 'DV009', '2026-07-26', NULL),
    ('THDV019', 'NV005', 'BN0019', 'DV016', '2026-08-27', N'Thực hiện theo chỉ định phác đồ'),
    ('THDV020', 'NV006', 'BN0002', 'DV003', '2026-09-08', NULL)
GO

-- ================================================================
-- 34. UPDATE KHOA - gan Truong khoa (pha vo chu trinh KHOA <-> BAC_SI)
-- ================================================================
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV001' WHERE K_MaKhoa = 'KH01'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV002' WHERE K_MaKhoa = 'KH02'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV003' WHERE K_MaKhoa = 'KH03'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV004' WHERE K_MaKhoa = 'KH04'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV005' WHERE K_MaKhoa = 'KH05'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV006' WHERE K_MaKhoa = 'KH06'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV007' WHERE K_MaKhoa = 'KH07'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV008' WHERE K_MaKhoa = 'KH08'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV009' WHERE K_MaKhoa = 'KH09'
UPDATE KHOA SET BS_MaBS_TruongKhoa = 'NV010' WHERE K_MaKhoa = 'KH10'
GO
