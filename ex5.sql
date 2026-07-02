-- 1. Tạo và sử dụng cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS quan_ly_hoc_truoc_tuyen;
USE quan_ly_hoc_truoc_tuyen;

-- Xóa các bảng cũ nếu đã tồn tại theo thứ tự để tránh lỗi ràng buộc khóa ngoại
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS students;


-- 2. Tạo bảng Học viên (Bảng độc lập)
CREATE TABLE students (
    ma_hoc_vien VARCHAR(20) PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


-- 3. Tạo bảng Giảng viên (Bảng độc lập)
CREATE TABLE instructors (
    ma_giang_vien VARCHAR(20) PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


-- 4. Tạo bảng Khóa học (Mối quan hệ 1-N với Giảng viên)
CREATE TABLE courses (
    ma_khoa_hoc VARCHAR(20) PRIMARY KEY,
    ten_khoa_hoc VARCHAR(150) NOT NULL,
    mo_ta TEXT,
    gia_khoa_hoc DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    ma_giang_vien VARCHAR(20) NOT NULL, -- Khóa ngoại lưu vết giảng viên dạy
    
    -- Ràng buộc kiểm tra giá khóa học không được âm
    CONSTRAINT chk_gia_khoa_hoc CHECK (gia_khoa_hoc >= 0),
    
    -- Khai báo Khóa ngoại tham chiếu sang bảng giảng viên
    CONSTRAINT fk_courses_instructors 
        FOREIGN KEY (ma_giang_vien) REFERENCES instructors(ma_giang_vien)
);


-- 5. Tạo bảng trung gian Đăng ký học (Mối quan hệ N-N giữa Học viên và Khóa học)
CREATE TABLE enrollments (
    ma_hoc_vien VARCHAR(20),
    ma_khoa_hoc VARCHAR(20),
    ngay_dang_ky DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    -- Thiết lập Khóa chính kép để học viên không bị đăng ký trùng 1 khóa nhiều lần
    PRIMARY KEY (ma_hoc_vien, ma_khoa_hoc),
    
    -- Thiết lập 2 Khóa ngoại trỏ về 2 bảng gốc tương ứng
    CONSTRAINT fk_enroll_student FOREIGN KEY (ma_hoc_vien) REFERENCES students(ma_hoc_vien),
    CONSTRAINT fk_enroll_course FOREIGN KEY (ma_khoa_hoc) REFERENCES courses(ma_khoa_hoc)
);


-- 6. Kiểm tra cấu trúc các bảng vừa tạo để đảm bảo thành công
DESCRIBE courses;
DESCRIBE enrollments;
