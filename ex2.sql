-- 1. Tạo và sử dụng cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS quan_ly_thu_vien;
USE quan_ly_thu_vien;

-- Xóa các bảng cũ nếu đã tồn tại (Xóa bảng con/trung gian trước để tránh lỗi khóa ngoại)
DROP TABLE IF EXISTS borrowings;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS readers;


-- 2. Tạo bảng Sách (Bảng độc lập)
CREATE TABLE books (
    ma_sach VARCHAR(20) PRIMARY KEY,
    ten_sach VARCHAR(150) NOT NULL,
    tac_gia VARCHAR(100)
);


-- 3. Tạo bảng Độc giả (Bảng độc lập)
CREATE TABLE readers (
    ma_doc_gia VARCHAR(20) PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(15)
);


-- 4. Tạo bảng trung gian Mượn sách (Chưa thêm ràng buộc NOT NULL cho ngày mượn)
CREATE TABLE borrowings (
    ma_sach VARCHAR(20),
    ma_doc_gia VARCHAR(20),
    ngay_muon DATE, -- Tạm thời để trống để áp dụng lệnh ALTER ở bước sau
    ngay_tra DATE,
    
    -- Thiết lập khóa chính kép cho bảng trung gian
    PRIMARY KEY (ma_sach, ma_doc_gia, ngay_muon),
    
    -- Thiết lập các khóa ngoại liên kết tới 2 bảng gốc
    CONSTRAINT fk_borrow_book FOREIGN KEY (ma_sach) REFERENCES books(ma_sach),
    CONSTRAINT fk_borrow_reader FOREIGN KEY (ma_doc_gia) REFERENCES readers(ma_doc_gia)
);


-- 5. YÊU CẦU: Dùng lệnh ALTER TABLE để thêm ràng buộc NOT NULL cho cột ngay_muon
ALTER TABLE borrowings 
MODIFY COLUMN ngay_muon DATE NOT NULL;


-- 6. Kiểm tra lại cấu trúc bảng trung gian sau khi sửa đổi
DESCRIBE borrowings;
