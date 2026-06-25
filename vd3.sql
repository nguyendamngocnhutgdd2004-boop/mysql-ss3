-- Thêm lớp học
INSERT INTO Lop (MaLop, TenLop) VALUES ('LH01', 'Cong nghe thong tin K20');

-- Thêm sinh viên thuộc lớp LH01
INSERT INTO SinhVien (MaSV, TenSV, NgaySinh, MaLop) 
VALUES ('SV001', 'Nguyen Van A', '2005-02-20', 'LH01');

-- Xem danh sách kết hợp 2 bảng
SELECT SinhVien.MaSV, SinhVien.TenSV, Lop.TenLop 
FROM SinhVien 
JOIN Lop ON SinhVien.MaLop = Lop.MaLop;
