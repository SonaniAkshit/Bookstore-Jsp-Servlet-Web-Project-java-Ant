import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/OTPVerificationServlet")
public class OTPVerificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        // Get the submitted OTP
        String digit1 = request.getParameter("digit1");
        String digit2 = request.getParameter("digit2");
        String digit3 = request.getParameter("digit3");
        String digit4 = request.getParameter("digit4");
        String submittedOtp = digit1 + digit2 + digit3 + digit4;

        // Get the email from session
        String email = (String) session.getAttribute("email");

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // Get stored OTP and verify
            String query = "SELECT verification_code FROM users WHERE email = ? AND activation_status = 'deactive'"; 
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedOtp = rs.getString("verification_code");

                if (submittedOtp.equals(storedOtp)) {
                    // Update activation status and remove verification code
                    String updateQuery = "UPDATE users SET activation_status = 'active', verification_code = NULL WHERE email = ?"; 
                    PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                    updateStmt.setString(1, email);
                    updateStmt.executeUpdate();
                    updateStmt.close();

                    // Clear session and show success message
                    session.removeAttribute("email");
                    out.println("<!DOCTYPE html>");
                    out.println("<html><head>");
                    out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    out.println("</head><body>");
                    out.println("<script>");
                    out.println("Swal.fire({");
                    out.println("  icon: 'success',");
                    out.println("  title: 'Success!',");
                    out.println("  text: 'Email verified successfully!',");
                    out.println("  showConfirmButton: false,");
                    out.println("  timer: 2000");
                    out.println("}).then(function() {");
                    out.println("  window.location = 'login.jsp';");
                    out.println("});");
                    out.println("</script>");
                    out.println("</body></html>");
                } else {
                    out.println("<!DOCTYPE html>");
                    out.println("<html><head>");
                    out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    out.println("</head><body>");
                    out.println("<script>");
                    out.println("Swal.fire({");
                    out.println("  icon: 'error',");
                    out.println("  title: 'Error!',");
                    out.println("  text: 'Invalid OTP code!',");
                    out.println("  showConfirmButton: false,");
                    out.println("  timer: 2000");
                    out.println("}).then(function() {");
                    out.println("  window.location = 'otp-verification.jsp';");
                    out.println("});");
                    out.println("</script>");
                    out.println("</body></html>");
                }
            } else {
                out.println("<!DOCTYPE html>");
                out.println("<html><head>");
                out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("</head><body>");
                out.println("<script>");
                out.println("Swal.fire({");
                out.println("  icon: 'error',");
                out.println("  title: 'Error!',");
                out.println("  text: 'User not found or already verified!',");
                out.println("  showConfirmButton: false,");
                out.println("  timer: 2000");
                out.println("}).then(function() {");
                out.println("  window.location = 'otp-verification.jsp';");
                out.println("});");
                out.println("</script>");
                out.println("</body></html>");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'error',");
            out.println("  title: 'Error!',");
            out.println("  text: 'An error occurred: " + e.getMessage().replace("'", "\\'") + "',");
            out.println("  showConfirmButton: false,");
            out.println("  timer: 2000");
            out.println("}).then(function() {");
            out.println("  window.location = 'otp-verification.jsp';");
            out.println("});");
            out.println("</script>");
            out.println("</body></html>");
        }
    }
}