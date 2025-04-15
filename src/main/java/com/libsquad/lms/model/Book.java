package com.libsquad.lms.model;

import java.time.LocalDateTime;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private String publisher;
    private String edition;
    private String isbn;
    private String genre;
    private BookStatus status;
    private LocalDateTime addedDate;

    // Enums for book status
    public enum BookStatus {
        AVAILABLE, RESERVED, ISSUED
    }

    // Constructor for creating new books (status defaults to AVAILABLE)
    public Book(String title, String author, String publisher, String edition,
                String isbn, String genre) {
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.edition = edition;
        this.isbn = isbn;
        this.genre = genre;
        this.status = BookStatus.AVAILABLE; // Default status
    }

    // Full constructor (for database retrieval)
    public Book(int bookId, String title, String author, String publisher,
                String edition, String isbn, String genre, BookStatus status,
                LocalDateTime addedDate) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.edition = edition;
        this.isbn = isbn;
        this.genre = genre;
        this.status = status;
        this.addedDate = addedDate;
    }

    // Getters/Setters


    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getEdition() {
        return edition;
    }

    public void setEdition(String edition) {
        this.edition = edition;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public BookStatus getStatus() {
        return status;
    }

    public void setStatus(BookStatus status) {
        this.status = status;
    }

    public LocalDateTime getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(LocalDateTime addedDate) {
        this.addedDate = addedDate;
    }

    // Status check helpers
    public boolean isAvailable() {
        return status == BookStatus.AVAILABLE;
    }
    public boolean isReserved() {
        return status == BookStatus.RESERVED;
    }
}