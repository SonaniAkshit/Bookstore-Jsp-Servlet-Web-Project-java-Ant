// Initialize DataTable
let userTable;

// Function to format date
function formatDate(dateString) {
    if (!dateString) return 'Never';
    const date = new Date(dateString);
    return date.toLocaleString();
}

// Function to update statistics cards
function updateStatistics(stats) {
    document.querySelector('.stats-card:nth-child(1) h3').textContent = stats.total || 0;
    document.querySelector('.stats-card:nth-child(2) h3').textContent = stats.user || 0;
    document.querySelector('.stats-card:nth-child(3) h3').textContent = stats.author || 0;
    document.querySelector('.stats-card:nth-child(4) h3').textContent = stats.admin || 0;
}

// Function to load users
function loadUsers() {
    fetch('../UserManagementServlet?action=getUsers')
        .then(response => response.json())
        .then(data => {
            updateStatistics(data.statistics);
            
            if (userTable) {
                userTable.destroy();
            }
            
            const tableBody = document.querySelector('.admin-table tbody');
            tableBody.innerHTML = '';
            
            data.users.forEach(user => {
                const row = `
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td><span class="badge bg-secondary">${user.role}</span></td>
                        <td><span class="badge bg-${user.status === 'active' ? 'success' : 'warning'}">${user.status}</span></td>
                        <td>${formatDate(user.lastLogin)}</td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" onclick="viewUser(${user.id})">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm btn-warning me-1" onclick="editUser(${user.id})">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="deleteUser(${user.id})">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                `;
                tableBody.insertAdjacentHTML('beforeend', row);
            });
            
            // Initialize DataTable
            userTable = new DataTable('.admin-table', {
                order: [[3, 'asc'], [1, 'asc']],
                pageLength: 10,
                language: {
                    search: 'Search:',
                    lengthMenu: 'Show _MENU_ entries',
                    info: 'Showing _START_ to _END_ of _TOTAL_ entries',
                    paginate: {
                        first: 'First',
                        last: 'Last',
                        next: 'Next',
                        previous: 'Previous'
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error loading users:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Failed to load users. Please try again.'
            });
        });
}

// Load users when page loads
document.addEventListener('DOMContentLoaded', loadUsers);

// Refresh data every 5 minutes
setInterval(loadUsers, 300000);