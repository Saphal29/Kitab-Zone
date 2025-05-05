package com.libsquad.lms.model;

import com.libsquad.lms.utils.ValidationException;
import com.libsquad.lms.service.BookService;
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
    private int totalCopies;  // Changed 'copies' to 'totalCopies'

    public enum Genre {
        FICTION, NON_FICTION, SCIENCE, TECHNOLOGY
    }

    public enum BookStatus {
        AVAILABLE, RESERVED, ISSUED
    }

    // Full Constructor (11 parameters)
    public Book(int bookId, String title, String author, String publisher,
                String edition, String isbn, Genre genre, BookStatus status,
                LocalDateTime addedDate, String coverImage, int totalCopies) { // Changed 'copies' to 'totalCopies'
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
        this.totalCopies = totalCopies;  // Changed 'copies' to 'totalCopies'
    }

    // Minimal Constructor (for creating new books)
    public Book(String title, String author, String publisher, String edition,
                String isbn, Genre genre, int totalCopies) {  // Changed 'copies' to 'totalCopies'
        this(0, // bookId (temp value for new books)
                title,
                author,
                publisher,
                edition,
                isbn,
                genre,
                BookStatus.AVAILABLE, // Default status
                LocalDateTime.now(),  // Auto-generated addedDate
                null,                 // Default coverImage
                totalCopies          // Changed 'copies' to 'totalCopies'
        );
    }

    // Getters and setters
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

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
        this.isbn = isbn; // Direct assignment without validation
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = Genre.valueOf(genre);
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

    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }

    public int getTotalCopies() { return totalCopies; }  // Changed 'copies' to 'totalCopies'
    public void setTotalCopies(int totalCopies) { this.totalCopies = totalCopies; }  // Changed 'copies' to 'totalCopies'

    // Status check helpers (MUST KEEP)
    public boolean isAvailable() {
        return status == BookStatus.AVAILABLE && totalCopies > 0;  // Changed 'copies' to 'totalCopies'
    }

    public boolean isReserved() {
        return status == BookStatus.RESERVED;
    }

    public boolean canBeIssued() {
        return isAvailable() && totalCopies >= 1;  // Changed 'copies' to 'totalCopies'
    }

    // New helper for copy availability
    public boolean hasLowStock() {
        return totalCopies <= 3;  // Changed 'copies' to 'totalCopies'
    }
}
