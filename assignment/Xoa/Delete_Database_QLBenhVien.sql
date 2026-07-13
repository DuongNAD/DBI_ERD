-- ================================================================
--  XOA TOAN BO DATABASE QLBenhVien (dung khi can lam lai tu dau)
-- ================================================================
IF DB_ID('QLBenhVien') IS NOT NULL
BEGIN
    ALTER DATABASE QLBenhVien SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE QLBenhVien
END
GO
