<%@ include file="header.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    int totalorder = 0;
    int Completed = 0;
    int Pending = 0;
    int Cancelled = 0;

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        Statement stmt = conn.createStatement();

        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM orders");
        if (rs1.next()) totalorder = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM orders WHERE status='delivered' ");
        if (rs2.next()) Completed = rs2.getInt(1);

        ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM orders  WHERE status='pending' ");
        if (rs3.next()) Pending = rs3.getInt(1);

        ResultSet rs4 = stmt.executeQuery("SELECT COUNT(*) FROM orders WHERE status='cancelled' ");
        if (rs4.next()) Cancelled = rs4.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

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
                <!-- <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#filterModal">
                    <i class="fas fa-filter"></i> Filter
                </button>
                <button class="btn btn-outline-success">
                    <i class="fas fa-file-excel"></i> Export
                </button> -->
            </div>
        </div>

        <!-- Order Statistics -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-primary text-white">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <h3><%= totalorder %></h3>
                    <p class="text-muted mb-0">Total Orders</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-success text-white">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h3><%= Completed %></h3>
                    <p class="text-muted mb-0">Completed</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-warning text-white">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3><%= Pending %></h3>
                    <p class="text-muted mb-0">Pending</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="icon bg-danger text-white">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <h3><%= Cancelled %></h3>
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
                        <%
                            try {
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM orders");

                                while (rs.next()) {
                                    String orderedat = rs.getString("ordered_at");
                        %>
                        <tr>
                            <td><%=  rs.getInt("id") %></td>
                            <td><%=  rs.getString("customer_name") %></td>
                            <td><%= orderedat %></td>
                            <td><%=  rs.getString("books") %></td>
                            <td>Rs.<%=  rs.getInt("total") %></td>

                            <% if ("delivered".equals(rs.getString("status"))) { %>
                                <td><span class="badge bg-success">Delivered</span></td>
                            <% } else if("cancelled".equals(rs.getString("status"))) { %>
                                <td><span class="badge bg-danger">Cancelled</span></td>
                            <% } else {%>
                                <td><span class="badge bg-warning">Processing</span></td>
                            <% } %>
                            <td>
                                <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#<%=  rs.getInt("id") %>">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="btn btn-sm btn-warning me-1"
                                        data-bs-toggle="modal"
                                        data-bs-target="#updateStatusModal"
                                        onclick="setOrderId('<%= rs.getInt("id") %>')">
                                    <i class="fas fa-edit"></i>
                                </button>

                            </td>
                        </tr>
                        <%
                                }
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

    <!-- Order Details Modal -->
    <%
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM orders");

        while (rs.next()) {
            String orderedat = rs.getString("ordered_at");
%>
    <div class="modal fade" id="<%=  rs.getInt("id") %>" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Order Details <%=  rs.getInt("id") %></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h6>Customer Information</h6>
                            <p><strong>Name:</strong> <%=  rs.getString("customer_name") %></p>
                            <p><strong>Email:</strong> <%=  rs.getString("email") %></p>
                            <p><strong>Phone:</strong> <%=  rs.getString("phone") %></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Shipping Address</h6>
                            <p><%=  rs.getString("address") %><br><%=  rs.getString("city") %><br><%=  rs.getString("state") %>,<%=  rs.getString("zipcode") %><br>India</p>
                        </div>
                    </div>
                    <h6>Order Items</h6>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Books</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><%=  rs.getString("books") %></td>
                                <td>Rs.<%=  rs.getString("total") %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <form action="../SendOrderConfirmationServlet" method="post">
                        <input type="hidden" name="orderId" id="orderIdInput" value="<%=  rs.getInt("id") %>">
                        <input type="hidden" name="customerEmail" id="customerEmailInput" value="<%=  rs.getString("email") %>">
                        <input type="hidden" name="customerName" id="customerNameInput" value="<%=  rs.getString("customer_name") %>">
                        <input type="hidden" name="customerPhone" id="customerPhoneInput" value="<%=  rs.getString("phone") %>">
                        <input type="hidden" name="customerAddress" id="customerAddressInput" value="<%=  rs.getString("address") %>">
                        <input type="hidden" name="customerCity" id="customerCityInput" value="<%=  rs.getString("city") %>">
                        <input type="hidden" name="customerState" id="customerStateInput" value="<%=  rs.getString("state") %>">
                        <input type="hidden" name="customerZipcode" id="customerZipcodeInput" value="<%=  rs.getString("zipcode") %>">
                        <input type="hidden" name="customerBooks" id="customerBooksInput" value="<%=  rs.getString("books") %>">
                        <input type="hidden" name="customerTotal" id="customerTotalInput" value="<%=  rs.getString("total") %>">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-info"><i class="fas fa-envelope"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <!-- Update Status Modal -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Order Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="../UpdateOrderStatusServlet" method="post" id="updateStatusForm">
                <input type="text" name="orderId" id="orderIdInput">
                <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Order Status</label>
                            <select name="status" class="form-select" required>
                                <option value="pending">Pending</option>
                                <option value="delivered">Delivered</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" form="updateStatusForm" class="btn btn-primary">Update Status</button>
                        </div>
                </form>
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

    <script>
        function setOrderId(id) {
            document.getElementById("orderIdInput").value = id;
        }
    </script>
    
</body>
</html>