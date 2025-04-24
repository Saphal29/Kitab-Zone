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
            --danger: #DC3545;
            --warning: #FFC107;
            --success: #28A745;
        }

        body {
            background-color: var(--background);
        }

        .app-container {
            display: flex;
        }

        .sidebar {
            background: #ffffff;  /* White background */
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
            color: #2D3436;  /* Dark text */
        }

        .app-logo i {
            color: #4CAF50;  /* Green icon */
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 0.875rem 1rem;
            color: #636E72;  /* Gray text */
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.2s;
        }

        .nav-item i {
            width: 20px;
            margin-right: 0.75rem;
        }

        .nav-item:hover {
            background: #F1F4F6;  /* Light gray background on hover */
            color: #2D3436;  /* Darker text on hover */
        }

        .nav-item.active {
            background: #4CAF50;  /* Green background for active */
            color: white;  /* White text for active */
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
        }

        .header {
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 28px;
            margin: 0;
        }

        .summary-cards {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .summary-card {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            flex: 1;
        }

        .summary-title {
            font-size: 16px;
            color: var(--text-secondary);
        }

        .summary-value {
            font-size: 24px;
            margin: 10px 0;
            color: var(--text-primary);
        }

        .summary-trend {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .summary-trend i {
            margin-right: 5px;
        }

        .fine-details {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
            margin-bottom: 4rem;
        }

        .fine-list, .payment-section {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            flex: 1;
        }

        .fine-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .fine-book {
            display: flex;
        }

        .book-cover img {
            width: 60px;
            height: 90px;
            object-fit: cover;
            border-radius: var(--radius);
            margin-right: 10px;
        }

        .book-info h4 {
            margin: 0;
            font-size: 16px;
            color: var(--text-primary);
        }

        .book-info p {
            margin: 5px 0;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .fine-amount {
            font-size: 18px;
            color: var(--danger);
        }

        .payment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .payment-total {
            font-size: 24px;
            color: var(--primary);
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

        .calculator, .receipt {
            margin-top: 20px;
        }

        .input-group {
            margin-bottom: 10px;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: var(--text-secondary);
        }

        .input-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
        }

        .receipt-header h3, .calculator h3 {
            margin: 0 0 10px 0;
            color: var(--text-primary);
        }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: var(--text-secondary);
        }

        .charts-section {
            background: var(--card-bg);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .chart-container {
            background-color: var(--card-bg);
            padding: 20px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- This sidebar structure should be the same in all files -->
<aside class="sidebar">
  <div class="app-logo">
      <i class="fas fa-book"></i>
      KitabZone
  </div>
  <nav>
      <a href="${pageContext.request.contextPath}/student/studentDashboard"class="nav-item">
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
      <a href="${pageContext.request.contextPath}/student/fines" class="nav-item active">
          <i class="fas fa-dollar-sign"></i>
          Fines & Payments
      </a>
      <a href="${pageContext.request.contextPath}/student/profile" class="nav-item">
          <i class="fas fa-user"></i>
          Profile
      </a>
  </nav>
</aside>
        <!-- Main Content -->
        <main class="main-content">
            <div class="header">
                <h1 class="page-title">Fines & Payments</h1>
            </div>

            <!-- Summary Cards -->
            <div class="summary-cards">
                <div class="summary-card">
                    <div class="summary-title">Total Outstanding</div>
                    <div class="summary-value">$12.50</div>
                    <div class="summary-trend">
                        <i class="fas fa-arrow-up" style="color: var(--danger)"></i>
                        <span>From 2 overdue books</span>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="summary-title">Paid This Month</div>
                    <div class="summary-value">$8.00</div>
                    <div class="summary-trend">
                        <i class="fas fa-check" style="color: var(--success)"></i>
                        <span>3 payments</span>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="summary-title">Pending Disputes</div>
                    <div class="summary-value">1</div>
                    <div class="summary-trend">
                        <i class="fas fa-clock" style="color: var(--warning)"></i>
                        <span>Under review</span>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="summary-title">Account Status</div>
                    <div class="summary-value" style="color: var(--warning)">Limited</div>
                    <div class="summary-trend">
                        <i class="fas fa-exclamation-triangle"></i>
                        <span>Due to outstanding fines</span>
                    </div>
                </div>
            </div>


            <!-- Fine Details and Payment -->
                        <div class="fine-details">
                          <!-- Fine List -->
                          <div class="fine-list">
                              <div class="fine-item">
                                  <div class="fine-book">
                                      <div class="book-cover">
                                          <img src="https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c" alt="Book Cover">
                                      </div>
                                      <div class="book-info">
                                          <h4>The Design of Everyday Things</h4>
                                          <p>Due: Oct 15, 2023</p>
                                          <p>Days Overdue: 5</p>
                                      </div>
                                  </div>
                                  <div class="fine-amount">$7.50</div>
                              </div>
                              <div class="fine-item">
                                  <div class="fine-book">
                                      <div class="book-cover">
                                          <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73" alt="Book Cover">
                                      </div>
                                      <div class="book-info">
                                          <h4>Clean Code</h4>
                                          <p>Due: Oct 18, 2023</p>
                                          <p>Days Overdue: 2</p>
                                      </div>
                                  </div>
                                  <div class="fine-amount">$5.00</div>
                              </div>
                          </div>

                          <!-- Payment Section -->
                          <div class="payment-section">
                              <div class="payment-header">
                                  <h3>Payment Summary</h3>
                                  <div class="payment-total">$12.50</div>
                              </div>
                              <button class="btn btn-primary">
                                  <i class="fas fa-credit-card"></i>
                                  Pay Now
                              </button>
                              <button class="btn btn-outline">
                                  <i class="fas fa-flag"></i>
                                  Dispute Fine
                              </button>

                              <!-- Fine Calculator -->
                              <div class="calculator">
                                  <h3>Fine Calculator</h3>
                                  <div class="calculator-input">
                                      <div class="input-group">
                                          <label>Days Overdue</label>
                                          <input type="number" min="1" value="1">
                                      </div>
                                      <div class="input-group">
                                          <label>Number of Books</label>
                                          <input type="number" min="1" value="1">
                                      </div>
                                  </div>
                                  <button class="btn btn-outline">Calculate Fine</button>
                              </div>

                              <!-- Latest Receipt -->
                              <div class="receipt">
                                  <div class="receipt-header">
                                      <h3>Latest Payment Receipt</h3>
                                      <p>Transaction ID: #LIB-2023-001</p>
                                  </div>
                                  <div class="receipt-details">
                                      <div class="receipt-row">
                                          <span>Date</span>
                                          <span>Oct 10, 2023</span>
                                      </div>
                                      <div class="receipt-row">
                                          <span>Amount Paid</span>
                                          <span>$8.00</span>
                                      </div>
                                      <div class="receipt-row">
                                          <span>Payment Method</span>
                                          <span>Credit Card</span>
                                      </div>
                                  </div>
                                  <button class="btn btn-outline">
                                      <i class="fas fa-download"></i>
                                      Download Receipt
                                  </button>
                              </div>
                          </div>
                      </div>

                      <!-- Charts Section -->
                      <div class="charts-section">
                          <h3>Fine History</h3>
                          <div class="chart-container">
                              <canvas id="fineChart"></canvas>
                          </div>
                      </div>
                  </main>
              </div>
          </body>
          </html>
