package com.libsquad.lms.dao;

import com.libsquad.lms.model.Fine;
import com.libsquad.lms.utils.DatabaseConnectionUtil;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class FineDAO {
    private Connection connection;

    public FineDAO() {
        try {
            connection = DatabaseConnectionUtil.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public FineDAO(Connection connection) {
        this.connection = connection;
    }

    public void createFine(Fine fine) throws SQLException {
        String sql = "INSERT INTO fines (userId, book_id, transaction_id, amount, reason, status, due_date, notes) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, fine.getUserId());
            stmt.setInt(2, fine.getBookId());
            stmt.setObject(3, fine.getTransactionId());
            stmt.setBigDecimal(4, fine.getAmount());
            stmt.setString(5, fine.getReason().name());
            stmt.setString(6, fine.getStatus().name());
            stmt.setDate(7, Date.valueOf(fine.getDueDate()));
            stmt.setString(8, fine.getNotes());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    fine.setFineId(rs.getInt(1));
                }
            }
        }
    }

    public List<Fine> getFinesByUserId(int userId) throws SQLException {
        List<Fine> fines = new ArrayList<>();
        String sql = "SELECT f.*, u.fullName as user_name, b.title as book_title, " +
                "w.fullName as waived_by_name " +
                "FROM fines f " +
                "JOIN users u ON f.userId = u.userId " +
                "JOIN books b ON f.book_id = b.book_id " +
                "LEFT JOIN users w ON f.waived_by = w.userId " +
                "WHERE f.userId = ? " +
                "ORDER BY f.created_at DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    fines.add(mapResultSetToFine(rs));
                }
            }
        }
        return fines;
    }

    public List<Fine> getAllFines() throws SQLException {
        List<Fine> fines = new ArrayList<>();
        String sql = "SELECT f.*, u.fullName as user_name, b.title as book_title, " +
                "w.fullName as waived_by_name " +
                "FROM fines f " +
                "JOIN users u ON f.userId = u.userId " +
                "JOIN books b ON f.book_id = b.book_id " +
                "LEFT JOIN users w ON f.waived_by = w.userId " +
                "ORDER BY f.created_at DESC";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                fines.add(mapResultSetToFine(rs));
            }
        }
        return fines;
    }

    public void markAsPaid(int fineId) throws SQLException {
        String sql = "UPDATE fines SET status = 'PAID', paid_at = ? " +
                "WHERE fine_id = ? AND status = 'PENDING'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(2, fineId);
            stmt.executeUpdate();
        }
    }

    public void waiveFine(int fineId, int waivedBy, String notes) throws SQLException {
        String sql = "UPDATE fines SET status = 'WAIVED', waived_at = ?, waived_by = ?, notes = ? " +
                "WHERE fine_id = ? AND status = 'PENDING'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(2, waivedBy);
            stmt.setString(3, notes);
            stmt.setInt(4, fineId);
            stmt.executeUpdate();
        }
    }

    public void cancelFine(int fineId) throws SQLException {
        String sql = "UPDATE fines SET status = 'CANCELLED' WHERE fine_id = ? AND status = 'PENDING'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, fineId);
            stmt.executeUpdate();
        }
    }

    public BigDecimal getTotalPendingFines(int userId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM fines WHERE userId = ? AND status = 'PENDING'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal(1);
                }
            }
        }
        return BigDecimal.ZERO;
    }

    public double getTotalPendingFines() throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM fines WHERE status = 'PENDING'";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
            return 0.0;
        }
    }

    private Fine mapResultSetToFine(ResultSet rs) throws SQLException {
        Fine fine = new Fine();
        fine.setFineId(rs.getInt("fine_id"));
        fine.setUserId(rs.getInt("userId"));
        fine.setBookId(rs.getInt("book_id"));
        fine.setTransactionId(rs.getInt("transaction_id"));
        fine.setAmount(rs.getBigDecimal("amount"));
        fine.setReason(Fine.FineReason.valueOf(rs.getString("reason")));
        fine.setStatus(Fine.FineStatus.valueOf(rs.getString("status")));
        fine.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        fine.setDueDate(rs.getDate("due_date").toLocalDate());

        Timestamp paidAt = rs.getTimestamp("paid_at");
        if (paidAt != null) {
            fine.setPaidAt(paidAt.toLocalDateTime());
        }

        Timestamp waivedAt = rs.getTimestamp("waived_at");
        if (waivedAt != null) {
            fine.setWaivedAt(waivedAt.toLocalDateTime());
        }

        fine.setWaivedBy(rs.getInt("waived_by"));
        fine.setNotes(rs.getString("notes"));
        fine.setUserName(rs.getString("user_name"));
        fine.setBookTitle(rs.getString("book_title"));
        fine.setWaivedByName(rs.getString("waived_by_name"));

        return fine;
    }
}