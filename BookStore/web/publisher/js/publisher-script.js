// Publisher Dashboard Script
$(document).ready(function() {
    // Initialize tooltips
    $('[data-toggle="tooltip"]').tooltip();
    
    // Form validation
    $('.publisher-form').submit(function(e) {
        let isValid = true;
        $(this).find('.publisher-form-control').each(function() {
            if ($(this).val() === '') {
                isValid = false;
                $(this).addClass('is-invalid');
            } else {
                $(this).removeClass('is-invalid');
            }
        });
        
        if (!isValid) {
            e.preventDefault();
            $('.publisher-form-error').removeClass('d-none');
        }
    });
    
    // Confirm actions
    $('.publisher-confirm-action').click(function(e) {
        e.preventDefault();
        const actionUrl = $(this).attr('href');
        
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, proceed!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = actionUrl;
            }
        });
    });
});