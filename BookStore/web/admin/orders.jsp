<%@ include file="header.jsp" %>
<script>
    document.querySelector('a[href="orders.jsp"]').classList.add('active');
</script>

    <!-- Main Content -->
    <div class="admin-main">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <button id="sidebar-toggle" class="btn btn-primary d-md-none">
                <i class="fas fa-bars"></i>
            </button>
            <h2 class="mb-0">Order Management</h2>
            <div class="btn-group">
                <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#filterModal">
                    <i class="fas fa-filter"></i> Filter
                </button>
                <button class="btn btn-outline-success">
                    <i class="fas fa-file-excel"></i> Export
                </button>
            </div>
        </div>

        <!-- Order Statistics -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-primary text-white">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <h3>156</h3>
                    <p class="text-muted mb-0">Total Orders</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-success text-white">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3>124</h3>
                    <p class="text-muted mb-0">Completed</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-warning text-white">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3>22</h3>
                    <p class="text-muted mb-0">Pending</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-danger text-white">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <h3>10</h3>
                    <p class="text-muted mb-0">Cancelled</p>
                </div>
            </div>
        </div>

        <!-- Orders Table -->
        <div class="card">
            <div class="card-body">
                <table class="table admin-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Books</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#12345</td>
                            <td>John Doe</td>
                            <td>2023-08-15</td>
                            <td>The Great Gatsby, 1984</td>
                            <td>$45.98</td>
                            <td><span class="badge bg-success">Delivered</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#orderDetailsModal">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="btn btn-sm btn-warning me-1" data-bs-toggle="modal" data-bs-target="#updateStatusModal">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>#12344</td>
                            <td>Jane Smith</td>
                            <td>2023-08-14</td>
                            <td>To Kill a Mockingbird</td>
                            <td>$15.99</td>
                            <td><span class="badge bg-warning">Processing</span></td>
                            <td>
                                <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#orderDetailsModal">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="btn btn-sm btn-warning me-1" data-bs-toggle="modal" data-bs-target="#updateStatusModal">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Order Details Modal -->
    <div class="modal fade" id="orderDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Order Details #12345</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h6>Customer Information</h6>
                            <p><strong>Name:</strong> John Doe</p>
                            <p><strong>Email:</strong> john@example.com</p>
                            <p><strong>Phone:</strong> +1 234 567 890</p>
                        </div>
                        <div class="col-md-6">
                            <h6>Shipping Address</h6>
                            <p>123 Main St<br>Apt 4B<br>New York, NY 10001<br>United States</p>
                        </div>
                    </div>
                    <h6>Order Items</h6>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>The Great Gatsby</td>
                                <td>1</td>
                                <td>$25.99</td>
                                <td>$25.99</td>
                            </tr>
                            <tr>
                                <td>1984</td>
                                <td>1</td>
                                <td>$19.99</td>
                                <td>$19.99</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3" class="text-end"><strong>Subtotal:</strong></td>
                                <td>$45.98</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-end"><strong>Shipping:</strong></td>
                                <td>$4.99</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                <td><strong>$50.97</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Print Invoice</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Order Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="updateStatusForm">
                        <div class="mb-3">
                            <label class="form-label">Order Status</label>
                            <select class="form-select" required>
                                <option value="processing">Processing</option>
                                <option value="shipped">Shipped</option>
                                <option value="delivered">Delivered</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status Notes</label>
                            <textarea class="form-control" rows="3" placeholder="Add any notes about the status update"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="updateStatusForm" class="btn btn-primary">Update Status</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Modal -->
    <div class="modal fade" id="filterModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Filter Orders</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="filterForm">
                        <div class="mb-3">
                            <label class="form-label">Date Range</label>
                            <div class="input-group">
                                <input type="date" class="form-control" placeholder="Start Date">
                                <span class="input-group-text">to</span>
                                <input type="date" class="form-control" placeholder="End Date">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select">
                                <option value="">All</option>
                                <option value="processing">Processing</option>
                                <option value="shipped">Shipped</option>
                                <option value="delivered">Delivered</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Order Total</label>
                            <div class="input-group">
                                <input type="number" class="form-control" placeholder="Min">
                                <span class="input-group-text">to</span>
                                <input type="number" class="form-control" placeholder="Max">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="filterForm" class="btn btn-primary">Apply Filters</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="js/admin-script.js"></script>
</body>
</html>