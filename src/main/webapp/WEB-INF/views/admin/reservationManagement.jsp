<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Management - KitabZone</title>
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


        /* Main Content Styles */
        .main-content {
            padding: 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 1.8rem;
            color: var(--text);
        }

        .search-box {
            display: flex;
            gap: 10px;
            background: white;
            padding: 10px;
            border-radius: 8px;
            box-shadow: var(--shadow);
        }

        .search-box input {
            border: none;
            outline: none;
            padding: 5px;
            width: 300px;
        }

        .search-box button {
            background: var(--primary);
            color: white;
            border: none;
            padding: 5px 15px;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .search-box button:hover {
            background: #218838;
        }

        /* Table Styles */
        .reservations-table {
            width: 100%;
            background: white;
            border-radius: 8px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .reservations-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .reservations-table th,
        .reservations-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--border);
        }

        .reservations-table th {
            background: var(--primary-light);
            color: var(--primary);
            font-weight: 600;
        }

        .reservations-table tr:hover {
            background: var(--primary-light);
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-pending {
            background: var(--warning);
            color: #856404;
        }

        .status-approved {
            background: var(--success);
            color: white;
        }

        .status-cancelled {
            background: var(--danger);
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .btn-approve {
            background: var(--success);
            color: white;
        }

        .btn-reject {
            background: var(--danger);
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            max-width: 90%;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 1.2rem;
            color: var(--text);
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-light);
        }

        .modal-body {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: var(--text);
        }

        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid var(--border);
            border-radius: 4px;
            resize: vertical;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn-cancel {
            background: var(--text-light);
            color: white;
        }

        /* Alert Styles */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
                                 <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
                                 <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item active"><i class="fas fa-calendar-check"></i> Reservation Management</a>
                                 <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item "><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>

                             </nav>
                         </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="page-header">
                <h1 class="page-title">Reservation Management</h1>
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search reservations...">
                    <button><i class="fas fa-search"></i> Search</button>
                </div>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>

            <div class="reservations-table">
                <table>
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>Member Name</th>
                            <th>Reservation Date</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${reservations}" var="reservation">
                            <tr>
                                <td>${reservation.bookTitle}</td>
                                <td>${reservation.userName}</td>
                                <td>${reservation.reservationDate}</td>
                                <td>${reservation.priority}</td>
                                <td>
                                    <span class="status-badge status-${reservation.status.name().toLowerCase()}">
                                        ${reservation.status}
                                    </span>
                                </td>
                                <td class="action-buttons">
                                    <c:if test="${reservation.status == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/admin/reservationManagement" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="reservationId" value="${reservation.id}">
                                            <button type="submit" class="btn btn-approve">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                        </form>
                                        <button class="btn btn-reject" onclick="openRejectModal(${reservation.id})">
                                            <i class="fas fa-times"></i> Reject
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <!-- Reject Modal -->
    <div id="rejectModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Reject Reservation</h3>
                <button class="close-modal" onclick="closeRejectModal()">&times;</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/reservationManagement" method="post">
                <input type="hidden" name="action" value="reject">
                <input type="hidden" name="reservationId" id="rejectReservationId">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="reason">Reason for Rejection:</label>
                        <textarea id="reason" name="reason" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-cancel" onclick="closeRejectModal()">Cancel</button>
                    <button type="submit" class="btn btn-reject">Reject Reservation</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openRejectModal(reservationId) {
            document.getElementById('rejectModal').style.display = 'flex';
            document.getElementById('rejectReservationId').value = reservationId;
        }

        function closeRejectModal() {
            document.getElementById('rejectModal').style.display = 'none';
            document.getElementById('reason').value = '';
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.querySelectorAll('.reservations-table tbody tr');

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchText) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
