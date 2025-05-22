<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <title>Book Management</title>

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

       .page-title {
         font-size: 1.75rem;
         font-weight: 600;
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

       /* Table Styles */
       .table-container {
         background: var(--card-bg);
         border-radius: var(--radius);
         box-shadow: var(--shadow);
         padding: 1.5rem;
         overflow-x: auto;
       }

       table {
         width: 100%;
         border-collapse: collapse;
       }

       th, td {
         padding: 1rem;
         text-align: left;
         border-bottom: 1px solid var(--border-color);
       }

       th {
         font-weight: 600;
         color: var(--text-primary);
         background: var(--hover-bg);
       }

       tr:hover {
         background: var(--hover-bg);
       }

       .status {
         display: inline-block;
         padding: 0.25rem 0.75rem;
         border-radius: 1rem;
         font-size: 0.875rem;
         font-weight: 500;
       }

       .status-available {
         background: #E3F2FD;
         color: #1976D2;
       }

       .status-reserved {
         background: #FFF8E1;
         color: #FFA000;
       }

       .status-issued {
         background: #FFEBEE;
         color: #D32F2F;
       }

       .action-btn {
         display: inline-flex;
         align-items: center;
         justify-content: center;
         width: 2rem;
         height: 2rem;
         border-radius: 50%;
         background: transparent;
         border: none;
         cursor: pointer;
         transition: background var(--transition-speed);
       }

       .action-btn:hover {
         background: rgba(0, 0, 0, 0.1);
       }

       .action-btn i {
         font-size: 1rem;
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

       .alert {
         padding: 1rem;
         border-radius: var(--radius);
         margin-bottom: 1.5rem;
       }

       .alert.success {
         background: #E8F5E9;
         color: #2E7D32;
       }

       .alert.error {
         background: #FFEBEE;
         color: #C62828;
       }

       .book-cover {
         width: 50px;
         height: 70px;
         object-fit: cover;
         border-radius: 4px;
       }
       .header-actions {
                  display: flex;
                  align-items: center;
                  gap: 1rem;
              }

              .add-book-form {
                  display: none;
                  background: var(--card-bg);
                  border-radius: var(--radius);
                  box-shadow: var(--shadow);
                  padding: 2rem;
                  margin-top: 2rem;
                  margin-bottom: 2rem;
                  width: 100%;
                  position: relative;
                  z-index: 1;
              }

              .add-book-form.active {
                  display: block !important;
              }

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
                display: flex !important;
                justify-content: flex-end;
                gap: 1rem;
                margin-top: 2rem;
                padding-top: 1rem;
                border-top: 1px solid var(--border-color);
                position: relative;
                z-index: 2;
              }

              .btn {
                display: inline-block !important;
                padding: 0.75rem 1.5rem;
                font-size: 1rem;
                border: none;
                border-radius: var(--radius);
                cursor: pointer;
                transition: background var(--transition-speed);
                min-width: 120px;
                position: relative;
                z-index: 2;
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
                 position: relative;
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
                 min-height: 200px;
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

              .preview-image {
                  max-width: 100%;
                  max-height: 200px;
                  object-fit: contain;
                  border-radius: 4px;
                  margin-top: 1rem;
              }

              #uploadText, #imageUpload i {
                  transition: all 0.3s ease;
              }
    </style>
</head>
<body>
    <div class="app-container">
        <aside class="sidebar">
                  <div class="app-logo">
                      <i class="fas fa-book"></i> KitabZone
                  </div>
                  <nav>
                      <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="nav-item "><i class="fas fa-th-large"></i> Dashboard</a>
                      <a href="${pageContext.request.contextPath}/admin/member" class="nav-item"><i class="fas fa-users"></i> Member</a>
                      <a href="${pageContext.request.contextPath}/admin/books" class="nav-item active"><i class="fas fa-list"></i> Book</a>
                      <a href="${pageContext.request.contextPath}/admin/transactionControl" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
                      <a href="${pageContext.request.contextPath}/admin/reservationManagement" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
                      <a href="${pageContext.request.contextPath}/admin/fineManagement" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>

                  </nav>
              </aside>

       <main class="main-content">
                   <div class="header">
                       <h1 class="page-title">Book Management</h1>
                       <div class="header-actions">
                           <div class="global-search">
                               <i class="fas fa-search"></i>
                               <input type="text" id="searchInput" placeholder="Search by title, author, ISBN, or genre...">
                           </div>
                           <button id="addBookBtn" class="btn btn-primary">
                               <i class="fas fa-plus"></i> Add Book
                           </button>
                       </div>
                   </div>

                   <c:if test="${not empty param.success}">
                       <div class="alert success">
                           ${fn:escapeXml(param.success)}
                       </div>
                   </c:if>

                   <c:if test="${not empty error}">
                       <div class="alert error">
                           ${fn:escapeXml(error)}
                       </div>
                   </c:if>


                   <!-- Add Book Form (hidden by default) -->
                              <div id="addBookForm" class="add-book-form">
                                <form action="${pageContext.request.contextPath}/admin/addBook" method="POST" enctype="multipart/form-data">

                                      <!-- Title -->
                                      <div class="form-group">
                                          <label class="form-label">Title *</label>
                                          <input type="text" name="title" class="form-input" required>
                                      </div>

                                      <!-- Author -->
                                      <div class="form-group">
                                          <label class="form-label">Author *</label>
                                          <input type="text" name="author" class="form-input" required>
                                      </div>

                                      <!-- Publisher -->
                                      <div class="form-group">
                                          <label class="form-label">Publisher</label>
                                          <input type="text" name="publisher" class="form-input">
                                      </div>

                                      <!-- Edition -->
                                      <div class="form-group">
                                          <label class="form-label">Edition</label>
                                          <input type="text" name="edition" class="form-input">
                                      </div>

                                      <!-- ISBN -->
                                      <div class="form-group">
                                          <label class="form-label">ISBN *</label>
                                          <input type="text" name="isbn" class="form-input" required>
                                      </div>

                                      <!-- Genre -->
                                      <div class="form-group">
                                          <label class="form-label">Genre *</label>
                                          <select name="genre" class="form-select" required>
                                              <option value="">Select Genre</option>
                                              <c:forEach items="${genres}" var="genre">
                                                  <option value="${genre}">
                                                      ${fn:escapeXml(genre)}
                                                  </option>
                                              </c:forEach>
                                          </select>
                                      </div>

                                      <!-- Copies -->
                                      <div class="form-group">
                                          <label class="form-label">Number of Copies *</label>
                                          <input type="number" name="copies" min="1" value="1" class="form-input" required>
                                      </div>

                                      <!-- Cover Image -->
                                    <!-- Cover Image Section -->
                                    <div class="form-group">
                                        <label class="form-label">Cover Image</label>
                                      <div class="image-upload" id="imageUpload" onclick="document.getElementById('coverImageInput').click()">
                                          <input type="file" name="coverImage"
                                                 id="coverImageInput"
                                                 accept="image/*"
                                                 style="display: none;"
                                                 onchange="previewImage(event)">
                                          <i class="fas fa-cloud-upload-alt"></i>
                                          <p class="image-upload-text" id="uploadText">
                                              Click to upload
                                          </p>
                                          <img src="" alt="Preview" id="imagePreview" class="preview-image" style="display: none;">
                                      </div>

                                    </div>

                                      <!-- Form Actions -->
                                      <div class="form-actions">
                                          <button type="button" id="cancelAddBook" class="btn btn-secondary">Cancel</button>
                                          <button type="submit" class="btn btn-primary">Add Book</button>
                                      </div>
                                  </form>
                              </div>

                   <!-- Books Table -->
                   <div class="table-container">
                       <table>
                           <thead>
                               <tr>
                                   <th>Cover</th>
                                   <th>Title</th>
                                   <th>Author</th>
                                   <th>ISBN</th>
                                   <th>Genre</th>
                                   <th>Status</th>
                                   <th>Copies</th>
                                   <th>Actions</th>
                               </tr>
                           </thead>
                           <tbody>
                               <c:forEach items="${books}" var="book">
                                   <tr>
                                       <td>
                                           <c:if test="${not empty book.coverImage}">
                                               <img src="${pageContext.request.contextPath}/uploads/${fn:escapeXml(book.coverImage)}"
                                                    alt="Book Cover" class="book-cover">
                                           </c:if>
                                           <c:if test="${empty book.coverImage}">
                                               <i class="fas fa-book" style="font-size: 2rem; color: #ccc;"></i>
                                           </c:if>
                                       </td>
                                       <td>${fn:escapeXml(book.title)}</td>
                                       <td>${fn:escapeXml(book.author)}</td>
                                       <td>${fn:escapeXml(book.isbn)}</td>
                                       <td>${fn:escapeXml(book.genre)}</td>
                                       <td>
                                           <span class="status status-${fn:escapeXml(book.status.name().toLowerCase())}">
                                               ${fn:escapeXml(book.status)}
                                           </span>
                                       </td>
                                       <td>${fn:escapeXml(book.totalCopies)}</td>
                                       <td>
                                           <div class="action-buttons">
                                               <a href="${pageContext.request.contextPath}/admin/books?action=edit&id=${book.bookId}"
                                                  class="action-btn" title="Edit">
                                                   <i class="fas fa-edit"></i>
                                               </a>
                                               <form action="${pageContext.request.contextPath}/admin/deleteBook"
                                                     method="POST" style="display: inline;">
                                                   <input type="hidden" name="bookId" value="${book.bookId}">
                                                   <button type="submit" class="action-btn" title="Delete"
                                                           onclick="return confirm('Are you sure you want to delete this book?')">
                                                       <i class="fas fa-trash"></i>
                                                   </button>
                                               </form>
                                           </div>
                                       </td>
                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
               </main>
           </div>
            <script>
                    // Toggle add book form
                    document.getElementById('addBookBtn').addEventListener('click', function() {
                        document.getElementById('addBookForm').classList.add('active');
                        document.getElementById('editBookForm').classList.remove('active');
                    });

                    document.getElementById('cancelAddBook').addEventListener('click', function() {
                        document.getElementById('addBookForm').classList.remove('active');
                    });

                    //for add book
                     function previewImage(event) {
                         const file = event.target.files[0];
                         const preview = document.getElementById('imagePreview');
                         const uploadText = document.getElementById('uploadText');

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

                  // Search functionality
                  document.getElementById('searchInput').addEventListener('input', function(e) {
                      const searchTerm = e.target.value.toLowerCase();
                      const rows = document.querySelectorAll('.table-container tbody tr');

                      rows.forEach(row => {
                          if (row.querySelector('td[colspan]')) return;

                          const text = row.textContent.toLowerCase();
                          row.style.display = text.includes(searchTerm) ? '' : 'none';
                      });
                  });

                </script>
</body>
</html>