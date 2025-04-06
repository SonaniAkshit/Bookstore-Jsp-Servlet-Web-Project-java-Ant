import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/SubscribeServlet")
public class SubscribeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");

        // Database credentials
        String dbURL = "jdbc:mysql://localhost:3306/bookstore";
        String dbUser = "root";
        String dbPass = "";

        // Gmail credentials
        String from = "sonaniakshit777@gmail.com";
        String pass = "oost nblh rcet vyjt";  // Gmail App Password

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // 1. Save email in the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            String sql = "INSERT INTO subscriber (email) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.executeUpdate();

            // 2. Prepare email session
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
            props.put("mail.debug", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, pass);
                }
            });

            // 3. Compose the HTML email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, "E-Books"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Welcome to E-Books – You're Now Subscribed!");

            String htmlContent = "<h2>Welcome to <span style='color:#4CAF50;'>E-Books</span>!</h2>"
                    + "<p>Thank you for subscribing to our newsletter.</p>"
                    + "<p>You’ll now receive updates about <b>new arrivals</b>, <b>exclusive discounts</b>, and the best picks from our digital BookStore.</p>"
                    + "<br><p>Happy Reading!<br><strong>Team E-Books</strong></p>";

            message.setContent(htmlContent, "text/html");

            // 4. Send email
            Transport.send(message);

            // 5. Show SweetAlert success message
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'You’re Subscribed to E-Books!',");
            out.println("  text: 'Check your email for a welcome message and our latest updates.',");
            out.println("  confirmButtonText: 'Awesome!'");
            out.println("}).then(() => {");
            out.println("  window.location.href = 'index.jsp';");
            out.println("});");
            out.println("</script>");
            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'error',");
            out.println("  title: 'Subscription Failed!',");
            out.println("  html: 'We couldn\\'t complete your subscription to <b>E-Books</b>. Please try again.<br><br><code>" + e.getMessage().replace("'", "\\'") + "</code>',");
            out.println("  confirmButtonText: 'Retry'");
            out.println("}).then(() => {");
            out.println("  window.location.href = 'index.jsp';");
            out.println("});");
            out.println("</script>");
            out.println("</body></html>");
        }
    }
}
