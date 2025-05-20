<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Books - Library Management System</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    :root {
      --primary: #4CAF50;
      --primary-dark: #3e8e41;
      --background: #F8F9FA;
      --card-bg: #FFFFFF;
      --text-primary: #2D3436;
      --text-secondary: #636E72;
      --border-color: #E9ECEF;
      --hover-bg: #F1F4F6;
      --shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      --radius: 8px;
      --error: #DC3545;
      --warning: #FFC107;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Roboto, sans-serif;
    }

    body {
      background: var(--background);
      display: flex;
      min-height: 100vh;
    }

    a {
      text-decoration: none;
      color: inherit;
    }

    .app-container {
      display: flex;
      width: 100%;
      height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      width: 250px;
      background: var(--card-bg);
      padding: 1.5rem;
      border-right: 1px solid var(--border-color);
      display: flex;
      flex-direction: column;
    }

    .app-logo {
      display: flex;
      align-items: center;
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--text-primary);
      gap: 0.5rem;
      margin-bottom: 2rem;
    }

    .nav-item {
      display: flex;
      align-items: center;
      padding: 0.75rem 1rem;
      border-radius: var(--radius);
      font-size: 1rem;
      gap: 0.75rem;
      margin-bottom: 0.5rem;
      transition: background 0.2s;
    }

    .nav-item:hover {
      background: var(--hover-bg);
    }

    .nav-item.active {
      background: var(--primary);
      color: #fff;
    }

    /* Main Content */
    .main-content {
      flex: 1;
      padding: 2rem;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
    }

    .page-title {
      font-size: 1.75rem;
      font-weight: 600;
      color: var(--text-primary);
    }

    /* Tabs */
    .tabs {
      display: flex;
      gap: 1rem;
      margin-bottom: 2rem;
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 1rem;
      flex-wrap: wrap;
    }

    .tab {
      padding: 0.75rem 1.5rem;
      border-radius: var(--radius);
      cursor: pointer;
      font-weight: 500;
      color: var(--text-secondary);
      transition: all 0.2s;
      border: 1px solid transparent;
    }

    .tab.active {
      background: var(--primary);
      color: white;
    }

    .tab:hover:not(.active) {
      background: var(--hover-bg);
      border-color: var(--border-color);
    }

    /* Books Grid */
    .books-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 2rem;
    }

    .book-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      overflow: hidden;
      box-shadow: var(--shadow);
      transition: transform 0.2s;
    }

    .book-card:hover {
      transform: translateY(-4px);
    }

    .book-cover {
      position: relative;
      height: 200px;
    }

    .book-cover img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .due-badge {
      position: absolute;
      top: 1rem;
      right: 1rem;
      background: rgba(220, 53, 69, 0.9);
      color: white;
      padding: 0.25rem 0.75rem;
      border-radius: 1rem;
      font-size: 0.75rem;
      font-weight: 500;
    }

    .book-info {
      padding: 1.5rem;
    }

    .book-title {
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: var(--text-primary);
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .book-author {
      color: var(--text-secondary);
      font-size: 0.875rem;
      margin-bottom: 1rem;
      display: -webkit-box;
      -webkit-line-clamp: 1;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .progress-bar {
      width: 100%;
      height: 4px;
      background: var(--border-color);
      border-radius: 2px;
      margin: 1rem 0;
      overflow: hidden;
    }

    .progress {
      height: 100%;
      background: var(--primary);
      border-radius: 2px;
    }

    .book-meta {
      display: flex;
      justify-content: space-between;
      font-size: 0.875rem;
      color: var(--text-secondary);
      margin-bottom: 0.5rem;
    }

    .book-actions {
      display: flex;
      gap: 0.5rem;
      margin-top: 1rem;
    }

    .btn {
      padding: 0.75rem 1rem;
      border-radius: var(--radius);
      font-size: 0.875rem;
      cursor: pointer;
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-primary {
      background: var(--primary);
      color: white;
      border: none;
      flex: 1;
    }

    .btn-primary:hover {
      background: var(--primary-dark);
    }

    .btn-outline {
      background: transparent;
      border: 1px solid var(--border-color);
      color: var(--text-secondary);
    }

    .btn-outline:hover {
      background: var(--hover-bg);
    }

    /* Messages */
    .message {
      padding: 1rem;
      border-radius: var(--radius);
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .message-success {
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .message-error {
      background: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    /* Empty State */
    .empty-state {
      text-align: center;
      padding: 3rem;
      color: var(--text-secondary);
    }

    .empty-state i {
      font-size: 3rem;
      margin-bottom: 1rem;
      color: var(--border-color);
    }

    /* Responsive */
    @media (max-width: 768px) {
      .app-container {
        flex-direction: column;
      }

      .sidebar {
        width: 100%;
        height: auto;
      }

      .main-content {
        padding: 1.5rem;
      }

      .tabs {
        justify-content: center;
      }

      .books-grid {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 1.5rem;
      }

      .book-actions {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
  <div class="app-container">
    <!-- Sidebar -->
    <aside class="sidebar">
      <div class="app-logo">
        <i class="fas fa-book"></i>
        KitabZone
      </div>
      <nav>
        <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item">
          <i class="fas fa-th-large"></i>
          Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/student/myBooks" class="nav-item active">
          <i class="fas fa-book"></i>
          My Books
        </a>
        <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item">
          <i class="fas fa-search"></i>
          Browse Books
        </a>
        <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item">
          <i class="fas fa-clock"></i>
          Reservations
        </a>
        <a href="${pageContext.request.contextPath}/student/fines" class="nav-item">
          <i class="fas fa-dollar-sign"></i>
          Fines & Payments
        </a>
        <a href="${pageContext.request.contextPath}/student/profile" class="nav-item">
          <i class="fas fa-user"></i>
          Profile
        </a>
      </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="header">
        <h1 class="page-title">My Books</h1>
      </div>

      <!-- Messages -->
      <c:if test="${not empty success}">
        <div class="message message-success">
          <i class="fas fa-check-circle"></i>
          ${success}
        </div>
      </c:if>
      <c:if test="${not empty error}">
        <div class="message message-error">
          <i class="fas fa-exclamation-circle"></i>
          ${error}
        </div>
      </c:if>

      <div class="tabs">
        <div class="tab active">
          Currently Borrowed (<c:out value="${not empty transactions ? transactions.size() : 0}"/>)
        </div>
        <!-- You can add tabs for Reading History, Saved Books, etc. -->
        <div class="tab">Reading History</div>
        <div class="tab">Saved Books</div>
      </div>

      <!-- Books Grid -->
      <div class="books-grid">
        <c:choose>
          <c:when test="${empty transactions}">
            <div class="empty-state">
              <i class="fas fa-book-open"></i>
              <h3>No Books Borrowed</h3>
              <p>You haven't borrowed any books yet. Browse our collection to find something interesting!</p>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach items="${transactions}" var="transaction">
              <div class="book-card">
                <div class="book-cover">
                  <c:choose>
                    <c:when test="${not empty transaction.bookCoverImage}">
                      <c:choose>
                        <c:when test="${fn:startsWith(transaction.bookCoverImage, 'uploads/')}">
                          <img src="${pageContext.request.contextPath}/${transaction.bookCoverImage}" alt="${transaction.bookTitle}" />
                        </c:when>
                        <c:otherwise>
                          <img src="${pageContext.request.contextPath}/uploads/${transaction.bookCoverImage}" alt="${transaction.bookTitle}" />
                        </c:otherwise>
                      </c:choose>
                    </c:when>
                    <c:otherwise>
                      <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c" alt="Default Book Cover" />
                    </c:otherwise>
                  </c:choose>
                  <div class="due-badge">
                    Due <fmt:formatDate value="${transaction.dueDate}" pattern="MMM dd"/>
                  </div>
                </div>
                <div class="book-info">
                  <h3 class="book-title">${transaction.bookTitle}</h3>
                  <p class="book-author">${transaction.bookAuthor}</p>
                  <div class="book-meta">
                    <span>Borrowed: <fmt:formatDate value="${transaction.borrowDate}" pattern="MMM dd, yyyy"/></span>
                  </div>
                  <div class="book-actions">
                    <button class="btn btn-primary" type="button">
                      <i class="fas fa-book-reader"></i>
                      Continue Reading
                    </button>
                    <form action="${pageContext.request.contextPath}/student/returnBook" method="post" style="display: inline;">
                      <input type="hidden" name="transactionId" value="${transaction.id}" />
                      <button type="submit" class="btn btn-outline">
                        <i class="fas fa-undo"></i>
                        Return Book
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>
    </main>
  </div>
</body>
</html>
