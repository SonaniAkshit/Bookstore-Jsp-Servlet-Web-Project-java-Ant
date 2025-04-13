import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class ProcessOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user email from session
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String totalStr = request.getParameter("total");

        double total = Double.parseDouble(totalStr);

        // Fetch books from user's cart and concatenate names
        List<String> booksList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // Get books from cart
            String cartSql = "SELECT bookname FROM cart WHERE user_email = ?";
            stmt = conn.prepareStatement(cartSql);
            stmt.setString(1, userEmail);
            rs = stmt.executeQuery();

            while (rs.next()) {
                booksList.add(rs.getString("bookname"));
            }

            String books = String.join(", ", booksList);

            // Insert order into orders table
            String insertSql = "INSERT INTO orders (customer_name, email, phone, address, city, state, zipcode, books, total, status) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, fullName);
            stmt.setString(2, userEmail);
            stmt.setString(3, phone);
            stmt.setString(4, address);
            stmt.setString(5, city);
            stmt.setString(6, state);
            stmt.setString(7, zipCode);
            stmt.setString(8, books);
            stmt.setDouble(9, total);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Clear the cart after order is placed
                String clearCartSql = "DELETE FROM cart WHERE user_email = ?";
                stmt = conn.prepareStatement(clearCartSql);
                stmt.setString(1, userEmail);
                stmt.executeUpdate();

                session.setAttribute("alert", "Order placed successfully!");
                response.sendRedirect("ordersuccess.jsp");
            } else {
                session.setAttribute("alert", "Failed to place the order. Try again!");
                response.sendRedirect("checkout.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alert", "Something went wrong!");
            response.sendRedirect("checkout.jsp");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
}
