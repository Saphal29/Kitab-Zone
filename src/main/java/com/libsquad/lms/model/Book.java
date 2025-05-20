package com.libsquad.lms.model;

import java.time.LocalDateTime;

public class Book {
    private int bookId;
    private String title;
    private String author;
    private String publisher;
    private String edition;
    private String isbn;
    private Genre genre;
    private BookStatus status;
    private LocalDateTime addedDate;
    private String coverImage;
    private int totalCopies;
    private int availableCopies; // ✅ New field
    private String description;  // ✅ New field

    public Book() {

    }

    public enum Genre {
        FICTION, NON_FICTION, SCIENCE, TECHNOLOGY
    }

    public enum BookStatus {
        AVAILABLE, RESERVED, ISSUED
    }

    // ✅ Full Constructor
    public Book(int bookId, String title, String author, String publisher,
                String edition, String isbn, Genre genre, BookStatus status,
                LocalDateTime addedDate, String coverImage, int totalCopies,
                int availableCopies, String description) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.edition = edition;
        this.isbn = isbn;
        this.genre = genre;
        this.status = status;
        this.addedDate = addedDate;
        this.coverImage = coverImage;
        this.totalCopies = totalCopies;
        this.availableCopies = availableCopies;
        this.description = description;
    }

    // ✅ Minimal Constructor
    public Book(String title, String author, String publisher, String edition,
                String isbn, Genre genre, int totalCopies, int availableCopies, String description) {
        this(0, title, author, publisher, edition, isbn, genre,
                BookStatus.AVAILABLE, LocalDateTime.now(), null,
                totalCopies, availableCopies, description);
    }

    // ✅ Getters & Setters

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public String getEdition() { return edition; }
    public void setEdition(String edition) { this.edition = edition; }

    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }

    public Genre getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = Genre.valueOf(genre); }

    public BookStatus getStatus() { return status; }
    public void setStatus(BookStatus status) { this.status = status; }

    public LocalDateTime getAddedDate() { return addedDate; }
    public void setAddedDate(LocalDateTime addedDate) { this.addedDate = addedDate; }

    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }

    public int getTotalCopies() { return totalCopies; }
    public void setTotalCopies(int totalCopies) { this.totalCopies = totalCopies; }

    public int getAvailableCopies() { return availableCopies; }
    public void setAvailableCopies(int availableCopies) { this.availableCopies = availableCopies; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    // ✅ Status Helpers

    public boolean isAvailable() {
        return status == BookStatus.AVAILABLE && availableCopies > 0;
    }

    public boolean isReserved() {
        return status == BookStatus.RESERVED;
    }

    public boolean canBeIssued() {
        return isAvailable() && availableCopies >= 1;
    }

    public boolean hasLowStock() {
        return availableCopies <= 3;
    }
}
