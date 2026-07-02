-- 1. Tạo và sử dụng cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS quan_ly_he_thong;
USE quan_ly_he_thong;

-- 2. Xóa bảng cũ nếu đã tồn tại trước đó để tránh lỗi
DROP TABLE IF EXISTS users;

-- 3. YÊU CẦU: Tạo bảng users với các ràng buộc cơ bản
CREATE TABLE users (
    ten_dang_nhap VARCHAR(50) PRIMARY KEY,       -- Khóa chính (Tự động NOT NULL và UNIQUE)
    mat_khau VARCHAR(255) NOT NULL,               -- Bắt buộc nhập mật khẩu
    email VARCHAR(100) UNIQUE NOT NULL,           -- Đảm bảo email duy nhất và không trống
    trang_thai VARCHAR(15) DEFAULT 'ACTIVE'       -- Giá trị mặc định là 'ACTIVE'
);

-- 4. YÊU CẦU: Dùng ALTER TABLE để thêm ràng buộc CHECK cho trạng thái
-- Chỉ cho phép cột trạng thái nhận 1 trong 2 giá trị: 'ACTIVE' hoặc 'INACTIVE'
ALTER TABLE users
ADD CONSTRAINT chk_trang_thai_users CHECK (trang_thai IN ('ACTIVE', 'INACTIVE'));

-- 5. Lệnh kiểm tra cấu trúc bảng vừa tạo
DESCRIBE users;
