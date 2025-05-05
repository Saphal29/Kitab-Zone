package com.libsquad.lms.dao;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.BookStatus;
import com.libsquad.lms.model.Book.Genre;
import com.libsquad.lms.utils.DatabaseConnectionUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookDAO {
    private static final String TABLE_NAME = "books";

    public void create(Book book) {
        String sql = "INSERT INTO " + TABLE_NAME + " (" +
                "title, author, publisher, edition, isbn, genre, " +
                "status, added_date, cover_image, total_copies" +  // Changed 'copies' to 'total_copies'
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            setInsertParameters(stmt, book);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Database error creating book", e);
        }
    }

    public void update(Book book) {
        String sql = "UPDATE " + TABLE_NAME + " SET " +
                "title = ?, author = ?, publisher = ?, edition = ?, " +
                "isbn = ?, genre = ?, status = ?, total_copies = ?, " + // Changed 'copies' to 'total_copies'
                "cover_image = ? WHERE book_id = ?";

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            setUpdateParameters(stmt, book);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Database error updating book", e);
        }
    }

    public void delete(int bookId) {
        String sql = "DELETE FROM " + TABLE_NAME + " WHERE book_id = ?";

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Database error deleting book", e);
        }
    }

    public Optional<Book> findById(int bookId) {
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE book_id = ?";

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Optional.of(mapRowToBook(rs));
            }
            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Database error finding book", e);
        }
    }

    public List<Book> findAll() {
        String sql = "SELECT * FROM " + TABLE_NAME;
        List<Book> books = new ArrayList<>();

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                books.add(mapRowToBook(rs));
            }
            return books;
        } catch (SQLException e) {
            throw new RuntimeException("Database error retrieving books", e);
        }
    }

    public List<Book> search(String query) {
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE " +
                "title LIKE ? OR author LIKE ? OR isbn LIKE ?";

        List<Book> books = new ArrayList<>();

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapRowToBook(rs));
            }
            return books;
        } catch (SQLException e) {
            throw new RuntimeException("Database error searching books", e);
        }
    }

    public boolean exists(int bookId) {
        String sql = "SELECT COUNT(*) FROM " + TABLE_NAME + " WHERE book_id = ?";

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Database error checking book existence", e);
        }
    }

    // --- Helper Methods ---

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
        stmt.setInt(10, book.getTotalCopies());  // Changed 'copies' to 'totalCopies'
    }

    private void setUpdateParameters(PreparedStatement stmt, Book book) throws SQLException {
        stmt.setString(1, book.getTitle());
        stmt.setString(2, book.getAuthor());
        stmt.setString(3, book.getPublisher());
        stmt.setString(4, book.getEdition());
        stmt.setString(5, book.getIsbn());
        stmt.setString(6, book.getGenre().name());
        stmt.setString(7, book.getStatus().name());
        stmt.setInt(8, book.getTotalCopies());  // Changed 'copies' to 'totalCopies'
        stmt.setString(9, book.getCoverImage());
        stmt.setInt(10, book.getBookId());
    }

    private Book mapRowToBook(ResultSet rs) throws SQLException {
        Timestamp ts = rs.getTimestamp("added_date");
        LocalDateTime addedDate = ts != null ? ts.toLocalDateTime() : null;

        return new Book(
                rs.getInt("book_id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("isbn"),
                rs.getString("publisher"),
                rs.getString("edition"),
                parseGenre(rs.getString("genre")),
                parseBookStatus(rs.getString("status")),
                addedDate,
                rs.getString("cover_image"),
                rs.getInt("total_copies")  // Changed 'copies' to 'total_copies'
        );
    }

    private Genre parseGenre(String value) {
        try {
            return Genre.valueOf(value);
        } catch (IllegalArgumentException e) {
            return Genre.FICTION; // Default fallback
        }
    }

    private BookStatus parseBookStatus(String value) {
        try {
            return BookStatus.valueOf(value);
        } catch (IllegalArgumentException e) {
            return BookStatus.AVAILABLE; // Default fallback
        }
    }
}
