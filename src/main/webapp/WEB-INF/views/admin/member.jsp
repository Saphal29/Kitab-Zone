<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library App - Members</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4CAF50;
            --background: #FFFFFF;
            --text-primary: #333333;
            --text-secondary: #666666;
            --border-color: #EEEEEE;
            --hover-bg: #F8F9FA;
            --edit-btn-bg: #E2E8F0;
            --cancel-btn-bg: #FF5252;
            --radius: 8px;
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
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="app-logo">
                <i class="fas fa-book"></i>
                KitabZone
            </div>
            <nav>
                <a href="adminDashboard.html" class="nav-item"><i class="fas fa-th-large"></i> Dashboard</a>
                <a href="member.html" class="nav-item active"><i class="fas fa-users"></i> Members</a>
                <a href="addbook.html" class="nav-item"><i class="fas fa-book"></i> Add Books</a>
                <a href="transactionControl.html" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
                <a href="reserveManagement.html" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
                <a href="fineManagement.html" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>
                <a href="system.html" class="nav-item "><i class="fas fa-tools"></i> System Configuration</a>


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

                <div class="actions-row">
                    <div class="search-member">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search Member">
                    </div>
                    <div class="action-buttons">
                        <button class="btn btn-primary">
                            <i class="fas fa-user-plus"></i>
                            Add Members
                        </button>
                        <button class="btn btn-secondary">
                            <i class="fas fa-file-import"></i>
                            Import
                        </button>
                    </div>
                </div>

                <table class="members-table">
                    <thead>
                        <tr>
                            <th>Member ID</th>
                            <th>Register ID</th>
                            <th>Member</th>
                            <th>Email ID</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#48964</td>
                            <td>3234</td>
                            <td>Alfredo Bergson</td>
                            <td>Alfredobergson@example.com</td>
                            <td>
                                <div class="table-actions">
                                    <button class="btn btn-edit">Edit</button>
                                    <button class="btn btn-cancel">Cancel</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#48964</td>
                            <td>3234</td>
                            <td>Roger Schleifer</td>
                            <td>Rogerschleifer@example.com</td>
                            <td>
                                <div class="table-actions">
                                    <button class="btn btn-edit">Edit</button>
                                    <button class="btn btn-cancel">Cancel</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#48964</td>
                            <td>3234</td>
                            <td>Angel Calzoni</td>
                            <td>Angelcalzoni@example.com</td>
                            <td>
                                <div class="table-actions">
                                    <button class="btn btn-edit">Edit</button>
                                    <button class="btn btn-cancel">Cancel</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </main>
        </div>
    </div>
</body>
</html>
