--Create Database
CREATE DATABASE libraryManagementSystemDb;
USE libraryManagementSystemDb;

--user table for handling users/students affair
CREATE TABLE users (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('SUPER_ADMIN', 'ADMIN', 'STUDENT') NOT NULL,
    fullName VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    profilePic VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
--book table
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(17) UNIQUE NOT NULL,
    genre ENUM('FICTION', 'NON_FICTION', 'SCIENCE', 'TECHNOLOGY') NOT NULL,
    publisher VARCHAR(255),
    edition VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('AVAILABLE', 'RESERVED', 'ISSUED', 'MAINTENANCE') DEFAULT 'AVAILABLE',
    cover_image VARCHAR(255),
    description TEXT,
    INDEX idx_genre (genre),
    INDEX idx_status (status)
);


CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    status ENUM('BORROWED', 'RETURNED') DEFAULT 'BORROWED',
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiry_date TIMESTAMP NULL DEFAULT NULL,
    status ENUM('PENDING', 'APPROVED', 'CANCELLED', 'FULFILLED', 'EXPIRED') DEFAULT 'PENDING',
    priority INT DEFAULT 0,
    notes TEXT,
    approved_by INT,
    approved_at TIMESTAMP NULL DEFAULT NULL,
    cancelled_at TIMESTAMP NULL DEFAULT NULL,
    cancelled_reason TEXT,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(userId) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_user (userId),
    INDEX idx_book (book_id),
    INDEX idx_reservation_date (reservation_date)
);

CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id INT NOT NULL,
    userId INT NOT NULL,
    book_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    reason ENUM('LATE_RETURN', 'DAMAGED_BOOK', 'LOST_BOOK', 'OTHER') NOT NULL,
    status ENUM('PENDING', 'PAID', 'WAIVED', 'CANCELLED') DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date DATE NOT NULL,
    paid_at TIMESTAMP NULL DEFAULT NULL,
    waived_at TIMESTAMP NULL DEFAULT NULL,
    waived_by INT NULL DEFAULT NULL,
    notes TEXT,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (waived_by) REFERENCES users(userId) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_user (userId),
    INDEX idx_transaction (transaction_id)
);

