<%@ page contentType="text/html;charset=UTF-8" %>
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
      --background: #F8F9FA;
      --card-bg: #FFFFFF;
      --text-primary: #2D3436;
      --text-secondary: #636E72;
      --border-color: #E9ECEF;
      --hover-bg: #F1F4F6;
      --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      --radius: 12px;
      --transition-speed: 0.3s;
    }

    /* Reset & Base */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Roboto, sans-serif;
    }

    body {
      background: var(--background);
      color: var(--text-primary);
    }

    a {
      text-decoration: none;
      color: inherit;
    }

    /* Layout */
    .app-container {
      display: flex;
      height: 100vh;
      overflow: hidden;
    }

    /* Sidebar */
    .sidebar {
      background: var(--card-bg);
      border-right: 1px solid var(--border-color);
      width: 250px;
      padding: 2rem 1.5rem;
      display: flex;
      flex-direction: column;
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
      gap: 0.75rem;
      padding: 0.75rem 1rem;
      font-size: 1rem;
      border-radius: var(--radius);
      transition: background var(--transition-speed);
      margin-bottom: 0.5rem;
    }

    .nav-item i {
      font-size: 1.25rem;
    }

    .nav-item:hover {
      background: var(--hover-bg);
    }

    .nav-item.active {
      background: var(--primary);
      color: #fff;
    }

    /* Main Content */
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

    .global-search {
      display: flex;
      align-items: center;
      padding: 0.5rem 1rem;
      background: var(--card-bg);
      border: 1px solid var(--border-color);
      border-radius: var(--radius);
      width: 100%;
      max-width: 400px;
    }

    .global-search input {
      border: none;
      outline: none;
      font-size: 1rem;
      flex: 1;
      margin-left: 0.75rem;
    }

    /* Transaction Control */
    .card {
      background: var(--card-bg);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      padding: 1.5rem;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      justify-content: space-between;
      transition: box-shadow var(--transition-speed);
    }

    .card:hover {
      box-shadow: 0 6px 8px rgba(0, 0, 0, 0.1);
    }

    .card i {
      font-size: 2rem;
      color: var(--primary);
    }

    .card-content {
      flex: 1;
      margin-left: 1rem;
    }

    .card-title {
      font-size: 1.25rem;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .card-subtitle {
      font-size: 0.95rem;
      color: var(--text-secondary);
    }

    .card-action {
      padding: 0.5rem 1rem;
      background: var(--primary);
      color: #fff;
      font-size: 0.9rem;
      border-radius: var(--radius);
      cursor: pointer;
      border: none;
      transition: background var(--transition-speed);
    }

    .card-action:hover {
      background: #43A047;
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
        <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item"><i class="fas fa-th-large"></i> Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
         <a href="${pageContext.request.contextPath}/admin/books" class="nav-item"><i class="fas fa-list"></i> Book</a>
        <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item active"><i class="fas fa-tasks"></i> Transaction Control</a>
        <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
        <a  href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>




      </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="header">
        <div class="global-search">
          <i class="fas fa-search"></i>
          <input type="text" placeholder="Search Transactions" />
        </div>
      </div>

      <!-- Cards Section -->
      <div class="card">
        <i class="fas fa-check-circle"></i>
        <div class="card-content">
          <h2 class="card-title">Approve/Reject Book Requests</h2>
          <p class="card-subtitle">Review and handle all book issue requests.</p>
        </div>
        <button class="card-action">Manage</button>
      </div>

      <div class="card">
        <i class="fas fa-calendar-alt"></i>
        <div class="card-content">
          <h2 class="card-title">Set/Modify Due Dates</h2>
          <p class="card-subtitle">Adjust due dates for borrowed books.</p>
        </div>
        <button class="card-action">Adjust</button>
      </div>

      <div class="card">
        <i class="fas fa-sync-alt"></i>
        <div class="card-content">
          <h2 class="card-title">Process Book Returns</h2>
          <p class="card-subtitle">Record and track book return details.</p>
        </div>
        <button class="card-action">Process</button>
      </div>

      <div class="card">
        <i class="fas fa-clock"></i>
        <div class="card-content">
          <h2 class="card-title">Handle Book Renewals</h2>
          <p class="card-subtitle">Allow members to renew borrowed books.</p>
        </div>
        <button class="card-action">Renew</button>
      </div>

      <div class="card">
        <i class="fas fa-exclamation-circle"></i>
        <div class="card-content">
          <h2 class="card-title">Mark Books as Overdue</h2>
          <p class="card-subtitle">Identify and handle overdue books.</p>
        </div>
        <button class="card-action">Update</button>
      </div>

      <div class="card">
        <i class="fas fa-chart-line"></i>
        <div class="card-content">
          <h2 class="card-title">Track Borrowing History</h2>
          <p class="card-subtitle">View and analyze past transactions.</p>
        </div>
        <button class="card-action">View</button>
      </div>
    </main>
  </div>
</body>
</html>
