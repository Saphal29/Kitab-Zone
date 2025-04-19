package com.libsquad.lms.model;

import java.time.LocalDateTime;

public class User {
 private int userId;
 private String username;
 private String password;
 private UserRole role;
 private String fullName;
 private String email;
 private String profilePic;  // Stores path/URL or null
 private String phone;
 private String address;
 private LocalDateTime createdAt;
 private LocalDateTime updatedAt;

 // ------------------------ Constructors ------------------------

 // Full constructor (database retrieval)
 public User(int userId, String username, String password, UserRole role,
             String fullName, String email, String profilePic,
             String phone, String address,
             LocalDateTime createdAt, LocalDateTime updatedAt) {
  this.userId = userId;
  this.username = username;
  this.password = password;
  this.role = role;
  this.fullName = fullName;
  this.email = email;
  this.profilePic = profilePic;
  this.phone = phone;
  this.address = address;
  this.createdAt = createdAt;
  this.updatedAt = updatedAt;
 }

 // Student self-registration (default role: STUDENT)
 public User(String username, String hashedPassword,
             String fullName, String email, String phone,
             String address, String profilePic) {
  this(-1, username, hashedPassword, UserRole.STUDENT,
          fullName, email, profilePic, phone, address,
          null, null);
 }

 // Admin/SuperAdmin user creation (explicit role)
 public User(String username, String hashedPassword, UserRole role,
             String fullName, String email, String phone,
             String address, String profilePic) {
  this(-1, username, hashedPassword, role,
          fullName, email, profilePic, phone, address,
          null, null);
 }

//Getters/Setters
 public int getUserId() {
  return userId;
 }

 public void setUserId(int userId) {
  this.userId = userId;
 }

 public String getUsername() {
  return username;
 }

 public void setUsername(String username) {
  this.username = username;
 }

 public String getPassword() {
  return password;
 }

 public void setPassword(String password) {
  this.password = password;
 }

 public UserRole getRole() {
  return role;
 }

 public void setRole(UserRole role) {
  this.role = role;
 }

 public String getFullName() {
  return fullName;
 }

 public void setFullName(String fullName) {
  this.fullName = fullName;
 }

 public String getEmail() {
  return email;
 }

 public void setEmail(String email) {
  this.email = email;
 }

 public String getProfilePic() {
  return profilePic;
 }

 public void setProfilePic(String profilePic) {
  this.profilePic = profilePic;
 }

 public String getPhone() {
  return phone;
 }

 public void setPhone(String phone) {
  this.phone = phone;
 }

 public String getAddress() {
  return address;
 }

 public void setAddress(String address) {
  this.address = address;
 }

 public LocalDateTime getCreatedAt() {
  return createdAt;
 }

 public void setCreatedAt(LocalDateTime createdAt) {
  this.createdAt = createdAt;
 }

 public LocalDateTime getUpdatedAt() {
  return updatedAt;
 }

 public void setUpdatedAt(LocalDateTime updatedAt) {
  this.updatedAt = updatedAt;
 }

 //  Role Helpers
 public boolean isAdmin() {
  return role == UserRole.ADMIN;
 }

 public boolean isSuperAdmin() {
  return role == UserRole.SUPER_ADMIN;
 }

 public boolean isStudent() {
  return role == UserRole.STUDENT;
 }
}