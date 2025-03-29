<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if publisher is logged in and validate session attributes
    String publisherName = (String) session.getAttribute("publisherName");
    String publisherRole = (String) session.getAttribute("userRole");  // 'userRole' should be set to 'publisher' in the servlet
    String publisherEmail = (String) session.getAttribute("publisherEmail");

    // If any required session attribute is missing or user is not publisher, redirect to publisher login page
    if (publisherName == null || publisherEmail == null || !"publisher".equals(publisherRole)) {
        response.sendRedirect("login.jsp");  // Redirect to publisher login page if validation fails
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publisher Panel - BookStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="css/publisher-style.css" rel="stylesheet">
</head>
<body>
    <!-- Sidebar -->
    <div class="publisher-sidebar">
        <div class="d-flex flex-column h-100">
            <div class="p-3 text-center">
                <h4 class="text-light">Welcome, <%= publisherName %>!</h4>  <!-- Display publisher name -->
            </div>
            <nav class="nav flex-column mt-3">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a class="nav-link" href="manage-books.jsp">
                    <i class="fas fa-book"></i> Manage Books
                </a>
                <a class="nav-link" href="publisher-profile.jsp">
                    <i class="fas fa-user-circle"></i> Profile
                </a>
            </nav>
            <div class="mt-auto p-3">
                <form action="../PublisherLogoutServlet" method="post">
                    <button type="submit" class="btn btn-danger w-100">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>