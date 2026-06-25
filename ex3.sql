-- 1. Tạo database mới cho bài này và kích hoạt nó
CREATE DATABASE IF NOT EXISTS QuanLyTruongHocV2;
USE QuanLyTruongHocV2;

-- 2. Tạo bảng bên 1 trước (Bảng Lop)
CREATE TABLE Lop (
    MaLop VARCHAR(10) PRIMARY KEY,
    TenLop VARCHAR(50) NOT NULL
);

-- 3. Tạo bảng bên N sau (Bảng SinhVien có chứa khóa ngoại)
CREATE TABLE SinhVien (
    MaSV VARCHAR(10) PRIMARY KEY,
    TenSV VARCHAR(50) NOT NULL,
    NgaySinh DATE,
    MaLop VARCHAR(10), -- Cột này để chứa mã lớp
    
    -- Lệnh thiết lập mối quan hệ 1 - N (Khóa ngoại)
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
);
