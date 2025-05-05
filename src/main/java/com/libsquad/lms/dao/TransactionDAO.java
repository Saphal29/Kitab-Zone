package com.libsquad.lms.dao;

import com.libsquad.lms.model.Transaction;
import com.libsquad.lms.utils.DatabaseConnectionUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TransactionDAO {
    private static final String TABLE_NAME = "transactions";

    public void create(Transaction transaction) {
        String sql = "INSERT INTO " + TABLE_NAME + " (userId, book_id, checkout_date, due_date, status) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, transaction.getUserId());
            stmt.setInt(2, transaction.getBookId());
            stmt.setTimestamp(3, Timestamp.valueOf(transaction.getCheckoutDate()));
            stmt.setTimestamp(4, Timestamp.valueOf(transaction.getDueDate()));
            stmt.setString(5, transaction.getStatus().name());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    transaction.setTransactionId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error creating transaction", e);
        }
    }

    public List<Transaction> findActiveByUserId(int userId) {
        String sql = "SELECT t.*, b.title, b.author, b.cover_image " +
                "FROM " + TABLE_NAME + " t " +
                "JOIN books b ON t.book_id = b.book_id " +
                "WHERE t.user_id = ? AND t.status = 'ACTIVE'";

        List<Transaction> transactions = new ArrayList<>();

        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                transactions.add(mapRowToTransaction(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error finding transactions", e);
        }

        return transactions;
    }

    private Transaction mapRowToTransaction(ResultSet rs) throws SQLException {
        Transaction transaction = new Transaction();
        transaction.setTransactionId(rs.getInt("transaction_id"));
        transaction.setUserId(rs.getInt("userId"));
        transaction.setBookId(rs.getInt("book_id"));

        Timestamp ts = rs.getTimestamp("checkout_date");
        transaction.setCheckoutDate(ts != null ? ts.toLocalDateTime() : null);

        ts = rs.getTimestamp("due_date");
        transaction.setDueDate(ts != null ? ts.toLocalDateTime() : null);

        ts = rs.getTimestamp("return_date");
        transaction.setReturnDate(ts != null ? ts.toLocalDateTime() : null);

        transaction.setStatus(Transaction.Status.valueOf(rs.getString("status")));
        transaction.setRenewCount(rs.getInt("renew_count"));

        // Book details
        transaction.setBookTitle(rs.getString("title"));
        transaction.setBookAuthor(rs.getString("author"));
        transaction.setBookCoverImage(rs.getString("cover_image"));

        return transaction;
    }
}