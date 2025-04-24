<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Reservations - Library Management System</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
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
      --warning: #FFC107;
      --danger: #DC3545;
      --success: #28A745;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }

    body {
      background: var(--background);
      min-height: 100vh;
      overflow-x: hidden;
    }

    .app-container {
      display: flex;
      min-height: 100vh;
    }

    .sidebar {
      background: var(--card-bg);
      padding: 1.5rem;
      border-right: 1px solid var(--border-color);
      width: 250px;
      flex-shrink: 0;
    }

    .app-logo {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      font-size: 1.25rem;
      font-weight: 600;
      margin-bottom: 2rem;
      color: var(--text-primary);
    }

    .app-logo i {
      font-size: 1.5rem;
      color: var(--primary);
    }

    nav {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    .nav-item {
      display: flex;
      align-items: center;
      padding: 0.875rem 1rem;
      color: var(--text-secondary);
      text-decoration: none;
      border-radius: var(--radius);
      transition: all 0.2s;
      font-size: 0.95rem;
    }

    .nav-item i {
      width: 20px;
      margin-right: 0.75rem;
      font-size: 1.1rem;
    }

    .nav-item:hover {
      background: var(--hover-bg);
      color: var(--text-primary);
    }

    .nav-item.active {
      background: var(--primary);
      color: white;
    }

    .nav-item.active i {
      color: white;
    }

    .nav-group {
      margin-bottom: 1.5rem;
    }

    .nav-group-title {
      font-size: 0.75rem;
      text-transform: uppercase;
      color: var(--text-secondary);
      font-weight: 500;
      padding: 0 1rem;
      margin-bottom: 0.5rem;
    }

    .main-content {
      flex: 1;
      padding: 2rem;
      overflow-y: auto;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
    }

    .page-title {
      font-size: 1.75rem;
      font-weight: 600;
      color: var(--text-primary);
    }

    .tabs {
      display: flex;
      gap: 1rem;
      margin-bottom: 2rem;
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 1rem;
      flex-wrap: wrap;
    }

    .tab {
      padding: 0.75rem 1.5rem;
      border-radius: var(--radius);
      cursor: pointer;
      font-weight: 500;
      color: var(--text-secondary);
      transition: all 0.2s;
    }

    .tab.active {
      background: var(--primary);
      color: white;
    }

    .reservations-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
      gap: 1.5rem;
    }

    .reservation-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      padding: 1.5rem;
      box-shadow: var(--shadow);
    }

    .reservation-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 1.5rem;
    }

    .book-info {
      display: flex;
      gap: 1.5rem;
    }

    .book-cover {
      width: 100px;
      height: 150px;
      border-radius: var(--radius);
      overflow: hidden;
    }

    .book-cover img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .book-details h3 {
      font-size: 1.25rem;
      margin-bottom: 0.5rem;
      color: var(--text-primary);
    }

    .book-author {
      color: var(--text-secondary);
      margin-bottom: 1rem;
    }

    .status-badge {
      padding: 0.5rem 1rem;
      border-radius: 50px;
      font-size: 0.875rem;
      font-weight: 500;
    }

    .status-active {
      background: #E8F5E9;
      color: var(--success);
    }

    .status-pending {
      background: #FFF3E0;
      color: var(--warning);
    }

    .status-expiring {
      background: #FFEBEE;
      color: var(--danger);
    }

    .reservation-timeline {
      margin: 2rem 0;
      position: relative;
      padding-left: 2rem;
    }

    .timeline-item {
      position: relative;
      padding-bottom: 1.5rem;
    }

    .timeline-item::before {
      content: '';
      position: absolute;
      left: -2rem;
      top: 0;
      width: 1px;
      height: 100%;
      background: var(--border-color);
    }

    .timeline-item::after {
      content: '';
      position: absolute;
      left: -2.25rem;
      top: 0.25rem;
      width: 0.5rem;
      height: 0.5rem;
      border-radius: 50%;
      background: var(--primary);
    }

    .timeline-date {
      font-size: 0.875rem;
      color: var(--text-secondary);
      margin-bottom: 0.25rem;
    }

    .timeline-event {
      color: var(--text-primary);
    }

    .queue-position {
      background: var(--hover-bg);
      padding: 1rem;
      border-radius: var(--radius);
      margin: 1rem 0;
    }

    .position-indicator {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-top: 0.5rem;
    }

    .position-bar {
      flex: 1;
      height: 4px;
      background: var(--border-color);
      border-radius: 2px;
      overflow: hidden;
    }

    .position-progress {
      height: 100%;
      background: var(--primary);
      width: 30%;
    }

    .reservation-actions {
      display: flex;
      gap: 1rem;
      margin-top: 1.5rem;
      padding-top: 1.5rem;
      border-top: 1px solid var(--border-color);
      flex-wrap: wrap;
    }

    .btn {
      padding: 0.75rem 1.5rem;
      border-radius: var(--radius);
      font-size: 0.95rem;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      transition: all 0.2s;
      border: none;
    }

    .btn-primary {
      background: var(--primary);
      color: white;
    }

    .btn-outline {
      border: 1px solid var(--border-color);
      background: transparent;
      color: var(--text-secondary);
    }

    .btn-danger {
      background: var(--danger);
      color: white;
    }

    .notification-settings {
      margin-top: 1rem;
      font-size: 0.875rem;
      color: var(--text-secondary);
    }

    .settings-toggle {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      cursor: pointer;
    }

    .settings-toggle i {
      color: var(--primary);
    }

    @media (max-width: 768px) {
      .app-container {
        flex-direction: column;
      }
      .sidebar {
        width: 100%;
        height: auto;
        position: static;
        border-right: none;
        border-bottom: 1px solid var(--border-color);
      }
      .main-content {
        margin-left: 0;
      }
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
      <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item">
          <i class="fas fa-th-large"></i>
          Dashboard
      </a>
       <a href="${pageContext.request.contextPath}/student/myBooks" class="nav-item">
          <i class="fas fa-book"></i>
          My Books
      </a>
       <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item">
          <i class="fas fa-search"></i>
          Browse Books
      </a>
      <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item active">
          <i class="fas fa-clock"></i>
          Reservations
      </a>
      <a href="${pageContext.request.contextPath}/student/fines" class="nav-item">
          <i class="fas fa-dollar-sign"></i>
          Fines & Payments
      </a>
      <a href="${pageContext.request.contextPath}/student/profile" class="nav-item">
          <i class="fas fa-user"></i>
          Profile
      </a>
  </nav>
</aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="header">
        <h1 class="page-title">My Reservations</h1>
      </div>

      <div class="tabs">
        <div class="tab active">Active (2)</div>
        <div class="tab">Pending (1)</div>
        <div class="tab">History</div>
      </div>

       <!-- Reservations Grid -->
       <div class="reservations-grid">
        <!-- Active Reservation -->
        <div class="reservation-card">
            <div class="reservation-header">
                <div class="book-info">
                    <div class="book-cover">
                        <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c" alt="Book Cover">
                    </div>
                    <div class="book-details">
                        <h3>The Design of Everyday Things</h3>
                        <p class="book-author">Don Norman</p>
                        <span class="status-badge status-active">Ready for Pickup</span>
                    </div>
                </div>
            </div>

            <div class="reservation-timeline">
                <div class="timeline-item">
                    <div class="timeline-date">Today</div>
                    <div class="timeline-event">Book is ready for pickup</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">Oct 15, 2023</div>
                    <div class="timeline-event">Reservation confirmed</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">Oct 14, 2023</div>
                    <div class="timeline-event">Reservation requested</div>
                </div>
            </div>

            <div class="notification-settings">
                <div class="settings-toggle">
                    <i class="fas fa-bell"></i>
                    Email notifications enabled
                </div>
            </div>

            <div class="reservation-actions">
                <button class="btn btn-primary">
                    <i class="fas fa-check"></i>
                    Confirm Pickup
                </button>
                <button class="btn btn-danger">
                    <i class="fas fa-times"></i>
                    Cancel Reservation
                </button>
            </div>
        </div>

        <!-- Pending Reservation -->
        <div class="reservation-card">
            <div class="reservation-header">
                <div class="book-info">
                    <div class="book-cover">
                        <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73" alt="Book Cover">
                    </div>
                    <div class="book-details">
                        <h3>Clean Code</h3>
                        <p class="book-author">Robert C. Martin</p>
                        <span class="status-badge status-pending">Queue Position: 2</span>
                    </div>
                </div>
            </div>

            <div class="queue-position">
                <h4>Your Position in Queue</h4>
                <div class="position-indicator">
                    <span>2 of 6</span>
                    <div class="position-bar">
                        <div class="position-progress"></div>
                    </div>
                </div>
            </div>

            <div class="reservation-timeline">
                <div class="timeline-item">
                    <div class="timeline-date">Estimated availability</div>
                    <div class="timeline-event">Nov 1, 2023</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">Oct 10, 2023</div>
                    <div class="timeline-event">Added to queue</div>
                </div>
            </div>

            <div class="notification-settings">
                <div class="settings-toggle">
                    <i class="fas fa-bell"></i>
                    Notify when available
                </div>
            </div>

            <div class="reservation-actions">
                <button class="btn btn-outline">
                    <i class="fas fa-eye"></i>
                    View Details
                </button>
                <button class="btn btn-danger">
                    <i class="fas fa-times"></i>
                    Leave Queue
                </button>
            </div>
        </div>
    </main>
  </div>
</body>
</html>
