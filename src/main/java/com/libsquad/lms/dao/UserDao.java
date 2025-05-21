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

    // Get user by ID
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE userId = ?";
        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapUserFromResultSet(rs) : null;
            }
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

    // Get all students
    public List<User> getAllStudents() throws SQLException {
        return getUsersByRole(UserRole.STUDENT);
    }

    // Get all admins
    public List<User> getAllAdmins() throws SQLException {
        return getUsersByRole(UserRole.ADMIN);
    }

    // Get users by specific role
    public List<User> getUsersByRole(UserRole role) throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM " + TABLE_NAME + " WHERE role = ? ORDER BY userId";

        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, role.name());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapUserFromResultSet(rs));
                }
            }
        }
        return users;
    }

    // Update user role
    public boolean updateUserRole(int userId, UserRole newRole) throws SQLException {
        String sql = "UPDATE " + TABLE_NAME + " SET role = ? WHERE userId = ?";
        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newRole.name());
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    // Update user information (including optional password update)
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE " + TABLE_NAME + " SET " +
                "username = ?, fullName = ?, email = ?, phone = ?, " +
                "address = ?, profilePic = ?, role = ? " +
                (user.getPassword() != null && !user.getPassword().isEmpty() ? ", password = ? " : "") +
                "WHERE userId = ?";

        try (Connection connection = DatabaseConnectionUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            int paramIndex = 1;
            ps.setString(paramIndex++, user.getUsername());
            ps.setString(paramIndex++, user.getFullName());
            ps.setString(paramIndex++, user.getEmail());
            ps.setString(paramIndex++, user.getPhone());
            ps.setString(paramIndex++, user.getAddress());
            ps.setString(paramIndex++, user.getProfilePic());
            ps.setString(paramIndex++, user.getRole().name());

            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                ps.setString(paramIndex++, user.getPassword());
            }

            ps.setInt(paramIndex, user.getUserId());

            return ps.executeUpdate() > 0;
        }
    }

    // Delete user
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

    public int getTotalMembers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE role != 'ADMIN' AND role != 'SUPER_ADMIN'";
        try (Connection conn = DatabaseConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}