package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.dao.ReservationDAO;
import com.libsquad.lms.dao.FineDAO;
import com.libsquad.lms.model.User;
import com.libsquad.lms.model.Transaction;
import com.libsquad.lms.model.Reservation;
import com.libsquad.lms.model.Fine;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "StudentDashboardServlet", urlPatterns = "/student/studentDashboard")
public class StudentDashboardServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(StudentDashboardServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            LOGGER.info("No session or user found, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        LOGGER.info("Loading dashboard for user: " + user.getUserId());

        try (Connection conn = DatabaseConnectionUtil.getConnection()) {
            // Initialize DAOs
            TransactionDAO transactionDAO = new TransactionDAO(conn);
            ReservationDAO reservationDAO = new ReservationDAO();
            FineDAO fineDAO = new FineDAO(conn);

            // Get borrowed books
            List<Transaction> borrowedBooks = transactionDAO.getBorrowedBooksByUser(user.getUserId());
            request.setAttribute("borrowedBooksList", borrowedBooks);
            request.setAttribute("borrowedBooks", borrowedBooks.size());
            LOGGER.info("Found " + borrowedBooks.size() + " borrowed books");

            // Get active reservations
            List<Reservation> activeReservations = reservationDAO.getReservationsByUserId(user.getUserId());
            request.setAttribute("activeReservationsList", activeReservations);
            request.setAttribute("activeReservations", activeReservations.size());
            LOGGER.info("Found " + activeReservations.size() + " active reservations");

            // Get overdue books
            int overdueBooks = (int) borrowedBooks.stream()
                    .filter(transaction -> transaction.getDueDate().toLocalDate().isBefore(LocalDate.now()))
                    .count();
            request.setAttribute("overdueBooks", overdueBooks);
            LOGGER.info("Found " + overdueBooks + " overdue books");

            // Get pending fines
            List<Fine> fines = fineDAO.getFinesByUserId(user.getUserId());
            double pendingFines = fines.stream()
                    .filter(fine -> fine.getStatus() == Fine.FineStatus.PENDING)
                    .mapToDouble(fine -> fine.getAmount().doubleValue())
                    .sum();
            request.setAttribute("pendingFines", pendingFines);
            LOGGER.info("Found pending fines: $" + pendingFines);

            // Set user attribute for the JSP
            request.setAttribute("user", user);

            // Forward to JSP
            String jspPath = "/WEB-INF/views/student/studentDashboard.jsp";
            LOGGER.info("Forwarding to JSP: " + jspPath);
            request.getRequestDispatcher(jspPath).forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading dashboard data", e);
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/student/studentDashboard.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in dashboard", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
        }
    }
}