package com.libsquad.lms.controller.admin;

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

@WebServlet("/admin/fines")
public class AdminFinesServlet extends HttpServlet {
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
        if (!user.getRole().equals("ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/student/studentDashboard");
            return;
        }

        try {
            List<Fine> fines = fineDAO.getAllFines();
            request.setAttribute("fines", fines);
            request.getRequestDispatcher("/WEB-INF/views/admin/fineManagement.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading fines: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/fineManagement.jsp").forward(request, response);
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
        if (!user.getRole().equals("ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/student/studentDashboard");
            return;
        }

        String action = request.getParameter("action");
        int fineId = Integer.parseInt(request.getParameter("fineId"));

        try {
            switch (action) {
                case "pay":
                    fineDAO.markAsPaid(fineId);
                    request.setAttribute("success", "Fine marked as paid successfully");
                    break;
                case "waive":
                    String notes = request.getParameter("notes");
                    fineDAO.waiveFine(fineId, user.getUserId(), notes);
                    request.setAttribute("success", "Fine waived successfully");
                    break;
                case "cancel":
                    fineDAO.cancelFine(fineId);
                    request.setAttribute("success", "Fine cancelled successfully");
                    break;
                default:
                    request.setAttribute("error", "Invalid action");
            }

            response.sendRedirect(request.getContextPath() + "/admin/fines");
        } catch (SQLException e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/fineManagement.jsp").forward(request, response);
        }
    }
}