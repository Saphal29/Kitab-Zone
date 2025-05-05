package com.libsquad.lms.service;

import com.libsquad.lms.dao.BookDAO;
import com.libsquad.lms.model.Book;
import com.libsquad.lms.model.Book.BookStatus;
import com.libsquad.lms.utils.ValidationException;
import java.time.LocalDateTime;
import java.util.List;

public class BookService {
    private final BookDAO bookDao;

    public BookService() {
        this.bookDao = new BookDAO();
    }

    public void createBook(Book book) throws ValidationException {
        validateBook(book);
        book.setAddedDate(LocalDateTime.now());
        book.setStatus(BookStatus.AVAILABLE);
        bookDao.create(book);
    }

    public void updateBook(Book book) throws ValidationException {
        validateBook(book);
        bookDao.update(book);
    }

    public void deleteBook(int bookId) throws ValidationException {
        if (!bookDao.exists(bookId)) {
            throw new ValidationException("Book not found with ID: " + bookId);
        }
        bookDao.delete(bookId);
    }

    public Book getBookById(int bookId) throws ValidationException {
        return bookDao.findById(bookId)
                .orElseThrow(() -> new ValidationException("Book not found with ID: " + bookId));
    }

    public List<Book> getAllBooks() {
        return bookDao.findAll();
    }

    public List<Book> searchBooks(String query) {
        return bookDao.search(query);
    }

    public void updateStock(int bookId, int quantityChange) throws ValidationException {
        Book book = getBookById(bookId);
        int newQuantity = book.getTotalCopies() + quantityChange;  // Changed 'copies' to 'totalCopies'

        if (newQuantity < 0) {
            throw new ValidationException("Invalid stock adjustment");
        }

        book.setTotalCopies(newQuantity);  // Changed 'copies' to 'totalCopies'
        updateStockStatus(book);
        bookDao.update(book);
    }

    private void validateBook(Book book) throws ValidationException {
        if (book.getTitle() == null || book.getTitle().trim().isEmpty()) {
            throw new ValidationException("Title is required");
        }

        if (book.getAuthor() == null || book.getAuthor().trim().isEmpty()) {
            throw new ValidationException("Author is required");
        }

        if (book.getGenre() == null) {
            throw new ValidationException("Genre is required");
        }

        if (book.getTotalCopies() < 0) {  // Changed 'copies' to 'totalCopies'
            throw new ValidationException("Number of copies cannot be negative");
        }
    }

    private void updateStockStatus(Book book) {
        if (book.getTotalCopies() == 0) {  // Changed 'copies' to 'totalCopies'
            book.setStatus(BookStatus.RESERVED);
        } else if (book.getStatus() == BookStatus.RESERVED && book.getTotalCopies() > 0) {  // Changed 'copies' to 'totalCopies'
            book.setStatus(BookStatus.AVAILABLE);
        }
    }
}
