<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - BookStore</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body>
    <div class="container">
        <div class="error-container">
            <h1>Oops! Something went wrong</h1>
            <p>We're sorry, but an error occurred while processing your request.</p>
            <% if (response.getStatus() == 404) { %>
                <p>The page you're looking for could not be found.</p>
            <% } else { %>
                <p>Please try again later or contact support if the problem persists.</p>
            <% } %>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn">Return to Homepage</a>
        </div>
    </div>
</body>
</html>df