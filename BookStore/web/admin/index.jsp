<%@ include file="header.jsp" %>
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
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-primary text-white">
                        <i class="fas fa-book"></i>
                    </div>
                    <h3>150</h3>
                    <p class="text-muted mb-0">Total Books</p>
                </div>
            </div>
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
                    <p class="text-muted mb-0">Active Users</p>
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

        <!-- Charts -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Sales Overview</h5>
                        <canvas id="salesChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Recent Activities</h5>
                        <div class="list-group list-group-flush">
                            <div class="list-group-item">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">New order received</h6>
                                    <small>3 mins ago</small>
                                </div>
                                <p class="mb-1">Order #12345 - $99.99</p>
                            </div>
                            <div class="list-group-item">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">New user registered</h6>
                                    <small>1 hour ago</small>
                                </div>
                                <p class="mb-1">John Doe joined the platform</p>
                            </div>
                            <div class="list-group-item">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">Book stock updated</h6>
                                    <small>2 hours ago</small>
                                </div>
                                <p class="mb-1">Added 50 copies of "The Great Gatsby"</p>
                            </div>
                        </div>
                    </div>
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