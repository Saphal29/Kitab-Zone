<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Fines</title>
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

        .app-logo i {
            color: var(--primary);
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
            text-decoration: none;
            color: var(--text-primary);
        }

        .nav-item:hover {
            background: var(--hover-bg);
        }

        .nav-item.active {
            background: var(--primary);
            color: #fff;
        }

        .nav-item i {
            width: 20px;
            text-align: center;
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

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 0.9em;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: background-color 0.2s;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-danger {
            background-color: var(--error);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            position: relative;
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            width: 400px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .close {
            position: absolute;
            right: 20px;
            top: 10px;
            font-size: 24px;
            cursor: pointer;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: var(--text-primary);
        }

        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
        }

        .modal-footer {
            margin-top: 20px;
            text-align: right;
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

            .modal-content {
                width: 90%;
                margin: 30% auto;
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
                          <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item "><i class="fas fa-th-large"></i> Dashboard</a>
                          <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
                          <a href="${pageContext.request.contextPath}/admin/books" class="nav-item"><i class="fas fa-list"></i> Book</a>
                          <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
                          <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
                          <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item active"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>

                      </nav>
                  </aside>
    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <h1>
                <i class="fas fa-dollar-sign"></i>
                Manage Fines
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

            <table class="fines-table">
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Book</th>
                        <th>Reason</th>
                        <th>Amount</th>
                        <th>Due Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${fines}" var="fine">
                        <tr>
                            <td>${fine.userName}</td>
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
                                <c:if test="${fine.status == 'PENDING'}">
                                    <div class="action-buttons">
                                        <button class="btn btn-success" onclick="showPaymentModal(${fine.fineId})">
                                            <i class="fas fa-check"></i>
                                            Mark as Paid
                                        </button>
                                        <button class="btn btn-warning" onclick="showWaiveModal(${fine.fineId})">
                                            <i class="fas fa-hand-holding-heart"></i>
                                            Waive Fine
                                        </button>
                                        <button class="btn btn-danger" onclick="cancelFine(${fine.fineId})">
                                            <i class="fas fa-times"></i>
                                            Cancel
                                        </button>
                                    </div>
                                </c:if>
                                <c:if test="${fine.status == 'WAIVED'}">
                                    <small class="text-muted">
                                        Waived by: ${fine.waivedByName}<br>
                                        <fmt:formatDate value="${fine.waivedAt}" pattern="MMM dd, yyyy"/>
                                    </small>
                                </c:if>
                                <c:if test="${fine.status == 'PAID'}">
                                    <small class="text-muted">
                                        Paid on: <fmt:formatDate value="${fine.paidAt}" pattern="MMM dd, yyyy"/>
                                    </small>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Payment Modal -->
    <div class="modal fade" id="paymentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Process Payment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to mark this fine as paid?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form action="${pageContext.request.contextPath}/admin/fines" method="POST">
                        <input type="hidden" name="action" value="pay">
                        <input type="hidden" name="fineId" id="paymentFineId">
                        <button type="submit" class="btn btn-success">Confirm Payment</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Waive Modal -->
    <div class="modal fade" id="waiveModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Waive Fine</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin/fines" method="POST">
                        <input type="hidden" name="action" value="waive">
                        <input type="hidden" name="fineId" id="waiveFineId">
                        <div class="mb-3">
                            <label for="waiveNotes" class="form-label">Reason for Waiving</label>
                            <textarea class="form-control" id="waiveNotes" name="notes" rows="3" required></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-warning">Confirm Waive</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showPaymentModal(fineId) {
            document.getElementById('paymentFineId').value = fineId;
            new bootstrap.Modal(document.getElementById('paymentModal')).show();
        }

        function showWaiveModal(fineId) {
            document.getElementById('waiveFineId').value = fineId;
            new bootstrap.Modal(document.getElementById('waiveModal')).show();
        }

        function cancelFine(fineId) {
            if (confirm('Are you sure you want to cancel this fine?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/fines';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'cancel';

                const fineIdInput = document.createElement('input');
                fineIdInput.type = 'hidden';
                fineIdInput.name = 'fineId';
                fineIdInput.value = fineId;

                form.appendChild(actionInput);
                form.appendChild(fineIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>