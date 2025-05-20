package com.libsquad.lms.controller.student;


import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Transaction;
import com.libsquad.lms.model.User;

import com.libsquad.lms.service.BookService;
import com.libsquad.lms.utils.DatabaseConnectionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/student/processBorrow")
public class BorrowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String redirectURL = request.getContextPath() + "/student/browseBooks";

        try {
            // 1. Get book ID
            int bookId = Integer.parseInt(request.getParameter("bookId"));

            // 2. Check availability
            BookService bookService = new BookService();
            Book book = bookService.getBookById(bookId);

            if (book.getAvailableCopies() <= 0) {
                response.sendRedirect(redirectURL + "?error=Book+not+available");
                return;
            }

            // 3. Create transaction
            TransactionDAO transactionDAO = new TransactionDAO(DatabaseConnectionUtil.getConnection());
            LocalDate borrowDate = LocalDate.now();

            Transaction transaction = new Transaction(
                    0,
                    user.getUserId(),
                    bookId,
                    Date.valueOf(borrowDate),
                    Date.valueOf(borrowDate.plusDays(14)),
                    null,
                    "BORROWED"
            );

            // 4. Process borrow
            if (transactionDAO.insertTransaction(transaction)) {
                bookService.decrementAvailableCopies(bookId);
                response.sendRedirect(redirectURL + "?success=Book+borrowed+successfully");
            } else {
                response.sendRedirect(redirectURL + "?error=Borrow+failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(redirectURL + "?error=Invalid+book+ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(redirectURL + "?error=Error+processing+request");
        }
    }
}