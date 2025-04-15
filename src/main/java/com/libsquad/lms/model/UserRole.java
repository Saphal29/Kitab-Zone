package com.libsquad.lms.model;

public enum UserRole {
    SUPER_ADMIN("Super Admin"),
    ADMIN("Admin"),
    STUDENT("Student");

    private final String displayName;

    UserRole(String displayName) {
        this.displayName = displayName;
    }

    @Override
    public String toString() {
        return displayName;
    }
}