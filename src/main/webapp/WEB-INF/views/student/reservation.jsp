<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Reservations</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            --shadow: 0 2px 4px rgba(0,0,0,0.05);
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

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        h1 {
            color: var(--text-primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: var(--radius);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* Book Grid Styles */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px 0;
        }

        .book-card {
            background: var(--card-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .book-cover {
            width: 100%;
            height: 200px;
            background-color: var(--hover-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-cover i {
            font-size: 48px;
            color: var(--primary);
        }

        .book-info {
            padding: 15px;
        }

        .book-title {
            font-size: 1.1em;
            font-weight: bold;
            margin-bottom: 10px;
            color: var(--text-primary);
        }

        .book-details {
            margin-bottom: 15px;
        }

        .book-detail {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
            color: var(--text-secondary);
            font-size: 0.9em;
        }

        .book-detail i {
            width: 16px;
            color: var(--primary);
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 500;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 15px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-approved {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .status-fulfilled {
            background-color: #cce5ff;
            color: #004085;
            border: 1px solid #b8daff;
        }

        .status-expired {
            background-color: #e2e3e5;
            color: #383d41;
            border: 1px solid #d6d8db;
        }

        .cancel-btn {
            width: 100%;
            padding: 10px;
            background-color: var(--error);
            color: white;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background-color 0.3s;
            font-weight: 500;
        }

        .cancel-btn:hover {
            background-color: #c82333;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 20px;
            color: var(--border-color);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 60px;
                padding: 10px 0;
            }

            .app-logo span {
                display: none;
            }

            .nav-item span {
                display: none;
            }

            .main-content {
                margin-left: 60px;
            }

            .container {
                padding: 10px;
            }

            .book-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar Navigation -->
   <aside class="sidebar">
               <div class="app-logo">
                   <i class="fas fa-book"></i> KitabZone
               </div>
               <nav>
                   <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item">
                       <i class="fas fa-th-large"></i> Dashboard
                   </a>
                   <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item">
                       <i class="fas fa-book"></i> Browse Books
                   </a>
                   <a href="${pageContext.request.contextPath}/student/myBooks" class="nav-item">
                       <i class="fas fa-book-reader"></i> My Books
                   </a>
                   <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item active">
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
        <div class="container">
            <h1>
                <i class="fas fa-calendar-check"></i>
                My Reservations
            </h1>

            <c:if test="${not empty success}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty reservations}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-times"></i>
                        <h3>No Reservations Found</h3>
                        <p>You haven't made any book reservations yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="book-grid">
                        <c:forEach items="${reservations}" var="reservation">
                            <div class="book-card">
                                <div class="book-cover">
                                    <c:choose>
                                        <c:when test="${not empty reservation.bookCover}">
                                            <img src="${pageContext.request.contextPath}/uploads/${reservation.bookCover}" alt="${reservation.bookTitle}" onerror="this.style.display='none'; this.parentElement.querySelector('i').style.display='flex';">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-book"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="book-info">
                                    <div class="book-title">${reservation.bookTitle}</div>
                                    <div class="book-details">
                                        <div class="book-detail">
                                            <i class="fas fa-calendar"></i>
                                            <span>Reserved: ${reservation.reservationDate}</span>
                                        </div>
                                        <div class="book-detail">
                                            <i class="fas fa-sort-numeric-up"></i>
                                            <span>Priority: ${reservation.priority}</span>
                                        </div>
                                    </div>
                                    <span class="status-badge status-${reservation.status.name().toLowerCase()}">
                                        <i class="fas fa-circle"></i>
                                        ${reservation.status}
                                    </span>
                                    <c:if test="${reservation.status == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/student/reservation/cancel" method="post" onsubmit="return confirm('Are you sure you want to cancel this reservation?');">
                                            <input type="hidden" name="reservationId" value="${reservation.id}">
                                            <button type="submit" class="cancel-btn">
                                                <i class="fas fa-times"></i>
                                                Cancel Reservation
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>
