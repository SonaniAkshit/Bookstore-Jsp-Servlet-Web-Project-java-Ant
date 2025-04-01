<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<script>
    document.querySelector('a[href="index.jsp"]').classList.add('active');
</script>

    <!-- Main Content -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <button id="sidebar-toggle" class="btn btn-primary d-md-none">
                <i class="fas fa-bars"></i>
            </button>
            <h2 class="mb-0">Dashboard Overview</h2>
            <div class="toast-container position-fixed top-0 end-0 p-3"></div>
        </div>

        <!-- Stats Cards -->
        <div class="row g-4 mb-4">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                    
                    PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) AS total_books FROM books");
                    ResultSet rs = ps.executeQuery();
                    
                    int totalBooks = 0;
                    if (rs.next()) {
                        totalBooks = rs.getInt("total_books");
                    }
                    conn.close();
            %>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-primary text-white">
                        <i class="fas fa-book"></i>
                    </div>
                    <h3><%= totalBooks %></h3>
                    <p class="text-muted mb-0">Total Books</p>
                </div>
            </div>
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-success text-white">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3>45</h3>
                    <p class="text-muted mb-0">New Orders</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-warning text-white">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>289</h3>
                    <p class="text-muted mb-0">Users</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-info text-white">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <h3>$12,456</h3>
                    <p class="text-muted mb-0">Total Revenue</p>
                </div>
            </div>
        </div>

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
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#12345</td>
                            <td>John Doe</td>
                            <td>The Great Gatsby, 1984</td>
                            <td>$45.98</td>
                            <td><span class="badge bg-success">Delivered</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary">View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#12344</td>
                            <td>Jane Smith</td>
                            <td>To Kill a Mockingbird</td>
                            <td>$15.99</td>
                            <td><span class="badge bg-warning">Processing</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary">View</button>
                            </td>
                        </tr>
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