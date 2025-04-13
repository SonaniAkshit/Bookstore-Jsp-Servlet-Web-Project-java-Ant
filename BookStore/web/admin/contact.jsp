<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="header.jsp" %>

<%
    int totalSubscribers = 0;
    int newToday = 0;

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        Statement stmt = conn.createStatement();

        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM contact_messages");
        if (rs1.next()) totalSubscribers = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM contact_messages WHERE DATE(submitted_at) = CURDATE()");
        if (rs2.next()) newToday = rs2.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<script>
    document.querySelector('a[href="contact.jsp"]').classList.add('active');
</script>

<!-- Main Content -->
<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none">
            <i class="fas fa-bars"></i>
        </button>
        <h2 class="mb-0">Contact Messages</h2>
        <div class="btn-group">
        </div>
    </div>

       <!-- Subscriber Statistics -->
       <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="stats-card">
                <div class="icon bg-primary text-white">
                    <i class="fas fa-envelope"></i>
                </div>
                <h3><%= totalSubscribers %></h3>
                <p class="text-muted mb-0">Total Subscribers</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="stats-card">
                <div class="icon bg-info text-white">
                    <i class="fas fa-calendar"></i>
                </div>
                <h3><%= newToday %></h3>
                <p class="text-muted mb-0">New Today</p>
            </div>
        </div>
    </div>

    <!-- Contact Messages Table -->
    <div class="card">
        <div class="card-body">
            <table class="table admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM contact_messages");

                            while (rs.next()) {
                                String submittedAt = rs.getString("submitted_at");
                    %>
                    <tr>
                        <td>#<%= rs.getInt("id") %></td>
                        <td>
                            <i class="fas fa-user me-1"></i>
                            <%= rs.getString("name") %>
                        </td>
                        <td>
                            <i class="fas fa-envelope me-1"></i>
                            <%= rs.getString("email") %>
                        </td>
                        <td><%= rs.getString("subject") %></td>
                        <td>
                            <%= rs.getString("message") %>
                        </td>
                        <td>
                            <i class="fas fa-calendar me-1"></i>
                            <%= submittedAt %>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" onclick="composeTo('<%= rs.getString("email") %>', 'Re: <%= rs.getString("subject") %>')">
                                <i class="fas fa-reply"></i>
                            </button>

                            <button class="btn btn-sm btn-danger">
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

<!-- Email Compose Modal -->
<div class="modal fade" id="composeModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">
                    <i class="fas fa-reply me-2"></i>Reply to Message
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="../ReplyContactMessageServlet" class="needs-validation" method="post" novalidate>
                    <div class="mb-3">
                        <label for="recipients" class="form-label">
                            <i class="fas fa-user me-1"></i>To:
                        </label>
                        <input type="text" class="form-control" id="recipients" name="recipients" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label">
                            <i class="fas fa-heading me-1"></i>Subject:
                        </label>
                        <input type="text" class="form-control" id="subject" name="subject" required>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">
                            <i class="fas fa-envelope me-1"></i>Message:
                        </label>
                        <textarea class="form-control" id="message" name="message" rows="6" required></textarea>
                    </div>
                    <div class="text-end">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane me-1"></i>Send Reply
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Add these before closing body tag -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="js/admin-script.js"></script>
</body>
</html>
<script>
function composeTo(email, subject) {
    document.getElementById('recipients').value = email;
    document.getElementById('subject').value = subject || '';
    new bootstrap.Modal(document.getElementById('composeModal')).show();
}

function viewMessage(message) {
    const modal = new bootstrap.Modal(document.createElement('div'));
    modal.element.innerHTML = `
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Message Content</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="message-preview">${message}</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    `;
    document.body.appendChild(modal.element);
    modal.show();
}

// Form validation
(function () {
    'use strict'
    var forms = document.querySelectorAll('.needs-validation')
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }
            form.classList.add('was-validated')
        }, false)
    })
})()
</script>
