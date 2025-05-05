package com.libsquad.lms.controller.admin;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.Genre;
import com.libsquad.lms.service.BookService;
import com.libsquad.lms.utils.FileUtil;
import com.libsquad.lms.utils.ValidationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "AddBookServlet", urlPatterns = "/admin/addBook")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class AddBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("genres", Book.Genre.values());
            request.getRequestDispatcher("/WEB-INF/views/admin/addBook.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading form: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String title = getParameter(request, "title");
            String author = getParameter(request, "author");
            String publisher = getParameter(request, "publisher");
            String edition = getParameter(request, "edition");
            String isbn = getParameter(request, "isbn");
            Genre genre = Genre.valueOf(getParameter(request, "genre"));
            int copies = Integer.parseInt(getParameter(request, "copies"));
            Part filePart = request.getPart("coverImage");

            Book book = new Book(
                    title, author, publisher,
                    edition, isbn, genre, copies
            );

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = FileUtil.saveUploadedFile(filePart);
                book.setCoverImage(fileName);
            }

            new BookService().createBook(book);

            response.sendRedirect(request.getContextPath() +
                    "/admin/adminDashboard?success=Book+added+successfully");

        } catch (ValidationException | IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("genres", Book.Genre.values());
            preserveFormParameters(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/addBook.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "System error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String getParameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value != null ? value.trim() : "";
    }

    private void preserveFormParameters(HttpServletRequest request) {
        String[] params = {"title", "author", "publisher", "edition", "isbn", "copies"};
        for (String param : params) {
            request.setAttribute(param, request.getParameter(param));
        }
    }
}