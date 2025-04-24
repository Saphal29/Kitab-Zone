<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Library Portal</title>

    <link href="${pageContext.request.contextPath}/static/css/home.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="main-nav">
        <div class="nav-container">
            <div class="nav-brand">
                <i class="fas fa-book-open"></i>
                KitabZone
            </div>
            <div class="nav-links">

                <a href="${pageContext.request.contextPath}/login" class="nav-btn">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="nav-btn primary">Get Started</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <div class="hero-text">
                <h1 class="hero-title">Discover Your Next<br>Great Read</h1>
                <p class="hero-subtitle">Access millions of academic resources, rare collections, and digital archives</p>
                <div class="cta-container">
                    <a href="${pageContext.request.contextPath}/register" class="hero-cta">Start Exploring</a>
                    <a href="${pageContext.request.contextPath}/login" class="hero-cta outline">View Catalog</a>
                </div>
            </div>
            <div class="hero-image">
                <img src="${pageContext.request.contextPath}/static/images/hero.jpg"
                     alt="Library books collection"
                     class="hero-img">
            </div>
        </div>
    </section>

    <!-- Featured Section -->
    <section class="featured">
        <div class="featured-container">
            <div class="featured-card">
                <img src="${pageContext.request.contextPath}/static/images/feature-image1.jpg"
                     alt="Digital Archives"
                     class="featured-img">
                <h3>Digital Archives</h3>
                <p>Access rare manuscripts and historical documents</p>
            </div>
            <div class="featured-card">
                <img src="${pageContext.request.contextPath}/static/images/feature-image2.jpg"
                     alt="Study Spaces"
                     class="featured-img">
                <h3>Eco-Reads</h3>
                <p>Book our state-of-the-art study facilities</p>
            </div>
            <div class="featured-card">
                <img src="${pageContext.request.contextPath}/static/images/feature-image3.jpg"
                     alt="Research Tools"
                     class="featured-img">
                <h3>Research Tools</h3>
                <p>Advanced citation and reference management</p>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact">
        <div class="contact-container">
            <h2>Get in Touch</h2>
            <div class="contact-info">
                <div class="contact-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <p>Itahari, Sunsari</p>
                </div>
                <div class="contact-item">
                    <i class="fas fa-phone"></i>
                    <p>+977 9823467543 </p>
                </div>
                <div class="contact-item">
                    <i class="fas fa-envelope"></i>
                    <p>kitabzone66@gmail.edu</p>
                </div>
            </div>
            <div class="social-links">
                <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-facebook"></i></a>
                <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="main-footer">
        <div class="footer-content">
            <p>&copy; 2025 kitabZone Academic Library. All rights reserved.</p>
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
            </div>
        </div>
    </footer>
</body>
</html>