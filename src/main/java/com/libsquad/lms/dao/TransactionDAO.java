package com.libsquad.lms.dao;

import com.libsquad.lms.model.Transaction;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {
    private final Connection conn;

    public TransactionDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean borrowBook(Transaction transaction) throws SQLException {
        String sql = "INSERT INTO transactions (userId, book_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, transaction.getUserId());
            stmt.setInt(2, transaction.getBookId());
            stmt.setDate(3, new java.sql.Date(transaction.getBorrowDate().getTime()));
            stmt.setDate(4, new java.sql.Date(transaction.getDueDate().getTime()));
            stmt.setString(5, "BORROWED");
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean returnBook(int transactionId, Date returnDate) throws SQLException {
        String sql = "UPDATE transactions SET return_date = ?, status = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, returnDate);
            stmt.setString(2, "RETURNED");
            stmt.setInt(3, transactionId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean insertTransaction(Transaction transaction) throws SQLException {
        String sql = "INSERT INTO transactions (userId, book_id, borrow_date, due_date, return_date, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, transaction.getUserId());
            stmt.setInt(2, transaction.getBookId());
            stmt.setDate(3, transaction.getBorrowDate());
            stmt.setDate(4, transaction.getDueDate());
            stmt.setDate(5, transaction.getReturnDate());
            stmt.setString(6, transaction.getStatus());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean isBookAvailable(int bookId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM transactions WHERE book_id = ? AND status = 'BORROWED'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) == 0;
            }
        }
    }

    public List<Transaction> getBorrowedBooksByUser(int userId) throws SQLException {
        List<Transaction> list = new ArrayList<>();
        String sql = "SELECT t.*, b.title AS book_title, b.author AS book_author, b.cover_image AS book_cover_image " +
                "FROM transactions t " +
                "JOIN books b ON t.book_id = b.book_id " +
                "WHERE t.userId = ? AND t.status = 'BORROWED'";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Transaction tr = new Transaction(
                            rs.getInt("id"),
                            rs.getInt("userId"),
                            rs.getInt("book_id"),
                            rs.getDate("borrow_date"),
                            rs.getDate("due_date"),
                            rs.getDate("return_date"),
                            rs.getString("status")
                    );
                    tr.setBookTitle(rs.getString("book_title"));
                    tr.setBookAuthor(rs.getString("book_author"));
                    tr.setBookCoverImage(rs.getString("book_cover_image"));
                    list.add(tr);
                }
            }
        }
        return list;
    }

    public int getBookIdByTransaction(int transactionId) throws SQLException {
        String sql = "SELECT book_id FROM transactions WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, transactionId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("book_id");
                }
            }
        }
        throw new SQLException("Transaction not found with ID: " + transactionId);
    }
}