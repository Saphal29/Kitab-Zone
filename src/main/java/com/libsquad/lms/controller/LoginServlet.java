package com.libsquad.lms.controller;

import com.libsquad.lms.model.User;
import com.libsquad.lms.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    // Handle GET requests (loading the login page)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            AuthService authService = new AuthService();
            User user = authService.authenticate(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                // Store both user object and user ID
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId()); // Add this line

                // Cookie logic remains the same
                Cookie cookie = new Cookie("user", user.getUsername());
                cookie.setMaxAge(60*50);
                cookie.setPath("/");
                response.addCookie(cookie);

                // Redirect based on role
                String redirectPath = (user.isSuperAdmin() || user.isAdmin())
                        ? "/admin/adminDashboard"
                        : "/student/studentDashboard";
                response.sendRedirect(request.getContextPath() + redirectPath);
                return;
            } else {
                request.setAttribute("error", "Invalid credentials");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        }
    }


    private void handleInvalidRole(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException, ServletException {
        session.invalidate();
        request.setAttribute("error", "Your account has an invalid role configuration");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private void handleInvalidCredentials(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("error", "Invalid username or password");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private void handleDatabaseError(HttpServletRequest request, HttpServletResponse response, SQLException e)
            throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("error", "Database error occurred. Please try again later.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}