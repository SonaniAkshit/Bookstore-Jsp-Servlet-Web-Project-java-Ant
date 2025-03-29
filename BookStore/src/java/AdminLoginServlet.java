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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";  // Update with actual database password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            // SQL query to verify login credentials from the 'admin' table
            String loginQuery = "SELECT name FROM admin WHERE email = ? AND password = ?";

            try (PreparedStatement stmt = connection.prepareStatement(loginQuery)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                ResultSet resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    // Login success - retrieve admin name
                    String name = resultSet.getString("name");

                    // Set session attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("adminName", name);
                    session.setAttribute("adminEmail", email);
                    session.setAttribute("userRole", "admin");  // Set role as admin

                    // Update last_login and status to 'active' in the admin table
                    String updateQuery = "UPDATE admin SET last_login = NOW(), status = 'active' WHERE email = ?";
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, email);
                        updateStmt.executeUpdate();
                    }

                    // Display login success message and redirect to admin profile page
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println("<!DOCTYPE html>");
                    response.getWriter().println("<html lang='en'>");
                    response.getWriter().println("<head>");
                    response.getWriter().println("<meta charset='UTF-8'>");
                    response.getWriter().println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                    response.getWriter().println("<title>Login Successful</title>");
                    response.getWriter().println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    response.getWriter().println("</head>");
                    response.getWriter().println("<body>");

                    response.getWriter().println("<script>");
                    response.getWriter().println("Swal.fire({");
                    response.getWriter().println("  icon: 'success',");
                    response.getWriter().println("  title: 'Login Successful!',");
                    response.getWriter().println("  text: 'Welcome, Admin " + name + "!',");
                    response.getWriter().println("  timer: 3000,");  // Auto-close after 3 seconds
                    response.getWriter().println("  showConfirmButton: false");
                    response.getWriter().println("}).then(() => {");
                    response.getWriter().println("  window.location.href = 'admin/admin-profile.jsp';");  // Redirect to admin profile page
                    response.getWriter().println("});");
                    response.getWriter().println("</script>");
                    response.getWriter().println("</body>");
                    response.getWriter().println("</html>");

                } else {
                    // Invalid login attempt - display SweetAlert2 error and redirect to login page
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println("<!DOCTYPE html>");
                    response.getWriter().println("<html lang='en'>");
                    response.getWriter().println("<head>");
                    response.getWriter().println("<meta charset='UTF-8'>");
                    response.getWriter().println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                    response.getWriter().println("<title>Invalid Login</title>");
                    response.getWriter().println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    response.getWriter().println("</head>");
                    response.getWriter().println("<body>");
                    response.getWriter().println("<script>");
                    response.getWriter().println("Swal.fire({");
                    response.getWriter().println("  icon: 'error',");
                    response.getWriter().println("  title: 'Invalid Login!',");
                    response.getWriter().println("  text: 'Incorrect email or password. Please try again.',");
                    response.getWriter().println("}).then(() => {");
                    response.getWriter().println("  window.location.href = 'admin/login.jsp';");  // Redirect back to login page
                    response.getWriter().println("});");
                    response.getWriter().println("</script>");
                    response.getWriter().println("</body>");
                    response.getWriter().println("</html>");
                }
            }
        } catch (Exception e) {
            // Unexpected error handling
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<!DOCTYPE html>");
            response.getWriter().println("<html lang='en'>");
            response.getWriter().println("<head>");
            response.getWriter().println("<meta charset='UTF-8'>");
            response.getWriter().println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            response.getWriter().println("<title>Error Occurred</title>");
            response.getWriter().println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            response.getWriter().println("</head>");
            response.getWriter().println("<body>");
            response.getWriter().println("<script>");
            response.getWriter().println("Swal.fire({");
            response.getWriter().println("  icon: 'error',");
            response.getWriter().println("  title: 'Unexpected Error!',");
            response.getWriter().println("  text: 'An unexpected error occurred. Please try again later.',");
            response.getWriter().println("}).then(() => {");
            response.getWriter().println("  window.location.href = 'admin/login.jsp';");  // Redirect to login page after error
            response.getWriter().println("});");
            response.getWriter().println("</script>");
            response.getWriter().println("</body>");
            response.getWriter().println("</html>");
        }
    }
}
