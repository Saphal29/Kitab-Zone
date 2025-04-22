<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Books - Library Management System</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <style>
    :root {
      --primary: #4caf50;
      --background: #f8f9fa;
      --card-bg: #ffffff;
      --text-primary: #2d3436;
      --text-secondary: #636e72;
      --border-color: #e9ecef;
      --hover-bg: #f1f4f6;
      --shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
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
      display: flex;
      min-height: 100vh;
      flex-direction: row;
    }

    /* Sidebar */
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

    .nav-item {
      display: flex;
      align-items: center;
      padding: 0.75rem 1rem;
      color: var(--text-secondary);
      text-decoration: none;
      border-radius: var(--radius);
      margin-bottom: 0.5rem;
      transition: all 0.2s;
    }

    .nav-item:hover {
      background: var(--hover-bg);
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
      flex-grow: 1;
      padding: 2rem;
    }

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
      padding: 1rem 0;
    }

    .page-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--text-primary);
    }

    /* Tabs */
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

    .tab:hover:not(.active) {
      background: var(--hover-bg);
    }

    /* Books Grid */
    .books-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 2rem;
    }

    .book-card {
      background: var(--card-bg);
      border-radius: var(--radius);
      overflow: hidden;
      box-shadow: var(--shadow);
      transition: transform 0.2s;
    }

    .book-card:hover {
      transform: translateY(-4px);
    }

    .book-cover {
      position: relative;
      height: 200px;
    }

    .book-cover img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .due-badge {
      position: absolute;
      top: 1rem;
      right: 1rem;
      background: rgba(255, 82, 82, 0.9);
      color: white;
      padding: 0.25rem 0.75rem;
      border-radius: 1rem;
      font-size: 0.75rem;
    }

    .book-info {
      padding: 1.5rem;
    }

    .book-title {
      font-weight: 600;
      margin-bottom: 0.5rem;
      color: var(--text-primary);
    }

    .book-author {
      color: var(--text-secondary);
      font-size: 0.875rem;
      margin-bottom: 1rem;
    }

    .progress-bar {
      width: 100%;
      height: 4px;
      background: var(--border-color);
      border-radius: 2px;
      margin: 1rem 0;
      overflow: hidden;
    }

    .progress {
      height: 100%;
      background: var(--primary);
      border-radius: 2px;
    }

    .book-meta {
      display: flex;
      justify-content: space-between;
      font-size: 0.875rem;
      color: var(--text-secondary);
    }

    .book-actions {
      display: flex;
      gap: 1rem;
      margin-top: 1rem;
      flex-wrap: wrap;
    }

    .btn {
      padding: 0.5rem 1rem;
      border-radius: var(--radius);
      border: none;
      font-size: 0.875rem;
      cursor: pointer;
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 0.5rem;
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

    .btn:hover {
      opacity: 0.9;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .app-container {
        flex-direction: column;
      }

      .sidebar {
        width: 100%;
        border-right: none;
        border-bottom: 1px solid var(--border-color);
        position: static;
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        justify-content: space-around;
      }

      .main-content {
        margin-left: 0;
        padding: 1rem;
      }

      .tabs {
        flex-direction: column;
        gap: 0.5rem;
      }

      .book-meta {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.5rem;
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
      <a href="studentDashboard.html" class="nav-item">
          <i class="fas fa-th-large"></i>
          Dashboard
      </a>
      <a href="myBooks.html" class="nav-item active">
          <i class="fas fa-book"></i>
          My Books
      </a>
      <a href="browseBooks.html" class="nav-item">
          <i class="fas fa-search"></i>
          Browse Books
      </a>
      <a href="reservations.html" class="nav-item">
          <i class="fas fa-clock"></i>
          Reservations
      </a>
      <a href="fines.html" class="nav-item">
          <i class="fas fa-dollar-sign"></i>
          Fines & Payments
      </a>
      <a href="profile.html" class="nav-item">
          <i class="fas fa-user"></i>
          Profile
      </a>
  </nav>
</aside>

    <main class="main-content">
      <div class="header">
        <h1 class="page-title">My Books</h1>
      </div>

      <div class="tabs">
        <div class="tab active">Currently Borrowed (3)</div>
        <div class="tab">Reading History</div>
        <div class="tab">Saved Books</div>
      </div>
        <!-- Books Grid -->
        <div class="books-grid">
          <!-- Book 1 -->
          <div class="book-card">
              <div class="book-cover">
                  <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c" alt="Book Cover">
                  <div class="due-badge">Due in 3 days</div>
              </div>
              <div class="book-info">
                  <h3 class="book-title">The Design of Everyday Things</h3>
                  <p class="book-author">Don Norman</p>
                  <div class="progress-bar">
                      <div class="progress" style="width: 75%"></div>
                  </div>
                  <div class="book-meta">
                      <span>75% completed</span>
                      <span>Page 180 of 240</span>
                  </div>
                  <div class="book-actions">
                      <button class="btn btn-primary">
                          <i class="fas fa-book-reader"></i>
                          Continue Reading
                      </button>
                      <button class="btn btn-outline">
                          <i class="fas fa-undo"></i>
                          Return
                      </button>
                  </div>
              </div>
          </div>

          <!-- Book 2 -->
          <div class="book-card">
              <div class="book-cover">
                  <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73" alt="Book Cover">
                  <div class="due-badge">Due in 5 days</div>
              </div>
              <div class="book-info">
                  <h3 class="book-title">Clean Code</h3>
                  <p class="book-author">Robert C. Martin</p>
                  <div class="progress-bar">
                      <div class="progress" style="width: 30%"></div>
                  </div>
                  <div class="book-meta">
                      <span>30% completed</span>
                      <span>Page 90 of 300</span>
                  </div>
                  <div class="book-actions">
                      <button class="btn btn-primary">
                          <i class="fas fa-book-reader"></i>
                          Continue Reading
                      </button>
                      <button class="btn btn-outline">
                          <i class="fas fa-undo"></i>
                          Return
                      </button>
                  </div>
              </div>
          </div>

          <!-- Book 3 -->
          <div class="book-card">
              <div class="book-cover">
                  <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f" alt="Book Cover">
                  <div class="due-badge">Due in 7 days</div>
              </div>
              <div class="book-info">
                  <h3 class="book-title">Atomic Habits</h3>
                  <p class="book-author">James Clear</p>
                  <div class="progress-bar">
                      <div class="progress" style="width: 45%"></div>
                  </div>
                  <div class="book-meta">
                      <span>45% completed</span>
                      <span>Page 135 of 300</span>
                  </div>
                  <div class="book-actions">
                      <button class="btn btn-primary">
                          <i class="fas fa-book-reader"></i>
                          Continue Reading
                      </button>
                      <button class="btn btn-outline">
                          <i class="fas fa-undo"></i>
                          Return
                      </button>
                  </div>
              </div>
          </div>

      </div>
    </main>
  </div>
</body>
</html>
