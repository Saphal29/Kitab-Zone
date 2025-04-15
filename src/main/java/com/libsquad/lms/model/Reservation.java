package com.libsquad.lms.model;

import java.time.LocalDateTime;

public class Reservation {
    private int reservationId;
    private int userId;
    private int bookId;
    private LocalDateTime reservationDate;
    private ReservationStatus status;

    // Enums for reservation status
    public enum ReservationStatus {
        PENDING, APPROVED, DENIED
    }

    // Constructor for new reservations
    public Reservation(int userId, int bookId) {
        this.userId = userId;
        this.bookId = bookId;
        this.status = ReservationStatus.PENDING; // Default status
    }

    // Full constructor (for database retrieval)
    public Reservation(int reservationId, int userId, int bookId,
                       LocalDateTime reservationDate, ReservationStatus status) {
        this.reservationId = reservationId;
        this.userId = userId;
        this.bookId = bookId;
        this.reservationDate = reservationDate;
        this.status = status;
    }

    // Getters/Setters


    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
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

    public ReservationStatus getStatus() {
        return status;
    }

    public void setStatus(ReservationStatus status) {
        this.status = status;
    }

    // Status check helpers
    public boolean isPending() {
        return status == ReservationStatus.PENDING;
    }
}