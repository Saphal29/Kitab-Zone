package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.FineDAO;
import com.libsquad.lms.model.Fine;
import com.libsquad.lms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/student/fines")
public class StudentFinesServlet extends HttpServlet {
    private FineDAO fineDAO;

    @Override
    public void init() throws ServletException {
        try {
            fineDAO = new FineDAO();
        } catch (Exception e) {
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

        try {
            List<Fine> fines = fineDAO.getFinesByUserId(user.getUserId());
            request.setAttribute("fines", fines);
            request.getRequestDispatcher("/WEB-INF/views/student/fines.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading fines: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/student/fines.jsp").forward(request, response);
        }
    }
}