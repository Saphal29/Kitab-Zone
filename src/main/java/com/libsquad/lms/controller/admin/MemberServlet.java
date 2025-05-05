package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.UserDao;
import com.libsquad.lms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MemberServlet", urlPatterns = "/admin/member")
public class MemberServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Forward to add user page
            request.getRequestDispatcher("/WEB-INF/views/admin/addUser.jsp").forward(request, response);
        } else {
            // Existing member listing logic
            try {
                User currentUser = (User) request.getSession().getAttribute("user");
                List<User> allUsers = userDao.getAllUsers();

                request.setAttribute("users", allUsers);
                request.setAttribute("currentUserId", currentUser != null ? currentUser.getUserId() : -1);

                request.getRequestDispatcher("/WEB-INF/views/admin/member.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Error loading user data from database");
            }
        }
    }
}