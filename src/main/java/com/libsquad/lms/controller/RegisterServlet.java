package com.libsquad.lms.controller;

import com.libsquad.lms.model.User;
import com.libsquad.lms.service.AuthService;
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

@WebServlet("/register")
@MultipartConfig // Required for file uploads
public class RegisterServlet extends HttpServlet {
    private final AuthService authService = new AuthService();

    // Handle GET requests (display registration form)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Handle profile picture upload
            Part filePart = request.getPart("profilePic");
            String profilePicPath = null;

            if (filePart != null && filePart.getSize() > 0) {
                String uploadDir = getServletContext().getRealPath("/uploads");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = UUID.randomUUID() + "-" + filePart.getSubmittedFileName();
                filePart.write(uploadDir + File.separator + fileName);
                profilePicPath = "/uploads/" + fileName;
            }

            // Create user with all fields
            User newUser = authService.registerStudent(
                    request.getParameter("username"),
                    request.getParameter("password"),
                    request.getParameter("fullName"),
                    request.getParameter("email"),
                    request.getParameter("phone"),
                    request.getParameter("address"),
                    profilePicPath
            );

            request.getSession().setAttribute("success", "Registration successful!");
            response.sendRedirect("login");

        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}
