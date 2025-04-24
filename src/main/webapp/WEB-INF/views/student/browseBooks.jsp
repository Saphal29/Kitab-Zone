<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Browse Books - Library Management System</title>
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
      --shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      --radius: 8px;
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
    }

    a {
      text-decoration: none;
      color: inherit;
    }

    .app-container {
      display: flex;
      width: 100%;
      height: 100vh;
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

    .nav-item {
      display: flex;
      align-items: center;
      padding: 0.75rem 1rem;
      border-radius: var(--radius);
      font-size: 1rem;
      gap: 0.75rem;
      margin-bottom: 0.5rem;
      transition: background 0.2s;
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
      display: flex;
      flex-direction: column;
    }

    .header {
      display: flex;
      flex-direction: column;
      gap: 1rem;
      margin-bottom: 2rem;
    }

    .header-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .page-title {
      font-size: 1.75rem;
      font-weight: 600;
      color: var(--text-primary);
    }

    .search-filter-row {
      display: flex;
      align-items: center;
      gap: 1rem;
      flex-wrap: wrap;
      justify-content: space-between;
    }

    .search-container {
      position: relative;
      flex: 1;
      max-width: 600px;
    }

    .search-input {
      width: 100%;
      padding: 1rem 1rem 1rem 3.5rem;
      background: white;
      border: 1px solid var(--border-color);
      border-radius: 50px;
      font-size: 1rem;
      color: var(--text-primary);
    }

    .search-input:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(76, 175, 80, 0.1);
    }

    .search-icon {
      position: absolute;
      left: 1.25rem;
      top: 50%;
      transform: translateY(-50%);
      color: #A0AEC0;
      font-size: 1.25rem;
    }

    .filter-pills {
      display: flex;
      gap: 0.5rem;
      flex-wrap: wrap;
    }

    .filter-pill {
      padding: 0.5rem 1rem;
      background: white;
      border: 1px solid var(--border-color);
      border-radius: 50px;
      font-size: 0.875rem;
      color: var(--text-secondary);
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .filter-pill:hover {
      border-color: var(--primary);
      color: var(--primary);
    }

    .filter-pill.active {
      background: var(--primary);
      color: white;
      border-color: var(--primary);
    }

    /* Categories */
    .categories {
      display: flex;
      overflow-x: auto;
      gap: 1rem;
      margin-bottom: 2rem;
      padding-bottom: 4rem;
    }

    .category {
      padding: 1.3rem 1rem;
      border-radius: var(--radius);
      background: var(--card-bg);
      color: var(--text-secondary);
      text:center;
      font-weight: 500;
      white-space: nowrap;
      cursor: pointer;
      transition: background 0.2s;
    }

    .category.active {
      background: var(--primary);
      color: white;
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
      box-shadow: var(--shadow);
      overflow: hidden;
      transition: transform 0.2s;
    }

    .book-card:hover {
      transform: translateY(-4px);
    }

    .book-cover {
      height: 300px;
      position: relative;
    }

    .book-cover img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .book-status {
      position: absolute;
      top: 1rem;
      right: 1rem;
      font-size: 0.75rem;
      font-weight: 500;
      padding: 0.25rem 0.75rem;
      border-radius: 1rem;
      background: rgba(255, 255, 255, 0.9);
    }

    .status-available {
      color: var(--primary);
    }

    .status-borrowed {
      color: #DC3545;
    }

    .book-info {
      padding: 1.5rem;
    }

    .book-title {
      font-weight: 600;
      color: var(--text-primary);
      margin-bottom: 0.5rem;
    }

    .book-author {
      color: var(--text-secondary);
      font-size: 0.875rem;
      margin-bottom: 1rem;
    }

    .book-meta {
      display: flex;
      justify-content: space-between;
      font-size: 0.875rem;
      color: var(--text-secondary);
      margin-bottom: 1rem;
    }

    .book-rating {
      display: flex;
      align-items: center;
      gap: 0.25rem;
    }

    .star-filled {
      color: #FFC107;
    }

    .book-actions {
      display: flex;
      gap: 0.5rem;
    }

    .btn {
      padding: 0.75rem 1rem;
      border: none;
      border-radius: var(--radius);
      font-size: 0.875rem;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      transition: 0.2s;
    }

    .btn-primary {
      background: var(--primary);
      color: white;
      flex: 1;
      justify-content: center;
    }

    .btn-outline {
      background: transparent;
      border: 1px solid var(--border-color);
      color: var(--text-secondary);
    }

    .pagination {
      display: flex;
      justify-content: center;
      gap: 0.5rem;
      margin-top: 2rem;
    }

    .page-btn {
      padding: 0.5rem 1rem;
      background: var(--card-bg);
      border: 1px solid var(--border-color);
      border-radius: var(--radius);
      cursor: pointer;
    }

    .page-btn.active {
      background: var(--primary);
      color: white;
      border-color: var(--primary);
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
       <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item active">
          <i class="fas fa-search"></i>
          Browse Books
      </a>
       <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item">
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
        <div class="header-top">
          <h1 class="page-title">Browse Books</h1>
        </div>

        <div class="search-filter-row">
          <div class="search-container">
            <input type="text" class="search-input" placeholder="Search for books, authors, or ISBN...">
            <i class="fas fa-search search-icon"></i>
          </div>

          <div class="filter-pills">
            <div class="filter-pill active"><i class="fas fa-th-large"></i> All Books</div>
            <div class="filter-pill"><i class="fas fa-book"></i> Available Now</div>
            <div class="filter-pill"><i class="fas fa-star"></i> Most Popular</div>
            <div class="filter-pill"><i class="fas fa-clock"></i> Recently Added</div>
            <div class="filter-pill"><i class="fas fa-filter"></i> Filters</div>
          </div>
        </div>
      </div>

      <div class="categories">
        <div class="category active">All Books</div>
        <div class="category">Fiction</div>
        <div class="category">Non-Fiction</div>
        <div class="category">Science</div>
        <div class="category">Technology</div>
        <div class="category">Business</div>
        <div class="category">Arts</div>
        <div class="category">History</div>
        <div class="category">Philosophy</div>
      </div>

      <div class="books-grid">
        <!-- Book Card -->
        <div class="book-card">
          <div class="book-cover">
            <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c" alt="Book Cover">
            <div class="book-status status-available">Available</div>
          </div>
          <div class="book-info">
            <h3 class="book-title">The Design of Everyday Things</h3>
            <p class="book-author">Don Norman</p>
            <div class="book-meta">
              <div class="book-rating">
                <i class="fas fa-star star-filled"></i>
                <span>4.5 (128 reviews)</span>
              </div>
              <span>368 pages</span>
            </div>
            <div class="book-actions">
              <button class="btn btn-primary"><i class="fas fa-book"></i> Borrow Now</button>
              <button class="btn btn-outline"><i class="fas fa-bookmark"></i></button>
            </div>
          </div>
        </div>
        <!-- Add more book cards -->
      </div>

      <div class="pagination">
        <button class="page-btn"><i class="fas fa-chevron-left"></i></button>
        <button class="page-btn active">1</button>
        <button class="page-btn">2</button>
        <button class="page-btn">3</button>
        <button class="page-btn">...</button>
        <button class="page-btn">12</button>
        <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
      </div>
    </main>
  </div>
</body>
</html>
