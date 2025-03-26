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

@WebServlet("/ResendOtpServlet")
public class ResendOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null) {
            out.println("Invalid session");
            return;
        }

        try {
            // Generate new OTP
            Random random = new Random();
            String newOtp = String.format("%04d", random.nextInt(10000));

            // Update OTP in database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            String updateQuery = "UPDATE users SET verification_code = ? WHERE email = ? AND activation_status = 'deactive'";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, newOtp);
            stmt.setString(2, userEmail);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Send new OTP via email
                final String senderEmail = "sonaniakshit777@gmail.com";
                final String senderPassword = "ppwf xxij ruvq bvzn"; // Use App Password for Gmail

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Session mailSession = Session.getInstance(props, new jakarta.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(senderEmail, senderPassword);
                    }
                });

                try {
                    Message message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(senderEmail));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
                    message.setSubject("New OTP Verification Code - E-Books");
                    message.setText("Your new verification code is: " + newOtp + "\n\n"
                            + "Please enter this code to verify your email address.\n\n"
                            + "Best regards,\nE-Books Team");

                    Transport.send(message);
                    out.println("OTP Resent!");
                } catch (MessagingException e) {
                    e.printStackTrace();
                    out.println("Failed to send OTP email");
                }
            } else {
                out.println("User not found or already verified");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error occurred while resending OTP");
        }
    }
}