-- 1. Tạo và sử dụng cơ sở dữ liệu mới
CREATE DATABASE IF NOT EXISTS quan_ly_ban_hang_nang_cao;
USE quan_ly_ban_hang_nang_cao;

-- Xóa các bảng cũ nếu đã tồn tại (Xóa bảng con/trung gian trước để tránh lỗi ràng buộc khóa ngoại)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;


-- 2. Tạo bảng Sản phẩm (Bảng gốc độc lập)
CREATE TABLE products (
    ma_san_pham VARCHAR(20) PRIMARY KEY,
    ten_san_pham VARCHAR(150) NOT NULL,
    gia_ban DECIMAL(15, 2) NOT NULL
);


-- 3. Tạo bảng Đơn hàng (Bảng gốc độc lập)
CREATE TABLE orders (
    ma_don_hang VARCHAR(20) PRIMARY KEY,
    ngay_dat_hang DATETIME DEFAULT CURRENT_TIMESTAMP,
    tong_tien DECIMAL(15, 2) DEFAULT 0.00
);


-- 4. Tạo bảng trung gian Chi tiết đơn hàng (order_items)
CREATE TABLE order_items (
    ma_don_hang VARCHAR(20),
    ma_san_pham VARCHAR(20),
    so_luong_mua INT NOT NULL DEFAULT 1,
    
    -- YÊU CẦU: Thiết lập Khóa chính kép (Composite Primary Key)
    PRIMARY KEY (ma_don_hang, ma_san_pham),
    
    -- YÊU CẦU: Thiết lập các Khóa ngoại (Foreign Key) tham chiếu
    CONSTRAINT fk_items_order FOREIGN KEY (ma_don_hang) REFERENCES orders(ma_don_hang),
    CONSTRAINT fk_items_product FOREIGN KEY (ma_san_pham) REFERENCES products(ma_san_pham),
    
    -- Thêm ràng buộc kiểm tra số lượng phải lớn hơn 0
    CONSTRAINT chk_so_luong_mua CHECK (so_luong_mua > 0)
);


-- 5. Kiểm tra cấu trúc bảng trung gian sau khi tạo thành công
DESCRIBE order_items;
