package com.libsquad.lms.filter;

import com.libsquad.lms.model.User;
import com.libsquad.lms.model.UserRole;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AdminAuthFilter", urlPatterns = {"/admin/*", "/reports"})
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Log the request for debugging
        System.out.println("AdminAuthFilter: Processing request to " + req.getRequestURI());

        if (session == null || session.getAttribute("user") == null) {
            System.out.println("AdminAuthFilter: No session or user found, redirecting to login");
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        System.out.println("AdminAuthFilter: User role: " + user.getRole());

        if (user.isSuperAdmin() || user.isAdmin()) {
            // Let request proceed for Admins/SuperAdmins
            System.out.println("AdminAuthFilter: Access granted for admin user");
            chain.doFilter(request, response);
        } else {
            // Deny access to non-admins
            System.out.println("AdminAuthFilter: Access denied for non-admin user");
            res.sendRedirect(req.getContextPath() + "/access-denied");
        }
    }
}
