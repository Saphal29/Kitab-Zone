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


