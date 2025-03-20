<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BookStore</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Mobile Navigation Toggle -->
            <button class="navbar-toggler d-md-none" type="button" data-bs-toggle="collapse" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky">
                    <div class="text-center mb-4">
                        <h4 class="text-white">BookStore Admin</h4>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">
                                <i class="fas fa-home"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="books.jsp">
                                <i class="fas fa-book"></i> Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link dropdown-toggle" href="#">
                                <i class="fas fa-users"></i> Users
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="users.jsp?type=admin">Admin Users</a></li>
                                <li><a class="dropdown-item" href="users.jsp?type=customer">Customer Users</a></li>
                                <li><a class="dropdown-item" href="users.jsp">All Users</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link dropdown-toggle" href="#">
                                <i class="fas fa-shopping-cart"></i> Orders
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="orders.jsp?status=pending">Pending Orders</a></li>
                                <li><a class="dropdown-item" href="orders.jsp?status=approved">Approved Orders</a></li>
                                <li><a class="dropdown-item" href="orders.jsp">All Orders</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="categories.jsp">
                                <i class="fas fa-tags"></i> Categories
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../logout">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

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