<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if admin is logged in and validate session attributes
    String adminName = (String) session.getAttribute("adminName");
    String adminRole = (String) session.getAttribute("userRole");  // 'userRole' should be set to 'admin' in the servlet
    String adminEmail = (String) session.getAttribute("adminEmail");

    // If any required session attribute is missing or user is not admin, redirect to admin login page
    if (adminName == null || adminEmail == null || !"admin".equals(adminRole)) {
        response.sendRedirect("login.jsp");  // Redirect to admin login page if validation fails
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="css/admin-style.css" rel="stylesheet">
</head>
<body>
    <!-- Sidebar -->
    <div class="admin-sidebar">
        <div class="d-flex flex-column h-100">
            <div class="p-3 text-center">
                <h4 class="text-light">Welcome, <%= adminName %>!</h4>  <!-- Display admin name -->
            </div>
            <nav class="nav flex-column mt-3">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a class="nav-link" href="books.jsp">
                    <i class="fas fa-book"></i> Books
                </a>
                <a class="nav-link" href="orders.jsp">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
                <a class="nav-link" href="users.jsp">
                    <i class="fas fa-users"></i> Users
                </a>
                <a class="nav-link" href="admin-profile.jsp">
                    <i class="fas fa-user-circle"></i> Profile
                </a>
            </nav>
            <div class="mt-auto p-3">
                <form action="../AdminLogoutServlet" method="post">
                    <button type="submit" class="btn btn-danger w-100">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
