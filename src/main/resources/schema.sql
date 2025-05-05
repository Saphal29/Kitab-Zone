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
     added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     status ENUM('AVAILABLE', 'RESERVED', 'ISSUED', 'MAINTENANCE') DEFAULT 'AVAILABLE',
     cover_image VARCHAR(255),
     INDEX idx_genre (genre),
     INDEX idx_status (status)
 );
-- Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    book_id INT NOT NULL,
    checkout_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP NOT NULL,
    return_date TIMESTAMP,
    status ENUM('ACTIVE', 'RETURNED', 'OVERDUE') DEFAULT 'ACTIVE',
    renew_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    INDEX idx_transaction_status (status),
    INDEX idx_due_date (due_date)
);

-- Reservations Table
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    expiration_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    INDEX idx_reservation_status (status),
    INDEX idx_reservation_user (user_id)
);

-- Fines Table
CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    transaction_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('PAID', 'UNPAID') DEFAULT 'UNPAID',
    issued_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    paid_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id) ON DELETE CASCADE,
    INDEX idx_fine_status (status)
);

