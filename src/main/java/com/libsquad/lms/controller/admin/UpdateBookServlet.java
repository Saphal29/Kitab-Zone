package com.libsquad.lms.controller.admin;

import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.Genre;
import com.libsquad.lms.service.BookService;
import com.libsquad.lms.utils.ValidationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "UpdateBookServlet", urlPatterns = "/admin/updateBook")
@MultipartConfig
public class UpdateBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String edition = request.getParameter("edition");
            String isbn = request.getParameter("isbn");
            Genre genre = Genre.valueOf(request.getParameter("genre"));
            int copies = Integer.parseInt(request.getParameter("copies"));
            Part filePart = request.getPart("coverImage");

            BookService bookService = new BookService();
            Book book = bookService.getBookById(bookId);

            // Update book details
            book.setTitle(title);
            book.setAuthor(author);
            book.setPublisher(publisher);
            book.setEdition(edition);
            book.setIsbn(isbn);
            book.setGenre(String.valueOf(genre));
            book.setTotalCopies(copies);

            // Handle cover image update
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = request.getServletContext().getRealPath("/uploads");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fullPath = uploadPath + File.separator + fileName;
                filePart.write(fullPath);

                // Save just the filename
                book.setCoverImage(fileName);
            }

            bookService.updateBook(book);

            response.sendRedirect(request.getContextPath() +
                    "/admin/books?success=Book+updated+successfully");

        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("genres", Genre.values());
            request.getRequestDispatcher("/WEB-INF/views/admin/editBook.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "System error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}