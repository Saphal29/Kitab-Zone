<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Library App - Members</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
    :root {
                --primary: #4CAF50;
                --primary-dark: #388E3C;
                --background: #FFFFFF;
                --text-primary: #333333;
                --text-secondary: #666666;
                --border-color: #EEEEEE;
                --hover-bg: #F8F9FA;
                --edit-btn-bg: #E2E8F0;
                --cancel-btn-bg: #FF5252;
                --danger: #D32F2F;
                --radius: 8px;
                --shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            }

            body {
                background: var(--background);
            }

            .app-container {
                display: grid;
                grid-template-columns: 240px 1fr;
                min-height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                background: var(--background);
                padding: 1.5rem;
                border-right: 1px solid var(--border-color);
                height: 100vh;
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
                padding: 0.75rem 1rem;
                color: var(--text-secondary);
                text-decoration: none;
                border-radius: var(--radius);
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
            }

            .nav-item.active {
                background: var(--primary);
                color: white;
            }

            .nav-item i {
                margin-right: 0.75rem;
                width: 20px;
            }

            /* Header */
            .global-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 2rem;
                border-bottom: 1px solid var(--border-color);
            }

            .global-search {
                display: flex;
                align-items: center;
                background: var(--background);
                border: 1px solid var(--border-color);
                border-radius: var(--radius);
                padding: 0.5rem 1rem;
                width: 400px;
            }

            .global-search input {
                border: none;
                outline: none;
                width: 100%;
                margin-left: 0.5rem;
            }

            .header-actions {
                display: flex;
                align-items: center;
                gap: 1.5rem;
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

            /* Actions Row */
            .actions-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
            }

            .search-member {
                display: flex;
                align-items: center;
                background: var(--background);
                border: 1px solid var(--border-color);
                border-radius: var(--radius);
                padding: 0.5rem 1rem;
                width: 300px;
            }

            .search-member input {
                border: none;
                outline: none;
                width: 100%;
                margin-left: 0.5rem;
            }

            .action-buttons {
                display: flex;
                gap: 0.75rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                border-radius: var(--radius);
                border: none;
                font-size: 0.875rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-primary {
                background: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background: var(--primary-dark);
            }

            .btn-secondary {
                background: var(--hover-bg);
                color: var(--text-primary);
                border: 1px solid var(--border-color);
            }

            /* Members Table */
            .members-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }

            .members-table th {
                text-align: left;
                padding: 1rem;
                color: var(--text-secondary);
                font-weight: 500;
                font-size: 0.875rem;
                border-bottom: 1px solid var(--border-color);
            }

            .members-table td {
                padding: 1rem;
                font-size: 0.875rem;
                border-bottom: 1px solid var(--border-color);
            }

            .members-table tr:hover {
                background: var(--hover-bg);
            }

            .table-actions {
                display: flex;
                gap: 0.5rem;
            }

            .btn-edit {
                background: var(--edit-btn-bg);
                color: var(--text-secondary);
                padding: 0.25rem 1rem;
            }

            .btn-cancel {
                background: var(--cancel-btn-bg);
                color: white;
                padding: 0.25rem 1rem;
            }

            /* Profile Section */
            .profile-section {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .profile-image {
                width: 32px;
                height: 32px;
                border-radius: 50%;
            }

            /* Add User Modal */
            .modal {
                display: none;
                position: fixed;
                z-index: 100;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
            }

            .modal-content {
                background-color: var(--background);
                margin: 5% auto;
                padding: 2rem;
                border-radius: var(--radius);
                width: 50%;
                max-width: 600px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .modal-title {
                font-size: 1.25rem;
                font-weight: 500;
            }

            .close-btn {
                background: none;
                border: none;
                font-size: 1.5rem;
                cursor: pointer;
                color: var(--text-secondary);
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
                color: var(--text-secondary);
            }

            .form-input {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid var(--border-color);
                border-radius: var(--radius);
                font-size: 0.875rem;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 0.75rem;
                margin-top: 2rem;
            }

            /* Notification styles */
            .notification {
                padding: 1rem;
                margin-bottom: 1.5rem;
                border-radius: var(--radius);
            }

            .notification-success {
                background-color: #E8F5E9;
                color: #2E7D32;
                border: 1px solid #A5D6A7;
            }

            .notification-error {
                background-color: #FFEBEE;
                color: #C62828;
                border: 1px solid #EF9A9A;
            }

            /* Role badges */
            .role-badge {
                display: inline-block;
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 500;
                text-transform: capitalize;
            }

            .role-admin {
                background-color: #FFEBEE;
                color: #C62828;
                border: 1px solid #EF9A9A;
            }

            .role-super_admin {
                background-color: #E3F2FD;
                color: #1565C0;
                border: 1px solid #90CAF9;
            }

            .role-student {
                background-color: #E8F5E9;
                color: #2E7D32;
                border: 1px solid #A5D6A7;
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
            <a href="${pageContext.request.contextPath}/admin/member" class="nav-item active"><i class="fas fa-users"></i> Member</a>
            <a href="${pageContext.request.contextPath}/admin/addBook" class="nav-item"><i class="fas fa-book"></i> Add Books</a>
            <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item "><i class="fas fa-tasks"></i> Transaction Control</a>
            <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
            <a  href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>




          </nav>
        </aside>

        <div class="main-section">
            <!-- Global Header -->
            <div class="global-header">
                <div class="global-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search Ex. ISBN, Title, Author, Member, etc">
                </div>
                <div class="header-actions">
                    <div class="date-filter">
                        Last 6 months <i class="fas fa-chevron-down"></i>
                    </div>
                    <i class="fas fa-bell"></i>
                    <img src="https://via.placeholder.com/32" alt="Profile" class="profile-image">
                </div>
            </div>

            <!-- Main Content -->
            <main class="main-content">
                <div class="page-header">
                    <h1 class="page-title">Members</h1>
                    <p class="page-subtitle">To create a member and view the member report</p>
                </div>

                <!-- Notifications -->
                <c:if test="${not empty successMessage}">
                    <div class="notification notification-success">
                        ${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="notification notification-error">
                        ${errorMessage}
                    </div>
                </c:if>

                <div class="actions-row">
                    <div class="search-member">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search Member" id="memberSearch">
                    </div>
                    <div class="action-buttons">
                        <button class="btn btn-primary" onclick="openAddUserModal()">
                            <i class="fas fa-user-plus"></i> Add Member
                        </button>
                    </div>
                </div>

                <table class="members-table">
                    <thead>
                        <tr>
                            <th>Member ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty users}">
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>#${user.userId}</td>
                                        <td>${user.fullName}</td>
                                        <td>
                                            <span class="role-badge role-${user.role.toString().toLowerCase()}">
                                                ${user.role}
                                            </span>
                                        </td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>
                                            <div class="table-actions">
                                                <button class="btn btn-edit" onclick="window.location.href='${pageContext.request.contextPath}/admin/editUser?id=${user.userId}'">
                                                    <i class="fas fa-edit"></i> Edit
                                                </button>
                                                <c:if test="${user.userId != currentUserId}">
                                                    <form action="${pageContext.request.contextPath}/admin/deleteUser" method="post" style="display: inline;">
                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                        <button type="submit" class="btn btn-cancel" onclick="return confirm('Are you sure you want to delete this user?')">
                                                            <i class="fas fa-trash-alt"></i> Delete
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" style="text-align: center;">No members found</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </main>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Add New Member</h3>
                <button class="close-btn" onclick="closeAddUserModal()">&times;</button>
            </div>

            <form id="addUserForm" action="${pageContext.request.contextPath}/admin/addUser" method="post">
                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Phone</label>
                    <input type="tel" name="phone" class="form-input">
                </div>

                <div class="form-group">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-input" required>
                        <option value="STUDENT">Student</option>
                        <option value="ADMIN">Admin</option>
                    </select>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeAddUserModal()">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create Member</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Modal functions
        function openAddUserModal() {
            document.getElementById('addUserModal').style.display = 'block';
        }

        function closeAddUserModal() {
            document.getElementById('addUserModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('addUserModal');
            if (event.target == modal) {
                closeAddUserModal();
            }
        }

        // Search functionality
        document.getElementById('memberSearch').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.members-table tbody tr');

            rows.forEach(row => {
                if (row.querySelector('td[colspan]')) return;

                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Password confirmation (if needed)
        document.getElementById('addUserForm')?.addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]')?.value;

            if (confirmPassword && password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    </script>
</body>
</html>