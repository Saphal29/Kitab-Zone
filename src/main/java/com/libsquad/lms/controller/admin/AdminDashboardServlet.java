package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.UserDao;
import com.libsquad.lms.dao.BookDAO;
import com.libsquad.lms.dao.ReservationDAO;
import com.libsquad.lms.dao.FineDAO;
import com.libsquad.lms.model.User;
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
import java.util.List;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = "/admin/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {
    private UserDao userDao;
    private BookDAO bookDAO;
    private ReservationDAO reservationDAO;
    private FineDAO fineDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DatabaseConnectionUtil.getConnection();
            userDao = new UserDao();
            bookDAO = new BookDAO(conn);
            reservationDAO = new ReservationDAO(conn);
            fineDAO = new FineDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Error initializing servlet", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isAdmin() && !user.isSuperAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get total members (excluding admins)
            int totalMembers = userDao.getTotalMembers();
            request.setAttribute("totalMembers", totalMembers);

            // Get total books
            int totalBooks = bookDAO.getTotalBooks();
            request.setAttribute("totalBooks", totalBooks);

            // Get active reservations
            int activeReservations = reservationDAO.getActiveReservationsCount();
            request.setAttribute("activeReservations", activeReservations);

            // Get pending fines total
            double pendingFines = fineDAO.getTotalPendingFines();
            request.setAttribute("pendingFines", pendingFines);

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard data");
        }
    }
}