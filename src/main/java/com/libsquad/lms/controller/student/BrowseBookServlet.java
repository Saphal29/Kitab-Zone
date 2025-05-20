package com.libsquad.lms.controller.student;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.service.BookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name="BrowseBookServlet", urlPatterns="/student/browseBooks")
public class BrowseBookServlet extends HttpServlet {
    private final BookService bookService = new BookService();

    public BrowseBookServlet() throws SQLException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get all books from database
            List<Book> books = bookService.getAllBooks();

            // Set books as request attribute
            request.setAttribute("books", books);

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/student/browseBooks.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading books: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/student/browseBooks.jsp").forward(request, response);
        }
    }
}