package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.UserDao;
import com.libsquad.lms.model.User;
import com.libsquad.lms.model.UserRole;
import com.libsquad.lms.utils.HashPasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddUserServlet", urlPatterns = "/admin/addUser")
public class AddUserServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form parameters
            String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            UserRole role = UserRole.valueOf(request.getParameter("role"));

            // Hash password
            String hashedPassword = HashPasswordUtil.hashPassword(password);

            // Create user object
            User newUser = new User(
                    username,
                    hashedPassword,
                    role,
                    fullName,
                    email,
                    phone != null ? phone : "",
                    address != null ? address : "",
                    "default.png" // Default profile picture
            );

            // Save to database
            int userId = userDao.createUser(newUser);

            if (userId > 0) {
                response.sendRedirect(request.getContextPath() + "/admin/member?success=User+created+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=Failed+to+create+user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/member?error=Error+creating+user: " + e.getMessage());
        }
    }
}