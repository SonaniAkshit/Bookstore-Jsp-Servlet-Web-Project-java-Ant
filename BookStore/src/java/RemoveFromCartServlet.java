import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/removeFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String cartItemId = request.getParameter("cartItemId");

        Connection conn = null;
        PreparedStatement stmt = null;

        boolean success = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            String sql = "DELETE FROM cart WHERE id = ? AND user_email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cartItemId);
            stmt.setString(2, userEmail);

            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                success = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Cart Update</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>"); // SweetAlert CDN
        out.println("</head>");
        out.println("<body>");

        if (success) {
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("    title: 'Deleted!',");
            out.println("    text: 'Item has been removed from your cart.',");
            out.println("    icon: 'success',");
            out.println("    confirmButtonText: 'OK'");
            out.println("}).then(() => { window.location.href = 'cart.jsp'; });");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("    title: 'Error!',");
            out.println("    text: 'Failed to remove item. Please try again.',");
            out.println("    icon: 'error',");
            out.println("    confirmButtonText: 'OK'");
            out.println("}).then(() => { window.location.href = 'cart.jsp'; });");
            out.println("</script>");
        }

        out.println("</body>");
        out.println("</html>");
    }
}
