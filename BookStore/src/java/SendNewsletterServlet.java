import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class SendNewsletterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String recipients = request.getParameter("recipients");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        final String fromEmail = "sonaniakshit777@gmail.com";
        final String password = "oost nblh rcet vyjt"; // Gmail App Password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        response.setContentType("text/html");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "E-Books")); // Show E-Books as sender name
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipients));
            msg.setSubject(subject);
            msg.setText(message);

            Transport.send(msg);

            response.getWriter().println(getAlertHTML(
                "Newsletter Sent from <b>E-Books</b>!",
                "Your newsletter has been successfully delivered to subscribers.",
                "success",
                "admin/subscriber.jsp"
            ));
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println(getAlertHTML(
                "Failed to Send Newsletter",
                "We couldn’t send the newsletter. Please try again.<br><br><code>" +
                escapeHTML(e.getMessage()) + "</code>",
                "error",
                "admin/subscriber.jsp"
            ));
        }
    }

    private String getAlertHTML(String title, String msg, String icon, String redirectTo) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <title>Newsletter Status - E-Books</title>
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            </head>
            <body>
                <script>
                    Swal.fire({
                        icon: '%s',
                        title: '%s',
                        html: '%s',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        window.location.href = '%s';
                    });
                </script>
            </body>
            </html>
        """.formatted(icon, title, msg, redirectTo);
    }

    private String escapeHTML(String text) {
        return text == null ? "" : text.replace("&", "&amp;")
                                       .replace("<", "&lt;")
                                       .replace(">", "&gt;")
                                       .replace("\"", "&quot;")
                                       .replace("'", "&#39;");
    }
}
