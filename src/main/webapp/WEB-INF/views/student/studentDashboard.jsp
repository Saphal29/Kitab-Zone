<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - KitabZone</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        .dashboard-header {
            margin-bottom: 30px;
        }

        .welcome-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
        }

        .welcome-section h2 {
            color: var(--text);
            margin-bottom: 10px;
        }

        .welcome-section p {
            color: var(--text-light);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            position: relative;
            border-left: 4px solid var(--primary);
        }

        .stat-card h3 {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .stat-card .value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary);
        }

        .stat-card .icon {
            font-size: 2.5rem;
            color: var(--primary-light);
            position: absolute;
            right: 20px;
            top: 20px;
        }

        .section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            border-left: 4px solid var(--primary);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 1.2rem;
            color: var(--text);
        }

        .view-all {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
        }

        .book-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }

        .book-card {
            background: var(--primary-light);
            padding: 15px;
            border-radius: 8px;
            transition: transform 0.3s ease;
        }

        .book-card:hover {
            transform: translateY(-5px);
        }

        .book-card h4 {
            margin-bottom: 5px;
            color: var(--text);
        }

        .book-card p {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .book-card .status {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            margin-top: 10px;
        }

        .status-borrowed {
            background: var(--primary);
            color: white;
        }

        .status-reserved {
            background: var(--warning);
            color: #856404;
        }

        .status-overdue {
            background: var(--danger);
            color: white;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .action-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            text-align: center;
            text-decoration: none;
            color: var(--text);
            transition: transform 0.3s ease;
            border-left: 4px solid var(--primary);
        }

        .action-card:hover {
            transform: translateY(-5px);
        }

        .action-card i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .action-card h3 {
            margin-bottom: 5px;
        }

        .action-card p {
            color: var(--text-light);
            font-size: 0.9rem;
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
                       <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item active">
                           <i class="fas fa-th-large"></i> Dashboard
                       </a>
                       <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item">
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
            <!-- Welcome Section -->
            <div class="welcome-section">
                <h2>Welcome back, ${user.fullName}!</h2>
                <p>Here's an overview of your library activity</p>
            </div>

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-book icon"></i>
                    <h3>Books Borrowed</h3>
                    <div class="value">${borrowedBooks}</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-calendar-check icon"></i>
                    <h3>Active Reservations</h3>
                    <div class="value">${activeReservations}</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-clock icon"></i>
                    <h3>Overdue Books</h3>
                    <div class="value">${overdueBooks}</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-money-bill-wave icon"></i>
                    <h3>Pending Fines</h3>
                    <div class="value">$${pendingFines}</div>
                </div>
            </div>

            <!-- Currently Borrowed Books -->
            <div class="section">
                <div class="section-header">
                    <h3 class="section-title">Currently Borrowed Books</h3>
                    <a href="${pageContext.request.contextPath}/student/myBooks" class="view-all">View All</a>
                </div>
                <div class="book-list">
                    <c:forEach items="${borrowedBooksList}" var="book">
                        <div class="book-card">
                            <h4>${book.bookTitle}</h4>
                            <p>${book.bookAuthor}</p>
                            <p>Due: ${book.dueDate}</p>
                            <c:set var="today" value="<%= new java.sql.Date(System.currentTimeMillis()) %>"/>
                            <span class="status ${book.dueDate.before(today) ? 'status-overdue' : 'status-borrowed'}">
                                ${book.dueDate.before(today) ? 'Overdue' : 'Borrowed'}
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Active Reservations -->
            <div class="section">
                <div class="section-header">
                    <h3 class="section-title">Active Reservations</h3>
                </div>
                <div class="book-list">
                    <c:forEach items="${activeReservationsList}" var="reservation">
                        <div class="book-card">
                            <h4>${reservation.bookTitle}</h4>
                            <p>${reservation.bookAuthor}</p>
                            <p>Reserved: ${reservation.reservationDate}</p>
                            <span class="status status-reserved">Reserved</span>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/student/browseBooks" class="action-card">
                    <i class="fas fa-search"></i>
                    <h3>Browse Books</h3>
                    <p>Search and browse available books</p>
                </a>
                <a href="${pageContext.request.contextPath}/student/browseBooks" class="action-card">
                    <i class="fas fa-calendar-plus"></i>
                    <h3>Make Reservation</h3>
                    <p>Reserve a book for future borrowing</p>
                </a>
                <a href="${pageContext.request.contextPath}/student/fines" class="action-card">
                    <i class="fas fa-money-bill-wave"></i>
                    <h3>Pay Fines</h3>
                    <p>View and pay any pending fines</p>
                </a>
                <a href="${pageContext.request.contextPath}/student/profile" class="action-card">
                    <i class="fas fa-user-edit"></i>
                    <h3>Update Profile</h3>
                    <p>Manage your account information</p>
                </a>
            </div>
        </main>
    </div>
</body>
</html>