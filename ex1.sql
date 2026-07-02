-- 1. Tạo và sử dụng Cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS quan_ly_truong_hoc;
USE quan_ly_truong_hoc;

-- 2. Xóa các bảng cũ nếu đã tồn tại để không bị lỗi trùng lặp
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS classes;

-- 3. Tạo bảng Lớp học (Bảng cha - Phải tạo trước)
CREATE TABLE classes (
    ma_lop VARCHAR(20) PRIMARY KEY,       -- Khóa chính định danh lớp
    ten_lop VARCHAR(100) NOT NULL         -- Tên lớp (Bắt buộc nhập)
);

-- 4. Tạo bảng Sinh viên (Bảng con - Chứa khóa ngoại trỏ về bảng cha)
CREATE TABLE students (
    ma_sinh_vien VARCHAR(20) PRIMARY KEY, -- Khóa chính định danh sinh viên
    ho_ten VARCHAR(100) NOT NULL,         -- Họ tên (Bắt buộc nhập)
    ngay_sinh DATE,                       -- Ngày sinh sinh viên
    ma_lop VARCHAR(20) NOT NULL,          -- Cột lưu thông tin lớp (Bắt buộc nhập)
    
    -- Khai báo Ràng buộc Khóa ngoại (FOREIGN KEY)
    CONSTRAINT fk_students_classes 
        FOREIGN KEY (ma_lop) REFERENCES classes(ma_lop)
);

-- 5. Lệnh kiểm tra cấu trúc 2 bảng sau khi tạo thành công
DESCRIBE classes;
DESCRIBE students;
