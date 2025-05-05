package com.libsquad.lms.controller.student;

import com.libsquad.lms.dao.BookDAO;
import com.libsquad.lms.dao.TransactionDAO;
import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@WebServlet("/student/borrowBook")
public class BorrowBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login");
            return;
        }

        int bookId = Integer.parseInt(request.getParameter("bookId")); // Changed from book_id to bookId

        try {
            // Get book details
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.findById(bookId).orElseThrow(
                    () -> new ServletException("Book not found"));

            // Check if book is available
            if (!book.isAvailable()) {
                session.setAttribute("error", "Book is not available for borrowing");
                response.sendRedirect("browseBooks");
                return;
            }

            // Create transaction record
            Transaction transaction = new Transaction();
            transaction.setUserId(userId);
            transaction.setBookId(bookId);
            transaction.setCheckoutDate(LocalDateTime.now());
            transaction.setDueDate(LocalDateTime.now().plus(14, ChronoUnit.DAYS));
            transaction.setStatus(Transaction.Status.ACTIVE);

            // Save to database
            TransactionDAO transactionDAO = new TransactionDAO();
            transactionDAO.create(transaction);

            // Update book status and copies
            book.setTotalCopies(book.getTotalCopies() - 1);
            if (book.getTotalCopies() <= 0) {
                book.setStatus(Book.BookStatus.RESERVED);
            }
            bookDAO.update(book);

            // After successful borrow
            session.setAttribute("success", "Book borrowed successfully!");
            response.sendRedirect(request.getContextPath() + "/student/myBooks");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error borrowing book: " + e.getMessage());
            response.sendRedirect("browseBooks");
        }
    }
}