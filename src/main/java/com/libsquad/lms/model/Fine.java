package com.libsquad.lms.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Fine {
    private int fineId;
    private int userId;
    private int bookId;
    private Integer transactionId;
    private BigDecimal amount;
    private FineReason reason;
    private FineStatus status;
    private LocalDateTime createdAt;
    private LocalDate dueDate;
    private LocalDateTime paidAt;
    private LocalDateTime waivedAt;
    private Integer waivedBy;
    private String notes;

    // Additional fields for display purposes
    private String userName;
    private String bookTitle;
    private String waivedByName;

    public enum FineReason {
        LATE_RETURN,
        DAMAGED_BOOK,
        LOST_BOOK,
        OTHER
    }

    public enum FineStatus {
        PENDING,
        PAID,
        WAIVED,
        CANCELLED
    }

    public enum PaymentMethod {
        CASH,
        ONLINE
    }

    // Default constructor
    public Fine() {
        this.status = FineStatus.PENDING;
        this.createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public int getFineId() {
        return fineId;
    }

    public void setFineId(int fineId) {
        this.fineId = fineId;
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

    public Integer getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(Integer transactionId) {
        this.transactionId = transactionId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public FineReason getReason() {
        return reason;
    }

    public void setReason(FineReason reason) {
        this.reason = reason;
    }

    public FineStatus getStatus() {
        return status;
    }

    public void setStatus(FineStatus status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public LocalDateTime getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(LocalDateTime paidAt) {
        this.paidAt = paidAt;
    }

    public LocalDateTime getWaivedAt() {
        return waivedAt;
    }

    public void setWaivedAt(LocalDateTime waivedAt) {
        this.waivedAt = waivedAt;
    }

    public Integer getWaivedBy() {
        return waivedBy;
    }

    public void setWaivedBy(Integer waivedBy) {
        this.waivedBy = waivedBy;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getWaivedByName() {
        return waivedByName;
    }

    public void setWaivedByName(String waivedByName) {
        this.waivedByName = waivedByName;
    }

    // Helper methods
    public boolean isPending() {
        return status == FineStatus.PENDING;
    }

    public boolean isPaid() {
        return status == FineStatus.PAID;
    }

    public boolean isWaived() {
        return status == FineStatus.WAIVED;
    }

    public boolean isOverdue() {
        return isPending() && dueDate.isBefore(LocalDate.now());
    }
}