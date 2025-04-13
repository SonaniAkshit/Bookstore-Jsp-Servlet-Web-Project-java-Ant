<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Ensure user is logged in
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, String>> cartItems = new ArrayList<>();
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        // Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        
        // Fetch cart items for the logged-in user
        String sql = "SELECT id, bookname, author, price, image, quantity, created_at FROM cart WHERE user_email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, userEmail);
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("id", rs.getString("id"));
            item.put("bookname", rs.getString("bookname"));
            item.put("author", rs.getString("author"));
            item.put("price", rs.getString("price"));
            item.put("image", rs.getString("image"));
            item.put("quantity", rs.getString("quantity"));
            item.put("created_at", rs.getTimestamp("created_at").toString());

            Timestamp timestamp = rs.getTimestamp("created_at");
            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");    
            item.put("created_at", sdf.format(timestamp));
            
            cartItems.add(item);

            

        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script> <!-- Font Awesome -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <title>Shopping Cart</title>
    <style>
        h2 {
            color: #333;
            text-align: center;
        }
        .empty-cart {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cart-table {
            margin: 20px auto;
            width: 80%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cart-table th, .cart-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .cart-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        .cart-table img {
            border-radius: 3px;
            object-fit: cover;
        }
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .quantity-btn {
            background: #eee;
            border: none;
            width: 25px;
            height: 25px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .quantity-btn:hover {
            background: #ddd;
        }
        .quantity-input {
            width: 50px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 4px;
        }
        .remove-btn, .update-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .remove-btn {
            background-color: #dc3545;
            color: white;
            margin-right: 5px;
        }
        .update-btn {
            background-color: #28a745;
            color: white;
        }
        .remove-btn:hover {
            background-color: #c82333;
        }
        .update-btn:hover {
            background-color: #218838;
        }
        .checkout-btn {
            display: block;
            width: 200px;
            margin: 30px auto 0;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .checkout-btn:hover {
            background-color: #0056b3;
        }
        .total-section {
            margin: 20px auto;
            width: 80%;
            text-align: right;
            padding: 20px;
            background: white;
            border-radius: 8px;
            /* box-shadow: 0 2px 4px rgba(0,0,0,0.1); */
        }
        .total-section span {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <br><br>

    <h2>Your Shopping Cart</h2>
    
    <% if (cartItems.isEmpty()) { %>
        <div class="empty-cart">
            <p>Your cart is empty.</p>
        </div>
    <% } else { %>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Book Name</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Add Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                double total = 0;
                for (Map<String, String> item : cartItems) { 
                    double price = Double.parseDouble(item.get("price"));
                    int quantity = Integer.parseInt(item.get("quantity"));
                    total += price * quantity;
                %>
                    <tr>
                        <td><img src="<%= item.get("image") %>" width="80" height="100" alt="Book Image"></td>
                        <td><%= item.get("bookname") %></td>
                        <td><%= item.get("author") %></td>
                        <td>Rs.<%= String.format("%.2f", price) %></td>
                        <td>
                            <form action="UpdateCartServlet" method="post" class="quantity-control">
                                <input type="hidden" name="cartItemId" value="<%= item.get("id") %>">
                                <button type="button" class="quantity-btn" onclick="updateQuantity(this, -1)">-</button>
                                <input type="number" name="quantity" value="<%= quantity %>" min="1" max="10" class="quantity-input" onchange="validateQuantity(this)">
                                <button type="button" class="quantity-btn" onclick="updateQuantity(this, 1)">+</button>
                                <button type="submit" class="update-btn"><i class="fas fa-edit"></i></button>
                            
                            </form>
                        </td>
                        <td><%= item.get("created_at") %></td>
                        <td>
                            <form action="RemoveFromCartServlet" method="post" style="display: inline;">
                                <input type="hidden" name="cartItemId" value="<%= item.get("id") %>">
                                <button type="submit" class="action-btn remove-btn"><i class="fas fa-trash-alt"></i></button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <div class="total-section">
            <span>Total: Rs.<%= String.format("%.2f", total) %></span>
        </div>

        <form action="checkout.jsp" method="post">
            <button type="submit" class="checkout-btn">Proceed to Checkout</button>
        </form>

        <script>
            document.querySelectorAll(".remove-btn").forEach(function(button) {
            button.addEventListener("click", function(event) {
                event.preventDefault(); // Prevent immediate form submission

                const form = this.closest("form"); // Get the form associated with this button
                const cartItemId = form.querySelector("input[name='cartItemId']").value; // Get the cart item ID

                Swal.fire({
                    title: 'Are you sure?',
                    text: 'You won\'t be able to revert this!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, remove it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit(); // Submit the form after confirmation
                    }
                });
            });
        });

            function updateQuantity(btn, change) {
                const input = btn.parentElement.querySelector('input[type="number"]');
                let value = parseInt(input.value) + change;
                if (value < 1) value = 1;
                input.value = value;
            }

            function validateQuantity(input) {
                if (input.value < 1) input.value = 1;
            }
        </script>
    <% } %>
    <br><br>
    <jsp:include page="footer.jsp" />
</body>
</html>
