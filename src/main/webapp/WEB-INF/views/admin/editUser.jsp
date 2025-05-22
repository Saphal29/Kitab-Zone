<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit User - Library Management System</title>
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
            --edit-btn-bg: #E2E8F0;
            --cancel-btn-bg: #FF5252;
            --danger: #D32F2F;
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

        .edit-user-container {
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

        .page-subtitle {
            color: var(--text-secondary);
            font-size: 0.9rem;
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
            background: var(--edit-btn-bg);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: var(--hover-bg);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #B71C1C;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
        }

        .danger-zone {
            margin-top: 3rem;
            padding: 1.5rem;
            background-color: #FFF5F5;
            border-radius: var(--radius);
            border: 1px solid #FFCDD2;
        }

        .danger-zone-title {
            color: var(--danger);
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .role-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            margin-left: 0.5rem;
        }

        .role-student {
            background-color: #E8F5E9;
            color: #2E7D32;
        }

        .role-admin {
            background-color: #E3F2FD;
            color: #1565C0;
        }

        .role-super_admin {
            background-color: #EDE7F6;
            color: #512DA8;
        }

        .current-user-notice {
            color: var(--text-secondary);
            font-style: italic;
            margin-top: 1rem;
        }

        .profile-pic-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 1rem;
            border: 2px solid var(--border-color);
        }
    </style>
</head>
<body>
    <div class="edit-user-container">
        <div class="page-header">
            <h1 class="page-title">Edit User</h1>
            <p class="page-subtitle">Update user information and permissions</p>
        </div>

        <form action="${pageContext.request.contextPath}/admin/updateUser" method="post" enctype="multipart/form-data">
            <input type="hidden" name="userId" value="${user.userId}">

            <div class="form-group">
                <label class="form-label">Profile Picture</label>
                <c:choose>
                    <c:when test="${not empty user.profilePic}">
                        <img src="${pageContext.request.contextPath}/uploads/${user.profilePic}"
                             alt="Profile Picture" class="profile-pic-preview">
                    </c:when>
                    <c:otherwise>
                        <img src="https://ui-avatars.com/api/?name=${user.fullName}&background=28a745&color=fff&size=150"
                             alt="Profile Picture" class="profile-pic-preview">
                    </c:otherwise>
                </c:choose>
                <input type="file" id="profilePicUpload" name="profilePic" accept="image/*" style="display: none;">
                <button type="button" class="btn btn-secondary" onclick="document.getElementById('profilePicUpload').click()">
                    <i class="fas fa-upload"></i> Upload New Photo
                </button>
            </div>

            <div class="form-group">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="form-control"
                       value="${user.fullName}" required>
            </div>

            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control"
                       value="${user.username}" required>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="${user.email}" required>
            </div>

            <div class="form-group">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="tel" id="phone" name="phone" class="form-control"
                       value="${user.phone}">
            </div>

            <div class="form-group">
                <label for="address" class="form-label">Address</label>
                <textarea id="address" name="address" class="form-control"
                          rows="3">${user.address}</textarea>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">New Password (leave blank to keep current)</label>
                <input type="password" id="password" name="password" class="form-control">
            </div>

            <div class="form-group">
                <label for="role" class="form-label">User Role</label>
                <select id="role" name="role" class="form-control" required>
                    <option value="STUDENT" ${user.role == 'STUDENT' ? 'selected' : ''}>Student</option>
                    <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Administrator</option>
                    <option value="SUPER_ADMIN" ${user.role == 'SUPER_ADMIN' ? 'selected' : ''}>Super Administrator</option>
                </select>
                <span class="role-badge role-${user.role.toString().toLowerCase()}">
                    Current: ${user.role}
                </span>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/admin/member" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Users
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </div>
        </form>

        <c:if test="${sessionScope.user.userId != user.userId}">
            <div class="danger-zone">
                <h3 class="danger-zone-title">Danger Zone</h3>
                <p>Deleting a user is permanent and cannot be undone. All their data will be removed from the system.</p>
                <form action="${pageContext.request.contextPath}/admin/deleteUser" method="post"
                      onsubmit="return confirm('Are you sure you want to permanently delete this user?')">
                    <input type="hidden" name="userId" value="${user.userId}">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash-alt"></i> Delete User
                    </button>
                </form>
            </div>
        </c:if>
        <c:if test="${sessionScope.user.userId == user.userId}">
            <p class="current-user-notice">
                <i class="fas fa-info-circle"></i> You cannot delete your own account while logged in.
            </p>
        </c:if>
    </div>

    <script>
        // Preview profile picture when selected
        document.getElementById('profilePicUpload').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    document.querySelector('.profile-pic-preview').src = event.target.result;
                }
                reader.readAsDataURL(file);
            }
        });

        // Confirm before leaving page with unsaved changes
        window.addEventListener('beforeunload', function(e) {
            const form = document.querySelector('form');
            const initialData = new FormData(form);
            let hasChanges = false;

            form.querySelectorAll('input, select, textarea').forEach(element => {
                if (element.type !== 'file' && element.value !== initialData.get(element.name)) {
                    hasChanges = true;
                }
            });

            if (hasChanges) {
                e.preventDefault();
                e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
            }
        });
    </script>
</body>
</html>