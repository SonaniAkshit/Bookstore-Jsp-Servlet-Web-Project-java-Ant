<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - E-Books Digital Library</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/style.css">
    <link rel="stylesheet" href="CSS/signup.css">
    <style>
        .home-button {
            position: fixed;
            top: 20px;
            left: 20px;
            font-size: 24px;
            color: #333;
            text-decoration: none;
            transition: color 0.3s ease;
            z-index: 1000;
        }
        .home-button:hover {
            color: #007bff;
        }
    </style>
</head>
<body class="signup-page">
    <a href="login.jsp" class="home-button" title="Back to Login">
        <i class="fas fa-arrow-left"></i>
    </a>
    <div class="signup-container">
        <div class="signup-form-container">
            <div class="signup-form">
                <div class="text-center mb-3">
                    <a href="index.jsp" class="signup-logo">
                        <i class="fas fa-book-reader"></i>
                        <span>E-Books</span>
                    </a>
                </div>
                <h2 class="text-center mb-3">Forgot Password</h2>
                <p class="text-center text-muted mb-4">Enter your email address and we'll send you a link to reset your password.</p>
                
                <form class="row g-3" action="ForgotPasswordServlet" method="post">
                    <div class="col-12">
                        <div class="form-floating">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                            <label for="email">Email Address</label>
                        </div>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary w-100">Send Reset Link</button>
                    </div>
                </form>
                
                <div class="text-center mt-3">
                    <span class="text-muted">Remember your password?</span>
                    <a href="login.jsp" class="login-link">Sign In</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>