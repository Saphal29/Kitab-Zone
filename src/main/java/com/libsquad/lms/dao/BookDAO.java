package com.libsquad.lms.dao;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.BookStatus;
import com.libsquad.lms.model.Book.Genre;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookDAO {
    private final Connection conn;
    private static final String TABLE_NAME = "books";

    public BookDAO(Connection conn) {
        this.conn = conn;
    }

    // Create a new book
    public void create(Book book) throws SQLException {
        String sql = "INSERT INTO " + TABLE_NAME + " (" +
                "title, author, publisher, edition, isbn, genre, " +
                "status, added_date, cover_image, total_copies, available_copies, description" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            setInsertParameters(stmt, book);
            stmt.executeUpdate();
        }
    }

    // Update existing book
    public void update(Book book) throws SQLException {
        String sql = "UPDATE " + TABLE_NAME + " SET " +
                "title = ?, author = ?, publisher = ?, edition = ?, " +
                "isbn = ?, genre = ?, status = ?, total_copies = ?, " +
                "available_copies = ?, cover_image = ?, description = ? " +
                "WHERE book_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            setUpdateParameters(stmt, book);
            stmt.executeUpdate();
        }
    }

    // Delete a book
    public void delete(int bookId) throws SQLException {
        String sql = "DELETE FROM " + TABLE_NAME + " WHERE book_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        }
    }

    // Find book by ID
    public Optional<Book> findById(int bookId) throws SQLException {
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE book_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? Optional.of(mapRowToBook(rs)) : Optional.empty();
            }
        }
    }

    // Get all books
    public List<Book> findAll() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE_NAME;

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                books.add(mapRowToBook(rs));
            }
        }
        return books;
    }

    // Search books
    public List<Book> search(String query) throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE title LIKE ? OR author LIKE ? OR isbn LIKE ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    books.add(mapRowToBook(rs));
                }
            }
        }
        return books;
    }

    // Stock management methods
    public void incrementAvailableCopies(int bookId) throws SQLException {
        updateCopies(bookId, 1);
    }

    public void decrementAvailableCopies(int bookId) throws SQLException {
        updateCopies(bookId, -1);
    }

    private void updateCopies(int bookId, int delta) throws SQLException {
        String sql = "UPDATE " + TABLE_NAME + " SET available_copies = available_copies + ? " +
                "WHERE book_id = ? AND available_copies + ? >= 0";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, delta);
            stmt.setInt(2, bookId);
            stmt.setInt(3, delta);
            stmt.executeUpdate();
        }
    }

    // Helper methods
    private void setInsertParameters(PreparedStatement stmt, Book book) throws SQLException {
        stmt.setString(1, book.getTitle());
        stmt.setString(2, book.getAuthor());
        stmt.setString(3, book.getPublisher());
        stmt.setString(4, book.getEdition());
        stmt.setString(5, book.getIsbn());
        stmt.setString(6, book.getGenre().name());
        stmt.setString(7, book.getStatus().name());
        stmt.setTimestamp(8, Timestamp.valueOf(book.getAddedDate()));
        stmt.setString(9, book.getCoverImage());
        stmt.setInt(10, book.getTotalCopies());
        stmt.setInt(11, book.getAvailableCopies());
        stmt.setString(12, book.getDescription());
    }

    private void setUpdateParameters(PreparedStatement stmt, Book book) throws SQLException {
        stmt.setString(1, book.getTitle());
        stmt.setString(2, book.getAuthor());
        stmt.setString(3, book.getPublisher());
        stmt.setString(4, book.getEdition());
        stmt.setString(5, book.getIsbn());
        stmt.setString(6, book.getGenre().name());
        stmt.setString(7, book.getStatus().name());
        stmt.setInt(8, book.getTotalCopies());
        stmt.setInt(9, book.getAvailableCopies());
        stmt.setString(10, book.getCoverImage());
        stmt.setString(11, book.getDescription());
        stmt.setInt(12, book.getBookId());
    }

    private Book mapRowToBook(ResultSet rs) throws SQLException {
        return new Book(
                rs.getInt("book_id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("publisher"),
                rs.getString("edition"),
                rs.getString("isbn"),
                parseGenre(rs.getString("genre")),
                parseBookStatus(rs.getString("status")),
                rs.getTimestamp("added_date").toLocalDateTime(),
                rs.getString("cover_image"),
                rs.getInt("total_copies"),
                rs.getInt("available_copies"),
                rs.getString("description")
        );
    }

    private Genre parseGenre(String value) {
        try {
            return Genre.valueOf(value);
        } catch (IllegalArgumentException e) {
            return Genre.FICTION;
        }
    }

    private BookStatus parseBookStatus(String value) {
        try {
            return BookStatus.valueOf(value);
        } catch (IllegalArgumentException e) {
            return BookStatus.AVAILABLE;
        }
    }

    public int getTotalBooks() throws SQLException {
        String sql = "SELECT COUNT(*) FROM books";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}