<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Library System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/styles.css">
    <style>
        /* General Body Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Main Container */
        .container {
            max-width: 600px;
            background: #fff;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            padding: 90px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* Branding */
        .branding {
            text-align: center;
            margin-bottom: 20px;
        }

        .branding img {
            max-width: 70px;
            margin-bottom: 10px;
        }

        /* Heading */
        h1 {
            color: #2f855a;
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Alerts */
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

        .alert.success {
            background-color: #38a169;
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
          padding: 8px 30px; /* Increased padding for better focus */
          background-color: #fff;
          position: relative;
      }

      /* Label Styling */
      .form-group label {
          min-width: 100px; /* Ensures consistent label width */
          color: #4a5568;
          font-size: 14px;
          text-align: left;
          margin-right: 10px;
      }

      /* Input Fields */
      .form-group input {
          flex: 1;
          border: none;
          outline: none;
          font-size: 14px;
          padding: 10px;
          border-radius: 10px; /* Matches form group rounding */
          background: transparent;
      }

      /* Placeholder Styling */
      .form-group input::placeholder {
          color: #a0aec0;
      }
       /* Focus Styling */
       .form-group input:focus {
           background-color: #e6f7ff; /* Light blue focus effect */
           border: 2px solid #2f855a; /* Green border for focus */
           outline: none;
           box-shadow: 0 0 8px #2f855a; /* Smooth glowing effect */
       }

       /* Icons */
       .form-group i {
           position: absolute;
           right: 10px;
           color: #a0aec0;
           opacity: 0.6;
           pointer-events: none;
       }

       .form-group input:focus ~ i {
           color: #2f855a;
           opacity: 1;
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

      /* Links */
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
    </style>
</head>
<body>
    <div class="container">
        <h1>Login</h1>

        <% if(request.getAttribute("error") != null) { %>
            <div class="alert error"><%= request.getAttribute("error") %></div>
        <% } %>

        <% if(session.getAttribute("success") != null) { %>
            <div class="alert success"><%= session.getAttribute("success") %></div>
            <% session.removeAttribute("success"); %>
        <% } %>

        <form method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
                <i class="fa fa-user"></i>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <i class="fa fa-lock"></i>
            </div>

            <button type="submit">Login</button>
        </form>

        <p>Don't have an account? <a href="register">Register here</a></p>
    </div>
</body>
</html>