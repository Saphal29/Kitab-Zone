<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow Book - ${book.title}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        :root {
            --primary: #28a745;
            --primary-light: #e8f5e9;
            --secondary: #f8f9fa;
            --success: #2ecc71;
            --danger: #dc3545;
            --warning: #ffc107;
            --text: #2c3e50;
            --text-light: #6c757d;
            --border: #dee2e6;
            --shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--secondary);
            color: var(--text);
        }

        .app-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background: white;
            padding: 20px;
            box-shadow: var(--shadow);
        }

        .app-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 30px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            color: var(--text);
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 5px;
            transition: all 0.3s ease;
        }

        .nav-item:hover {
            background: var(--primary-light);
        }

        .nav-item.active {
            background: var(--primary);
            color: white;
        }

        .main-content {
            padding: 20px;
        }

        .borrow-container {
            max-width: 900px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow);
        }

        .page-header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--border);
        }

        .page-header h2 {
            color: var(--text);
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-header h2 i {
            color: var(--primary);
        }

        .book-info {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .book-cover {
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .book-cover img {
            width: 100%;
            height: auto;
            display: block;
            transition: transform 0.3s ease;
        }

        .book-cover:hover img {
            transform: scale(1.05);
        }

        .book-meta {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .meta-group {
            background: var(--primary-light);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid var(--primary);
        }

        .meta-group h3 {
            color: var(--text);
            font-size: 1.1rem;
            margin-bottom: 10px;
        }

        .meta-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid var(--border);
        }

        .meta-item:last-child {
            border-bottom: none;
        }

        .meta-label {
            color: var(--text-light);
            font-weight: 500;
        }

        .meta-value {
            color: var(--text);
            font-weight: 600;
        }

        .availability-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            margin-top: 10px;
        }

        .available {
            background: var(--success);
            color: white;
        }

        .unavailable {
            background: var(--danger);
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-secondary {
            background: var(--secondary);
            color: var(--text);
            border: 1px solid var(--border);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .error-message {
            background: #fff5f5;
            color: var(--danger);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid var(--danger);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="app-logo">
                <i class="fas fa-book"></i> KitabZone
            </div>
            <nav>
                <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item">
                    <i class="fas fa-th-large"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item active">
                    <i class="fas fa-book"></i> Browse Books
                </a>
                <a href="${pageContext.request.contextPath}/student/myBooks" class="nav-item">
                    <i class="fas fa-book-reader"></i> My Books
                </a>
                <a href="${pageContext.request.contextPath}/student/fines" class="nav-item">
                    <i class="fas fa-money-bill-wave"></i> My Fines
                </a>
                <a href="${pageContext.request.contextPath}/student/profile" class="nav-item">
                    <i class="fas fa-user"></i> Profile
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="borrow-container">
                <c:choose>
                    <c:when test="${empty book}">
                        <div class="error-message">
                            <i class="fas fa-exclamation-circle"></i>
                            Book details could not be loaded. Please try again.
                        </div>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/student/browseBooks" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Back to Browse
                            </a>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="page-header">
                            <h2>
                                <i class="fas fa-book-open"></i>
                                Confirm Borrow Request
                            </h2>
                        </div>

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
                                <div class="meta-group">
                                    <h3>Book Information</h3>
                                    <div class="meta-item">
                                        <span class="meta-label">Title</span>
                                        <span class="meta-value">${book.title}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Author</span>
                                        <span class="meta-value">${book.author}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">ISBN</span>
                                        <span class="meta-value">${book.isbn}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Publisher</span>
                                        <span class="meta-value">${book.publisher}</span>
                                    </div>
                                </div>

                                <div class="meta-group">
                                    <h3>Availability</h3>
                                    <div class="meta-item">
                                        <span class="meta-label">Available Copies</span>
                                        <span class="meta-value">${book.availableCopies}</span>
                                    </div>
                                    <c:choose>
                                        <c:when test="${book.availableCopies > 0}">
                                            <span class="availability-badge available">
                                                <i class="fas fa-check-circle"></i>
                                                Available for Borrowing
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="availability-badge unavailable">
                                                <i class="fas fa-times-circle"></i>
                                                Currently Unavailable
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <form action="${pageContext.request.contextPath}/student/processBorrow"
                                      method="post">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <div class="action-buttons">
                                        <c:choose>
                                            <c:when test="${book.availableCopies > 0}">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-check-circle"></i>
                                                    Confirm Borrow
                                                </button>
                                            </c:when>
                                        </c:choose>
                                        <a href="${pageContext.request.contextPath}/student/browseBooks" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left"></i>
                                            Back to Browse
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>