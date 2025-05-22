package com.libsquad.lms.controller.admin;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.Genre;
import com.libsquad.lms.service.BookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "BookListServlet", urlPatterns = "/admin/books")
public class BookListServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(BookListServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            BookService bookService = new BookService();
            List<Book> books = bookService.getAllBooks();

            String action = request.getParameter("action");
            String idParam = request.getParameter("id");

            if (action != null && action.equals("edit") && idParam != null) {
                try {
                    int bookId = Integer.parseInt(idParam);
                    Book bookToEdit = bookService.getBookById(bookId);
                    if (bookToEdit != null) {
                        request.setAttribute("bookToEdit", bookToEdit);
                        request.setAttribute("genres", Genre.values());
                        LOGGER.info("Forwarding to editBook.jsp for book ID: " + bookId);
                        request.getRequestDispatcher("/WEB-INF/views/admin/editBook.jsp")
                                .forward(request, response);
                        return;
                    } else {
                        LOGGER.warning("Book not found with ID: " + bookId);
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
                        return;
                    }
                } catch (NumberFormatException e) {
                    LOGGER.warning("Invalid book ID format: " + idParam);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID format");
                    return;
                }
            }

            request.setAttribute("books", books);
            request.setAttribute("genres", Genre.values());
            request.getRequestDispatcher("/WEB-INF/views/admin/bookList.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in BookListServlet", e);
            request.setAttribute("error", "Error retrieving books: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}