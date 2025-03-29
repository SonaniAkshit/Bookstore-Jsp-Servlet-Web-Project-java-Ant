<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
    // Check session attributes for admin login
    String userName = (String) session.getAttribute("adminName");
    String userEmail = (String) session.getAttribute("adminEmail");
    String userRole = (String) session.getAttribute("userRole"); // Check for admin role
    
    // Redirect to login page if session attributes are missing or role isn't admin
    if (userName == null || userEmail == null || !"admin".equals(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<script>
    document.querySelector('a[href="admin-profile.jsp"]').classList.add('active');
</script>

<!-- Main Content -->
<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none">
            <i class="fas fa-bars"></i>
        </button>
        <h2 class="mb-0">Admin Profile</h2>
        <div class="toast-container position-fixed top-0 end-0 p-3"></div>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="admin-profile">
                <div class="profile-header">
                    <img src="https://i.pravatar.cc/150?img=12" alt="Admin Avatar" class="profile-avatar">
                    <h4 class="mt-3"><%= userName %></h4>  <!-- Display admin name -->
                    <p class="text-muted mb-0"><%= userEmail %></p>  <!-- Display admin email -->
                </div>
                <div class="profile-stats">
                    <div class="row text-center">
                        <div class="col-4">
                            <h5>150</h5>
                            <small class="text-muted">Books</small>
                        </div>
                        <div class="col-4">
                            <h5>45</h5>
                            <small class="text-muted">Orders</small>
                        </div>
                        <div class="col-4">
                            <h5>289</h5>
                            <small class="text-muted">Users</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="admin-profile">
                <h4 class="mb-4">Profile Settings</h4>
                <form id="adminProfileForm" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="adminName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="adminName" value="<%= userName %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="adminEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="adminEmail" value="<%= userEmail %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="adminPassword" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="adminPassword">
                        <small class="text-muted">Leave blank to keep current password</small>
                    </div>
                    <div class="mb-3">
                        <label for="adminAvatar" class="form-label">Profile Picture</label>
                        <input type="file" class="form-control" id="adminAvatar" accept="image/*" onchange="previewImage(this)">
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>

            <div class="admin-profile mt-4">
                <h4 class="mb-4">Recent Activity</h4>
                <div class="list-group list-group-flush">
                    <div class="list-group-item">
                        <div class="d-flex w-100 justify-content-between">
                            <h6 class="mb-1">Updated book inventory</h6>
                            <small>3 hours ago</small>
                        </div>
                        <p class="mb-1">Added 50 new copies of "The Great Gatsby"</p>
                    </div>
                    <div class="list-group-item">
                        <div class="d-flex w-100 justify-content-between">
                            <h6 class="mb-1">Processed order</h6>
                            <small>5 hours ago</small>
                        </div>
                        <p class="mb-1">Order #12345 marked as delivered</p>
                    </div>
                    <div class="list-group-item">
                        <div class="d-flex w-100 justify-content-between">
                            <h6 class="mb-1">User management</h6>
                            <small>1 day ago</small>
                        </div>
                        <p class="mb-1">Approved 3 new user registrations</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/admin-script.js"></script>
</body>
</html>
