<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile - KitabZone</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        :root {
            --primary: #28a745;
            --primary-light: #e8f5e9;
            --secondary: #f8f9fa;
            --success: #2ecc71;
            --danger: #dc3545;
            --warning: #ffc107;
            --text: #2c3e50;
            --text-light: #6c757d;
            --border: #dee2e6;
            --shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--secondary);
            color: var(--text);
        }

        .app-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background: white;
            padding: 20px;
            box-shadow: var(--shadow);
        }

        .app-logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 30px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 15px;
            color: var(--text);
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 5px;
            transition: all 0.3s ease;
        }

        .nav-item:hover {
            background: var(--primary-light);
        }

        .nav-item.active {
            background: var(--primary);
            color: white;
        }

        .main-content {
            padding: 20px;
        }

        .profile-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow);
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 30px;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--border);
        }

        .profile-picture {
            position: relative;
            width: 150px;
            height: 150px;
        }

        .profile-picture img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary-light);
        }

        .profile-info h1 {
            font-size: 2rem;
            color: var(--text);
            margin-bottom: 10px;
        }

        .profile-info p {
            color: var(--text-light);
            margin-bottom: 5px;
        }

        .profile-section {
            margin-bottom: 30px;
        }

        .profile-section h2 {
            font-size: 1.2rem;
            color: var(--text);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .info-item {
            background: var(--primary-light);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid var(--primary);
        }

        .info-item label {
            display: block;
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .info-item span {
            color: var(--text);
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow);
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
                <a href="${pageContext.request.contextPath}/student/studentDashboard" class="nav-item">
                    <i class="fas fa-th-large"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/student/browseBooks" class="nav-item">
                    <i class="fas fa-book"></i> Browse Books
                </a>
                <a href="${pageContext.request.contextPath}/student/myBooks" class="nav-item">
                    <i class="fas fa-book-reader"></i> My Books
                </a>
                <a href="${pageContext.request.contextPath}/student/fines" class="nav-item">
                    <i class="fas fa-money-bill-wave"></i> My Fines
                </a>
                <a href="${pageContext.request.contextPath}/student/profile" class="nav-item active">
                    <i class="fas fa-user"></i> Profile
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="profile-container">
                <div class="profile-header">
                    <div class="profile-picture">
                        <c:choose>
                            <c:when test="${not empty user.profilePic && user.profilePic != 'default.png'}">
                                <img src="${pageContext.request.contextPath}/uploads/${user.profilePic}" alt="${user.fullName}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://ui-avatars.com/api/?name=${user.fullName}&background=28a745&color=fff&size=150" alt="${user.fullName}">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="profile-info">
                        <h1>${user.fullName}</h1>
                        <p><i class="fas fa-envelope"></i> ${user.email}</p>
                        <p><i class="fas fa-phone"></i> ${user.phone}</p>
                    </div>
                </div>

                <div class="profile-section">
                    <h2>Personal Information</h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <label>Username</label>
                            <span>${user.username}</span>
                        </div>
                        <div class="info-item">
                            <label>Full Name</label>
                            <span>${user.fullName}</span>
                        </div>
                        <div class="info-item">
                            <label>Email</label>
                            <span>${user.email}</span>
                        </div>
                        <div class="info-item">
                            <label>Phone</label>
                            <span>${user.phone}</span>
                        </div>
                        <div class="info-item">
                            <label>Address</label>
                            <span>${user.address}</span>
                        </div>
                        <div class="info-item">
                            <label>Member Since</label>
                            <span>${user.createdAt}</span>
                        </div>
                    </div>
                </div>

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger" onclick="return confirm('Are you sure you want to logout?')">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
