package com.libsquad.lms.service;
import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.model.Transaction;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Date; // <-- use java.sql.Date here
import java.time.LocalDate;
import java.util.Calendar;

public class TransactionService {
    private TransactionDAO transactionDAO;

    public TransactionService(Connection conn) {
        this.transactionDAO = new TransactionDAO(conn);
    }

    public boolean borrowBook(int userId, int bookId) throws SQLException {
        if (!transactionDAO.isBookAvailable(bookId)) {
            return false;
        }

        Transaction transaction = new Transaction();
        transaction.setUserId(userId);
        transaction.setBookId(bookId);

        java.util.Date todayUtil = new java.util.Date();
        Date today = new Date(todayUtil.getTime()); // convert to java.sql.Date
        transaction.setBorrowDate(today);

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(todayUtil);
        calendar.add(Calendar.DAY_OF_MONTH, 14); // 2 weeks due
        Date dueDate = new Date(calendar.getTimeInMillis()); // convert to java.sql.Date
        transaction.setDueDate(dueDate);

        transaction.setStatus("BORROWED");

        return transactionDAO.borrowBook(transaction);
    }

    public boolean returnBook(int transactionId) throws SQLException {
        // Convert LocalDate.now() to java.sql.Date
        Date todaySqlDate = Date.valueOf(LocalDate.now());
        return transactionDAO.returnBook(transactionId, todaySqlDate);
    }
}
