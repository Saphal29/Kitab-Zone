<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <title>Edit Book - Library Management System</title>
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
            padding: 2rem;
        }

        .edit-form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            background: var(--card-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
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
        .form-select {
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 0.75rem;
            font-size: 1rem;
            width: 100%;
            outline: none;
            transition: border-color var(--transition-speed);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border: none;
            border-radius: var(--radius);
            cursor: pointer;
            transition: background var(--transition-speed);
            min-width: 120px;
        }

        .btn-primary {
            background: var(--primary);
            color: #fff;
        }

        .btn-secondary {
            background: var(--hover-bg);
            color: var(--text-primary);
        }

        .image-upload {
            border: 2px dashed var(--border-color);
            border-radius: var(--radius);
            padding: 2rem;
            text-align: center;
            cursor: pointer;
        }

        .preview-image {
            max-width: 100%;
            max-height: 200px;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="edit-form-container">
        <form action="${pageContext.request.contextPath}/admin/updateBook"
              method="POST" enctype="multipart/form-data">
            <input type="hidden" name="bookId" value="${bookToEdit.bookId}">

            <!-- Title -->
            <div class="form-group">
                <label class="form-label">Title *</label>
                <input type="text" name="title" value="${fn:escapeXml(bookToEdit.title)}"
                       class="form-input" required>
            </div>

            <!-- Author -->
            <div class="form-group">
                <label class="form-label">Author *</label>
                <input type="text" name="author" value="${fn:escapeXml(bookToEdit.author)}"
                       class="form-input" required>
            </div>

            <!-- Publisher -->
            <div class="form-group">
                <label class="form-label">Publisher</label>
                <input type="text" name="publisher" value="${fn:escapeXml(bookToEdit.publisher)}"
                       class="form-input">
            </div>

            <!-- Edition -->
            <div class="form-group">
                <label class="form-label">Edition</label>
                <input type="text" name="edition" value="${fn:escapeXml(bookToEdit.edition)}"
                       class="form-input">
            </div>

            <!-- ISBN -->
            <div class="form-group">
                <label class="form-label">ISBN *</label>
                <input type="text" name="isbn" value="${fn:escapeXml(bookToEdit.isbn)}"
                       class="form-input" required>
            </div>

            <!-- Genre -->
            <div class="form-group">
                <label class="form-label">Genre *</label>
                <select name="genre" class="form-select" required>
                    <option value="">Select Genre</option>
                    <c:forEach items="${genres}" var="genre">
                        <option value="${genre}"
                            ${bookToEdit.genre eq genre ? 'selected' : ''}>
                            ${fn:escapeXml(genre)}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Copies -->
            <div class="form-group">
                <label class="form-label">Number of Copies *</label>
                <input type="number" name="copies" value="${fn:escapeXml(bookToEdit.totalCopies)}"
                       min="1" class="form-input" required>
            </div>

            <!-- Cover Image -->
            <div class="form-group">
                <label class="form-label">Cover Image</label>
                <div class="image-upload" id="editImageUpload" onclick="document.getElementById('editCoverImageInput').click()">
                    <input type="file" name="coverImage"
                           id="editCoverImageInput"
                           accept="image/*"
                           style="display: none;"
                           onchange="previewEditImage(event)">

                    <i class="fas fa-cloud-upload-alt"></i>

                    <p class="image-upload-text" id="editUploadText">
                       Drag and drop or click to upload
                    </p>

                    <c:choose>
                      <c:when test="${not empty bookToEdit.coverImage}">
                        <img src="${pageContext.request.contextPath}/uploads/${bookToEdit.coverImage}"
                             alt="Preview"
                             id="editImagePreview"
                             class="preview-image" />
                      </c:when>
                      <c:otherwise>
                        <img src="" alt="Preview" id="editImagePreview" class="preview-image" />
                      </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="button" id="cancelEditBook" class="btn btn-secondary">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Book</button>
            </div>
        </form>
    </div>

    <script>
        // Cancel edit book form
        document.getElementById('cancelEditBook').addEventListener('click', function() {
            window.location.href = "${pageContext.request.contextPath}/admin/books";
        });

        // Preview image for edit form
        function previewEditImage(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('editImagePreview');
            const uploadText = document.getElementById('editUploadText');

            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    uploadText.style.display = 'none';
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>