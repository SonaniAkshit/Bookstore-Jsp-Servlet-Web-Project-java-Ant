import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.Random;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        // Check if fields are empty
        if (name == null || email == null || contact == null || gender == null || role == null || password == null) {
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("<script>Swal.fire('Error!', 'All fields are required!', 'error').then(function() { window.location = 'signup.jsp'; });</script>");
            return;
        }

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // Insert query
            // Generate 4-digit OTP
            Random random = new Random();
            String otp = String.format("%04d", random.nextInt(10000));

            // Insert user with OTP and deactive status
            String query = "INSERT INTO users(name, email, contact, gender, user_role, password, verification_code, activation_status) VALUES (?, ?, ?, ?, ?, ?, ?, 'deactive')";
            PreparedStatement stmt = conn.prepareStatement(query);

            // Set parameters and execute query
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, contact);
            stmt.setString(4, gender);
            stmt.setString(5, role);
            stmt.setString(6, password);
            stmt.setString(7, otp);

            int rowCount = stmt.executeUpdate();

            if (rowCount > 0) {
                // Send OTP via email
                final String senderEmail = "sonaniakshit777@gmail.com";
                final String senderPassword = "ppwf xxij ruvq bvzn"; // Use App Password for Gmail

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(senderEmail, senderPassword);
                    }
                });

                try {
                    Message message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(senderEmail));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                    message.setSubject("Email Verification - E-Books");
                    message.setText("Dear " + name + ",\n\n"
                            + "Your verification code is: " + otp + "\n\n"
                            + "Please enter this code to verify your email address.\n\n"
                            + "Best regards,\nE-Books Team");

                    Transport.send(message);

                    // Store email in session for verification
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("email", email);

                    out.println("<!DOCTYPE html>");
                    out.println("<html><head>");
                    out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    out.println("</head><body>");
                    out.println("<script>");
                    out.println("Swal.fire({");
                    out.println("  icon: 'success',");
                    out.println("  title: 'Verification Code Sent!',");
                    out.println("  text: 'Please check your email for the verification code.',");
                    out.println("  confirmButtonText: 'OK'");
                    out.println("}).then(function() {");
                    out.println("  window.location = 'otp-verification.jsp';");
                    out.println("});");
                    out.println("</script>");
                    out.println("</body></html>");

                } catch (MessagingException e) {
                    // Log the error for debugging
                    e.printStackTrace();
                    System.err.println("Email sending failed: " + e.getMessage());
                    
                    // Check for specific error types
                    String errorMessage = "Failed to send verification email. ";
                    if (e instanceof jakarta.mail.AuthenticationFailedException) {
                        errorMessage += "Invalid email credentials.";
                    } else if (e instanceof jakarta.mail.SendFailedException) {
                        errorMessage += "Invalid recipient email address.";
                    } else {
                        errorMessage += "Please try again later.";
                    }
                    
                    out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                    out.println("<script>Swal.fire('Error!', '" + errorMessage + "', 'error').then(function() { window.location = 'signup.jsp'; });</script>");
                }
            } else {
                out.println("<!DOCTYPE html>");
                out.println("<html><head>");
                out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
                out.println("</head><body>");
                out.println("<script>");
                out.println("Swal.fire('Signup Failed!', 'Please try again.', 'error').then(function() { window.location = 'signup.jsp'; });");
                out.println("</script>");
                out.println("</body></html>");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire('Unexpected Error!', 'An error occurred. Please try again later.', 'error').then(function() { window.location = 'signup.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        }

        out.close(); // Close the PrintWriter after sending the response
    }
}
