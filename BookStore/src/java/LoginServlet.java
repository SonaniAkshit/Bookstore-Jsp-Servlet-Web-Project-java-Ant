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
    private static final String DB_PASSWORD = ""; // Update with your actual password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String selectedRole = request.getParameter("role"); // Role from login form

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            // Query to check login credentials and fetch role
            String loginQuery = "SELECT name, 'user' AS role FROM user WHERE email = ? AND password = ? AND ? = 'user' "
                    + "UNION ALL "
                    + "SELECT name, 'author' AS role FROM author WHERE email = ? AND password = ? AND ? = 'author' "
                    + "UNION ALL "
                    + "SELECT name, 'admin' AS role FROM admin WHERE email = ? AND password = ? AND ? = 'admin'";

            try (PreparedStatement stmt = connection.prepareStatement(loginQuery)) {
                stmt.setString(1, email);
                stmt.setString(2, password);
                stmt.setString(3, selectedRole);
                stmt.setString(4, email);
                stmt.setString(5, password);
                stmt.setString(6, selectedRole);
                stmt.setString(7, email);
                stmt.setString(8, password);
                stmt.setString(9, selectedRole);

                ResultSet resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    // Retrieve user details and login success
                    String name = resultSet.getString("name");
                    String role = resultSet.getString("role");

                    // Store user info in session
                    HttpSession session = request.getSession();
                    session.setAttribute("userName", name);
                    session.setAttribute("userRole", role);
                    session.setAttribute("userEmail", email);

                    // Generate HTML response with SweetAlert2 login success message and redirection
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

                    // Redirect based on role after SweetAlert
                    switch (role) {
                        case "user":
                            response.getWriter().println("  window.location.href = 'profile.jsp';");
                            break;
                        case "author":
                            response.getWriter().println("  window.location.href = 'author/author-profile.jsp';");
                            break;
                        case "admin":
                            response.getWriter().println("  window.location.href = 'admin/admin-profile.jsp';");
                            break;
                    }

                    response.getWriter().println("});");
                    response.getWriter().println("</script>");

                    response.getWriter().println("</body>");
                    response.getWriter().println("</html>");

                } else {
                    // Incorrect login or role mismatch
                    request.setAttribute("error", "Invalid email, password, or role combination!");
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
