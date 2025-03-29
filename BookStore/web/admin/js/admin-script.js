// Admin Dashboard Scripts

// Sidebar Toggle Functionality
document.addEventListener('DOMContentLoaded', function() {
    const sidebarToggle = document.getElementById('sidebar-toggle');
    const adminSidebar = document.querySelector('.admin-sidebar');
    const adminMain = document.querySelector('.admin-main');

    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            adminSidebar.classList.toggle('show');
            adminMain.classList.toggle('full-width');
        });
    }

    // Close sidebar on mobile when clicking outside
    document.addEventListener('click', function(event) {
        const isMobile = window.innerWidth <= 768;
        if (isMobile && !event.target.closest('.admin-sidebar') && !event.target.closest('#sidebar-toggle')) {
            adminSidebar.classList.remove('show');
            adminMain.classList.remove('full-width');
        }
    });
});

// Data Visualization Example (using Chart.js)
function initializeCharts() {
    const salesChart = document.getElementById('salesChart');
    if (salesChart) {
        new Chart(salesChart, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Monthly Sales',
                    data: [65, 59, 80, 81, 56, 55],
                    borderColor: '#3498db',
                    tension: 0.1,
                    fill: false
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Monthly Sales Overview'
                    }
                }
            }
        });
    }
}

// Data Table Initialization
function initializeDataTables() {
    const dataTables = document.querySelectorAll('.admin-table');
    dataTables.forEach(table => {
        new DataTable(table, {
            pageLength: 10,
            responsive: true,
            dom: 'Bfrtip',
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
        });
    });
}

// Form Validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return;

    form.addEventListener('submit', function(event) {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });
}

// Initialize all components
document.addEventListener('DOMContentLoaded', function() {
    initializeCharts();
    initializeDataTables();
    validateForm('adminProfileForm');

    // Enable tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

// Handle Image Preview
function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.querySelector('.profile-avatar').src = e.target.result;
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// Notification System
const notifications = {
    show: function(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast show bg-${type}`;
        toast.setAttribute('role', 'alert');
        toast.innerHTML = `
            <div class="toast-header">
                <strong class="me-auto">Notification</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body text-white">
                ${message}
            </div>
        `;
        document.querySelector('.toast-container').appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
    },
    success: function(message) {
        this.show(message, 'success');
    },
    error: function(message) {
        this.show(message, 'danger');
    },
    warning: function(message) {
        this.show(message, 'warning');
    }
};