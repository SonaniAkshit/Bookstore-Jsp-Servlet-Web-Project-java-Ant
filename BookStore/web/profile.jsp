<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Check if user is logged in with valid session attributes
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    String userEmail = (String) session.getAttribute("userEmail");

    if (userName == null || !"user".equals(userRole) || userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    String alert = (String) session.getAttribute("alert");
    if (alert != null) {
%>
    <script>
        window.onload = () => {
            Swal.fire({
                // icon: 'success',
                // title: 'Done!',
                text: '<%= alert %>'
            });
        }
    </script>
<%
        session.removeAttribute("alert");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-container {
            padding: 2rem 0;
            background-color: #f8f9fa;
        }

        .profile-header {
            background: #2c3e50;
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid white;
            object-fit: cover;
            margin-bottom: 1rem;
        }

        .profile-section {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 1.5rem;
        }

        .order-item {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .btn-logout {
            background-color: #ff4757;
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 2px 5px rgba(255, 71, 87, 0.3);
        }

        .btn-logout:hover {
            background-color: #ff6b81;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 71, 87, 0.4);
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="profile-container">
        <div class="profile-header text-center">
            <img src="https://i.pravatar.cc/150?img=12" alt="Profile Picture" class="profile-avatar">
            <h2><%= userName %></h2>
            <p class="mb-0"><%= userEmail %></p>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="profile-section">
                        <h3>Account Info</h3>
                        <p><strong>Name:</strong> <%= userName %></p>
                        <p><strong>Email:</strong> <%= userEmail %></p>
                        <p><strong>Role:</strong> <%= userRole %></p>
                        <form action="LogoutServlet" method="post">
                            <button type="submit" class="btn btn-logout w-100">Logout</button>
                        </form>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="profile-section">
                        <h3>Your Orders</h3>

                        <%
                            try {
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                Statement stmt = conn.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM orders WHERE email = '" + userEmail + "'");

                                while (rs.next()) {
                                    int orderId = rs.getInt("id");
                        %>

                        <div class="order-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Order #<%=rs.getInt("id")%></h5>
                                    <p class="mb-0 text-muted"><%= rs.getString("books") %> • Total: Rs.<%= rs.getString("total") %></p>
                                </div>
                                <% String status = rs.getString("status"); %>
                                <span class="badge bg-<%= status.equals("delivered") ? "success" : status.equals("cancelled") ? "danger" : "warning" %>">
                                    <%= status.equals("pending") ? "Processing" : status.substring(0, 1).toUpperCase() + status.substring(1) %>
                                </span>
                                <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#updateStatusModal" onclick="setOrderId(<%= orderId %>)">
                                    <i class="fas fa-edit"></i>
                                </button>
                            </div>
                        </div>
                        <%      }
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <!-- Update Status Modal -->
<div class="modal fade" id="updateStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="CancelOrderServlet" method="post" id="updateStatusForm">
                <div class="modal-header">
                    <h5 class="modal-title">Cancel Your Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="orderId" id="orderIdInput">
                    <div class="mb-3">
                        <!-- <label class="form-label">Order Status</label> -->
                        <select name="status" class="form-select" required>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button> -->
                    <button type="submit" class="btn btn-primary">Cancel Order</button>
                </div>
            </form>
        </div>
    </div>
</div>
    </div>
    <script>
        function setOrderId(id) {
            document.getElementById('orderIdInput').value = id;
        }
    </script>
    
    <!-- Include SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
