package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.ReservationDAO;
import com.libsquad.lms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "ReservationServlet", urlPatterns = {"/student/reservation"})
public class ReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        try {
            reservationDAO = new ReservationDAO();
            System.out.println("ReservationServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing ReservationServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error initializing servlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ReservationServlet doGet called");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("No active session found, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        System.out.println("Processing request for user: " + user.getUserId());

        try {
            var reservations = reservationDAO.getReservationsByUserId(user.getUserId());
            System.out.println("Found " + reservations.size() + " reservations");

            request.setAttribute("reservations", reservations);
            request.getRequestDispatcher("/WEB-INF/views/student/reservation.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Error loading reservations: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error loading reservations: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/student/reservation.jsp").forward(request, response);
        }
    }
}
