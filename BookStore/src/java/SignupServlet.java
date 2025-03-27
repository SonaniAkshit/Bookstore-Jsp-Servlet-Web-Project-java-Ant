import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details (move to a config file for better security)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Database connection details (move to a config file for better security)

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Input validation
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String gender = request.getParameter("gender");
        String userRole = request.getParameter("role");
        String password = request.getParameter("password");
        
        // Check for null values
        if (name == null || email == null || contact == null || gender == null || userRole == null || password == null) {
            session.setAttribute("messageType", "error");
            session.setAttribute("messageTitle", "Error!");
            session.setAttribute("messageText", "All fields are required.");
            response.sendRedirect("signup.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            conn.setAutoCommit(false); // Enable transaction management

            // Check if the email already exists
            String checkEmailQuery = "SELECT email FROM users WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailQuery);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                session.setAttribute("messageType", "warning");
                session.setAttribute("messageTitle", "Warning!");
                session.setAttribute("messageText", "Email already exists!");
                response.sendRedirect("signup.jsp");
                return;
            }

            // Insert new user
            String insertQuery = "INSERT INTO users (name, email, contact, gender, user_role, password, activation_status) VALUES (?, ?, ?, ?, ?, ?, ?)";            
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, contact);
            pstmt.setString(4, gender);
            pstmt.setString(5, userRole);
            pstmt.setString(6, password);
            pstmt.setString(7, "active");

            int result = pstmt.executeUpdate();

            if (result > 0) {
                conn.commit();
                session.setAttribute("messageType", "success");
                session.setAttribute("messageTitle", "Success!");
                session.setAttribute("messageText", "Registration successful! Please login to continue.");
                response.sendRedirect("login.jsp");
            } else {
                conn.rollback();
                session.setAttribute("messageType", "error");
                session.setAttribute("messageTitle", "Error!");
                session.setAttribute("messageText", "Registration failed. Please try again.");
                response.sendRedirect("signup.jsp");
            }

        } catch (ClassNotFoundException e) {
            session.setAttribute("messageType", "error");
            session.setAttribute("messageTitle", "Error!");
            session.setAttribute("messageText", "Database driver not found. Please contact administrator.");
            response.sendRedirect("signup.jsp");
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            session.setAttribute("messageType", "error");
            session.setAttribute("messageTitle", "Error!");
            session.setAttribute("messageText", "Database error occurred. Please try again later.");
            response.sendRedirect("signup.jsp");
        } finally {
            // Close resources in reverse order
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}
