package com.libsquad.lms.dao;

import com.libsquad.lms.model.Reservation;
import com.libsquad.lms.utils.DatabaseConnectionUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    private Connection connection;

    public ReservationDAO() throws SQLException {
        this.connection = DatabaseConnectionUtil.getConnection();
    }

    public ReservationDAO(Connection connection) {
        this.connection = connection;
    }

    public void createReservation(Reservation reservation) throws SQLException {
        String sql = "INSERT INTO reservations (userId, book_id, reservation_date, status, priority) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, reservation.getUserId());
            stmt.setInt(2, reservation.getBookId());
            stmt.setTimestamp(3, Timestamp.valueOf(reservation.getReservationDate()));
            stmt.setString(4, reservation.getStatus().name());
            stmt.setInt(5, reservation.getPriority());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    reservation.setId(rs.getInt(1));
                }
            }
        }
    }

    public List<Reservation> getReservationsByUserId(int userId) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, b.title as book_title, b.author as book_author, b.cover_image as book_cover " +
                "FROM reservations r " +
                "JOIN books b ON r.book_id = b.book_id " +
                "WHERE r.userId = ? " +
                "ORDER BY r.reservation_date DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Reservation reservation = new Reservation();
                    reservation.setId(rs.getInt("id"));
                    reservation.setUserId(rs.getInt("userId"));
                    reservation.setBookId(rs.getInt("book_id"));
                    reservation.setReservationDate(rs.getTimestamp("reservation_date").toLocalDateTime());
                    reservation.setStatus(Reservation.ReservationStatus.valueOf(rs.getString("status")));
                    reservation.setPriority(rs.getInt("priority"));
                    reservation.setBookTitle(rs.getString("book_title"));
                    reservation.setBookAuthor(rs.getString("book_author"));
                    reservation.setBookCover(rs.getString("book_cover"));

                    Timestamp expiryDate = rs.getTimestamp("expiry_date");
                    if (expiryDate != null) {
                        reservation.setExpiryDate(expiryDate.toLocalDateTime());
                    }

                    reservations.add(reservation);
                }
            }
        }
        return reservations;
    }

    public boolean hasActiveReservation(int userId, int bookId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reservations " +
                "WHERE userId = ? AND book_id = ? AND status IN ('PENDING', 'APPROVED')";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public int getNextPriority(int bookId) throws SQLException {
        String sql = "SELECT COALESCE(MAX(priority), 0) + 1 FROM reservations " +
                "WHERE book_id = ? AND status = 'PENDING'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 1;
    }

    public void updateReservationStatus(int reservationId, Reservation.ReservationStatus status) throws SQLException {
        String sql = "UPDATE reservations SET status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status.name());
            stmt.setInt(2, reservationId);
            stmt.executeUpdate();
        }
    }

    public void cancelReservation(int reservationId, String reason) throws SQLException {
        String sql = "UPDATE reservations SET status = 'CANCELLED', cancelled_at = ?, cancelled_reason = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setString(2, reason);
            stmt.setInt(3, reservationId);
            stmt.executeUpdate();
        }
    }

    public void approveReservation(int reservationId, int approvedBy) throws SQLException {
        String sql = "UPDATE reservations SET status = 'APPROVED', approved_by = ?, approved_at = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, approvedBy);
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(3, reservationId);
            stmt.executeUpdate();
        }
    }

    public void fulfillReservation(int reservationId) throws SQLException {
        String sql = "UPDATE reservations SET status = 'FULFILLED' WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, reservationId);
            stmt.executeUpdate();
        }
    }

    public void expireReservation(int reservationId) throws SQLException {
        String sql = "UPDATE reservations SET status = 'EXPIRED' WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, reservationId);
            stmt.executeUpdate();
        }
    }

    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, b.title as book_title, b.author as book_author, b.cover_image as book_cover, " +
                "u.fullName as user_name " +
                "FROM reservations r " +
                "JOIN books b ON r.book_id = b.book_id " +
                "JOIN users u ON r.userId = u.userId " +
                "ORDER BY r.reservation_date DESC";

        System.out.println("ReservationDAO: Executing SQL query: " + sql);

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            System.out.println("ReservationDAO: Prepared statement created successfully");

            try (ResultSet rs = stmt.executeQuery()) {
                System.out.println("ReservationDAO: Query executed successfully");

                while (rs.next()) {
                    System.out.println("ReservationDAO: Processing reservation row");
                    Reservation reservation = new Reservation();
                    reservation.setId(rs.getInt("id"));
                    reservation.setUserId(rs.getInt("userId"));
                    reservation.setBookId(rs.getInt("book_id"));
                    reservation.setReservationDate(rs.getTimestamp("reservation_date").toLocalDateTime());
                    reservation.setStatus(Reservation.ReservationStatus.valueOf(rs.getString("status")));
                    reservation.setPriority(rs.getInt("priority"));
                    reservation.setBookTitle(rs.getString("book_title"));
                    reservation.setBookAuthor(rs.getString("book_author"));
                    reservation.setBookCover(rs.getString("book_cover"));
                    reservation.setUserName(rs.getString("user_name"));

                    Timestamp expiryDate = rs.getTimestamp("expiry_date");
                    if (expiryDate != null) {
                        reservation.setExpiryDate(expiryDate.toLocalDateTime());
                    }

                    Timestamp approvedAt = rs.getTimestamp("approved_at");
                    if (approvedAt != null) {
                        reservation.setApprovedAt(approvedAt.toLocalDateTime());
                    }

                    Timestamp cancelledAt = rs.getTimestamp("cancelled_at");
                    if (cancelledAt != null) {
                        reservation.setCancelledAt(cancelledAt.toLocalDateTime());
                    }

                    reservation.setCancelledReason(rs.getString("cancelled_reason"));
                    reservation.setApprovedBy(rs.getInt("approved_by"));

                    reservations.add(reservation);
                    System.out.println("ReservationDAO: Added reservation ID " + reservation.getId() + " to list");
                }
            }
        } catch (SQLException e) {
            System.err.println("ReservationDAO: Error executing query: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }

        System.out.println("ReservationDAO: Successfully retrieved " + reservations.size() + " reservations");
        return reservations;
    }

    public int getActiveReservationsCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM reservations WHERE status = 'PENDING'";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}