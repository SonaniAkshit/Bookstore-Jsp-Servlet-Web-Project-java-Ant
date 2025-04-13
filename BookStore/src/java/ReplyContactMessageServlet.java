import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

public class ReplyContactMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String to = request.getParameter("recipients");
        String subject = request.getParameter("subject");
        String messageContent = request.getParameter("message");

        final String from = "sonaniakshit777@gmail.com";
        final String password = "oost nblh rcet vyjt"; // Gmail App Password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(subject);
            message.setText(messageContent);

            Transport.send(message);

            // Full HTML with SweetAlert
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Reply Sent</title>");
            out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head>");
            out.println("<body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Reply Sent!',");
            out.println("  text: 'Your reply has been sent successfully.',");
            out.println("  confirmButtonColor: '#3085d6'");
            out.println("}).then(() => { window.location.href = 'admin/contact.jsp'; });");
            out.println("</script>");
            out.println("</body>");
            out.println("</html>");

        } catch (MessagingException e) {
            out.println("<html><body>");
            out.println("<h3 style='color:red;'>Error sending email: " + e.getMessage() + "</h3>");
            out.println("<a href='admin/contact.jsp'>Go Back</a>");
            out.println("</body></html>");
        }
    }
}
