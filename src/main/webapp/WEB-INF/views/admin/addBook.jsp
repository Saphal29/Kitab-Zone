<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <title>Add New Book</title>

    <style>
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

        /* Form Section */
        .form-container {
          background: var(--card-bg);
          border-radius: var(--radius);
          box-shadow: var(--shadow);
          padding: 2rem;
          max-width: 800px;
          margin: 0 auto;
        }

        .form-group {
          margin-bottom: 1.5rem;
        }

        .form-label {
          font-weight: 500;
          color: var(--text-primary);
          margin-bottom: 0.5rem;
          display: block;
        }

        .form-input,
        .form-select,
        .form-textarea {
          border: 1px solid var(--border-color);
          border-radius: var(--radius);
          padding: 0.75rem;
          font-size: 1rem;
          width: 100%;
          outline: none;
          transition: border-color var(--transition-speed), box-shadow var(--transition-speed);
        }

        .form-input:focus,
        .form-select:focus,
        .form-textarea:focus {
          border-color: var(--primary);
          box-shadow: 0 0 4px rgba(76, 175, 80, 0.4);
        }

        .form-textarea {
          resize: vertical;
          min-height: 120px;
        }

        .form-actions {
          display: flex;
          justify-content: flex-end;
          gap: 1rem;
        }

        .btn {
          padding: 0.75rem 1.5rem;
          font-size: 1rem;
          border: none;
          border-radius: var(--radius);
          cursor: pointer;
          transition: background var(--transition-speed);
        }

        .btn-primary {
          background: var(--primary);
          color: #fff;
        }

        .btn-primary:hover {
          background: #43A047;
        }

        .btn-secondary {
          background: var(--hover-bg);
          color: var(--text-primary);
        }

        .btn-secondary:hover {
          background: #E2E8F0;
        }

        .image-upload {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        border: 2px dashed var(--border-color);
        border-radius: var(--radius);
        padding: 2rem;
        cursor: pointer;
        transition: all var(--transition-speed);
        text-align: center;
        }

        .image-upload:hover {
        border-color: var(--primary);
        background: rgba(76, 175, 80, 0.05);
        }

        .image-upload i {
        font-size: 2.5rem;
        color: var(--primary);
        margin-bottom: 0.5rem;
        }

        .image-upload-text {
        color: var(--text-secondary);
        font-size: 0.875rem;
        margin-top: 0.5rem;
        }

        .error-text { color: #dc3545; font-size: 0.875rem; margin-top: 0.25rem; }
        .preview-image { max-width: 200px; margin-top: 1rem; border-radius: 8px; }
    </style>
</head>
<body>
    <div class="app-container">
       <aside class="sidebar">
         <div class="app-logo">
           <i class="fas fa-book"></i> KitabZone
         </div>
         <nav>
           <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item"><i class="fas fa-th-large"></i> Dashboard</a>
           <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
           <a href="${pageContext.request.contextPath}/admin/addBook" class="nav-item active"><i class="fas fa-book"></i> Add Books</a>
           <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item "><i class="fas fa-tasks"></i> Transaction Control</a>
           <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
           <a  href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>




         </nav>
       </aside>

        <main class="main-content">
            <div class="form-container">
                <c:if test="${not empty error}">
                    <div class="alert error">${fn:escapeXml(error)}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/addBook"
                      method="POST" enctype="multipart/form-data">

                    <!-- Title -->
                    <div class="form-group">
                        <label class="form-label">Title *</label>
                        <input type="text" name="title"
                               value="${fn:escapeXml(param.title)}"
                               class="form-input" required>
                    </div>

                    <!-- Author -->
                    <div class="form-group">
                        <label class="form-label">Author *</label>
                        <input type="text" name="author"
                               value="${fn:escapeXml(param.author)}"
                               class="form-input" required>
                    </div>

                    <!-- Publisher -->
                    <div class="form-group">
                        <label class="form-label">Publisher</label>
                        <input type="text" name="publisher"
                               value="${fn:escapeXml(param.publisher)}"
                               class="form-input">
                    </div>

                    <!-- Edition -->
                    <div class="form-group">
                        <label class="form-label">Edition</label>
                        <input type="text" name="edition"
                               value="${fn:escapeXml(param.edition)}"
                               class="form-input">
                    </div>

                    <!-- ISBN -->
                    <div class="form-group">
                        <label class="form-label">ISBN *</label>
                        <input type="text" name="isbn"
                               value="${fn:escapeXml(param.isbn)}"
                               class="form-input"
                               required>

                    </div>

                    <!-- Genre -->
                    <div class="form-group">
                        <label class="form-label">Genre *</label>
                        <select name="genre" class="form-select" required>
                            <option value="">Select Genre</option>
                            <c:forEach items="${genres}" var="genre">
                                <option value="${genre}"
                                    ${param.genre eq genre ? 'selected' : ''}>
                                    ${fn:escapeXml(genre)}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Copies -->
                    <div class="form-group">
                        <label class="form-label">Number of Copies *</label>
                        <input type="number" name="copies"
                               value="${empty param.copies ? 1 : fn:escapeXml(param.copies)}"
                               min="1" class="form-input" required>
                    </div>

                    <!-- Cover Image -->
                    <div class="form-group">
                        <label class="form-label">Cover Image</label>
                        <div class="image-upload" id="imageUpload">
                            <input type="file" name="coverImage"
                                   accept="image/*" hidden
                                   onchange="previewImage(event)">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <p class="image-upload-text" id="uploadText">
                                Drag and drop or click to upload
                            </p>
                            <img src="${fn:escapeXml(param.coverImage)}"
                                 alt="Preview"
                                 id="imagePreview"
                                 class="preview-image"
                                 style="${not empty param.coverImage ? 'display: block;' : ''}">
                        </div>
                        <c:if test="${not empty imageError}">
                            <div class="error-text">${fn:escapeXml(imageError)}</div>
                        </c:if>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/books"
                           class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Add Book</button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('imagePreview');
            const uploadText = document.getElementById('uploadText');

            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    uploadText.style.display = 'none';
                };
                reader.readAsDataURL(file);
            } else {
                preview.src = '';
                preview.style.display = 'none';
                uploadText.style.display = 'block';
            }
        }

        document.getElementById('imageUpload').addEventListener('click', () => {
            document.querySelector('input[name="coverImage"]').click();
        });
    </script>
</body>
</html>