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
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelector('a[href="orders.jsp"]').classList.add('active');
    });
</script>

<!-- Main Content -->
<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none">
            <i class="fas fa-bars"></i>
        </button>
        <h2 class="mb-0">Order Management</h2>
    </div>

    <!-- Order Statistics -->
    <div class="row g-4 mb-4">
        <%-- Statistics Cards --%>
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
                        <th>Email</th>
                        <th>Date</th>
                        <!-- <th>Books</th>
                        <th>Total</th> -->
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
                                int orderId = rs.getInt("id");
                    %>
                    <tr>
                        <td><%= orderId %></td>
                        <td><%= rs.getString("customer_name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("ordered_at") %></td>
                        <!-- <td><%= rs.getString("books") %></td>
                        <td>Rs.<%= rs.getInt("total") %></td> -->
                        <td>
                            <% String status = rs.getString("status"); %>
                            <span class="badge bg-<%= status.equals("delivered") ? "success" : status.equals("cancelled") ? "danger" : "warning" %>">
                                <%= status.equals("pending") ? "Processing" : status.substring(0, 1).toUpperCase() + status.substring(1) %>
                            </span>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#orderModal<%= orderId %>">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm btn-warning me-1" data-bs-toggle="modal" data-bs-target="#updateStatusModal" onclick="setOrderId(<%= orderId %>)">
                                <i class="fas fa-edit"></i>
                            </button>
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

<!-- Order Details Modals -->
<%
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM orders");

        while (rs.next()) {
            int orderId = rs.getInt("id");
%>
<div class="modal fade" id="orderModal<%= orderId %>" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Order Details <%= orderId %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h6>Customer Information</h6>
                        <p><strong>Name:</strong> <%= rs.getString("customer_name") %></p>
                        <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                        <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>
                    </div>
                    <div class="col-md-6">
                        <h6>Shipping Address</h6>
                        <p>
                            <%= rs.getString("address") %><br>
                            <%= rs.getString("city") %><br>
                            <%= rs.getString("state") %>, <%= rs.getString("zipcode") %><br>
                            India
                        </p>
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
                            <td><%= rs.getString("books") %></td>
                            <td>Rs.<%= rs.getString("total") %></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <form action="../SendOrderConfirmationServlet" method="post">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <input type="hidden" name="customerEmail" value="<%= rs.getString("email") %>">
                    <input type="hidden" name="customerName" value="<%= rs.getString("customer_name") %>">
                    <input type="hidden" name="customerPhone" value="<%= rs.getString("phone") %>">
                    <input type="hidden" name="customerAddress" value="<%= rs.getString("address") %>">
                    <input type="hidden" name="customerCity" value="<%= rs.getString("city") %>">
                    <input type="hidden" name="customerState" value="<%= rs.getString("state") %>">
                    <input type="hidden" name="customerZipcode" value="<%= rs.getString("zipcode") %>">
                    <input type="hidden" name="customerBooks" value="<%= rs.getString("books") %>">
                    <input type="hidden" name="customerTotal" value="<%= rs.getString("total") %>">
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
            <form action="../UpdateOrderStatusServlet" method="post" id="updateStatusForm">
                <div class="modal-header">
                    <h5 class="modal-title">Update Order Status</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="orderId" id="orderIdInput">
                    <div class="mb-3">
                        <label class="form-label">Order Status</label>
                        <select name="status" class="form-select" required>
                            <option value="pending">Pending</option>
                            <option value="delivered">Delivered</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Status</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function setOrderId(id) {
        console.log("Setting Order ID to:", id);
        document.getElementById("orderIdInput").value = id;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="js/admin-script.js"></script>