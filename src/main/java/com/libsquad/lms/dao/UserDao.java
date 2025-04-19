package com.libsquad.lms.dao;

import com.libsquad.lms.model.User;
import com.libsquad.lms.model.UserRole;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    private static final String TABLE_NAME = "users";

    // Create user (returns generated userId)
    public int createUser(User user) throws SQLException {
        String sql = "INSERT INTO " + TABLE_NAME + " (username, password, role, fullName, " +
                "email, phone, address, profilePic) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole().name());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getPhone());
            ps.setString(7, user.getAddress());
            ps.setString(8, user.getProfilePic());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }
            return -1;
        }
    }

    // Get user by username (for login)
    public User getUserByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE username = ?";
        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapUserFromResultSet(rs) : null;
            }
        }
    }

    // Check username uniqueness
    public boolean usernameExists(String username) throws SQLException {
        String sql = "SELECT userId FROM " + TABLE_NAME + " WHERE username = ?";
        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Check email uniqueness
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT userId FROM " + TABLE_NAME + " WHERE email = ?";
        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Get all users (for admin panel)
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE_NAME + " ORDER BY userId";

        try (Connection connection = DatabaseConnectionUtil.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(mapUserFromResultSet(rs));
            }
        }
        return users;
    }

    // Update user role (admin function)
    public boolean updateUserRole(int userId, UserRole newRole) throws SQLException {
        String sql = "UPDATE " + TABLE_NAME + " SET role = ? WHERE userId = ?";
        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newRole.name());
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // Delete user (admin function)
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM " + TABLE_NAME + " WHERE userId = ?";
        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // Map ResultSet to User object
    private User mapUserFromResultSet(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("userId"),
                rs.getString("username"),
                rs.getString("password"),
                UserRole.valueOf(rs.getString("role")),
                rs.getString("fullName"),
                rs.getString("email"),
                rs.getString("profilePic"),
                rs.getString("phone"),
                rs.getString("address"),
                rs.getObject("created_at", LocalDateTime.class),
                rs.getObject("updated_at", LocalDateTime.class)
        );
    }
}