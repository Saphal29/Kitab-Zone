package com.libsquad.lms.controller.admin;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TransactionControlServlet", urlPatterns = "/admin/transactionControl")
public class TransactionControlServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            request.getRequestDispatcher("/WEB-INF/views/admin/transactionControl.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading transactionControl page ");
        }
    }
}