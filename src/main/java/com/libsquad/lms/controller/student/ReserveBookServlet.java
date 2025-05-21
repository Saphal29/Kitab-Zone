package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.BookDAO;
import com.libsquad.lms.dao.ReservationDAO;
import com.libsquad.lms.model.Book;
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
import java.time.LocalDateTime;

@WebServlet("/student/reserveBook")
public class ReserveBookServlet extends HttpServlet {
    private ReservationDAO reservationDAO;
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection conn = DatabaseConnectionUtil.getConnection();
            reservationDAO = new ReservationDAO();
            bookDAO = new BookDAO(conn);
        } catch (SQLException e) {
            throw new ServletException("Error initializing servlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try {
            Book book = bookDAO.findById(bookId).orElse(null);
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/student/browseBooks?error=Book+not+found");
                return;
            }

            // Check if book is already reserved by this user
            if (reservationDAO.hasActiveReservation(user.getUserId(), bookId)) {
                response.sendRedirect(request.getContextPath() + "/student/browseBooks?error=You+already+have+an+active+reservation+for+this+book");
                return;
            }

            // Create new reservation
            Reservation reservation = new Reservation();
            reservation.setUserId(user.getUserId());
            reservation.setBookId(bookId);
            reservation.setReservationDate(LocalDateTime.now());
            reservation.setStatus(Reservation.ReservationStatus.PENDING);
            reservation.setPriority(reservationDAO.getNextPriority(bookId));

            reservationDAO.createReservation(reservation);
            response.sendRedirect(request.getContextPath() + "/student/browseBooks?success=Book+reserved+successfully");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/student/browseBooks?error=Error+creating+reservation:+%20" + e.getMessage());
        }
    }
}