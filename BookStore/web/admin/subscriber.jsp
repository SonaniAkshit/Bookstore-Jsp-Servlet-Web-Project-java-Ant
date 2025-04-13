<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="header.jsp" %>

<%
    int totalSubscribers = 0;
    int newToday = 0;

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        Statement stmt = conn.createStatement();

        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM subscriber");
        if (rs1.next()) totalSubscribers = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM subscriber WHERE DATE(subscribed_at) = CURDATE()");
        if (rs2.next()) newToday = rs2.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
    document.querySelector('a[href="subscriber.jsp"]').classList.add('active');
</script>

<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none"><i class="fas fa-bars"></i></button>
        <h2 class="mb-0"> <i class="fas fa-envelope"></i> Subscriber Management</h2>
    </div>

    <!-- Subscriber Statistics -->
    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="stats-card">
                <div class="icon bg-primary text-white"><i class="fas fa-users"></i></div>
                <h3><%= totalSubscribers %></h3>
                <p class="text-muted mb-0">Total Subscribers</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="stats-card">
                <div class="icon bg-success text-white"><i class="fas fa-user-plus"></i></div>
                <h3><%= newToday %></h3>
                <p class="text-muted mb-0">New Today</p>
            </div>
        </div>
    </div>

    <button class="btn btn-success" onclick="composeToAll()">
        <i class="fas fa-bullhorn me-1"></i> Compose to All
    </button>

    <br><br>
    <!-- Email Compose Modal -->
    <div class="modal fade" id="composeModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="../SendNewsletterServlet" method="post" class="needs-validation" novalidate>
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title"><i class="fas fa-envelope me-2"></i>Compose Newsletter</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-users me-1"></i>To:</label>
                            <input type="text" class="form-control" id="recipients" name="recipients" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-heading me-1"></i>Subject:</label>
                            <input type="text" class="form-control" name="subject" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-pen me-1"></i>Message:</label>
                            <textarea class="form-control" name="message" rows="6" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane me-1"></i>Send</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Subscribers Table -->
    <div class="card">
        <div class="card-body">
            <table class="table admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Email</th>
                        <th>Subscription Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM subscriber");

                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String email = rs.getString("email");
                                String subscribedAt = rs.getString("subscribed_at");
                    %>
                    <tr>
                        <td><%= id %></td>
                        <td><i class="fas fa-envelope me-1"></i><%= email %></td>
                        <td><i class="fas fa-calendar me-1"></i><%= subscribedAt %></td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td>
                            <!-- <button class="btn btn-sm btn-primary me-1" onclick="composeTo('<%= email %>')">
                                <i class="fas fa-envelope"></i>
                            </button> -->
                            <button class="btn btn-sm btn-danger" onclick="Swal.fire({
                                title: 'Are you sure?',
                                text: 'You want to delete this subscriber?',
                                icon: 'warning',
                                showCancelButton: true,
                                confirmButtonText: 'Yes, delete it!'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    window.location.href = '../DeleteSubscriberServlet?id=<%= id %>';
                                }
                            })">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    <%
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function composeTo(email) {
    document.getElementById('recipients').value = email;
    new bootstrap.Modal(document.getElementById('composeModal')).show();
}

function composeToAll() {
    const emails = Array.from(document.querySelectorAll('table tbody tr td:nth-child(2)'))
        .map(td => td.textContent.trim())
        .join(', ');
    document.getElementById('recipients').value = emails;
    new bootstrap.Modal(document.getElementById('composeModal')).show();
}

// Bootstrap form validation
(function () {
    'use strict'
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>
