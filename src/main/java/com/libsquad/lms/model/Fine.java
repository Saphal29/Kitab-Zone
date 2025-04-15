package com.libsquad.lms.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Fine {
    private int fineId;
    private int userId;
    private int transactionId;
    private BigDecimal amount;
    private LocalDate issuedDate;
    private LocalDate paidDate;
    private FineStatus status;

    // Enums for fine status
    public enum FineStatus {
        PAID, UNPAID
    }

    // Constructor for new fines
    public Fine(int userId, int transactionId, BigDecimal amount,
                LocalDate issuedDate) {
        this.userId = userId;
        this.transactionId = transactionId;
        this.amount = amount;
        this.issuedDate = issuedDate;
        this.status = FineStatus.UNPAID; // Default status
    }

    // Full constructor (for database retrieval)
    public Fine(int fineId, int userId, int transactionId, BigDecimal amount,
                LocalDate issuedDate, LocalDate paidDate, FineStatus status) {
        this.fineId = fineId;
        this.userId = userId;
        this.transactionId = transactionId;
        this.amount = amount;
        this.issuedDate = issuedDate;
        this.paidDate = paidDate;
        this.status = status;
    }

    // Getters/Setters
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

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public LocalDate getIssuedDate() {
        return issuedDate;
    }

    public void setIssuedDate(LocalDate issuedDate) {
        this.issuedDate = issuedDate;
    }

    public LocalDate getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(LocalDate paidDate) {
        this.paidDate = paidDate;
    }

    public FineStatus getStatus() {
        return status;
    }

    public void setStatus(FineStatus status) {
        this.status = status;
    }

    // Helper to check if fine is paid
    public boolean isPaid() {
        return status == FineStatus.PAID;
    }
}