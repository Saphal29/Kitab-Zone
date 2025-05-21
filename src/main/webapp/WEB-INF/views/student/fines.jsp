<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Fines</title>
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
            --success: #28A745;
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

        /* Fines Table */
        .fines-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .fines-table th,
        .fines-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .fines-table th {
            background-color: var(--hover-bg);
            font-weight: 600;
            color: var(--text-primary);
        }

        .fines-table tr:hover {
            background-color: var(--hover-bg);
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
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-paid {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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

        .total-fines {
            margin-top: 20px;
            padding: 15px;
            background-color: var(--hover-bg);
            border-radius: var(--radius);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-fines .amount {
            font-size: 1.2em;
            font-weight: 600;
            color: var(--text-primary);
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

            .fines-table {
                display: block;
                overflow-x: auto;
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
                  <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item ">
                                            <i class="fas fa-book-reader"></i> My Reservations
                                            </a>
                  <a href="${pageContext.request.contextPath}/student/fines" class="nav-item active">
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
                <i class="fas fa-dollar-sign"></i>
                My Fines & Payments
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
                <c:when test="${empty fines}">
                    <div class="empty-state">
                        <i class="fas fa-check-circle"></i>
                        <h3>No Fines Found</h3>
                        <p>You don't have any fines at the moment.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="fines-table">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>Reason</th>
                                <th>Amount</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Payment Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${fines}" var="fine">
                                <tr>
                                    <td>${fine.bookTitle}</td>
                                    <td>${fine.reason}</td>
                                    <td>$${fine.amount}</td>
                                    <td><fmt:formatDate value="${fine.dueDate}" pattern="MMM dd, yyyy"/></td>
                                    <td>
                                        <span class="status-badge status-${fine.status.name().toLowerCase()}">
                                            <i class="fas fa-circle"></i>
                                            ${fine.status}
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${fine.status == 'PAID'}">
                                            <div>
                                                <small>Paid on: <fmt:formatDate value="${fine.paymentDate}" pattern="MMM dd, yyyy"/></small><br>
                                                <small>Method: ${fine.paymentMethod}</small>
                                            </div>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="total-fines">
                        <span>Total Pending Fines:</span>
                        <span class="amount">
                            $<fmt:formatNumber value="${totalPendingFines}" pattern="#,##0.00"/>
                        </span>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>
