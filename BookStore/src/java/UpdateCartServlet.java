import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String cartItemId = request.getParameter("cartItemId");
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // ✅ Get previous cart quantity
            PreparedStatement getCartStmt = conn.prepareStatement("SELECT quantity FROM cart WHERE id = ? AND user_email = ?");
            getCartStmt.setString(1, cartItemId);
            getCartStmt.setString(2, userEmail);
            ResultSet cartRs = getCartStmt.executeQuery();

            int oldQuantity = 0;
            if (cartRs.next()) {
                oldQuantity = cartRs.getInt("quantity");
            }

            // ✅ Get current book stock
            PreparedStatement getStockStmt = conn.prepareStatement("SELECT stock FROM books WHERE id = ?");
            getStockStmt.setString(1, cartItemId);
            ResultSet stockRs = getStockStmt.executeQuery();

            int currentStock = 0;
            if (stockRs.next()) {
                currentStock = stockRs.getInt("stock");
            }

            int stockChange = oldQuantity - newQuantity;

            if (stockChange < 0 && Math.abs(stockChange) > currentStock) {
                // Not enough stock to increase quantity
                response.sendRedirect("cart.jsp?error=outofstock");
                return;
            }

            // ✅ Update cart quantity
            stmt = conn.prepareStatement("UPDATE cart SET quantity = ? WHERE id = ? AND user_email = ?");
            stmt.setInt(1, newQuantity);
            stmt.setString(2, cartItemId);
            stmt.setString(3, userEmail);
            stmt.executeUpdate();

            // ✅ Update stock accordingly
            PreparedStatement updateStockStmt = conn.prepareStatement("UPDATE books SET stock = stock + ? WHERE id = ?");
            updateStockStmt.setInt(1, stockChange);  // can be negative or positive
            updateStockStmt.setString(2, cartItemId);
            updateStockStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }

        response.sendRedirect("cart.jsp");
    }
}
