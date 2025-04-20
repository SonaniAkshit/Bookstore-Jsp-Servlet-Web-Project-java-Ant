<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
    // Check session attributes for admin login
    String userName = (String) session.getAttribute("adminName");
    String userEmail = (String) session.getAttribute("adminEmail");
    String userRole = (String) session.getAttribute("userRole");

    if (userName == null || userEmail == null || !"admin".equals(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/bookstore";
    String dbUser = "root";
    String dbPass = "";
    
    // Initialize admin variables
    String contact = "", gender = "", lastLogin = "", lastLogout = "", status = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        String query = "SELECT id, name, email, contact, gender, last_login, last_logout, status FROM admin WHERE email=?";
        
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, userEmail);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            userName = rs.getString("name");
            contact = rs.getString("contact");
            gender = rs.getString("gender");
            lastLogin = rs.getString("last_login");
            lastLogout = rs.getString("last_logout");
            status = rs.getString("status");
        }
        
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
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
    </div>

    <!-- <div class="row"> -->
        <!-- Profile Image and Basic Info -->
        <div class="col-md-4">
            <div class="admin-profile">
                <div class="profile-header">
                    <img src="https://i.pravatar.cc/150?img=12" alt="Admin Avatar" class="profile-avatar">
                    <h4 class="mt-3"><%= userName %></h4>
                    <p class="text-muted mb-0"><%= userEmail %></p>
                    <p class="text-muted mb-0"><%= contact %></p>
                </div>
            </div>
        </div>

        <!-- Profile Information 
        <div class="col-md-8">
            <div class="admin-profile">
                <h4 class="mb-4">Profile Info</h4>
                <form id="adminProfileForm" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="adminName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="adminName" value="<%= userName %>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="adminEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="adminEmail" value="<%= userEmail %>" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="adminContact" class="form-label">Contact</label>
                        <input type="text" class="form-control" id="adminContact" value="<%= contact %>" readonly>
                    </div>
                </form>
            </div>
        </div> -->
    </div>
<!-- </div> -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
