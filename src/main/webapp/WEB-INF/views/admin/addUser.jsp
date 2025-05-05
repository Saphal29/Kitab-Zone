<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add New Member - Library Management System</title>
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
            --cancel-btn-bg: #FF5252;
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
            background-color: #f5f5f5;
            padding: 2rem;
        }

        .add-user-container {
            max-width: 800px;
            margin: 0 auto;
            background: var(--background);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
        }

        .page-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .page-title {
            font-size: 1.5rem;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-primary);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius);
            border: none;
            font-size: 1rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        .btn-secondary {
            background: var(--background);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: var(--hover-bg);
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
        }

        .error-message {
            color: var(--cancel-btn-bg);
            margin-top: 0.5rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="add-user-container">
        <div class="page-header">
            <h1 class="page-title">Add New Member</h1>
            <p class="page-subtitle">Fill in the details to register a new library member</p>
        </div>

        <form action="${pageContext.request.contextPath}/admin/addUser" method="post" id="addUserForm">
            <div class="form-group">
                <label for="fullName" class="form-label">Full Name *</label>
                <input type="text" id="fullName" name="fullName" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="username" class="form-label">Username *</label>
                <input type="text" id="username" name="username" class="form-control" required>
                <small class="text-muted">Must be unique (3-20 characters)</small>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email *</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">Password *</label>
                <input type="password" id="password" name="password" class="form-control" required>
                <small class="text-muted">Minimum 8 characters</small>
            </div>

            <div class="form-group">
                <label for="confirmPassword" class="form-label">Confirm Password *</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                <div id="passwordError" class="error-message" style="display: none;">Passwords do not match</div>
            </div>

            <div class="form-group">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="tel" id="phone" name="phone" class="form-control">
            </div>

            <div class="form-group">
                <label for="address" class="form-label">Address</label>
                <textarea id="address" name="address" class="form-control" rows="3"></textarea>
            </div>

            <div class="form-group">
                <label for="role" class="form-label">Member Type *</label>
                <select id="role" name="role" class="form-control" required>
                    <option value="">Select Member Type</option>
                    <option value="STUDENT">Student</option>
                    <option value="ADMIN">Administrator</option>
                </select>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/admin/member" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Add Member
                </button>
            </div>
        </form>
    </div>

    <script>
        // Password confirmation validation
        document.getElementById('addUserForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorElement = document.getElementById('passwordError');

            if (password !== confirmPassword) {
                e.preventDefault();
                errorElement.style.display = 'block';
                document.getElementById('confirmPassword').focus();
            } else {
                errorElement.style.display = 'none';
            }
        });

        // Basic client-side validation
        document.getElementById('username').addEventListener('input', function() {
            this.value = this.value.replace(/[^a-zA-Z0-9_]/g, '');
        });
    </script>
</body>
</html>