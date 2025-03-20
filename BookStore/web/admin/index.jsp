<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                </div>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-primary text-white">
                            <i class="fas fa-book"></i>
                            <h3>Total Books</h3>
                            <h2>250</h2>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-success text-white">
                            <i class="fas fa-users"></i>
                            <h3>Total Users</h3>
                            <h2>1,200</h2>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-warning text-white">
                            <i class="fas fa-shopping-cart"></i>
                            <h3>Total Orders</h3>
                            <h2>450</h2>
                        </div>
                    </div>
                    <div class="col-xl-3 col-md-6">
                        <div class="stat-card bg-info text-white">
                            <i class="fas fa-dollar-sign"></i>
                            <h3>Revenue</h3>
                            <h2>$15,250</h2>
                        </div>
                    </div>
                </div>

                <!-- Recent Orders Table -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Recent Orders</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Customer</th>
                                                <th>Books</th>
                                                <th>Total</th>
                                                <th>Date</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>#12345</td>
                                                <td>John Doe</td>
                                                <td>The Silent Patient</td>
                                                <td>$19.99</td>
                                                <td>2024-01-20</td>
                                                <td><span class="badge bg-success">Completed</span></td>
                                            </tr>
                                            <tr>
                                                <td>#12346</td>
                                                <td>Jane Smith</td>
                                                <td>The Midnight Library</td>
                                                <td>$21.99</td>
                                                <td>2024-01-19</td>
                                                <td><span class="badge bg-warning">Pending</span></td>
                                            </tr>
                                            <tr>
                                                <td>#12347</td>
                                                <td>Mike Johnson</td>
                                                <td>Project Hail Mary</td>
                                                <td>$24.99</td>
                                                <td>2024-01-18</td>
                                                <td><span class="badge bg-info">Processing</span></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="Js/admin.js"></script>
</body>
</html>