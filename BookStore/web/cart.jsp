<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shopping Cart - BookStore</title>
    <link rel="stylesheet" href="CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .cart-container {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        .cart-table th, .cart-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .cart-table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .cart-item-image {
            width: 100px;
            height: 150px;
            object-fit: cover;
        }
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .quantity-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 0.25rem 0.5rem;
            cursor: pointer;
            border-radius: 4px;
        }
        .quantity-btn:hover {
            background: #0056b3;
        }
        .quantity-input {
            width: 50px;
            text-align: center;
            padding: 0.25rem;
        }
        .remove-item {
            color: #dc3545;
            cursor: pointer;
        }
        .remove-item:hover {
            color: #c82333;
        }
        .cart-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 2rem;
        }
        .cart-summary h3 {
            margin-top: 0;
            margin-bottom: 1rem;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        .checkout-btn {
            background: #28a745;
            color: white;
            border: none;
            padding: 1rem 2rem;
            width: 100%;
            margin-top: 1rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1.1rem;
        }
        .checkout-btn:hover {
            background: #218838;
        }
        .empty-cart {
            text-align: center;
            padding: 3rem;
        }
        .empty-cart i {
            font-size: 4rem;
            color: #6c757d;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    
    <div class="cart-container">
        <h2>Shopping Cart</h2>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Book</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM cart WHERE user_email = ?");
                        ps.setString(1, userEmail);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                <tr>
                    <td>
                        <div style="display: flex; gap: 1rem; align-items: center;">
                            <img src="images/book1.jpg" alt="Book Title" class="cart-item-image">
                            <div>
                                <h4 style="margin: 0;">The Great Gatsby</h4>
                                <p style="margin: 0.5rem 0; color: #666;">F. Scott Fitzgerald</p>
                            </div>
                        </div>
                    </td>
                    <td>$9.99</td>
                    <td>
                        <div class="quantity-control">
                            <button class="quantity-btn">-</button>
                            <input type="number" class="quantity-input" value="1" min="1">
                            <button class="quantity-btn">+</button>
                            <input type="submit" class="update-btn" value="Update" style="background: #28a745; color: white; border: none; padding: 0.25rem 0.5rem; cursor: pointer; border-radius: 4px;">
                        </div>
                    </td>
                    <td>$9.99</td>
                    <td>
                        <i class="fas fa-trash remove-item"></i>
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
        
        <div class="cart-summary">
            <h3>Order Summary</h3>
            <div class="summary-item">
                <span>Subtotal:</span>
                <span>$35.97</span>
            </div>
            <div class="summary-item">
                <span>Shipping:</span>
                <span>$5.00</span>
            </div>
            <div class="summary-item" style="font-weight: bold; margin-top: 1rem;">
                <span>Total:</span>
                <span>$40.97</span>
            </div>
            <form action="checkout" method="POST">
                <input type="submit" class="checkout-btn" value="Proceed to Checkout">
            </form>
        </div>
    </div>

    <%@include file="footer.jsp" %>
</body>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const quantityControls = document.querySelectorAll('.quantity-control');
    
    quantityControls.forEach(control => {
        const minusBtn = control.querySelector('.quantity-btn:first-child');
        const plusBtn = control.querySelector('.quantity-btn:nth-child(3)');
        const input = control.querySelector('.quantity-input');
        const updateBtn = control.querySelector('.update-btn');
        
        minusBtn.addEventListener('click', () => {
            const currentValue = parseInt(input.value);
            if (currentValue > 1) {
                input.value = currentValue - 1;
            }
        });
        
        plusBtn.addEventListener('click', () => {
            input.value = parseInt(input.value) + 1;
        });
        
        input.addEventListener('change', () => {
            if (parseInt(input.value) < 1) input.value = 1;
        });

        // updateBtn.addEventListener('click', () => {
        //     // Here you can add the logic to send the updated quantity to the server
        //     alert('Quantity updated!');
        // });
    });

});
</script>
</html>