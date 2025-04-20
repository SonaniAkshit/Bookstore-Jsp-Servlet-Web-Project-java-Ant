<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<script>
    document.querySelector('a[href="index.jsp"]').classList.add('active');
</script>

<!-- Main Content -->
<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none">
            <i class="fas fa-bars"></i>
        </button>
        <h2 class="mb-0"><i class="fas fa-home"></i> Admin Dashboard</h2>
        <div class="toast-container position-fixed top-0 end-0 p-3"></div>
    </div>

    <!-- Stats Cards -->
    <div class="row g-4 mb-4">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                
                PreparedStatement psBooks = conn.prepareStatement("SELECT COUNT(*) AS total_books FROM books");
                ResultSet rsBooks = psBooks.executeQuery();
                int totalBooks = 0;
                if (rsBooks.next()) {
                    totalBooks = rsBooks.getInt("total_books");
                }

                PreparedStatement psUsers = conn.prepareStatement("SELECT COUNT(*) AS total_users FROM user");
                ResultSet rsUsers = psUsers.executeQuery();
                int totalUsers = 0;
                if (rsUsers.next()) {
                    totalUsers = rsUsers.getInt("total_users");
                }

                PreparedStatement psPublishers = conn.prepareStatement("SELECT COUNT(*) AS total_publishers FROM publisher");
                ResultSet rsPublishers = psPublishers.executeQuery();
                int totalPublishers = 0;
                if (rsPublishers.next()) {
                    totalPublishers = rsPublishers.getInt("total_publishers");
                }

                PreparedStatement psAdmins = conn.prepareStatement("SELECT COUNT(*) AS total_admins FROM admin");
                ResultSet rsAdmins = psAdmins.executeQuery();
                int totalAdmins = 0;
                if (rsAdmins.next()) {
                    totalAdmins = rsAdmins.getInt("total_admins");
                }

                PreparedStatement psCart = conn.prepareStatement("SELECT COUNT(*) AS total_cart FROM cart");
                ResultSet rsCart = psCart.executeQuery();
                int totalCart = 0;
                if (rsCart.next()) {
                    totalCart = rsCart.getInt("total_cart");
                }

                PreparedStatement psorders = conn.prepareStatement("SELECT COUNT(*) AS total_orders FROM orders");
                ResultSet rsorders = psorders.executeQuery();
                int totalorders = 0;
                if (rsorders.next()) {
                    totalorders = rsorders.getInt("total_orders");
                }

                conn.close();
        %>

        <!-- Total Books Card -->
        <div class="col-md-3">
            <div class="stats-card">
                <div class="icon bg-primary text-white">
                    <i class="fas fa-book"></i>
                </div>
                <h3><%= totalBooks %></h3>
                <p class="text-muted mb-0">Books</p>
            </div>
        </div>

        <!-- Total Users Card -->
        <div class="col-md-3">
            <div class="stats-card">
                <div class="icon bg-warning text-white">
                    <i class="fas fa-users"></i>
                </div>
                <h3><%= totalUsers %></h3>
                <p class="text-muted mb-0">Users</p>
            </div>
        </div>

        <!-- Total Publishers Card -->
        <div class="col-md-3">
            <div class="stats-card">
                <div class="icon bg-info text-white">
                    <i class="fas fa-building"></i>
                </div>
                <h3><%= totalPublishers %></h3>
                <p class="text-muted mb-0">Publishers</p>
            </div>
        </div>

        <!-- Total Admins Card -->
        <div class="col-md-3">
            <div class="stats-card">
                <div class="icon bg-danger text-white">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h3><%= totalAdmins %></h3>
                <p class="text-muted mb-0">Admins</p>
            </div>
        </div>

        <!-- New cart Card -->
        <div class="col-md-3">
            <div class="stats-card">
                <div class="icon bg-success text-white">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h3><%= totalCart %></h3>
                <p class="text-muted mb-0">Cart</p>
            </div>
        </div>

        <!-- Order Card -->
        <div class="col-md-3">
            <div class="stats-card">
                <div class="icon bg-primary text-white">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <h3><%= totalorders %></h3>
                <p class="text-muted mb-0">Orders</p>
            </div>
        </div>

    </div>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <!-- Recent Orders Table -->
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Recent Orders</h5>
            <table class="table admin-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Books</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM orders WHERE DATE(ordered_at) = CURDATE()");

                            while (rs.next()) {
                                int orderId = rs.getInt("id");
                    %>
                    <tr>
                        <td><%= orderId %></td>
                        <td><%= rs.getString("customer_name") %></td>
                        <td><%= rs.getString("books") %></td>
                        <td>Rs.<%= rs.getInt("total") %></td>
                        <td>
                            <% String status = rs.getString("status"); %>
                            <span class="badge bg-<%= status.equals("delivered") ? "success" : status.equals("cancelled") ? "danger" : "warning" %>">
                                <%= status.equals("pending") ? "Processing" : status.substring(0, 1).toUpperCase() + status.substring(1) %>
                            </span>
                        </td>
                    </tr>
                    <%      }
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="js/admin-script.js"></script>
</body>
</html>
