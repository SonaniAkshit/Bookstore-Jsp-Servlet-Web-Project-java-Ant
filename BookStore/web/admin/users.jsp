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
        <h2 class="mb-0"><i class="fas fa-users me-2"></i>User Management</h2>
    </div>

    <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        int totalUsers = 0;
        int activeUsers = 0;
        int inactiveUsers = 0;

        java.util.List<String[]> usersList = new java.util.ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
            stmt = con.createStatement();

            String sql = "SELECT id, name, email, contact, gender, password, role, last_login, last_logout, status FROM "
                       + "(SELECT id, name, email, contact, gender, password, role, last_login, last_logout, status FROM admin "
                       + " UNION ALL "
                       + "SELECT id, name, email, contact, gender, password, role, last_login, last_logout, status FROM user "
                       + " UNION ALL "
                       + "SELECT id, name, email, contact, gender, password, role, last_login, last_logout, status FROM publisher) AS combined_users";

            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                totalUsers++;

                String status = rs.getString("status");
                if ("Active".equalsIgnoreCase(status)) {
                    activeUsers++;
                } else {
                    inactiveUsers++;
                }

                usersList.add(new String[]{
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("contact"),
                    rs.getString("gender"),
                    rs.getString("password"),
                    rs.getString("role"),
                    status,
                    rs.getString("last_login"),
                    rs.getString("last_logout")
                });
            }

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error fetching data: " + e.getMessage() + "</p>");
            e.printStackTrace();
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

    <!-- User Statistics -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stats-card">
                <div class="icon bg-primary text-white"><i class="fas fa-users"></i></div>
                <h3><%= totalUsers %></h3>
                <p class="text-muted mb-0">Total Users</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <div class="icon bg-success text-white"><i class="fas fa-user-check"></i></div>
                <h3><%= activeUsers %></h3>
                <p class="text-muted mb-0">Active Users</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <div class="icon bg-danger text-white"><i class="fas fa-user-slash"></i></div>
                <h3><%= inactiveUsers %></h3>
                <p class="text-muted mb-0">Inactive Users</p>
            </div>
        </div>
    </div>

    <!-- Search Box -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="input-group">
                <span class="input-group-text bg-primary text-white">
                    <i class="fas fa-search"></i>
                </span>
                <input type="text" id="searchInput" class="form-control" placeholder="Search by Name, Email, or Role" onkeyup="searchUsers()">
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="card">
        <div class="card-body">
            <table class="table admin-table" id="usersTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <!-- <th>Contact</th> -->
                        <!-- <th>Gender</th> -->
                        <!-- <th>Password</th> -->
                        <th>Role</th>
                        <th>Status</th>
                        <th>Last Login</th>
                        <th>Last Logout</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (String[] user : usersList) {
                    %>
                    <tr>
                        <td><%= user[0] %></td>
                        <td><%= user[1] %></td>
                        <td><%= user[2] %></td>
                        <!-- <td><%= user[3] %></td> -->
                        <!-- <td><%= user[4] != null ? user[4] : "N/A" %></td> -->
                        <!-- <td><%= user[5] != null ? user[5] : "N/A" %></td> -->
                        <td><%= user[6] %></td>
                        <td>
                            <% if ("Active".equalsIgnoreCase(user[7])) { %>
                                <span class="badge bg-success">Active</span>
                            <% } else { %>
                                <span class="badge bg-danger">Inactive</span>
                            <% } %>
                        </td>
                        <td><%= user[8] != null ? user[8] : "Never logged in" %></td>
                        <td><%= user[9] != null ? user[9] : "Never logged out" %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="js/admin-script.js"></script>

<script>
    function searchUsers() {
        let input = document.getElementById("searchInput");
        let filter = input.value.toLowerCase();
        let table = document.getElementById("usersTable");
        let tr = table.getElementsByTagName("tr");

        for (let i = 1; i < tr.length; i++) {
            let td = tr[i].getElementsByTagName("td");
            let match = false;

            for (let j = 0; j < td.length; j++) {
                if (td[j]) {
                    let textValue = td[j].textContent || td[j].innerText;
                    if (textValue.toLowerCase().indexOf(filter) > -1) {
                        match = true;
                    }
                }
            }

            tr[i].style.display = match ? "" : "none";
        }
    }
</script>

</body>
</html>
