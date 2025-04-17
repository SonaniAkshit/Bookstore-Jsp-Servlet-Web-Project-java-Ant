<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - E-Books Digital Library</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../CSS/style.css">
    <link rel="stylesheet" href="../CSS/login.css">
    
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
<body class="login-page">
    <a href="../index.jsp" class="home-button" title="Back to Home">
        <i class="fas fa-arrow-left"></i>
    </a>
    
    <div class="login-container">
        <div class="login-form-container">
            <div class="login-form">
                <div class="text-center mb-4">
                    <a href="../index.jsp" class="login-logo">
                        <i class="fas fa-book-reader"></i>
                        <span>E-Books Admin</span>
                    </a>
                </div>
                
                <h1>Admin Login</h1>
                <p class="text-muted mb-4">Please login to access admin dashboard</p>
                
                <form action="../AdminLoginServlet" method="POST">
                    <% 
                        if (request.getAttribute("error") != null) { 
                    %>
                        <div class="alert alert-danger" role="alert">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <% 
                        if (session.getAttribute("message") != null) { 
                    %>
                        <div class="alert alert-success" role="alert">
                            <%= session.getAttribute("message") %>
                            <% session.removeAttribute("message"); %>
                        </div>
                    <% } %>
                    
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="emailInput" name="email" placeholder="name@example.com" required>
                        <label for="emailInput">Admin Email</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="passwordInput" name="password" placeholder="Password" required>
                        <label for="passwordInput">Password</label>
                        <button type="button" class="password-toggle" onclick="togglePassword()">
                            <i class="far fa-eye"></i>
                        </button>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100 mb-3">Sign In</button>
<!--                    <p class="text-center mt-4">
                        Don't have an account? <a href="../signup.jsp" class="signup-link">Sign up</a>
                    </p>-->
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- Password Toggle JS -->
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('passwordInput');
            const icon = document.querySelector('.password-toggle i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>