<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

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
            --success: #28A745;
            --warning: #FFC107;
            --danger: #DC3545;
        }

        body {
            background-color: var(--background);
        }

        .app-container {
            display: flex;
        }

        .sidebar {
            background: #ffffff;
            padding: 1.5rem;
            border-right: 1px solid #E9ECEF;
            height: 100vh;
            position: fixed;
            width: 250px;
        }

        .app-logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 2rem;
            color: #2D3436;
        }

        .app-logo i {
            color: #4CAF50;
            font-size: 1.5rem;
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
            color: #636E72;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.2s;
            font-size: 0.95rem;
        }

        .nav-item i {
            width: 20px;
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        .nav-item:hover {
            background: #F1F4F6;
            color: #2D3436;
        }

        .nav-item.active {
            background: #4CAF50;
            color: white;
        }

        .nav-item.active i {
            color: white;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-picture {
            position: relative;
            margin-right: 20px;
        }

        .profile-picture img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--card-bg);
            box-shadow: var(--shadow);
        }

        .upload-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .profile-picture:hover .upload-overlay {
            opacity: 1;
        }

        .profile-info h1 {
            margin: 0;
            font-size: 24px;
            color: var(--text-primary);
        }

        .profile-badge {
            display: flex;
            align-items: center;
            color: var(--success);
            font-size: 14px;
        }

        .profile-badge i {
            margin-right: 5px;
        }

        .profile-content {
            display: flex;
            gap: 20px;
        }

        .profile-form, .account-status {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            flex: 1;
        }

        .form-section {
            margin-bottom: 20px;
        }

        .form-section h2 {
            margin-bottom: 10px;
            font-size: 18px;
            color: var(--text-primary);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 5px;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .form-group input {
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 14px;
            color: var(--text-primary);
        }

        .form-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-outline {
            background-color: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn i {
            margin-right: 5px;
        }

        .account-status h2 {
            margin-bottom: 20px;
            font-size: 18px;
            color: var(--text-primary);
        }

        .status-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .status-item:last-child {
            border-bottom: none;
        }

        .status-label {
            font-size: 14px;
            color: var(--text-secondary);
        }

        .status-value {
            font-size: 14px;
            color: var(--text-primary);
        }

        /* Add this to your existing CSS */
        .nav-item.logout {
            margin-top: auto;
            color: var(--danger);
        }

        .nav-item.logout:hover {
            background: #FFEBEE;
            color: var(--danger);
        }

        .nav-item.logout i {
            color: var(--danger);
        }
        /* Add to your existing CSS */
        .sidebar {
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        nav {
            display: flex;
            flex-direction: column;
            flex-grow: 1; /* Takes up remaining space */
        }

        .nav-footer {
            margin-top: auto; /* Pushes the footer to the bottom */
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }

        .nav-item.logout {
            color: var(--danger);
        }

        .nav-item.logout:hover {
            background: #FFEBEE;
            color: var(--danger);
        }

        .nav-item.logout i {
            color: var(--danger);
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
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
       <a href="${pageContext.request.contextPath}/student/reservation" class="nav-item">
          <i class="fas fa-clock"></i>
          Reservations
      </a>
       <a href="${pageContext.request.contextPath}/student/fines" class="nav-item">
          <i class="fas fa-dollar-sign"></i>
          Fines & Payments
      </a>
       <a href="${pageContext.request.contextPath}/student/profile" class="nav-item active">
          <i class="fas fa-user"></i>
          Profile
      </a>


          <div class="nav-footer">
                <a href="${pageContext.request.contextPath}/logout"
                   class="nav-item logout"
                   onclick="return confirm('Are you sure you want to logout?')">
                   <i class="fas fa-sign-out-alt"></i>
                   Logout
                </a>
            </div>
  </nav>
</aside>
        <!-- Main Content -->
        <main class="main-content">
            <!-- Profile Header -->
            <div class="profile-header">
                <div class="profile-picture">
                    <img src="https://via.placeholder.com/150" alt="Profile Picture">
                    <div class="upload-overlay">
                        <i class="fas fa-camera"></i>
                        Change Photo
                    </div>
                </div>
                <div class="profile-info">
                    <h1>John Doe</h1>
                    <p style="color: var(--text-secondary); margin-bottom: 1rem;">Student ID: STU2023001</p>
                    <div class="profile-badge">
                        <i class="fas fa-check-circle"></i>
                        Account Verified
                    </div>
                </div>
            </div>

            <!-- Profile Content -->
            <div class="profile-content">
                <!-- Profile Form -->
                <div class="profile-form">
                    <div class="form-section">
                        <h2>Personal Information</h2>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>First Name</label>
                                <input type="text" class="form-control" value="John">
                            </div>
                            <div class="form-group">
                                <label>Last Name</label>
                                <input type="text" class="form-control" value="Doe">
                            </div>
                            <div class="form-group">
                                <label>Email Address</label>
                                <input type="email" class="form-control" value="john.doe@example.com">
                            </div>
                            <div class="form-group">
                                <label>Phone Number</label>
                                <input type="tel" class="form-control" value="+1 234 567 8900">
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Academic Information</h2>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Student ID</label>
                                <input type="text" class="form-control" value="STU2023001" disabled>
                            </div>
                            <div class="form-group">
                                <label>Department</label>
                                <input type="text" class="form-control" value="Computer Science" disabled>
                            </div>
                            <div class="form-group">
                                <label>Program</label>
                                <input type="text" class="form-control" value="Bachelor of Science" disabled>
                            </div>
                            <div class="form-group">
                                <label>Year</label>
                                <input type="text" class="form-control" value="3rd Year" disabled>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Change Password</h2>
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Current Password</label>
                                <input type="password" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" class="form-control">
                            </div>
                        </div>
                    </div>

                    <div class="form-buttons">
                        <button class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Save Changes
                        </button>
                        <button class="btn btn-outline">
                            <i class="fas fa-undo"></i>
                            Reset
                        </button>
                    </div>
                </div>

                <!-- Account Status -->
                <div class="account-status">
                    <h2 style="margin-bottom: 1.5rem;">Account Status</h2>
                    <div class="status-item">
                        <span class="status-label">Account Type</span>
                        <span class="status-value">Student</span>
                    </div>
                    <div class="status-item">
                        <span class="status-label">Member Since</span>
                        <span class="status-value">Sep 2023</span>
                    </div>
                    <div class="status-item">
                        <span class="status-label">Books Borrowed</span>
                        <span class="status-value">12</span>
                    </div>
                    <div class="status-item">
                        <span class="status-label">Current Borrows</span>
                        <span class="status-value">3</span>
                    </div>
                    <div class="status-item">
                        <span class="status-label">Outstanding Fines</span>
                        <span class="status-value" style="color: var(--danger)">$12.50</span>
                    </div>
                    <div class="status-item">
                        <span class="status-label">Account Status</span>
                        <span class="status-value" style="color: var(--success)">Active</span>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script>
    // Basic confirmation
    function confirmLogout() {
        return confirm('Are you sure you want to logout?');
    }
    </script>
</body>
</html>
