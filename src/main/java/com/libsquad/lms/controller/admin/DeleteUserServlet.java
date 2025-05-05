package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.UserDao;
import com.libsquad.lms.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteUserServlet", urlPatterns = "/admin/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    private final UserDao userDao = new UserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        processDeleteRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Redirect GET requests to POST to maintain consistency
        processDeleteRequest(request, response);
    }

    private void processDeleteRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            User currentUser = (User) request.getSession().getAttribute("user");
            String userIdParam = request.getParameter("userId");

            // Fallback to 'id' parameter if 'userId' is not present (for backward compatibility)
            if (userIdParam == null || userIdParam.isEmpty()) {
                userIdParam = request.getParameter("id");
            }

            if (userIdParam == null || userIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=User+ID+is+required");
                return;
            }

            int userId = Integer.parseInt(userIdParam);

            // Prevent self-deletion
            if (currentUser != null && currentUser.getUserId() == userId) {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=Cannot+delete+your+own+account");
                return;
            }

            boolean success = userDao.deleteUser(userId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/member?success=User+deleted+successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/member?error=Failed+to+delete+user");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/member?error=Invalid+user+ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/member?error=Error+deleting+user");
        }
    }
}