package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.ReservationDAO;
import com.libsquad.lms.model.Reservation;
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

@WebServlet(name = "ReservationManagementServlet", urlPatterns = "/admin/reservationManagement")
public class ReservationManagementServlet extends HttpServlet {
    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DatabaseConnectionUtil.getConnection();
            reservationDAO = new ReservationDAO(conn);
            System.out.println("ReservationManagementServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing ReservationManagementServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error initializing servlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ReservationManagementServlet: Processing GET request");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("ReservationManagementServlet: No session or user found, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!user.isAdmin() && !user.isSuperAdmin()) {
            System.out.println("ReservationManagementServlet: User is not admin, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            System.out.println("ReservationManagementServlet: Fetching all reservations");
            List<Reservation> reservations = reservationDAO.getAllReservations();
            System.out.println("ReservationManagementServlet: Found " + reservations.size() + " reservations");

            request.setAttribute("reservations", reservations);
            System.out.println("ReservationManagementServlet: Forwarding to JSP");
            request.getRequestDispatcher("/WEB-INF/views/admin/reservationManagement.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("ReservationManagementServlet: Error loading reservations: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading reservations: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/reservationManagement.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ReservationManagementServlet: Unexpected error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/reservationManagement.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        String action = request.getParameter("action");
        String reservationIdStr = request.getParameter("reservationId");
        String reason = request.getParameter("reason");

        try {
            int reservationId = Integer.parseInt(reservationIdStr);

            switch (action) {
                case "approve":
                    reservationDAO.approveReservation(reservationId, user.getUserId());
                    response.sendRedirect(request.getContextPath() + "/admin/reservationManagement?success=Reservation+approved+successfully");
                    break;
                case "reject":
                    reservationDAO.cancelReservation(reservationId, reason != null ? reason : "Rejected by admin");
                    response.sendRedirect(request.getContextPath() + "/admin/reservationManagement?success=Reservation+rejected+successfully");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/reservationManagement?error=Invalid+action");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/reservationManagement?error=Invalid+reservation+ID");
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/admin/reservationManagement?error=Error+processing+reservation:+%20" + e.getMessage());
        }
    }
}