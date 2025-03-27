<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - E-Books Digital Library</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
    <%
        String messageType = (String) session.getAttribute("messageType");
        String messageTitle = (String) session.getAttribute("messageTitle");
        String messageText = (String) session.getAttribute("messageText");
        
        if (messageType != null && messageTitle != null && messageText != null) {
    %>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            Swal.fire({
                icon: '<%= messageType %>',
                title: '<%= messageTitle %>',
                text: '<%= messageText %>'
            }).then((result) => {
                if ('<%= messageType %>' === 'success') {
                    window.location.href = 'login.jsp';
                }
            });
        });
    </script>
    <%
            session.removeAttribute("messageType");
            session.removeAttribute("messageTitle");
            session.removeAttribute("messageText");
        }
    %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <a href="index.jsp" class="home-button" title="Back to Home">
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
                <h2 class="text-center mb-3">Create Account</h2>
                
                <form class="row g-2" action="SignupServlet" method="post" onsubmit="return validateForm()">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="name" name="name" placeholder="Full Name">
                            <label for="name">Full Name</label>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="email" name="email" placeholder="Email">
                            <label for="email">Email</label>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="contact" name="contact" placeholder="Contact">
                            <label for="contact">Contact</label>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-floating">
                            <div class="gender-radio-group pt-2">
                                <label class="form-label">Gender</label>&nbsp;&nbsp;&nbsp;
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="male" value="male">
                                    <label class="form-check-label" for="male">Male</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                                    <label class="form-check-label" for="female">Female</label>
                                </div>
                                <!-- <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="other" value="other">
                                    <label class="form-check-label" for="other">Other</label>
                                </div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-floating">
                            <select class="form-select" id="role" name="role">
                                <option value="">Select Role</option>
                                <option value="reader">Reader</option>
                                <option value="author">Author</option>
                                <option value="publisher">Publisher</option>
                            </select>
                            <label for="role">User Role</label>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                            <label for="password">Password</label>
                            <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                <i class="far fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password">
                            <label for="confirmPassword">Confirm Password</label>
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <i class="far fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-primary w-100">Sign Up</button>
                    </div>
                </form>
                
                <div class="text-center mt-3">
                    <span class="text-muted">Already have an account?</span>
                    <a href="login.jsp" class="login-link">Sign In</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Form Validation and Password Toggle Scripts -->
    <script>
        function validateForm() {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const contact = document.getElementById('contact').value.trim();
            const gender = document.querySelector('input[name="gender"]:checked');
            const role = document.getElementById('role').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            // Name validation
            if (name === '') {
                showError('Please enter your full name');
                return false;
            }

            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showError('Please enter a valid email address');
                return false;
            }

            // Contact validation
            const contactRegex = /^\d{10}$/;
            if (!contactRegex.test(contact)) {
                showError('Please enter a valid 10-digit contact number');
                return false;
            }

            // Gender validation
            if (!gender) {
                showError('Please select your gender');
                return false;
            }

            // Role validation
            if (role === '') {
                showError('Please select your role');
                return false;
            }

            // Password validation
            if (password.length < 6) {
                showError('Password must be at least 6 characters long');
                return false;
            }

            // Confirm password validation
            if (password !== confirmPassword) {
                showError('Passwords do not match');
                return false;
            }

            return true;
        }

        function showError(message) {
            Swal.fire({
                icon: 'error',
                title: 'Validation Error',
                text: message
            });
        }

        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = input.nextElementSibling.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>