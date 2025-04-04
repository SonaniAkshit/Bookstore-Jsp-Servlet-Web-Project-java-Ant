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
    </div>

    <!-- Search Box -->
    <div class="mb-4">
        <div class="input-group">
            <span class="input-group-text">
                <i class="fas fa-search"></i>
            </span>
            <input type="text" id="searchInput" class="form-control" placeholder="Search by Name, Email, or Role" onkeyup="searchUsers()">
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
                        <th>Contact</th>
                        <th>Gender</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Last Login</th>
                        <th>Last Logout</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                            stmt = con.createStatement();

                            // SQL query to fetch users
                            String sql = "SELECT id, name, email, contact, gender, role, status, last_login, last_logout FROM "
                                       + "(SELECT id, name, email, contact, gender, role, status, last_login, last_logout FROM admin "
                                       + " UNION ALL "
                                       + "SELECT id, name, email, contact, gender, role, status, last_login, last_logout FROM user "
                                       + " UNION ALL "
                                       + "SELECT id, name, email, contact, gender, role, status, last_login, last_logout FROM publisher) AS combined_users";

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
                                    <th>
                                        <% if (status != null && status.equalsIgnoreCase("Active")) { %>
                                            <i class="fas fa-circle text-success"></i>
                                        <% } else { %>
                                            <i class="fas fa-circle text-danger"></i>
                                        <% } %>
                                    </th>
                                    <td><%= lastLogin != null ? lastLogin : "Never logged in" %></td>
                                    <td><%= lastLogout != null ? lastLogout : "Never logged out" %></td>
                                </tr>
                    <%
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

<script>
// Function to filter the users table based on the search query
function searchUsers() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toLowerCase();
    let table = document.getElementById("usersTable");
    let tr = table.getElementsByTagName("tr");

    // Loop through all table rows and hide those that don't match the search query
    for (let i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
        let td = tr[i].getElementsByTagName("td");
        let match = false;
        
        // Loop through all columns of the row
        for (let j = 0; j < td.length; j++) {
            if (td[j]) {
                let textValue = td[j].textContent || td[j].innerText;
                if (textValue.toLowerCase().indexOf(filter) > -1) {
                    match = true;
                }
            }
        }

        // Show or hide row based on whether it matches the search term
        if (match) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }
}
</script>

</body>
</html>
