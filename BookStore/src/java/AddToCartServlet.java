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

        int quantityToAdd = 1;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // ✅ Fetch current stock
            PreparedStatement stockStmt = conn.prepareStatement("SELECT stock FROM books WHERE id = ?");
            stockStmt.setString(1, bookId);
            var stockRs = stockStmt.executeQuery();

            int currentStock = 0;
            if (stockRs.next()) {
                currentStock = stockRs.getInt("stock");
            }

            // ✅ Check if book is already in cart
            PreparedStatement checkStmt = conn.prepareStatement("SELECT quantity FROM cart WHERE id = ? AND user_email = ?");
            checkStmt.setString(1, bookId);
            checkStmt.setString(2, userEmail);
            var rs = checkStmt.executeQuery();

            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");

                if (currentStock <= 0) {
                    conn.close();
                    out.println("<html><head><script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
                    out.println("<script>");
                    out.println("Swal.fire({");
                    out.println("  title: 'Out of Stock!',");
                    out.println("  text: 'This book is currently not available.',");
                    out.println("  icon: 'error'");
                    out.println("}).then(() => { window.location.href='book-detail.jsp?id=" + bookId + "'; });");
                    out.println("</script></body></html>");
                    return;
                }

                // ✅ Update cart quantity
                int newQuantity = currentQuantity + quantityToAdd;
                if (newQuantity > currentStock) {
                    newQuantity = currentStock;
                }

                PreparedStatement updateCartStmt = conn.prepareStatement("UPDATE cart SET quantity = ? WHERE id = ? AND user_email = ?");
                updateCartStmt.setInt(1, newQuantity);
                updateCartStmt.setString(2, bookId);
                updateCartStmt.setString(3, userEmail);
                updateCartStmt.executeUpdate();

                // ✅ Update stock
                PreparedStatement updateStockStmt = conn.prepareStatement("UPDATE books SET stock = ? WHERE id = ?");
                updateStockStmt.setInt(1, currentStock - (newQuantity - currentQuantity));
                updateStockStmt.setString(2, bookId);
                updateStockStmt.executeUpdate();

            } else {
                if (currentStock < quantityToAdd) {
                    conn.close();
                    out.println("<html><head><script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
                    out.println("<script>");
                    out.println("Swal.fire({");
                    out.println("  title: 'Insufficient Stock!',");
                    out.println("  text: 'Only " + currentStock + " item(s) available.',");
                    out.println("  icon: 'warning'");
                    out.println("}).then(() => { window.location.href='book-detail.jsp?id=" + bookId + "'; });");
                    out.println("</script></body></html>");
                    return;
                }

                // ✅ Insert into cart
                PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO cart (id, bookname, author, publisher_email, price, image, quantity, user_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                insertStmt.setString(1, bookId);
                insertStmt.setString(2, bookName);
                insertStmt.setString(3, author);
                insertStmt.setString(4, publisherEmail);
                insertStmt.setString(5, price);
                insertStmt.setString(6, image);
                insertStmt.setInt(7, quantityToAdd);
                insertStmt.setString(8, userEmail);
                insertStmt.executeUpdate();

                // ✅ Update stock
                PreparedStatement updateStockStmt = conn.prepareStatement("UPDATE books SET stock = stock - ? WHERE id = ?");
                updateStockStmt.setInt(1, quantityToAdd);
                updateStockStmt.setString(2, bookId);
                updateStockStmt.executeUpdate();
            }

            conn.close();

            // ✅ Success SweetAlert
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  title: 'Added to Cart!',");
            out.println("  text: '" + bookName + " has been added to your cart.',");
            out.println("  imageUrl: '" + image + "',");
            out.println("  imageWidth: 100,");
            out.println("  imageHeight: 100,");
            out.println("  icon: 'success',");
            out.println("  timer: 3000,");
            out.println("  timerProgressBar: true");
            out.println("}).then(() => { window.location.href='cart.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><head><script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  title: 'Error!',");
            out.println("  text: 'Something went wrong. Please try again.',");
            out.println("  icon: 'error'");
            out.println("});");
            out.println("</script></body></html>");
        }
    }
}
