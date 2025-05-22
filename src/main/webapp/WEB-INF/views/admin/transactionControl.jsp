<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Library App - Transaction Control</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    /* Root Variables */
    :root {
      --primary: #4CAF50;
      --primary-dark: #388E3C;
      --background: #FFFFFF;
      --text-primary: #333333;
      --text-secondary: #666666;
      --border-color: #EEEEEE;
      --hover-bg: #F8F9FA;
      --radius: 8px;
      --shadow: 0 2px 10px rgba(0,0,0,0.1);
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

    /* Main Content */
    .main-content {
      padding: 2rem;
    }

    .page-header {
      margin-bottom: 1.5rem;
    }

    .page-title {
      font-size: 1.25rem;
      font-weight: 500;
      margin-bottom: 0.25rem;
    }

    .page-subtitle {
      color: var(--text-secondary);
      font-size: 0.875rem;
    }

    /* Search Bar */
    .search-bar {
      display: flex;
      align-items: center;
      background: var(--background);
      border: 1px solid var(--border-color);
      border-radius: var(--radius);
      padding: 0.5rem 1rem;
      width: 300px;
      margin-bottom: 1.5rem;
    }

    .search-bar input {
      border: none;
      outline: none;
      width: 100%;
      margin-left: 0.5rem;
    }

    /* Transactions Table */
    .transactions-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      background: var(--background);
      border-radius: var(--radius);
      overflow: hidden;
      box-shadow: var(--shadow);
    }

    .transactions-table th {
      text-align: left;
      padding: 1rem;
      color: var(--text-secondary);
      font-weight: 500;
      font-size: 0.875rem;
      border-bottom: 1px solid var(--border-color);
      background: var(--hover-bg);
    }

    .transactions-table td {
      padding: 1rem;
      font-size: 0.875rem;
      border-bottom: 1px solid var(--border-color);
    }

    .transactions-table tr:hover {
      background: var(--hover-bg);
    }

    /* Status Badge */
    .status-badge {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 500;
    }

    .status-borrowed {
      background: #E3F2FD;
      color: #1565C0;
    }

    .status-returned {
      background: #E8F5E9;
      color: #2E7D32;
    }

    .status-overdue {
      background: #FFEBEE;
      color: #C62828;
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
                                    <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item "><i class="fas fa-th-large"></i> Dashboard</a>
                                    <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
                                    <a href="${pageContext.request.contextPath}/admin/books" class="nav-item"><i class="fas fa-list"></i> Book</a>
                                    <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item active"><i class="fas fa-tasks"></i> Transaction Control</a>
                                    <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item "><i class="fas fa-calendar-check"></i> Reservation Management</a>
                                    <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item "><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>

                                </nav>
                            </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="page-header">
        <h1 class="page-title">Transaction Control</h1>
        <p class="page-subtitle">View and manage all book transactions</p>
      </div>

      <div class="search-bar">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search transactions..." id="transactionSearch">
      </div>

      <table class="transactions-table">
        <thead>
          <tr>
            <th>Transaction ID</th>
            <th>Book Title</th>
            <th>Member</th>
            <th>Borrow Date</th>
            <th>Due Date</th>
            <th>Return Date</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty transactions}">
              <c:forEach var="transaction" items="${transactions}">
                <tr>
                  <td>#${transaction.id}</td>
                  <td>${transaction.bookTitle}</td>
                  <td>${transaction.userName}</td>
                  <td><fmt:formatDate value="${transaction.borrowDate}" pattern="MMM dd, yyyy"/></td>
                  <td><fmt:formatDate value="${transaction.dueDate}" pattern="MMM dd, yyyy"/></td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty transaction.returnDate}">
                        <fmt:formatDate value="${transaction.returnDate}" pattern="MMM dd, yyyy"/>
                      </c:when>
                      <c:otherwise>
                        -
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <span class="status-badge status-${transaction.status.toLowerCase()}">
                      ${transaction.status}
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="7">
                  <div class="empty-state">
                    <i class="fas fa-book"></i>
                    <h3>No Transactions Found</h3>
                    <p>There are no transactions to display at the moment.</p>
                  </div>
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </main>
  </div>

  <script>
    // Search functionality
    document.getElementById('transactionSearch').addEventListener('input', function(e) {
      const searchTerm = e.target.value.toLowerCase();
      const rows = document.querySelectorAll('.transactions-table tbody tr');

      rows.forEach(row => {
        if (row.querySelector('td[colspan]')) return;

        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchTerm) ? '' : 'none';
      });
    });
  </script>
</body>
</html>
