package com.libsquad.lms.model;

import java.time.LocalDate;

public class Transaction {
    private int transactionId;
    private int userId;
    private int bookId;
    private LocalDate issueDate;
    private LocalDate dueDate;
    private LocalDate returnDate;
    private TransactionStatus status;

    // Enums for transaction status
    public enum TransactionStatus {
        ISSUED, RETURNED
    }

    // Constructor for issuing a book
    public Transaction(int userId, int bookId, LocalDate issueDate,
                       LocalDate dueDate) {
        this.userId = userId;
        this.bookId = bookId;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.status = TransactionStatus.ISSUED; // Default status
    }

    // Full constructor (for database retrieval)
    public Transaction(int transactionId, int userId, int bookId,
                       LocalDate issueDate, LocalDate dueDate,
                       LocalDate returnDate, TransactionStatus status) {
        this.transactionId = transactionId;
        this.userId = userId;
        this.bookId = bookId;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.status = status;
    }

    // Getters/Setters


    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
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

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public TransactionStatus getStatus() {
        return status;
    }

    public void setStatus(TransactionStatus status) {
        this.status = status;
    }

    // Helper to check if transaction is overdue
    public boolean isOverdue() {
        return LocalDate.now().isAfter(dueDate) && status != TransactionStatus.RETURNED;
    }
}