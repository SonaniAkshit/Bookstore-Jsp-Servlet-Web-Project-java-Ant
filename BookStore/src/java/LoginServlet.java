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

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            // Check if user exists
            String loginQuery = "SELECT name, password FROM user WHERE email = ?";

            try (PreparedStatement stmt = connection.prepareStatement(loginQuery)) {
                stmt.setString(1, email);
                ResultSet resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    String name = resultSet.getString("name");
                    String storedPassword = resultSet.getString("password");

                    // Direct password comparison (no hashing)
                    if (storedPassword.equals(password)) {
                        // Create session
                        HttpSession session = request.getSession();
                        session.setAttribute("userName", name);
                        session.setAttribute("userEmail", email);
                        session.setAttribute("userRole", "user");  // Fixed user role

                        // Update last_login and set status to 'active'
                        String updateQuery = "UPDATE user SET last_login = NOW(), status = 'active' WHERE email = ?";
                        try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, email);
                            updateStmt.executeUpdate();
                        }

                        // Redirect to profile page with success message
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
                        response.getWriter().println("  timer: 3000,");
                        response.getWriter().println("  showConfirmButton: false");
                        response.getWriter().println("}).then(() => {");
                        response.getWriter().println("  window.location.href = 'profile.jsp';");
                        response.getWriter().println("});");
                        response.getWriter().println("</script>");
                        response.getWriter().println("</body>");
                        response.getWriter().println("</html>");
                    } else {
                        request.setAttribute("error", "Invalid email or password!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Invalid email or password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();  // Log the error
            request.setAttribute("error", "An unexpected error occurred. Please try again later.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
