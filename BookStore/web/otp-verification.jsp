<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification - E-Books</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/otp.css">
</head>
<body>
    <div class="otp-container">
        <div class="text-center">
            <a href="index.html" class="otp-logo">
                <i class="fas fa-book-reader"></i>
                <span>E-Books</span>
            </a>
            <%
                String userEmail = (String) session.getAttribute("email");
                if (userEmail == null) {
                    response.sendRedirect("signup.jsp");
                    return;
                }
            %>
            <h2>Verify Your Email</h2>
            <p class="text-muted mb-4">Please enter the 4-digit code sent to <strong><%= userEmail %></strong></p>
            
            <form id="otpForm">
                <div class="otp-inputs">
                    <input type="text" name="digit1" class="otp-input" maxlength="1" autofocus>
                    <input type="text" name="digit2" class="otp-input" maxlength="1">
                    <input type="text" name="digit3" class="otp-input" maxlength="1">
                    <input type="text" name="digit4" class="otp-input" maxlength="1">
                    <input type="hidden" name="otp" id="fullOtp">
                </div>
                
                <button type="submit" class="btn btn-primary">Verify</button>
                
                <div class="resend-timer">
                    <span class="text-muted">Resend code in </span>
                    <span id="timer">30s</span>
                </div>
                
                <div class="resend-link mt-2 d-none" id="resendLink">
                    <span class="text-muted">Didn't receive the code?</span>
                    <a href="#" class="resend">Resend</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- OTP Script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('.otp-input');
            const form = document.getElementById('otpForm');
            const fullOtpInput = document.getElementById('fullOtp');
            const timerDisplay = document.getElementById('timer');
            const resendLink = document.getElementById('resendLink');
            let timeLeft = 30;

            // Timer function
            function startTimer() {
                const timer = setInterval(() => {
                    timeLeft--;
                    timerDisplay.textContent = timeLeft + 's';
                    
                    if (timeLeft <= 0) {
                        clearInterval(timer);
                        document.querySelector('.resend-timer').classList.add('d-none');
                        resendLink.classList.remove('d-none');
                    }
                }, 1000);
            }

            // Start timer on page load
            startTimer();

            // Handle input behavior
            inputs.forEach((input, index) => {
                // Allow only numbers
                input.addEventListener('keypress', function(e) {
                    if (!/[0-9]/.test(e.key)) {
                        e.preventDefault();
                    }
                });

                // Handle input
                input.addEventListener('input', function() {
                    if (this.value.length === 1) {
                        // Move to next input
                        if (index < inputs.length - 1) {
                            inputs[index + 1].focus();
                        }
                    }
                });

                // Handle backspace
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Backspace' && !this.value && index > 0) {
                        inputs[index - 1].focus();
                    }
                });

                // Handle paste
                input.addEventListener('paste', function(e) {
                    e.preventDefault();
                    const pastedData = e.clipboardData.getData('text').slice(0, 4).split('');
                    inputs.forEach((input, i) => {
                        if (pastedData[i] && /[0-9]/.test(pastedData[i])) {
                            input.value = pastedData[i];
                            if (i < inputs.length - 1) {
                                inputs[i + 1].focus();
                            }
                        }
                    });
                });
            });

            // Handle form submission
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Combine OTP digits
                const otp = Array.from(inputs).map(input => input.value).join('');
                fullOtpInput.value = otp;
                
                // Validate all inputs are filled
                const isComplete = Array.from(inputs).every(input => input.value.length === 1);
                if (!isComplete) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Incomplete OTP',
                        text: 'Please enter all 4 digits of the OTP code.'
                    });
                    return;
                }

                // Prepare form data
                const formData = new FormData(form);
                
                fetch('VerifyOtpServlet', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: data.message || 'OTP verified successfully!',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            window.location.href = 'login.jsp';
                        });
                    } else {
                        throw new Error(data.message || 'Invalid OTP');
                    }
                })
                .catch(error => {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: error.message || 'Verification failed. Please try again.'
                    });
                    // Clear inputs
                    inputs.forEach(input => input.value = '');
                    inputs[0].focus();
                });
            });

            // Handle resend
            let isResending = false;
            document.querySelector('.resend').addEventListener('click', function(e) {
                e.preventDefault();
                if (isResending) return;
                isResending = true;
                
                fetch('ResendOtpServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        // Reset timer
                        timeLeft = 30;
                        timerDisplay.textContent = timeLeft + 's';
                        document.querySelector('.resend-timer').classList.remove('d-none');
                        resendLink.classList.add('d-none');
                        startTimer();
                        // Clear inputs
                        inputs.forEach(input => input.value = '');
                        inputs[0].focus();
                        
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: data.message || 'New OTP has been sent to your email!',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    } else {
                        throw new Error(data.message || 'Failed to resend OTP');
                    }
                })
                .catch(error => {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: error.message || 'Something went wrong. Please try again later.'
                    });
                })
                .finally(() => {
                    isResending = false;
                });
            });
        });
    </script>
</body>
</html>