<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
 <meta charset="UTF-8" />
 <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
 <title>Browse Books - Library Management System</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
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
     --info: #17A2B8;
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
     flex-direction: column;
     gap: 1rem;
     margin-bottom: 2rem;
   }

   .header-top {
     display: flex;
     justify-content: space-between;
     align-items: center;
   }

   .page-title {
     font-size: 1.75rem;
     font-weight: 600;
     color: var(--text-primary);
   }

   .search-filter-row {
     display: flex;
     align-items: center;
     gap: 1rem;
     flex-wrap: wrap;
     justify-content: space-between;
   }

   .search-container {
     position: relative;
     flex: 1;
     max-width: 600px;
   }

   .search-input {
     width: 100%;
     padding: 1rem 1rem 1rem 3.5rem;
     background: white;
     border: 1px solid var(--border-color);
     border-radius: 50px;
     font-size: 1rem;
     color: var(--text-primary);
   }

   .search-input:focus {
     outline: none;
     border-color: var(--primary);
     box-shadow: 0 0 0 4px rgba(76, 175, 80, 0.1);
   }

   .search-icon {
     position: absolute;
     left: 1.25rem;
     top: 50%;
     transform: translateY(-50%);
     color: #A0AEC0;
     font-size: 1.25rem;
   }

   .filter-pills {
     display: flex;
     gap: 0.5rem;
     flex-wrap: wrap;
   }

   .filter-pill {
     padding: 0.5rem 1rem;
     background: white;
     border: 1px solid var(--border-color);
     border-radius: 50px;
     font-size: 0.875rem;
     color: var(--text-secondary);
     cursor: pointer;
     display: flex;
     align-items: center;
     gap: 0.5rem;
   }

   .filter-pill:hover {
     border-color: var(--primary);
     color: var(--primary);
   }

   .filter-pill.active {
     background: var(--primary);
     color: white;
     border-color: var(--primary);
   }

   /* Categories */
   .categories {
     display: flex;
     overflow-x: auto;
     gap: 1rem;
     margin-bottom: 2rem;
     padding-bottom: 0.5rem;
   }

   .category {
     padding: 1rem 1.5rem;
     border-radius: var(--radius);
     background: var(--card-bg);
     color: var(--text-secondary);
     text-align: center;
     font-weight: 500;
     white-space: nowrap;
     cursor: pointer;
     transition: all 0.2s;
     border: 1px solid var(--border-color);
   }

   .category.active {
     background: var(--primary);
     color: white;
     border-color: var(--primary);
   }

   .category:hover:not(.active) {
     background: var(--hover-bg);
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
     box-shadow: var(--shadow);
     overflow: hidden;
     transition: transform 0.2s;
   }

   .book-card:hover {
     transform: translateY(-4px);
   }

   .book-cover {
     height: 300px;
     position: relative;
   }

   .book-cover img {
     width: 100%;
     height: 100%;
     object-fit: cover;
   }

   .book-status {
     position: absolute;
     top: 1rem;
     right: 1rem;
     font-size: 0.75rem;
     font-weight: 500;
     padding: 0.25rem 0.75rem;
     border-radius: 1rem;
     background: rgba(255, 255, 255, 0.9);
   }

   .status-available {
     color: var(--primary);
   }

   .status-reserved {
     color: var(--warning);
   }

   .status-issued {
     color: var(--error);
   }

   .status-maintenance {
     color: var(--info);
   }

   .book-info {
     padding: 1.5rem;
   }

   .book-title {
     font-weight: 600;
     color: var(--text-primary);
     margin-bottom: 0.5rem;
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

   .book-meta {
     display: flex;
     justify-content: space-between;
     font-size: 0.875rem;
     color: var(--text-secondary);
     margin-bottom: 1rem;
   }

   .book-rating {
     display: flex;
     align-items: center;
     gap: 0.25rem;
   }

   .star-filled {
     color: #FFC107;
   }

   .book-actions {
     display: flex;
     gap: 0.5rem;
   }

   .btn {
     padding: 0.75rem 1rem;
     border: none;
     border-radius: var(--radius);
     font-size: 0.875rem;
     cursor: pointer;
     display: flex;
     align-items: center;
     gap: 0.5rem;
     transition: 0.2s;
   }

   .btn-primary {
     background: var(--primary);
     color: white;
     flex: 1;
     justify-content: center;
   }

   .btn-primary:hover {
     background: var(--primary-dark);
   }

   .btn-primary:disabled {
     background: #cccccc;
     cursor: not-allowed;
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

   .empty-state {
     grid-column: 1 / -1;
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

     .search-filter-row {
       flex-direction: column;
       align-items: stretch;
     }

     .filter-pills {
       justify-content: center;
     }

     .books-grid {
       grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
       gap: 1.5rem;
     }
   }
 </style>
</head>
<body>
  <div class="app-container">
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
                   <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item ">
                                             <i class="fas fa-book-reader"></i> My Reservations
                                             </a>
                   <a href="${pageContext.request.contextPath}/student/fines" class="nav-item">
                       <i class="fas fa-money-bill-wave"></i> My Fines
                   </a>
                   <a href="${pageContext.request.contextPath}/student/profile" class="nav-item ">
                       <i class="fas fa-user"></i> Profile
                   </a>
               </nav>
           </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="header">
        <div class="header-top">
          <h1 class="page-title">Browse Books</h1>
        </div>

        <!-- Messages -->
        <c:if test="${not empty param.success}">
            <div class="message message-success">
                <i class="fas fa-check-circle"></i>
                ${param.success}
            </div>
        </c:if>

        <c:if test="${not empty param.error}">
            <div class="message message-error">
                <i class="fas fa-exclamation-circle"></i>
                ${param.error}
            </div>
        </c:if>

        <div class="search-filter-row">
          <div class="search-container">
            <input type="text" class="search-input" placeholder="Search for books, authors, or ISBN...">
            <i class="fas fa-search search-icon"></i>
          </div>

          <div class="filter-pills">
            <div class="filter-pill active"><i class="fas fa-th-large"></i> All Books</div>

          </div>
        </div>
      </div>

      <!-- Books Grid -->
      <div class="books-grid">
        <c:choose>
          <c:when test="${empty books}">
            <div class="empty-state">
              <i class="fas fa-book-open"></i>
              <h3>No Books Found</h3>
              <p>There are currently no books available in the library.</p>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach items="${books}" var="book">
              <div class="book-card">
                <div class="book-cover">
                  <c:choose>
                    <c:when test="${not empty book.coverImage}">
                      <img src="${pageContext.request.contextPath}/uploads/${book.coverImage}" alt="${book.title}" class="book-image"/>
                    </c:when>
                    <c:otherwise>
                      <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c" alt="Default Book Cover">
                    </c:otherwise>
                  </c:choose>
                  <div class="book-status status-${book.status.name().toLowerCase()}">
                    ${book.status}
                  </div>
                </div>
                <div class="book-info">
                  <h3 class="book-title">${book.title}</h3>
                  <p class="book-author">${book.author}</p>
                  <div class="book-meta">
                    <span>ISBN: ${book.isbn}</span>
                    <span>Copies: ${book.totalCopies}</span>
                  </div>
                  <div class="book-actions">
                      <c:choose>
                          <c:when test="${book.availableCopies > 0}">
                              <a href="${pageContext.request.contextPath}/student/borrowBook?bookId=${book.bookId}"
                                 class="btn btn-primary">
                                  <i class="fas fa-book"></i> Borrow Now
                              </a>
                          </c:when>
                          <c:otherwise>
                              <a href="${pageContext.request.contextPath}/student/reserveBook?bookId=${book.bookId}"
                                 class="btn btn-primary">
                                  <i class="fas fa-clock"></i> Reserve Now
                              </a>
                          </c:otherwise>
                      </c:choose>
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
