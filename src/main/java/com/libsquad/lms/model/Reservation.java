package com.libsquad.lms.model;

import java.time.LocalDateTime;

public class Reservation {
    private int id;
    private int userId;
    private int bookId;
    private LocalDateTime reservationDate;
    private LocalDateTime expiryDate;
    private ReservationStatus status;
    private int priority;
    private String notes;
    private Integer approvedBy;
    private LocalDateTime approvedAt;
    private LocalDateTime cancelledAt;
    private String cancelledReason;

    // Book details (for display purposes)
    private String bookTitle;
    private String bookAuthor;
    private String bookCover;
    private String userName;

    // Enums for reservation status
    public enum ReservationStatus {
        PENDING,
        APPROVED,
        CANCELLED,
        FULFILLED,
        EXPIRED
    }

    // Default constructor
    public Reservation() {
        this.status = ReservationStatus.PENDING;
        this.priority = 0;
    }

    // Full constructor (for database retrieval)
    public Reservation(int id, int userId, int bookId,
                       LocalDateTime reservationDate, LocalDateTime expiryDate, ReservationStatus status,
                       int priority, String notes, Integer approvedBy, LocalDateTime approvedAt,
                       LocalDateTime cancelledAt, String cancelledReason, String bookTitle, String bookAuthor,
                       String userName) {
        this.id = id;
        this.userId = userId;
        this.bookId = bookId;
        this.reservationDate = reservationDate;
        this.expiryDate = expiryDate;
        this.status = status;
        this.priority = priority;
        this.notes = notes;
        this.approvedBy = approvedBy;
        this.approvedAt = approvedAt;
        this.cancelledAt = cancelledAt;
        this.cancelledReason = cancelledReason;
        this.bookTitle = bookTitle;
        this.bookAuthor = bookAuthor;
        this.userName = userName;
    }

    // Getters/Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public LocalDateTime getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(LocalDateTime reservationDate) {
        this.reservationDate = reservationDate;
    }

    public LocalDateTime getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDateTime expiryDate) {
        this.expiryDate = expiryDate;
    }

    public ReservationStatus getStatus() {
        return status;
    }

    public void setStatus(ReservationStatus status) {
        this.status = status;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Integer getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(Integer approvedBy) {
        this.approvedBy = approvedBy;
    }

    public LocalDateTime getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(LocalDateTime approvedAt) {
        this.approvedAt = approvedAt;
    }

    public LocalDateTime getCancelledAt() {
        return cancelledAt;
    }

    public void setCancelledAt(LocalDateTime cancelledAt) {
        this.cancelledAt = cancelledAt;
    }

    public String getCancelledReason() {
        return cancelledReason;
    }

    public void setCancelledReason(String cancelledReason) {
        this.cancelledReason = cancelledReason;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public String getBookCover() {
        return bookCover;
    }

    public void setBookCover(String bookCover) {
        this.bookCover = bookCover;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Status check helpers
    public boolean isPending() {
        return status == ReservationStatus.PENDING;
    }
}