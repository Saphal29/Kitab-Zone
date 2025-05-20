package com.libsquad.lms.controller.student;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.service.BookService;
import com.libsquad.lms.utils.ValidationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/student/borrowBook")
public class ShowBorrowPageServlet extends HttpServlet {
    private BookService bookService;
    private static final Logger LOG = Logger.getLogger(ShowBorrowPageServlet.class.getName());

    @Override
    public void init() throws ServletException {
        try {
            bookService = new BookService();
        } catch (SQLException e) {
            LOG.log(Level.SEVERE, "Failed to initialize BookService", e);
            throw new ServletException("Failed to initialize BookService", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String bookIdParam = request.getParameter("bookId");
        String redirectURL = request.getContextPath() + "/student/browseBooks";

        try {
            if (bookIdParam == null || bookIdParam.isEmpty()) {
                session.setAttribute("error", "Missing book ID");
                response.sendRedirect(redirectURL);
                return;
            }

            int bookId = Integer.parseInt(bookIdParam);
            Book book = bookService.getBookById(bookId);

            request.setAttribute("book", book);
            request.getRequestDispatcher("/WEB-INF/views/student/borrowBook.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            LOG.log(Level.SEVERE, "Invalid book ID format: {0}", bookIdParam);
            session.setAttribute("error", "Invalid book ID format");
            response.sendRedirect(redirectURL);
        } catch (ValidationException e) {
            LOG.log(Level.WARNING, "Book not found: {0}", bookIdParam);
            session.setAttribute("error", "Book not found: " + e.getMessage());
            response.sendRedirect(redirectURL);
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Error loading book", e);
            session.setAttribute("error", "Error loading book details");
            response.sendRedirect(redirectURL);
        }
    }

    @Override
    public void destroy() {
        try {
            if (bookService != null) {
                bookService.close();
            }
        } catch (SQLException e) {
            LOG.log(Level.SEVERE, "Error closing BookService", e);
        }
    }
}