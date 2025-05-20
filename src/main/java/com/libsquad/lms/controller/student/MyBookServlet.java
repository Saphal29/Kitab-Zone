package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.model.Transaction;
import com.libsquad.lms.model.User;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/student/myBooks")
public class MyBookServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(MyBookServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get existing session, don't create new
        String redirectURL = request.getContextPath() + "/login";

        // Check for valid session
        if (session == null) {
            LOGGER.warning("No session found - redirecting to login");
            response.sendRedirect(redirectURL);
            return;
        }

        User user = (User) session.getAttribute("user");
        LOGGER.info("Session user: " + (user != null ? user.getUsername() : "null"));

        if (user == null) {
            LOGGER.warning("user not found in session - redirecting to login");
            response.sendRedirect(redirectURL);
            return;
        }

        try (Connection conn = DatabaseConnectionUtil.getConnection()) {
            TransactionDAO transactionDAO = new TransactionDAO(conn);
            List<Transaction> transactions = transactionDAO.getBorrowedBooksByUser(user.getUserId());

            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("/WEB-INF/views/student/myBooks.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error fetching borrowed books for user: " + user.getUserId(), e);
            session.setAttribute("error", "Error retrieving your books. Please try again later.");
            response.sendRedirect(redirectURL);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in MyBookServlet", e);
            session.setAttribute("error", "An unexpected error occurred.");
            response.sendRedirect(redirectURL);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Or handle POST separately
    }
}
