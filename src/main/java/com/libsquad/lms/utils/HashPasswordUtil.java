package com.libsquad.lms.utils;
import org.mindrot.jbcrypt.BCrypt;
public final class HashPasswordUtil {
    // BCrypt cost factor (work factor)
    private static final int DEFAULT_COST = 10;

    // Private constructor to prevent instantiation
    private HashPasswordUtil() {
        throw new AssertionError("Utility class cannot be instantiated!");
    }
    public static String hashPassword(String rawPassword) {
        validateInput(rawPassword);
        return BCrypt.hashpw(rawPassword, BCrypt.gensalt(DEFAULT_COST));
    }
    public static boolean verifyPassword(String rawPassword, String hashedPassword) {
        if (rawPassword == null || rawPassword.isEmpty() ||
                hashedPassword == null || hashedPassword.isEmpty()) {
            return false;
        }

        try {
            return BCrypt.checkpw(rawPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            return false; // Invalid hash format
        }
    }

    // Validate input
    private static void validateInput(String rawPassword) {
        if (rawPassword == null || rawPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
    }
}