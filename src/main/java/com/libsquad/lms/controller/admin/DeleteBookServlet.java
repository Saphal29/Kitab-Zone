package com.libsquad.lms.controller.admin;

import com.libsquad.lms.service.BookService;
import com.libsquad.lms.utils.ValidationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "DeleteBookServlet", urlPatterns = "/admin/deleteBook")
public class DeleteBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String redirectURL = request.getContextPath() + "/admin/books";

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));

            try (BookService bookService = new BookService()) {
                bookService.deleteBook(bookId);
                session.setAttribute("success", "Book deleted successfully");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid book ID format");
        } catch (ValidationException e) {
            session.setAttribute("error", "Validation error: " + e.getMessage());
        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
        } catch (Exception e) {
            session.setAttribute("error", "Unexpected error: " + e.getMessage());
        }

        response.sendRedirect(redirectURL);
    }
}