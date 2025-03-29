<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<script>
    document.querySelector('a[href="users.jsp"]').classList.add('active');
</script>

<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none">
            <i class="fas fa-bars"></i>
        </button>
        <h2 class="mb-0">User Management</h2>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
            <i class="fas fa-plus"></i> Add New User
        </button>
    </div>

    <!-- Users Table -->
    <div class="card">
        <div class="card-body">
            <table class="table admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Gender</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Last Login</th>
                        <th>Last Logout</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Database Connection and Data Fetching
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BookStore", "root", "");
                            stmt = con.createStatement();

                            // SQL query to fetch users from admin, user, and author tables with all fields
                            String sql = "SELECT id, name, email, contact, gender, role, status, last_login, last_logout FROM "
                                       + "(SELECT id, name, email, contact, gender, 'Admin' AS role, status, last_login, last_logout FROM admin "
                                       + " UNION ALL "
                                       + "SELECT id, name, email, contact, gender, 'User' AS role, status, last_login, last_logout FROM user "
                                       + " UNION ALL "
                                       + "SELECT id, name, email, contact, gender, 'Author' AS role, status, last_login, last_logout FROM author) AS combined_users";

                            rs = stmt.executeQuery(sql);

                            // Display fetched data dynamically in table rows
                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String name = rs.getString("name");
                                String email = rs.getString("email");
                                String contact = rs.getString("contact");
                                String gender = rs.getString("gender");
                                String role = rs.getString("role");
                                String status = rs.getString("status");
                                String lastLogin = rs.getString("last_login");
                                String lastLogout = rs.getString("last_logout");
                    %>
                                <tr>
                                    <td><%= id %></td>
                                    <td><%= name %></td>
                                    <td><%= email %></td>
                                    <td><%= contact %></td>
                                    <td><%= gender != null ? gender : "N/A" %></td>
                                    <td><%= role %></td>
                                    <td>
                                        <% if ("active".equals(status)) { %>
                                            <i class="fas fa-circle text-success"></i> Active
                                        <% } else { %>
                                            <i class="fas fa-circle text-danger"></i> Inactive
                                        <% } %>
                                    </td>
                                    <td><%= lastLogin != null ? lastLogin : "Never logged in" %></td>
                                    <td><%= lastLogout != null ? lastLogout : "Never logged out" %></td>
                                    <td>
                                        <button class="btn btn-sm btn-primary">Edit</button>
                                        <button class="btn btn-sm btn-danger">Delete</button>
                                    </td>
                                </tr>
                    <%
                            } 
                        } catch (Exception e) {
                            e.printStackTrace(); // Handle exception
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (con != null) con.close();
                            } catch (SQLException ex) {
                                ex.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Include Bootstrap, Font Awesome, and other JS libraries -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="js/admin-script.js"></script>
<script src="js/user-management.js"></script>

</body>
</html>
