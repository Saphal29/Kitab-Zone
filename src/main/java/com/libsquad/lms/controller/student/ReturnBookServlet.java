package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.BookDAO;
import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/student/returnBook")
public class ReturnBookServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ReturnBookServlet.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String transactionIdParam = request.getParameter("transactionId");
        String redirectURL = request.getContextPath() + "/student/myBooks";

        if (transactionIdParam == null || transactionIdParam.isEmpty()) {
            session.setAttribute("error", "Invalid request");
            response.sendRedirect(redirectURL);
            return;
        }

        Connection conn = null;
        try {
            // 1. Get database connection and start transaction
            conn = DatabaseConnectionUtil.getConnection();
            conn.setAutoCommit(false);

            // 2. Parse transaction ID
            int transactionId = Integer.parseInt(transactionIdParam);
            Date returnDate = Date.valueOf(LocalDate.now());

            // 3. Initialize DAOs
            TransactionDAO transactionDAO = new TransactionDAO(conn);
            BookDAO bookDAO = new BookDAO(conn);

            // 4. Update transaction status
            boolean transactionUpdated = transactionDAO.returnBook(transactionId, returnDate);
            if (!transactionUpdated) {
                conn.rollback();
                session.setAttribute("error", "Failed to update transaction");
                response.sendRedirect(redirectURL);
                return;
            }

            // 5. Get book ID from transaction
            int bookId = transactionDAO.getBookIdByTransaction(transactionId);

            // 6. Update book availability
            bookDAO.incrementAvailableCopies(bookId);

            // 7. Commit transaction
            conn.commit();
            session.setAttribute("success", "Book returned successfully");

        } catch (NumberFormatException e) {
            handleError(conn, session, "Invalid transaction ID format", redirectURL, e);
        } catch (SQLException e) {
            handleError(conn, session, "Database error", redirectURL, e);
        } catch (Exception e) {
            handleError(conn, session, "Error processing return", redirectURL, e);
        } finally {
            closeConnection(conn);
        }

        response.sendRedirect(redirectURL);
    }

    private void handleError(Connection conn, HttpSession session, String message,
                             String redirectURL, Exception e) {
        try {
            if (conn != null) conn.rollback();
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Rollback failed", ex);
        }
        LOGGER.log(Level.SEVERE, message, e);
        session.setAttribute("error", message);
    }

    private void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.setAutoCommit(true); // Reset auto-commit mode
                conn.close();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error closing connection", e);
        }
    }
}