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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
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

            // SQL query to verify login credentials from the 'user' table
            String loginQuery = "SELECT name FROM user WHERE email = ? AND password = ?";

            try (PreparedStatement stmt = connection.prepareStatement(loginQuery)) {
                stmt.setString(1, email);
                stmt.setString(2, password);

                ResultSet resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    // Login success - retrieve user details
                    String name = resultSet.getString("name");

                    // Set session attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("userName", name);
                    session.setAttribute("userEmail", email);
                    session.setAttribute("userRole", "user");  // Fixed user role

                    // Update last_login and status to 'active' in the user table
                    String updateQuery = "UPDATE user SET last_login = NOW(), status = 'active' WHERE email = ?";
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, email);
                        updateStmt.executeUpdate();
                    }

                    // Display login success message and redirect to the user profile page
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
                    response.getWriter().println("  text: 'Welcome, " + name + "!',");
                    response.getWriter().println("  timer: 3000,");  // Auto-close after 3 seconds
                    response.getWriter().println("  showConfirmButton: false");
                    response.getWriter().println("}).then(() => {");
                    response.getWriter().println("  window.location.href = 'profile.jsp';");  // Redirect to user profile
                    response.getWriter().println("});");
                    response.getWriter().println("</script>");
                    response.getWriter().println("</body>");
                    response.getWriter().println("</html>");

                } else {
                    // Invalid login attempt - display error and return to login page
                    request.setAttribute("error", "Invalid email or password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
