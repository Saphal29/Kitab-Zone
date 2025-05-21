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

@WebServlet("/student/reservation/cancel")
public class CancelReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        try {
            reservationDAO = new ReservationDAO();
        } catch (Exception e) {
            throw new ServletException("Error initializing servlet", e);
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
        String reservationIdStr = request.getParameter("reservationId");

        try {
            int reservationId = Integer.parseInt(reservationIdStr);
            reservationDAO.cancelReservation(reservationId, "Cancelled by user");
            response.sendRedirect(request.getContextPath() + "/student/reservation?success=Reservation+cancelled+successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/reservation?error=Invalid+reservation+ID");
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/student/reservation?error=Error+cancelling+reservation:+%20" + e.getMessage());
        }
    }
}