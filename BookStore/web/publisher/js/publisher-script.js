// Publisher Dashboard Script
$(document).ready(function() {
    // Initialize tooltips and popovers
    $('[data-bs-toggle="tooltip"]').tooltip();
    $('[data-bs-toggle="popover"]').popover();



    // Load publisher statistics
    $.ajax({
        url: 'get-publisher-stats',
        type: 'GET',
        success: function(response) {
            $('#totalBooks').text(response.totalBooks || 0);
            $('#totalSales').text(response.totalSales || 0);
        }
    });
    
    // Initialize DataTables
    if ($('#booksTable').length) {
        $('#booksTable').DataTable({
            responsive: true,
            order: [[0, 'desc']],
            language: {
                search: "_INPUT_",
                searchPlaceholder: "Search books..."
            }
        });
    }

    // Password strength checker
    function checkPasswordStrength(password) {
        let strength = 0;
        const feedback = {
            strength: 0,
            text: 'None',
            color: '#dc3545'
        };

        if (password.length >= 8) strength += 25;
        if (password.match(/[a-z]+/)) strength += 25;
        if (password.match(/[A-Z]+/)) strength += 25;
        if (password.match(/[0-9]+/)) strength += 25;

        if (strength >= 100) {
            feedback.text = 'Strong';
            feedback.color = '#28a745';
        } else if (strength >= 50) {
            feedback.text = 'Medium';
            feedback.color = '#ffc107';
        } else if (strength > 0) {
            feedback.text = 'Weak';
            feedback.color = '#dc3545';
        }

        feedback.strength = strength;
        return feedback;
    }

    // Handle password visibility toggle
    $('.toggle-password').click(function() {
        const targetId = $(this).data('target');
        const input = $('#' + targetId);
        const icon = $(this).find('i');

        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            icon.removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            icon.removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });

    // Password strength indicator
    $('#newPassword').on('input', function() {
        const password = $(this).val();
        const feedback = checkPasswordStrength(password);
        const strengthBar = $('.password-strength .progress-bar');
        const strengthText = $('.password-strength .strength-text');

        strengthBar.css({
            'width': feedback.strength + '%',
            'background-color': feedback.color
        });
        strengthText.text(feedback.text).css('color', feedback.color);
    });

    // Form validation with enhanced feedback
    $('.publisher-form').submit(function(e) {
        e.preventDefault();
        let isValid = true;
        const form = $(this);
        
        form.find('.form-control').each(function() {
            const input = $(this);
            const value = input.val().trim();
            const required = input.prop('required');
            
            if (required && value === '') {
                isValid = false;
                input.addClass('is-invalid').removeClass('is-valid');
                input.next('.invalid-feedback').text('This field is required');
            } else if (input.attr('type') === 'email' && value !== '') {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    isValid = false;
                    input.addClass('is-invalid').removeClass('is-valid');
                    input.next('.invalid-feedback').text('Please enter a valid email address');
                } else {
                    input.addClass('is-valid').removeClass('is-invalid');
                }
            } else if (input.attr('type') === 'password' && value !== '') {
                if (value.length < 6) {
                    isValid = false;
                    input.addClass('is-invalid').removeClass('is-valid');
                    input.next('.invalid-feedback').text('Password must be at least 6 characters long');
                } else {
                    input.addClass('is-valid').removeClass('is-invalid');
                }
            } else if (value !== '') {
                input.addClass('is-valid').removeClass('is-invalid');
            }
        });
        
        if (isValid) {
            // Show loading state
            const submitBtn = form.find('[type="submit"]');
            const originalText = submitBtn.text();
            submitBtn.prop('disabled', true)
                     .html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...');
            
            // Simulate form submission (replace with actual AJAX call)
            setTimeout(function() {
                submitBtn.prop('disabled', false).text(originalText);
                
                // Show success message
                Swal.fire({
                    title: 'Success!',
                    text: 'Your changes have been saved.',
                    icon: 'success',
                    confirmButtonColor: '#3498db'
                });
                
                // Reset form state
                form.find('.is-valid').removeClass('is-valid');
            }, 1000);
        }
    });
    
    // Confirm actions with enhanced UI
    $('.publisher-confirm-action').click(function(e) {
        e.preventDefault();
        const actionUrl = $(this).attr('href');
        const actionType = $(this).data('action-type') || 'proceed';
        
        let config = {
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3498db',
            cancelButtonColor: '#95a5a6',
            confirmButtonText: 'Yes, proceed!',
            cancelButtonText: 'Cancel',
            showClass: {
                popup: 'animate__animated animate__fadeIn'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOut'
            }
        };
        
        if (actionType === 'delete') {
            config.confirmButtonColor = '#e74c3c';
            config.confirmButtonText = 'Yes, delete it!';
            config.title = 'Delete Confirmation';
        }
        
        Swal.fire(config).then((result) => {
            if (result.isConfirmed) {
                window.location.href = actionUrl;
            }
        });
    });
    
    // Toggle sidebar on mobile
    $('.sidebar-toggle').click(function() {
        $('body').toggleClass('sidebar-active');
    });
});