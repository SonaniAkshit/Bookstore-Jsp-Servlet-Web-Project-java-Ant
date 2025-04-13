import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/SendNewsletterServlet")
public class SendNewsletterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String recipients = request.getParameter("recipients");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        String from = "sonaniakshit777@gmail.com";
        String password = "oost nblh rcet vyjt";  // App password

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Setup mail server
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });

            // Determine if it's for all or one recipient
            List<String> emails = new ArrayList<>();
            if (recipients.contains(",")) {
                // bulk - get all from DB to ensure freshness
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT email FROM subscriber");
                while (rs.next()) {
                    emails.add(rs.getString("email"));
                }
                conn.close();
            } else {
                // single
                emails.add(recipients.trim());
            }

            // Send email to each subscriber
            for (String to : emails) {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(from, "E-Books"));
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject(subject);
                message.setContent(messageText, "text/html");
                Transport.send(message);
            }

            // Show success alert
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Newsletter Sent!',");
            out.println("  text: 'Your message has been delivered to all subscribers.',");
            out.println("  confirmButtonText: 'OK'");
            out.println("}).then(() => {");
            out.println("  window.location.href = 'admin/subscriber.jsp';");
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
            out.println("  title: 'Failed to Send!',");
            out.println("  html: 'Something went wrong while sending the newsletter.<br><br><code>" + e.getMessage().replace("'", "\\'") + "</code>',");
            out.println("  confirmButtonText: 'Try Again'");
            out.println("}).then(() => {");
            out.println("  window.location.href = 'admin/subscriber.jsp';");
            out.println("});");
            out.println("</script>");
            out.println("</body></html>");
        }
    }
}
