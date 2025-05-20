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

@WebServlet(name = "BookListServlet", urlPatterns = "/admin/books")
public class BookListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            BookService bookService = new BookService();
            List<Book> books = bookService.getAllBooks();

            String action = request.getParameter("action");
            int bookId = 0;

            if (action != null && action.equals("edit")) {
                bookId = Integer.parseInt(request.getParameter("id"));
                Book bookToEdit = bookService.getBookById(bookId);
                request.setAttribute("bookToEdit", bookToEdit);
            }

            request.setAttribute("books", books);
            request.setAttribute("genres", Genre.values());
            request.getRequestDispatcher("/WEB-INF/views/admin/bookList.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error retrieving books: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}