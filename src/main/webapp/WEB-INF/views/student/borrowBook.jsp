<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow Book - ${book.title}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        :root {
            --primary: #4CAF50;
            --error: #DC3545;
            --text-primary: #2D3436;
        }

        .borrow-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        h2 {
            color: var(--primary);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #eee;
            padding-bottom: 1rem;
        }

        .book-info {
            display: grid;
            grid-template-columns: 180px 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .book-cover img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .book-meta p {
            margin: 0.75rem 0;
            font-size: 1rem;
            color: var(--text-primary);
        }

        .borrow-btn {
            background: var(--primary);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            transition: opacity 0.2s;
        }

        .borrow-btn:hover {
            opacity: 0.9;
        }

        .error-message {
            color: var(--error);
            padding: 1rem;
            border: 1px solid var(--error);
            border-radius: 6px;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="borrow-container">
        <c:choose>
            <%-- Handle missing book --%>
            <c:when test="${empty book}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    Book details could not be loaded. Please try again.
                </div>
                <a href="${pageContext.request.contextPath}/student/browseBooks"
                   class="borrow-btn">
                    Back to Browse
                </a>
            </c:when>

            <%-- Show book details --%>
            <c:otherwise>
                <h2>
                    <i class="fas fa-book-open"></i>
                    Confirm Borrow Request
                </h2>

                <div class="book-info">
                    <div class="book-cover">
                        <c:choose>
                            <c:when test="${not empty book.coverImage}">
                                <img src="${pageContext.request.contextPath}/uploads/${book.coverImage}"
                                     alt="${book.title}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c"
                                     alt="Default Cover">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="book-meta">
                        <p><strong>Title:</strong> ${book.title}</p>
                        <p><strong>Author:</strong> ${book.author}</p>
                        <p><strong>ISBN:</strong> ${book.isbn}</p>
                        <p><strong>Available Copies:</strong> ${book.availableCopies}</p>

                        <p><strong>Publisher:</strong> ${book.publisher}</p>

                        <form action="${pageContext.request.contextPath}/student/processBorrow"
                              method="post">
                            <input type="hidden" name="bookId" value="${book.bookId}">

                            <c:choose>
                                <c:when test="${book.availableCopies > 0}">
                                    <button type="submit" class="borrow-btn">
                                        <i class="fas fa-check-circle"></i>
                                        Confirm Borrow
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <div class="error-message">
                                        <i class="fas fa-times-circle"></i>
                                        No available copies for borrowing
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>