<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String alertMessage = (String) session.getAttribute("alert");
    if (alertMessage != null) {
        session.removeAttribute("alert");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Status</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .swal2-popup {
            font-size: 1.1rem !important;
        }
    </style>
</head>
<body>

<% if (alertMessage != null) { %>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Thank you!',
        text: '<%= alertMessage %>',
        confirmButtonText: 'Back to Home',
        confirmButtonColor: '#3085d6',
        allowOutsideClick: false
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'index.jsp';
        }
    });
</script>
<% } else { %>
<script>
    window.location.href = 'index.jsp';
</script>
<% } %>

</body>
</html>
