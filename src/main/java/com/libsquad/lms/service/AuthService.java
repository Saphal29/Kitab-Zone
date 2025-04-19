package com.libsquad.lms.service;



import com.libsquad.lms.dao.UserDao;
import com.libsquad.lms.model.User;
import com.libsquad.lms.model.UserRole;
import com.libsquad.lms.utils.HashPasswordUtil;
import java.sql.SQLException;

public class AuthService {
    private final UserDao userDAO;

    public AuthService() {
        this.userDAO = new UserDao();
    }

    // ================== AUTHENTICATION ================== //
    public User authenticate(String username, String password) throws SQLException {
        User user = userDAO.getUserByUsername(username);
        if(user != null && HashPasswordUtil.verifyPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    // ================== USER REGISTRATION ================== //
    public User registerStudent(String username, String rawPassword,
                                String fullName, String email,
                                String phone, String address,
                                String profilePic) throws Exception {

        // Validate required fields
        if (username == null || username.trim().isEmpty() ||
                rawPassword == null || rawPassword.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("All required fields must be filled");
        }

        // Check existing username/email
        if (userDAO.usernameExists(username)) {
            throw new IllegalArgumentException("Username already exists");
        }
        if (userDAO.emailExists(email)) {
            throw new IllegalArgumentException("Email already registered");
        }

        // Hash password
        String hashedPassword = HashPasswordUtil.hashPassword(rawPassword);

        // Create user object
        User newUser = new User(
                username,
                hashedPassword,
                fullName,
                email,
                phone != null ? phone : "", // Handle optional fields
                address != null ? address : "",
                profilePic
        );

        // Save to database
        int userId = userDAO.createUser(newUser);
        newUser.setUserId(userId);

        return newUser;
    }
    // ================== ADMIN MANAGEMENT ================== //
    public User createAdminUser(User creator, String username, String password, UserRole role,
                                String fullName, String email, String phone, String address)
            throws SecurityException, SQLException {

        // Authorization check
        if(!creator.isSuperAdmin()) {
            throw new SecurityException("Only Super Admins can create admin users");
        }

        // Validate input
        if(role != UserRole.ADMIN && role != UserRole.SUPER_ADMIN) {
            throw new IllegalArgumentException("Invalid admin role");
        }

        // Create admin
        String hashedPassword = HashPasswordUtil.hashPassword(password);
        User adminUser = new User(username, hashedPassword, role, fullName, email, phone, address, null);

        int userId = userDAO.createUser(adminUser);
        adminUser.setUserId(userId);
        return adminUser;
    }

    // ================== AUTHORIZATION CHECKS ================== //
    public boolean canManageUsers(User requester) {
        return requester.isSuperAdmin() || requester.isAdmin();
    }

    public boolean canDeleteUser(User requester, User targetUser) {
        // Super Admins can delete anyone
        if(requester.isSuperAdmin()) return true;

        // Admins can only delete students
        return requester.isAdmin() && targetUser.isStudent();
    }

    public boolean canModifyBooks(User user) {
        return user.isAdmin() || user.isSuperAdmin();
    }

    public boolean canViewSensitiveReports(User user) {
        return user.isSuperAdmin();
    }
}