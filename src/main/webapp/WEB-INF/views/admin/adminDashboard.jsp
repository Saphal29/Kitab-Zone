<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library App</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Include Chart.js for graphs -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #4CAF50;
            --danger: #FF5252;
            --warning: #FFC107;
            --success: #66BB6A;
            --background: #F8F9FA;
            --card-bg: #FFFFFF;
            --text-primary: #2D3436;
            --text-secondary: #636E72;
            --border-color: #E9ECEF;
            --hover-bg: #F1F4F6;
            --shadow: 0 2px 4px rgba(0,0,0,0.05);
            --radius: 12px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        body {
            background: var(--background);
            color: var(--text-primary);
        }

        .app-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            background: var(--card-bg);
            padding: 2rem;
            border-right: 1px solid var(--border-color);
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
            padding: 0.875rem 1rem;
            color: var(--text-secondary);
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 0.5rem;
            transition: all 0.2s ease;
        }

        .nav-item.active {
            background: var(--primary);
            color: white;
        }

        .nav-item i {
            margin-right: 12px;
            width: 20px;
        }

        /* Main Content */
        .main-content {
            padding: 2rem;
        }

        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            width: 400px;
            border: 1px solid var(--border-color);
        }

        .search-bar input {
            border: none;
            outline: none;
            width: 100%;
            margin-left: 8px;
            font-size: 0.95rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--card-bg);
            padding: 1.25rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .stat-value {
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .stat-trend {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            border-radius: 1rem;
            font-size: 0.75rem;
            margin-left: 0.5rem;
        }

        .trend-up { background: #E8F5E9; color: var(--success); }
        .trend-down { background: #FFEBEE; color: var(--danger); }

        /* Charts */
        .charts-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .chart-container {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        /* Tables */
        .table-container {
            background: var(--card-bg);
            border-radius: var(--radius);
            padding: 1.5rem;
            box-shadow: var(--shadow);
            margin-bottom: 1.5rem;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .table-title {
            font-size: 1.125rem;
            font-weight: 600;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th,
        .data-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .data-table th {
            font-weight: 500;
            color: var(--text-secondary);
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.875rem;
        }

        .status-available {
            background: #E8F5E9;
            color: var(--success);
        }

        /* View All Link */
        .view-all {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .charts-section {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .app-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }

            .search-bar {
                width: 100%;
                max-width: 300px;
            }
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
                <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item active"><i class="fas fa-th-large"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
                <a href="${pageContext.request.contextPath}/admin/addBook" class="nav-item"><i class="fas fa-book"></i> Add Books</a>
               <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
                <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
                <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>



              </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <div class="header">
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search Ex. ISBN, Title, Author, Member, etc">
                </div>
                <div class="header-actions">
                    <div class="date-filter">
                        Last 6 months
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <i class="fas fa-bell"></i>
                    <img src="https://via.placeholder.com/32" alt="Profile" style="border-radius: 50%;">
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">
                        2405
                        <span class="stat-trend trend-up">+23%</span>
                    </div>
                    <div class="stat-label">Borrowed Books</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">
                        783
                        <span class="stat-trend trend-down">-14%</span>
                    </div>
                    <div class="stat-label">Returned Books</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">
                        45
                        <span class="stat-trend trend-up">+11%</span>
                    </div>
                    <div class="stat-label">Overdue Books</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">
                        12
                        <span class="stat-trend trend-up">+11%</span>
                    </div>
                    <div class="stat-label">Missing Books</div>
                </div>
            </div>

            <!-- Second Row Stats -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">32345</div>
                    <div class="stat-label">Total Books</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">1504</div>
                    <div class="stat-label">Visitors</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">34</div>
                    <div class="stat-label">New Members</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">$765</div>
                    <div class="stat-label">Pending Fees</div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-container">
                    <h3>Check-out Statistics</h3>
                    <canvas id="checkoutChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Overdue's History</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Member ID</th>
                                <th>Title</th>
                                <th>Due Date</th>
                                <th>Fine</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Add table rows here -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Recent Check-outs Table -->
            <div class="table-container">
                <div class="table-header">
                    <h3 class="table-title">Recent Check-out's</h3>
                    <a href="#" class="view-all">View All</a>
                </div>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>ISBN</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Member</th>
                            <th>Issued Date</th>
                            <th>Return Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Add table rows here -->
                    </tbody>
                </table>
            </div>
        </main>
    </div>

    <script>
        // Initialize Charts
        const ctx = document.getElementById('checkoutChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Borrowed',
                    data: [3000, 3500, 3200, 3700, 2500, 3200, 3400],
                    borderColor: '#4CAF50',
                    tension: 0.4
                },
                {
                    label: 'Returned',
                    data: [2000, 2800, 3900, 3600, 3800, 3000, 2500],
                    borderColor: '#FF5252',
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>