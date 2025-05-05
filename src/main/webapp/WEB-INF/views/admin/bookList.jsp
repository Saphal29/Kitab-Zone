<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <title>Book Management</title>

    <style>
       :root {
         --primary: #4CAF50;
         --background: #F8F9FA;
         --card-bg: #FFFFFF;
         --text-primary: #2D3436;
         --text-secondary: #636E72;
         --border-color: #E9ECEF;
         --hover-bg: #F1F4F6;
         --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
         --radius: 12px;
         --transition-speed: 0.3s;
       }

       * {
         margin: 0;
         padding: 0;
         box-sizing: border-box;
         font-family: 'Segoe UI', Roboto, sans-serif;
       }

       body {
         background: var(--background);
         color: var(--text-primary);
       }

       a {
         text-decoration: none;
         color: inherit;
       }

       .app-container {
         display: flex;
         height: 100vh;
         overflow: hidden;
       }

       /* Sidebar */
       .sidebar {
         background: var(--card-bg);
         border-right: 1px solid var(--border-color);
         width: 250px;
         padding: 2rem 1.5rem;
         display: flex;
         flex-direction: column;
       }

       .app-logo {
         display: flex;
         align-items: center;
         font-size: 1.5rem;
         font-weight: 600;
         gap: 0.5rem;
         margin-bottom: 2rem;
         color: var(--text-primary);
       }

       .nav-item {
         display: flex;
         align-items: center;
         gap: 0.75rem;
         padding: 0.75rem 1rem;
         font-size: 1rem;
         border-radius: var(--radius);
         transition: background var(--transition-speed);
         margin-bottom: 0.5rem;
       }

       .nav-item i {
         font-size: 1.25rem;
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
       }

       .global-search {
         display: flex;
         align-items: center;
         padding: 0.5rem 1rem;
         background: var(--card-bg);
         border: 1px solid var(--border-color);
         border-radius: var(--radius);
         width: 100%;
         max-width: 400px;
       }

       .global-search input {
         border: none;
         outline: none;
         font-size: 1rem;
         flex: 1;
         margin-left: 0.75rem;
       }

       /* Table Styles */
       .table-container {
         background: var(--card-bg);
         border-radius: var(--radius);
         box-shadow: var(--shadow);
         padding: 1.5rem;
         overflow-x: auto;
       }

       table {
         width: 100%;
         border-collapse: collapse;
       }

       th, td {
         padding: 1rem;
         text-align: left;
         border-bottom: 1px solid var(--border-color);
       }

       th {
         font-weight: 600;
         color: var(--text-primary);
         background: var(--hover-bg);
       }

       tr:hover {
         background: var(--hover-bg);
       }

       .status {
         display: inline-block;
         padding: 0.25rem 0.75rem;
         border-radius: 1rem;
         font-size: 0.875rem;
         font-weight: 500;
       }

       .status-available {
         background: #E3F2FD;
         color: #1976D2;
       }

       .status-reserved {
         background: #FFF8E1;
         color: #FFA000;
       }

       .status-issued {
         background: #FFEBEE;
         color: #D32F2F;
       }

       .action-btn {
         display: inline-flex;
         align-items: center;
         justify-content: center;
         width: 2rem;
         height: 2rem;
         border-radius: 50%;
         background: transparent;
         border: none;
         cursor: pointer;
         transition: background var(--transition-speed);
       }

       .action-btn:hover {
         background: rgba(0, 0, 0, 0.1);
       }

       .action-btn i {
         font-size: 1rem;
       }

       .btn {
         padding: 0.75rem 1.5rem;
         font-size: 1rem;
         border: none;
         border-radius: var(--radius);
         cursor: pointer;
         transition: background var(--transition-speed);
       }

       .btn-primary {
         background: var(--primary);
         color: #fff;
       }

       .btn-primary:hover {
         background: #43A047;
       }

       .btn-secondary {
         background: var(--hover-bg);
         color: var(--text-primary);
       }

       .btn-secondary:hover {
         background: #E2E8F0;
       }

       .alert {
         padding: 1rem;
         border-radius: var(--radius);
         margin-bottom: 1.5rem;
       }

       .alert.success {
         background: #E8F5E9;
         color: #2E7D32;
       }

       .alert.error {
         background: #FFEBEE;
         color: #C62828;
       }

       .book-cover {
         width: 50px;
         height: 70px;
         object-fit: cover;
         border-radius: 4px;
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
           <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item"><i class="fas fa-th-large"></i> Dashboard</a>
           <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
           <a href="${pageContext.request.contextPath}/admin/addBook" class="nav-item"><i class="fas fa-book"></i> Add Books</a>
           <a href="${pageContext.request.contextPath}/admin/books" class="nav-item active"><i class="fas fa-list"></i> Book List</a>
           <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
           <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
           <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>
         </nav>
       </aside>

        <main class="main-content">
            <div class="header">
                <h1 class="page-title">Book Management</h1>
                <div class="global-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search books...">
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert success">
                    ${fn:escapeXml(param.success)}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert error">
                    ${fn:escapeXml(error)}
                </div>
            </c:if>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Cover</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>ISBN</th>
                            <th>Genre</th>
                            <th>Status</th>
                            <th>Copies</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${books}" var="book">
                            <tr>
                                <td>
                                    <c:if test="${not empty book.coverImage}">
                                        <img src="${pageContext.request.contextPath}/uploads/${fn:escapeXml(book.coverImage)}"
                                             alt="Book Cover" class="book-cover">
                                    </c:if>
                                    <c:if test="${empty book.coverImage}">
                                        <i class="fas fa-book" style="font-size: 2rem; color: #ccc;"></i>
                                    </c:if>
                                </td>
                                <td>${fn:escapeXml(book.title)}</td>
                                <td>${fn:escapeXml(book.author)}</td>
                                <td>${fn:escapeXml(book.isbn)}</td>
                                <td>${fn:escapeXml(book.genre)}</td>
                                <td>
                                    <span class="status status-${fn:escapeXml(book.status.name().toLowerCase())}">
                                        ${fn:escapeXml(book.status)}
                                    </span>
                                </td>
                                <td>${fn:escapeXml(book.totalCopies)}</td>
                                <td>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <a href="${pageContext.request.contextPath}/admin/editBook?id=${book.bookId}"
                                           class="action-btn" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/deleteBook?id=${book.bookId}"
                                           class="action-btn" title="Delete"
                                           onclick="return confirm('Are you sure you want to delete this book?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>