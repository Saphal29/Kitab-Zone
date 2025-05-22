package com.libsquad.lms.controller.admin;

import com.libsquad.lms.model.Book;

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

@WebServlet(name = "AddBookServlet", urlPatterns = "/admin/addBook")
@MultipartConfig
public class AddBookServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            String edition = request.getParameter("edition");
            String isbn = request.getParameter("isbn");
            Book.Genre genre = Book.Genre.valueOf(request.getParameter("genre"));
            int copies = Integer.parseInt(request.getParameter("copies"));
            Part filePart = request.getPart("coverImage");

            // Assuming you get description from the form (or set to empty string if no description input)
            String description = request.getParameter("description");
            if (description == null) description = "";

// Use copies for both totalCopies and availableCopies initially
            Book book = new Book(
                    title, author, publisher,
                    edition, isbn, genre,
                    copies, copies,
                    description
            );


            if (filePart != null && filePart.getSize() > 0) {
                // Get file name
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                // Get real path to /uploads directory
                String uploadPath = request.getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs(); // Create folder if not exists
                }

                // Write file to disk
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                // Save just the filename in DB
                book.setCoverImage(fileName);
            }

            new BookService().createBook(book);

            response.sendRedirect(request.getContextPath() +
                    "/admin/books?success=Book+added+successfully");

        } catch (ValidationException | IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("genres", Book.Genre.values());
            request.getRequestDispatcher("/WEB-INF/views/admin/bookList.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "System error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
