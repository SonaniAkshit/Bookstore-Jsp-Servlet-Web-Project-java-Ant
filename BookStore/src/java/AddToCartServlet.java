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

@WebServlet("/AddToCart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");
        
        if (userEmail == null) {
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  title: 'Login Required',");
            out.println("  text: 'Please login first!',");
            out.println("  icon: 'warning',");
            out.println("  confirmButtonText: 'OK'");
            out.println("}).then(() => { window.location.href='login.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
            return;
        }

        String bookId = request.getParameter("bookId");
        String bookName = request.getParameter("bookName");
        String author = request.getParameter("author");
        String publisherEmail = request.getParameter("publisherEmail");
        String price = request.getParameter("price");
        String image = request.getParameter("image");
        int quantity = 1;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
            
            // Check if item already exists in cart
            PreparedStatement checkStmt = conn.prepareStatement("SELECT quantity FROM cart WHERE id = ? AND user_email = ?");
            checkStmt.setString(1, bookId);
            checkStmt.setString(2, userEmail);
            var rs = checkStmt.executeQuery();

            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                quantity += currentQuantity;
                PreparedStatement updateStmt = conn.prepareStatement("UPDATE cart SET quantity = ? WHERE id = ? AND user_email = ?");
                updateStmt.setInt(1, quantity);
                updateStmt.setString(2, bookId);
                updateStmt.setString(3, userEmail);
                updateStmt.executeUpdate();
            } else {
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO cart (id, bookname, author, publisher_email, price, image, quantity, user_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                stmt.setString(1, bookId);
                stmt.setString(2, bookName);
                stmt.setString(3, author);
                stmt.setString(4, publisherEmail);
                stmt.setString(5, price);
                stmt.setString(6, image);
                stmt.setInt(7, quantity);
                stmt.setString(8, userEmail);
                stmt.executeUpdate();
            }
            conn.close();
            
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  title: 'Added to Cart!',");
            out.println("  text: 'Your book has been added successfully.',");
            out.println("  icon: 'success',");
            out.println("  confirmButtonText: 'OK'");
            out.println("}).then(() => { window.location.href='cart.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  title: 'Error!',");
            out.println("  text: 'Something went wrong. Please try again.',");
            out.println("  icon: 'error',");
            out.println("  confirmButtonText: 'OK'");
            out.println("});");
            out.println("</script>");
            out.println("</body></html>");
        }
    }
}
