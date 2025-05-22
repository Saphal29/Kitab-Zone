<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - KitabZone</title>
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

        .recent-activity {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: var(--shadow);
            border-left: 4px solid var(--primary);
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid var(--border);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .activity-icon.book {
            background: var(--primary);
        }

        .activity-icon.user {
            background: var(--success);
        }

        .activity-icon.fine {
            background: var(--danger);
        }

        .activity-icon.reservation {
            background: var(--warning);
        }

        .activity-details {
            flex: 1;
        }

        .activity-title {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .activity-time {
            font-size: 0.8rem;
            color: var(--text-light);
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 30px;
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
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="app-logo">
                <i class="fas fa-book"></i> KitabZone
            </div>
            <nav>
                <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item active"><i class="fas fa-th-large"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
                <a href="${pageContext.request.contextPath}/admin/books" class="nav-item"><i class="fas fa-list"></i> Book</a>
                <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
                <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
                <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>
                <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="margin-top: auto; color: var(--danger);" onclick="return confirm('Are you sure you want to logout?')"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="dashboard-header">
                <h1>Admin Dashboard</h1>
            </div>

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-users icon"></i>
                    <h3>Total Members</h3>
                    <div class="value">${totalMembers != null ? totalMembers : 0}</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-book icon"></i>
                    <h3>Total Books</h3>
                    <div class="value">${totalBooks != null ? totalBooks : 0}</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-calendar-check icon"></i>
                    <h3>Active Reservations</h3>
                    <div class="value">${activeReservations != null ? activeReservations : 0}</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-hand-holding-usd icon"></i>
                    <h3>Pending Fines</h3>
                    <div class="value">$${pendingFines != null ? pendingFines : 0}</div>
                </div>
            </div>



            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/admin/books" class="action-card">
                    <i class="fas fa-plus-circle"></i>
                    <h3>Add New Book</h3>
                    <p>Add a new book to the library collection</p>
                </a>
                <a href="${pageContext.request.contextPath}/admin/member" class="action-card">
                    <i class="fas fa-user-plus"></i>
                    <h3>Add New Member</h3>
                    <p>Register a new library member</p>
                </a>
                <a href="${pageContext.request.contextPath}/admin/transactionControl" class="action-card">
                    <i class="fas fa-exchange-alt"></i>
                    <h3>Process Transaction</h3>
                    <p>Handle book borrowings and returns</p>
                </a>
                <a href="${pageContext.request.contextPath}/admin/fineManagement" class="action-card">
                    <i class="fas fa-money-bill-wave"></i>
                    <h3>Manage Fines</h3>
                    <p>View and process pending fines</p>
                </a>
            </div>
        </main>
    </div>
</body>
</html>