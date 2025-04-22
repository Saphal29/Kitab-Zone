<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Library App - Add Books</title>
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
        <a href="adminDashboard.html" class="nav-item"><i class="fas fa-th-large"></i> Dashboard</a>
        <a href="member.html" class="nav-item"><i class="fas fa-users"></i> Members</a>
        <a href="addbook.html" class="nav-item active"><i class="fas fa-book"></i> Add Books</a>
        <a href="transactionControl.html" class="nav-item"><i class="fas fa-tasks"></i> Transaction Control</a>
        <a href="reserveManagement.html" class="nav-item"><i class="fas fa-calendar-check"></i> Reservation Management</a>
        <a href="fineManagement.html" class="nav-item"><i class="fas fa-hand-holding-usd"></i> Fine Administration</a>
        <a href="system.html" class="nav-item "><i class="fas fa-tools"></i> System Configuration</a>


      </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
      <div class="form-container">
        <form>
          <div class="form-group">
            <label class="form-label">Book Title</label>
            <input type="text" class="form-input" placeholder="Enter book title" />
          </div>
          <div class="form-group">
            <label class="form-label">ISBN</label>
            <input type="text" class="form-input" placeholder="Enter ISBN" />
          </div>
          <div class="form-group">
            <label class="form-label">Author</label>
            <input type="text" class="form-input" placeholder="Enter author name" />
          </div>
          <div class="form-group">
            <label class="form-label">Publisher</label>
            <input type="text" class="form-input" placeholder="Enter publisher name" />
          </div>
          <div class="form-group">
            <label class="form-label">Publication Date</label>
            <input type="date" class="form-input" />
          </div>
          <div class="form-group">
            <label class="form-label">Category</label>
            <select class="form-select">
              <option value="">Select category</option>
              <option value="fiction">Fiction</option>
              <option value="non-fiction">Non-Fiction</option>
              <option value="science">Science</option>
              <option value="technology">Technology</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Number of Copies</label>
            <input type="number" class="form-input" min="1" value="1" />
          </div>
          <div class="form-group">
            <label class="form-label">Shelf Location</label>
            <input type="text" class="form-input" placeholder="Enter shelf location" />
          </div>
          <div class="form-group">
            <label class="form-label">Description</label>
            <textarea class="form-textarea" placeholder="Enter book description"></textarea>
          </div>
          <div class="form-group">
            <label class="form-label">Cover Image</label>
            <div class="image-upload" id="imageUpload">
              <input
                type="file"
                id="fileInput"
                accept="image/*"
                hidden
                onchange="previewImage(event)"
              />
              <i class="fas fa-cloud-upload-alt"></i>
              <p class="image-upload-text" id="uploadText">Drag and drop or click to upload</p>
              <img
                src=""
                alt="Preview"
                id="imagePreview"
                style="display: none; max-width: 100%; margin-top: 1rem; border-radius: var(--radius);"
              />
            </div>
          </div>

          <div class="form-actions">
            <button type="button" class="btn btn-secondary">Cancel</button>
            <button type="submit" class="btn btn-primary">Add Book</button>
          </div>
        </form>
      </div>
    </main>
  </div>
  <script>
    // Advanced Cover Image Upload with Live Preview
function previewImage(event) {
  const file = event.target.files[0];
  const preview = document.getElementById('imagePreview');
  const uploadText = document.getElementById('uploadText');

  if (file && file.type.startsWith('image/')) {
    const reader = new FileReader();
    reader.onload = () => {
      preview.src = reader.result;
      preview.style.display = 'block';
      uploadText.style.display = 'none'; // Hide instruction text
    };
    reader.readAsDataURL(file);
  } else {
    alert('Please upload a valid image file.');
    event.target.value = ''; // Clear invalid input
  }
}

document.getElementById('imageUpload').addEventListener('click', () => {
  document.getElementById('fileInput').click();
});

  </script>
</body>
</html>
