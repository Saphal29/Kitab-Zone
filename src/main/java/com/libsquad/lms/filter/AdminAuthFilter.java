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

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Block unauthorized access
        if (user == null || (!user.isAdmin() && !user.isSuperAdmin())) {
            res.sendRedirect(req.getContextPath() + "/access-denied");
            return;
        }

        chain.doFilter(request, response);
    }
}