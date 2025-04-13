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
    double total = 0.0;
    
    try {
        // Database Connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        
        // Fetch cart items for the logged-in user
        String sql = "SELECT id, bookname, author, price, quantity FROM cart WHERE user_email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, userEmail);
        rs = stmt.executeQuery();
        
        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("id", rs.getString("id"));
            item.put("bookname", rs.getString("bookname"));
            item.put("author", rs.getString("author"));
            item.put("price", rs.getString("price"));
            item.put("quantity", rs.getString("quantity"));
            
            double price = Double.parseDouble(rs.getString("price"));
            int quantity = Integer.parseInt(rs.getString("quantity"));
            total += price * quantity;
            
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
    <title>Checkout</title>
    <style>
        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .checkout-form {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .order-summary {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            height: fit-content;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .total {
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #333;
        }

        .place-order-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 4px;
            font-size: 18px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        .place-order-btn:hover {
            background-color: #218838;
        }

        .error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .checkout-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <br><br>

    <div class="checkout-container">
        <div class="checkout-form">
            <h2>Shipping Information</h2>
            <form id="checkoutForm" action="ProcessOrderServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required>
                    <div class="error" id="fullNameError"></div>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="<%= userEmail %>" readonly>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" required>
                    <div class="error" id="phoneError"></div>
                </div>

                <div class="form-group">
                    <label for="address">Shipping Address</label>
                    <textarea id="address" name="address" required></textarea>
                    <div class="error" id="addressError"></div>
                </div>

                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" required>
                    <div class="error" id="cityError"></div>
                </div>

                <div class="form-group">
                    <label for="state">State</label>
                    <input type="text" id="state" name="state" required>
                    <div class="error" id="stateError"></div>
                </div>

                <div class="form-group">
                    <label for="zipCode">ZIP Code</label>
                    <input type="text" id="zipCode" name="zipCode" required>
                    <div class="error" id="zipCodeError"></div>
                </div>

                <% for (Map<String, String> item : cartItems) { 
                    double price = Double.parseDouble(item.get("price"));
                    int quantity = Integer.parseInt(item.get("quantity"));
                %>

                <div class="form-group">
                    <label for="zipCode">Books</label>
                    <input type="text" name="bookname" value="<%= item.get("bookname") %>" required>
                </div>

                <% } %>

                <div class="form-group">
                    <label for="zipCode">Total</label>
                    <input type="text" name="total" value="<%= String.format("%.2f", total) %>" required>
                </div>

                <button type="submit" class="place-order-btn">Place Order</button>
            </form>
        </div>

        <div class="order-summary">
            <h2>Order Summary</h2>
            <hr>
            <% for (Map<String, String> item : cartItems) { 
                double price = Double.parseDouble(item.get("price"));
                int quantity = Integer.parseInt(item.get("quantity"));
            %>
                <div class="summary-item">
                    <div>
                        <strong><%= item.get("bookname") %></strong><br>
                        <p>By <%= item.get("author") %> </p>
                        <small>Quantity: <%= quantity %></small>
                    </div>
                    <div>Rs.<%= String.format("%.2f", price * quantity) %></div>
                </div>
            <% } %>

            <div class="total">
                <div class="summary-item">
                    <span>Total:</span>
                    <span>Rs.<%= String.format("%.2f", total) %></span>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateForm() {
            let isValid = true;
            const fullName = document.getElementById('fullName');
            const phone = document.getElementById('phone');
            const address = document.getElementById('address');
            const city = document.getElementById('city');
            const state = document.getElementById('state');
            const zipCode = document.getElementById('zipCode');

            // Reset errors
            document.querySelectorAll('.error').forEach(error => error.textContent = '');

            // Validate Full Name
            if (fullName.value.trim().length < 3) {
                document.getElementById('fullNameError').textContent = 'Please enter a valid name (minimum 3 characters)';
                isValid = false;
            }

            // Validate Phone Number
            const phoneRegex = /^[0-9]{10}$/;
            if (!phoneRegex.test(phone.value.trim())) {
                document.getElementById('phoneError').textContent = 'Please enter a valid 10-digit phone number';
                isValid = false;
            }

            // Validate Address
            if (address.value.trim().length < 10) {
                document.getElementById('addressError').textContent = 'Please enter a complete address';
                isValid = false;
            }

            // Validate City
            if (city.value.trim().length < 2) {
                document.getElementById('cityError').textContent = 'Please enter a valid city name';
                isValid = false;
            }

            // Validate State
            if (state.value.trim().length < 2) {
                document.getElementById('stateError').textContent = 'Please enter a valid state name';
                isValid = false;
            }

            // Validate ZIP Code
            const zipRegex = /^[0-9]{6}$/;
            if (!zipRegex.test(zipCode.value.trim())) {
                document.getElementById('zipCodeError').textContent = 'Please enter a valid 6-digit ZIP code';
                isValid = false;
            }

            return isValid;
        }
    </script>

    <br><br>
    <jsp:include page="footer.jsp" />
</body>
</html>