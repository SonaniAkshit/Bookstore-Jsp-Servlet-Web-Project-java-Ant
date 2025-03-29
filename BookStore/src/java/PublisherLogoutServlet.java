import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PublisherLogoutServlet")
public class PublisherLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";  // Update with actual MySQL password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);  // Get existing session, if any
        if (session != null) {
            String publisherEmail = (String) session.getAttribute("publisherEmail");

            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

                // Update last_logout with current timestamp and set status to 'inactive' in the publisher table
                String updateQuery = "UPDATE publisher SET last_logout = NOW(), status = 'inactive' WHERE email = ?";
                try (PreparedStatement stmt = connection.prepareStatement(updateQuery)) {
                    stmt.setString(1, publisherEmail);
                    stmt.executeUpdate();  // Update the publisher's last_logout and set status to 'inactive'
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            session.invalidate();  // End the session after updating the publisher table
        }

        // Set content type to HTML and write a response with SweetAlert2
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html lang='en'>");
        response.getWriter().println("<head>");
        response.getWriter().println("<meta charset='UTF-8'>");
        response.getWriter().println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        response.getWriter().println("<title>Logout Successful</title>");
        response.getWriter().println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        response.getWriter().println("</head>");
        response.getWriter().println("<body>");

        // Show SweetAlert2 message and redirect to login page after a short delay
        response.getWriter().println("<script>");
        response.getWriter().println("Swal.fire({");
        response.getWriter().println("  icon: 'success',");
        response.getWriter().println("  title: 'Logged Out',");
        response.getWriter().println("  text: 'You have successfully logged out, Publisher!',");
        response.getWriter().println("  timer: 3000,");  // Auto-close after 3 seconds
        response.getWriter().println("  showConfirmButton: false");
        response.getWriter().println("}).then(() => {");
        response.getWriter().println("  window.location.href = 'publisher/login.jsp';");  // Redirect to publisher login page
        response.getWriter().println("});");
        response.getWriter().println("</script>");

        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}
