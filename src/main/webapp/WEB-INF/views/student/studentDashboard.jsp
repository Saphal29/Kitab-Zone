
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Library Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #4CAF50;
            --background: #F8F9FA;
            --card-bg: #FFFFFF;
            --text-primary: #2D3436;
            --text-secondary: #636E72;
            --border-color: #E9ECEF;
            --hover-bg: #F1F4F6;
            --shadow: 0 2px 4px rgba(0,0,0,0.05);
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
            gap: 0.75rem;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 2.5rem;
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

        .global-search {
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 0.75rem 1rem;
            width: 400px;
        }

        .global-search input {
            border: none;
            outline: none;
            width: 100%;
            margin-left: 0.75rem;
            font-size: 0.95rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .profile-image {
            width: 32px;
            height: 32px;
            border-radius: 50%;
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
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .stat-title {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .stat-trend {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            font-size: 0.875rem;
        }

        .trend-up {
            color: #00B894;
        }

        .trend-down {
            color: #FF5252;
        }

        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .chart-card {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .chart-container {
            flex: 1;
            position: relative;
            width: 100%;
            height: calc(100% - 50px);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .chart-title {
            font-weight: 600;
            color: var(--text-primary);
        }

        .chart-actions {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .chart-actions select {
            padding: 0.5rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
        }

        /* Table */
        .table-card {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            max-height: 400px;
            overflow-y: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .table th {
            font-weight: 500;
            color: var(--text-secondary);
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.875rem;
        }

        .status-overdue {
            background: #FFE0E0;
            color: #FF5252;
        }

        .status-returned {
            background: #E0F2E9;
            color: #00B894;
        }

        /* Popular Books Section */
        .popular-books {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-top: 2rem;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .view-all {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 2rem;
        }

        .book-card {
            display: flex;
            flex-direction: column;
            transition: transform 0.2s ease;
        }

        .book-card:hover {
            transform: translateY(-4px);
        }

        .book-cover {
            position: relative;
            aspect-ratio: 2/3;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-rating {
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
            background: rgba(0, 0, 0, 0.75);
            color: #fff;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .book-rating i {
            color: #FFC107;
        }

        .book-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .book-title {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.95rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .book-author {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .book-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.5rem;
        }

        .book-meta span {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        /* Optional: Add a visual separator */
        .section-divider {
            height: 1px;
            background: var(--border-color);
            margin: 2rem 0;
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <div class="app-container">
       <!-- This sidebar structure should be the same in all files -->
<aside class="sidebar">
  <div class="app-logo">
      <i class="fas fa-book"></i>
      KitabZone
  </div>
  <nav>
      <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item active">
          <i class="fas fa-th-large"></i>
          Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/student/myBooks" class="nav-item">
          <i class="fas fa-book"></i>
          My Books
      </a>
      <a href="${pageContext.request.contextPath}/student/browseBooks"  class="nav-item">
          <i class="fas fa-search"></i>
          Browse Books
      </a>
      <a href="${pageContext.request.contextPath}/student/reservation"  class="nav-item">
          <i class="fas fa-clock"></i>
          Reservations
      </a>
      <a href="${pageContext.request.contextPath}/student/fines"  class="nav-item">
          <i class="fas fa-dollar-sign"></i>
          Fines & Payments
      </a>
      <a href="${pageContext.request.contextPath}/student/profile"  class="nav-item">
          <i class="fas fa-user"></i>
          Profile
      </a>
  </nav>
</aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <div class="header">
                <div class="global-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search books, authors, categories...">
                </div>
                <div class="header-actions">
                    <div class="date-filter">
                        Last 30 days <i class="fas fa-chevron-down"></i>
                    </div>
                    <i class="fas fa-bell"></i>
                    <img src="https://via.placeholder.com/32" alt="Profile" class="profile-image">
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-title">Currently Borrowed</div>
                    <div class="stat-value">3</div>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up trend-up"></i>
                        <span class="trend-up">2 new this month</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Books Read</div>
                    <div class="stat-value">24</div>
                    <div class="stat-trend">
                        <i class="fas fa-arrow-up trend-up"></i>
                        <span class="trend-up">5 this month</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Due Soon</div>
                    <div class="stat-value">1</div>
                    <div class="stat-trend trend-down">
                        <i class="fas fa-clock"></i>
                        Due in 2 days
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-title">Reading List</div>
                    <div class="stat-value">8</div>
                    <div class="stat-trend">
                        <i class="fas fa-plus"></i>
                        <span>3 new added</span>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Reading Activity</h3>
                        <div class="chart-actions">
                            <select>
                                <option>Last 6 months</option>
                                <option>Last year</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="activityChart"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <div class="chart-header">
                        <h3 class="chart-title">Reading Categories</h3>
                    </div>
                    <div class="chart-container">
                        <canvas id="categoriesChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="section-divider"></div>

            <!-- Current Borrows Table -->
            <div class="popular-books">
                <div class="section-header">
                    <h3 class="section-title">Popular Books</h3>
                    <a href="#" class="view-all">
                        View all books
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <div class="books-grid">
                    <!-- Book 1 -->
                    <div class="book-card">
                        <div class="book-cover">
                            <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80"
                                 alt="Atomic Habits">
                            <div class="book-rating">
                                <i class="fas fa-star"></i>
                                4.8
                            </div>
                        </div>
                        <div class="book-info">
                            <h4 class="book-title">Atomic Habits</h4>
                            <p class="book-author">James Clear</p>
                            <div class="book-meta">
                                <span><i class="fas fa-users"></i> 2.1k reads</span>
                                <span><i class="fas fa-book"></i> 320 pages</span>
                            </div>
                        </div>
                    </div>

                    <!-- Book 2 -->
                    <div class="book-card">
                        <div class="book-cover">
                            <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1112&q=80"
                                 alt="Deep Work">
                            <div class="book-rating">
                                <i class="fas fa-star"></i>
                                4.7
                            </div>
                        </div>
                        <div class="book-info">
                            <h4 class="book-title">Deep Work: Rules for Focused Success</h4>
                            <p class="book-author">Cal Newport</p>
                            <div class="book-meta">
                                <span><i class="fas fa-users"></i> 1.8k reads</span>
                                <span><i class="fas fa-book"></i> 296 pages</span>
                            </div>
                        </div>
                    </div>

                    <!-- Book 3 -->
                    <div class="book-card">
                        <div class="book-cover">
                            <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80"
                                 alt="The Psychology of Money">
                            <div class="book-rating">
                                <i class="fas fa-star"></i>
                                4.6
                            </div>
                        </div>
                        <div class="book-info">
                            <h4 class="book-title">The Psychology of Money</h4>
                            <p class="book-author">Morgan Housel</p>
                            <div class="book-meta">
                                <span><i class="fas fa-users"></i> 1.5k reads</span>
                                <span><i class="fas fa-book"></i> 256 pages</span>
                            </div>
                        </div>
                    </div>

                    <!-- Book 4 -->
                    <div class="book-card">
                        <div class="book-cover">
                            <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80"
                                 alt="The Lean Startup">
                            <div class="book-rating">
                                <i class="fas fa-star"></i>
                                4.5
                            </div>
                        </div>
                        <div class="book-info">
                            <h4 class="book-title">The Lean Startup</h4>
                            <p class="book-author">Eric Ries</p>
                            <div class="book-meta">
                                <span><i class="fas fa-users"></i> 1.2k reads</span>
                                <span><i class="fas fa-book"></i> 336 pages</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Activity Chart
        const activityCtx = document.getElementById('activityChart').getContext('2d');
        new Chart(activityCtx, {
            type: 'line',
            data: {
                labels: ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
                datasets: [{
                    label: 'Books Read',
                    data: [4, 3, 5, 6, 3, 5],
                    borderColor: '#4CAF50',
                    tension: 0.4,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });

        // Categories Chart
        const categoriesCtx = document.getElementById('categoriesChart').getContext('2d');
        new Chart(categoriesCtx, {
            type: 'doughnut',
            data: {
                labels: ['Fiction', 'Technology', 'Science', 'Self-Help'],
                datasets: [{
                    data: [8, 6, 4, 6],
                    backgroundColor: ['#4CAF50', '#2196F3', '#FFC107', '#9C27B0']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            boxWidth: 12,
                            padding: 15
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>