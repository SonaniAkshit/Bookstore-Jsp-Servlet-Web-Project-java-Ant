<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification - E-Books</title>
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="CSS/otp.css">
</head>
<body>
    <div class="otp-container">
        <div class="text-center">
            <a href="index.html" class="otp-logo">
                <i class="fas fa-book-reader"></i>
                <span>E-Books</span>
            </a>

            <h2>Verify Your Email</h2>
            <p class="text-muted mb-4">Please enter the 4-digit code sent to <strong>${sessionScope.email}</strong></p>
            
            <form id="otpForm" action="OTPVerificationServlet" method="post">
                <div class="otp-inputs">
                    <input type="text" name="digit1" class="otp-input" maxlength="1" autofocus>
                    <input type="text" name="digit2" class="otp-input" maxlength="1">
                    <input type="text" name="digit3" class="otp-input" maxlength="1">
                    <input type="text" name="digit4" class="otp-input" maxlength="1">
                    <input type="hidden" name="otp" id="fullOtp">
                </div>
                
                <input type="submit" name="Verify" class="btn btn-primary">
                
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
    <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const otpInputs = document.querySelectorAll('.otp-input');
        const form = document.getElementById('otpForm');
        let timer = 30;
        let timerInterval;

        // Auto-focus functionality
        otpInputs.forEach((input, index) => {
            input.addEventListener('input', function() {
                if (this.value.length === 1) {
                    if (index < otpInputs.length - 1) {
                        otpInputs[index + 1].focus();
                    }
                }
            });

            input.addEventListener('keydown', function(e) {
                if (e.key === 'Backspace' && !this.value && index > 0) {
                    otpInputs[index - 1].focus();
                }
            });
        });

        // Timer functionality
        function startTimer() {
            timerInterval = setInterval(() => {
                timer--;
                document.getElementById('timer').textContent = timer + 's';
                
                if (timer <= 0) {
                    clearInterval(timerInterval);
                    document.getElementById('resendLink').classList.remove('d-none');
                    document.getElementById('timer').parentElement.classList.add('d-none');
                }
            }, 1000);
        }

        // Start timer on page load
        startTimer();

        // Handle form submission
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Combine OTP digits
            const otp = Array.from(otpInputs).map(input => input.value).join('');
            document.getElementById('fullOtp').value = otp;

            // Submit form if OTP is complete
            if (otp.length === 4) {
                this.submit();
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid OTP',
                    text: 'Please enter all 4 digits of the OTP',
                    showConfirmButton: true
                });
            }
        });

        // Handle resend link
        document.querySelector('.resend').addEventListener('click', function(e) {
            e.preventDefault();
            // Reset timer
            timer = 30;
            document.getElementById('timer').textContent = timer + 's';
            document.getElementById('resendLink').classList.add('d-none');
            document.getElementById('timer').parentElement.classList.remove('d-none');
            startTimer();

            // Clear inputs
            otpInputs.forEach(input => input.value = '');
            otpInputs[0].focus();

            // Show resend message
            Swal.fire({
                icon: 'success',
                title: 'OTP Resent!',
                text: 'Please check your email for the new verification code',
                showConfirmButton: false,
                timer: 2000
            });
        });
    });
    </script>
</body>
</html>
