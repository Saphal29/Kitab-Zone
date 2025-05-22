package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.UserDao;
import com.libsquad.lms.model.User;
import com.libsquad.lms.model.UserRole;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "EditUserServlet", value = {"/admin/editUser", "/admin/updateUser"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5,    // 5 MB
        maxRequestSize = 1024 * 1024 * 10  // 10 MB
)
public class EditUserServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = userDao.getUserById(userId);

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/editUser.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=User+not+found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/member?error=Error+editing+user");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            User existingUser = userDao.getUserById(userId);

            if (existingUser == null) {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=User+not+found");
                return;
            }

            // Handle profile picture upload
            Part filePart = request.getPart("profilePic");
            if (filePart != null && filePart.getSize() > 0) {
                String uploadDir = getServletContext().getRealPath("/uploads");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = UUID.randomUUID() + "-" + filePart.getSubmittedFileName();
                filePart.write(uploadDir + File.separator + fileName);
                existingUser.setProfilePic(fileName);  // Store only the filename
            }

            // Update user details
            existingUser.setFullName(request.getParameter("fullName"));
            existingUser.setUsername(request.getParameter("username"));
            existingUser.setEmail(request.getParameter("email"));
            existingUser.setPhone(request.getParameter("phone"));
            existingUser.setRole(UserRole.valueOf(request.getParameter("role")));

            // Only update password if a new one was provided
            String newPassword = request.getParameter("password");
            if (newPassword != null && !newPassword.isEmpty()) {
                existingUser.setPassword(newPassword); // Note: Hash in production
            }

            boolean success = userDao.updateUser(existingUser);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/member?success=User+updated+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=Failed+to+update+user");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/member?error=Error+updating+user: " + e.getMessage());
        }
    }
}
