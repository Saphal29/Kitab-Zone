package com.libsquad.lms.controller.admin;

import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.model.Transaction;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/transactionControl")
public class TransactionControlServlet extends HttpServlet {
    private TransactionDAO transactionDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conn = DatabaseConnectionUtil.getConnection();
            transactionDAO = new TransactionDAO(conn);
            List<Transaction> transactions = transactionDAO.getAllTransactions();
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("/WEB-INF/views/admin/transactionControl.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading transactions");
        }
    }
}