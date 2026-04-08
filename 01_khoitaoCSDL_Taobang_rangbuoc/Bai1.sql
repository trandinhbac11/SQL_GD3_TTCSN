CREATE FUNCTION fn_ThongKeSVTheoTenLop(@TenLop NVARCHAR(10))
RETURNS @KQ TABLE
(
    MaLop INT,
    TenLop NVARCHAR(10),
    SoLuongSV INT
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Lop WHERE TenLop = @TenLop)
    BEGIN
        INSERT INTO @KQ
        SELECT Lop.MaLop, Lop.TenLop, COUNT(SV.MaSV) AS SoLuongSV
        FROM Lop
        LEFT JOIN SV ON Lop.MaLop = SV.MaLop
        WHERE Lop.TenLop = @TenLop
        GROUP BY Lop.MaLop, Lop.TenLop
    END
    ELSE
    BEGIN
        INSERT INTO @KQ
        SELECT Lop.MaLop, Lop.TenLop, COUNT(SV.MaSV) AS SoLuongSV
        FROM Lop
        LEFT JOIN SV ON Lop.MaLop = SV.MaLop
        GROUP BY Lop.MaLop, Lop.TenLop
    END

    RETURN
END
GOv