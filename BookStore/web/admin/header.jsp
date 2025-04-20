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
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/admin-dashboard.css" rel="stylesheet">
    <link href="css/admin-style.css" rel="stylesheet">
</head>
<body>
    <div class="admin-sidebar">
        <div class="p-3">
            <a class="navbar-brand d-flex align-items-center mb-4" href="index.jsp">
               <center>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <i class="fas fa-book-reader me-2 text-warning"></i>
                <span class="brand-text fs-4 fw-bold text-white">E-Books  </span>
                </center>
            </a>
            <nav>
                <a href="index.jsp" class="nav-link">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a href="books.jsp" class="nav-link">
                    <i class="fas fa-book"></i> Books
                </a>
                <a href="orders.jsp" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Orders
                </a>
                <a href="users.jsp" class="nav-link">
                    <i class="fas fa-users"></i> Users
                </a>
                <a href="subscriber.jsp" class="nav-link">
                    <i class="fas fa-envelope"></i> Subscribers
                </a>
                <a href="contact.jsp" class="nav-link">
                    <i class="fas fa-message"></i> Contact
                </a>
                <a href="admin-profile.jsp" class="nav-link">
                    <i class="fas fa-user"></i> Profile
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
