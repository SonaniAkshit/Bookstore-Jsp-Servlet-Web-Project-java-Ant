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

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";  // Update with your actual password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if email already exists in any of the user tables
            String checkQuery = "SELECT email FROM user WHERE email = ? UNION "
                              + "SELECT email FROM author WHERE email = ? UNION "
                              + "SELECT email FROM admin WHERE email = ?";

            PreparedStatement checkStmt = connection.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            checkStmt.setString(2, email);
            checkStmt.setString(3, email);

            ResultSet resultSet = checkStmt.executeQuery();
            if (resultSet.next()) {
                // Email already exists; generate SweetAlert2 error message
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<!DOCTYPE html>");
                response.getWriter().println("<html lang='en'>");
                response.getWriter().println("<head>");
                response.getWriter().println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                response.getWriter().println("</head>");
                response.getWriter().println("<body>");
                response.getWriter().println("<script>");
                response.getWriter().println("Swal.fire({");
                response.getWriter().println("  icon: 'error',");
                response.getWriter().println("  title: 'Email Already Registered',");
                response.getWriter().println("  text: 'Please use a different email.',");
                response.getWriter().println("  confirmButtonText: 'OK'");
                response.getWriter().println("}).then(() => { window.location.href = 'signup.jsp'; });");
                response.getWriter().println("</script>");
                response.getWriter().println("</body>");
                response.getWriter().println("</html>");
            } else {
                // Insert user data based on the selected role
                String insertQuery = null;
                if ("user".equalsIgnoreCase(role)) {
                    insertQuery = "INSERT INTO user (name, email, contact, gender, password, role, last_login, last_logout) VALUES (?, ?, ?, ?, ?, ?, NULL, NULL)";
                } else if ("author".equalsIgnoreCase(role)) {
                    insertQuery = "INSERT INTO author (name, email, contact, gender, password, role, last_login, last_logout) VALUES (?, ?, ?, ?, ?, ?, NULL, NULL)";
                } else if ("admin".equalsIgnoreCase(role)) {
                    insertQuery = "INSERT INTO admin (name, email, contact, gender, password, role, last_login, last_logout) VALUES (?, ?, ?, ?, ?, ?, NULL, NULL)";
                }

                if (insertQuery != null) {
                    PreparedStatement insertStmt = connection.prepareStatement(insertQuery);
                    insertStmt.setString(1, name);
                    insertStmt.setString(2, email);
                    insertStmt.setString(3, contact);
                    insertStmt.setString(4, gender);
                    insertStmt.setString(5, password);
                    insertStmt.setString(6, role);

                    int rowsInserted = insertStmt.executeUpdate();
                    insertStmt.close();

                    // Registration successful, show SweetAlert2 success message
                    if (rowsInserted > 0) {
                        response.setContentType("text/html;charset=UTF-8");
                        response.getWriter().println("<!DOCTYPE html>");
                        response.getWriter().println("<html lang='en'>");
                        response.getWriter().println("<head>");
                        response.getWriter().println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                        response.getWriter().println("</head>");
                        response.getWriter().println("<body>");
                        response.getWriter().println("<script>");
                        response.getWriter().println("Swal.fire({");
                        response.getWriter().println("  icon: 'success',");
                        response.getWriter().println("  title: 'Account Created Successfully!',");
                        response.getWriter().println("  text: 'You can now log in to your account.',");
                        response.getWriter().println("  confirmButtonText: 'Go to Login'");
                        response.getWriter().println("}).then(() => { window.location.href = 'login.jsp'; });");
                        response.getWriter().println("</script>");
                        response.getWriter().println("</body>");
                        response.getWriter().println("</html>");
                    } else {
                        // Registration failed; show error message
                        response.getWriter().println("<script>alert('Failed to create account. Please try again.'); window.location = 'signup.jsp';</script>");
                    }
                }
            }

            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An unexpected error occurred. Please try again later.'); window.location = 'signup.jsp';</script>");
        }
    }
}
