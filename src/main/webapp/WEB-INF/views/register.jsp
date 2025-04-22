<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Register - Library System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">


    <style>
      /* General Body Styling */
     body {
         font-family: Arial, sans-serif;
         background-color: #f3f4f6;
         margin: 0;
         padding: 0;
         height: 110%; /* Adjusted to allow scrolling */
         overflow-y: auto; /* Enables vertical scrolling */
         display: flex;
         justify-content: center;
         align-items: flex-start; /* Aligns the container at the top for scrolling */
     }

      /* Main Container Styling */
      .container {
          max-width: 600px; /* Increased width for more space */
          background: #fff;
          box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
          padding: 90px;
          border-radius: 10px;
          background: rgba(255, 255, 255, 0.8); /* Glassmorphism effect */
          backdrop-filter: blur(10px);
          border: 1px solid rgba(255, 255, 255, 0.3);
          margin: 20px auto; /* Centered horizontally with spacing at the top and bottom */
      }

      /* Heading */
      h1 {
          text-align: center;
          color: #2f855a;
          margin-bottom: 20px;
      }

      /* Alerts Styling */
      .alert {
          color: #fff;
          padding: 10px;
          border-radius: 5px;
          margin-bottom: 20px;
          text-align: center;
      }

      .alert.error {
          background-color: #e53e3e;
      }

      /* Form Styling */
      form {
          display: flex;
          flex-direction: column;
          gap: 20px;
      }

      /* Form Group Styling */
      .form-group {
          display: flex;
          align-items: center;
          justify-content: flex-start;
          border: 1px solid #e2e8f0;
          border-radius: 10px;
          padding: 12px;
          background-color: #fff;
          position: relative;
      }

      /* Label Styling */
      .form-group label {
          min-width: 100px;
          color: #4a5568;
          font-size: 14px;
          text-align: left;
          margin-right: 10px;
      }

      /* Input and Textarea Fields */
      .form-group input,
      .form-group textarea {
          flex: 1;
          border: none;
          outline: none;
          padding: 10px;
          font-size: 14px;
          background: transparent;
          border-radius: 10px; /* Rounded fields for modern design */
      }

      /* Placeholder Styling */
      .form-group input::placeholder,
      .form-group textarea::placeholder {
          color: #a0aec0;
      }

      /* Focus Styling */
      .form-group input:focus,
      .form-group textarea:focus {
          background-color: #e6f7ff; /* Light blue focus effect */
          border: 2px solid #2f855a;
          outline: none;
          box-shadow: 0 0 8px #2f855a; /* Smooth glowing effect */
      }

      .form-group input:focus ~ i,
      .form-group textarea:focus ~ i {
          color: #2f855a;
          opacity: 1;
      }

      /* Icons Styling */
      .form-group i {
          position: absolute;
          right: 10px;
          color: #a0aec0;
          opacity: 0.6;
          pointer-events: none;
      }

      /* Button Styling */
      button[type="submit"] {
          position: relative;
          background-color: #2f855a;
          color: #fff;
          padding: 12px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          overflow: hidden;
          transition: background-color 0.3s ease;
      }

      button[type="submit"]:hover {
          background-color: #276749;
      }

      button[type="submit"]::after {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background: rgba(255, 255, 255, 0.1);
          opacity: 0;
          transition: opacity 0.3s;
      }

      button[type="submit"]:hover::after {
          opacity: 1;
      }

      /* Links Styling */
      p {
          text-align: center;
          margin-top: 20px;
      }

      p a {
          color: #2f855a;
          text-decoration: none;
      }

      /* Responsive Design */
      @media (max-width: 600px) {
          .container {
              padding: 20px;
          }

          button[type="submit"] {
              padding: 10px;
              font-size: 16px;
          }
      }
    form-group input:focus,
    .form-group textarea:focus,
    .form-group input[type="file"]:focus {
        background-color: #e6f7ff; /* Light blue focus effect */
        border: 2px solid #2f855a; /* Consistent green border */
        outline: none;
        box-shadow: 0 0 8px #2f855a; /* Smooth glowing effect */
    }

    /* Ensures Other Fields Respond to Focus */
    .form-group textarea {
        border-radius: 10px;
        padding: 10px;
    }

    .form-group input[type="file"] {
        padding: 5px;
        border-radius: 10px;
    }

    /* Profile Picture Section Styling */
    .form-group.profile-pic {
        flex-direction: column;
        align-items: center;
        padding: 20px;
        border: 2px dashed #a0aec0;
        background-color: #f9fafb;
        text-align: center;
        border-radius: 15px;
    }

    /* Label Styling */
    .form-group.profile-pic label {
        text-align: center;
        color: #4a5568;
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 10px;
    }

    /* Custom File Input Styling */
    .custom-file {
        position: relative;
        display: inline-block;
        width: 80%; /* Adjust width for a spacious design */
    }

    .custom-file input[type="file"] {
        position: absolute;
        top: 0;
        right: 0;
        height: 100%;
        width: 100%;
        opacity: 0; /* Hide the default file input */
        cursor: pointer;
    }

    .custom-file-label {
        display: block;
        width: 100%;
        padding: 10px;
        font-size: 14px;
        color: #4a5568;
        background-color: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        transition: background-color 0.3s ease, border-color 0.3s ease;
        text-align: center;
        cursor: pointer;
    }

    .custom-file-label:hover {
        background-color: #e6f7ff; /* Light blue hover effect */
        border-color: #2f855a; /* Green border on hover */
    }

    .custom-file-label:active {
        background-color: #d1f4ff; /* Slightly darker blue on click */
    }

    /* Styling for File Upload Icon */
    .form-group.profile-pic i {
        margin-top: 10px;
        font-size: 24px;
        color: #2f855a;
    }

    .form-group.profile-pic .note {
        font-size: 12px;
        color: #718096;
        margin-top: 10px;
        text-align: center;
    }


    </style>
</head>
<body>
    <div class="container">

        <h1>Register</h1>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form method="post" enctype="multipart/form-data">
            <!-- Same form fields as in your original code -->
            <div class="form-group">
              <label>Username*:</label>
              <i class="fa fa-user"></i>
              <input type="text" name="username" required placeholder=" ">
          </div>

          <div class="form-group">
              <label>Password*:</label>
              <i class="fa fa-lock"></i>
              <input type="password" name="password" required placeholder=" ">
          </div>

          <div class="form-group">
              <label>Full Name*:</label>
              <i class="fa fa-id-card"></i>
              <input type="text" name="fullName" required placeholder=" ">
          </div>

          <div class="form-group">
              <label>Email*:</label>
              <i class="fa fa-envelope"></i>
              <input type="email" name="email" required placeholder=" ">
          </div>

          <div class="form-group">
              <label>Phone:</label>
              <i class="fa fa-phone"></i>
              <input type="tel" name="phone" placeholder=" ">
          </div>

          <div class="form-group">
              <label>Address:</label>
              <i class="fa fa-home"></i>
              <textarea name="address" rows="3"></textarea>
          </div>

         <div class="form-group profile-pic">
             <label for="profilePic">Profile Picture:</label>
             <div class="custom-file">
                 <input type="file" id="profilePic" name="profilePic" accept="image/*">
                 <span class="custom-file-label" id="fileLabel">No file chosen</span>
             </div>
             <i class="fa fa-image"></i>
             <p class="note">Upload a clear image (JPEG, PNG, max 5MB).</p>
         </div>



          <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login">Login here</a></p>
    </div>
    <script>
        const fileInput = document.getElementById('profilePic');
        const fileLabel = document.getElementById('fileLabel');

        fileInput.addEventListener('change', function () {
            if (this.files && this.files[0]) {
                fileLabel.textContent = this.files[0].name;
            } else {
                fileLabel.textContent = 'No file chosen';
            }
        });
    </script>

</body>

