package com.libsquad.lms.controller;

import com.libsquad.lms.model.User;
import com.libsquad.lms.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "HomeServlet", urlPatterns = {"/", "/home"})
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean redirected = false;

        // Check if there is user cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user".equals(cookie.getName())) {
                    String username = cookie.getValue();

                    try {
                        UserDao userDao = new UserDao();
                        User user = userDao.getUserByUsername(username);
                        if (user != null) {
                            // Creating new session
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user);

                            // Redirect based on Role
                            if (user.isSuperAdmin() || user.isAdmin()) {
                                response.sendRedirect(request.getContextPath() + "/admin/adminDashboard");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/student/studentDashboard");
                            }

                            redirected = true;

                            break; // Stop looping cookies
                        }

                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                }
            }
        }

        // If not redirected, show home.jsp
        if (!redirected) {
            request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
        }
    }
}
