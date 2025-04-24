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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");



        try {

            AuthService authService = new AuthService();
            User user = authService.authenticate(username, password);


            if (user != null) {
                //Creating a session and setting the user attribute
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                //creating Cookie to remember the user
                Cookie cookie = new Cookie("user", user.getUsername());
                cookie.setMaxAge(60*5);
                cookie.setPath("/");
                response.addCookie(cookie);

                //Redirecting the user based on Role
                if (user.isSuperAdmin() || user.isAdmin()) {
                    response.sendRedirect(request.getContextPath() + "/admin/adminDashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/student/studentDashboard");
                }

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