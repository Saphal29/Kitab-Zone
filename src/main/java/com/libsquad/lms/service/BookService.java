package com.libsquad.lms.service;

import com.libsquad.lms.dao.BookDAO;
import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.BookStatus;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import com.libsquad.lms.utils.ValidationException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class BookService implements AutoCloseable {
    private final Connection conn;
    private final BookDAO bookDao;

    public BookService() throws SQLException {
        this.conn = DatabaseConnectionUtil.getConnection();
        this.bookDao = new BookDAO(conn);
    }

    // Create new book
    public void createBook(Book book) throws ValidationException {
        try {
            validateBook(book);
            book.setAddedDate(LocalDateTime.now());
            book.setStatus(BookStatus.AVAILABLE);
            book.setAvailableCopies(book.getTotalCopies());
            bookDao.create(book);
        } catch (SQLException e) {
            throw new ValidationException("Database error creating book: " + e.getMessage());
        }
    }

    // Update existing book
    public void updateBook(Book book) throws ValidationException {
        try {
            validateBook(book);
            bookDao.update(book);
        } catch (SQLException e) {
            throw new ValidationException("Database error updating book: " + e.getMessage());
        }
    }

    // Delete book
    public void deleteBook(int bookId) throws ValidationException {
        try {
            if (!bookExists(bookId)) {
                throw new ValidationException("Book not found with ID: " + bookId);
            }
            bookDao.delete(bookId);
        } catch (SQLException e) {
            throw new ValidationException("Database error deleting book: " + e.getMessage());
        }
    }

    // Get book by ID
    public Book getBookById(int bookId) throws ValidationException {
        try {
            return bookDao.findById(bookId)
                    .orElseThrow(() -> new ValidationException("Book not found with ID: " + bookId));
        } catch (SQLException e) {
            throw new ValidationException("Database error finding book: " + e.getMessage());
        }
    }

    // Get all books
    public List<Book> getAllBooks() throws ValidationException {
        try {
            return bookDao.findAll();
        } catch (SQLException e) {
            throw new ValidationException("Database error retrieving books: " + e.getMessage());
        }
    }

    // Search books
    public List<Book> searchBooks(String query) throws ValidationException {
        try {
            return bookDao.search(query);
        } catch (SQLException e) {
            throw new ValidationException("Database error searching books: " + e.getMessage());
        }
    }

    // Stock management
    public void decrementAvailableCopies(int bookId) throws ValidationException {
        try {
            bookDao.decrementAvailableCopies(bookId);
        } catch (SQLException e) {
            throw new ValidationException("Database error updating copies: " + e.getMessage());
        }
    }

    public void incrementAvailableCopies(int bookId) throws ValidationException {
        try {
            bookDao.incrementAvailableCopies(bookId);
        } catch (SQLException e) {
            throw new ValidationException("Database error updating copies: " + e.getMessage());
        }
    }

    // Validation
    private void validateBook(Book book) throws ValidationException {
        if (book.getTitle() == null || book.getTitle().trim().isEmpty()) {
            throw new ValidationException("Title is required");
        }
        if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
            throw new ValidationException("Author is required");
        }
        if (book.getGenre() == null) {
            throw new ValidationException("Genre is required");
        }
        if (book.getTotalCopies() < 0) {
            throw new ValidationException("Total copies cannot be negative");
        }
        if (book.getAvailableCopies() < 0) {
            throw new ValidationException("Available copies cannot be negative");
        }
        if (book.getAvailableCopies() > book.getTotalCopies()) {
            throw new ValidationException("Available copies cannot exceed total copies");
        }
    }

    private boolean bookExists(int bookId) throws ValidationException {
        try {
            return bookDao.findById(bookId).isPresent();
        } catch (SQLException e) {
            throw new ValidationException("Database error checking book existence: " + e.getMessage());
        }
    }

    @Override
    public void close() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }
}