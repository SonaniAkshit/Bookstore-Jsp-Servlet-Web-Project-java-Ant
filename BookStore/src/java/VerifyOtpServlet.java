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

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String userEmail = (String) session.getAttribute("email");
        String enteredOtp = request.getParameter("otp");

        if (userEmail == null) {
            System.err.println("Email not found in session");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("<script>Swal.fire('Session Error!', 'Your session has expired. Please sign up again.', 'error').then(function() { window.location = 'signup.jsp'; });</script>");
            return;
        }

        if (enteredOtp == null || enteredOtp.trim().isEmpty()) {
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("<script>Swal.fire('Error!', 'Please enter the verification code.', 'error').then(function() { window.location = 'otp-verification.jsp'; });</script>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // Verify OTP and update user status
            String verifyQuery = "SELECT verification_code FROM users WHERE email = ? AND verification_code = ?";
            PreparedStatement verifyStmt = conn.prepareStatement(verifyQuery);
            verifyStmt.setString(1, userEmail);
            verifyStmt.setString(2, enteredOtp);

            ResultSet rs = verifyStmt.executeQuery();

            if (rs.next()) {
                // Update user status to active
                String updateQuery = "UPDATE users SET verification_code = NULL WHERE email = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setString(1, userEmail);
                updateStmt.executeUpdate();
                updateStmt.close();

                // Clear session
                session.removeAttribute("email");

                out.println("<!DOCTYPE html>");
                out.println("<html><head>");
                out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("</head><body>");
                out.println("<script>");
                out.println("Swal.fire({");
                out.println("  icon: 'success',");
                out.println("  title: 'Email Verified!',");
                out.println("  text: 'Your email has been verified successfully. Please log in.',");
                out.println("  confirmButtonText: 'OK'");
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
                out.println("Swal.fire('Invalid OTP!', 'Please enter the correct verification code.', 'error').then(function() { window.location = 'otp-verification.jsp'; });");
                out.println("</script>");
                out.println("</body></html>");
            }

            rs.close();
            verifyStmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire('Error!', 'An error occurred during verification. Please try again.', 'error').then(function() { window.location = 'otp-verification.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        }

        out.close();
    }
}