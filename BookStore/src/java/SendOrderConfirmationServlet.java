import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/SendOrderConfirmationServlet")
public class SendOrderConfirmationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        String email = request.getParameter("customerEmail");
        String name = request.getParameter("customerName");
        String phone = request.getParameter("customerPhone");
        String address = request.getParameter("customerAddress");
        String city = request.getParameter("customerCity");
        String state = request.getParameter("customerState");
        String zipcode = request.getParameter("customerZipcode");
        String books = request.getParameter("customerBooks");
        String total = request.getParameter("customerTotal");
        String status = request.getParameter("BookStatus");

        // Mail configuration
        final String from = "sonaniakshit777@gmail.com";  // Your sender email
        final String password = "oost nblh rcet vyjt";       // App-specific password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Your Order Confirmation - Order #" + orderId);

            String htmlContent = "<h2>Order Summary</h2>" +
                    "<p><strong>Order ID:</strong> " + orderId + "</p>" +
                    "<p><strong>Name:</strong> " + name + "</p>" +
                    "<p><strong>Email:</strong> " + email + "</p>" +
                    "<p><strong>Phone:</strong> " + phone + "</p>" +
                    "<p><strong>Address:</strong><br>" +
                    address + "<br>" + city + ", " + state + " - " + zipcode + "</p>" +
                    "<br><h4>Ordered Books:</h4>" +
                    "<table border='1' cellpadding='8' cellspacing='0'>" +
                    "<tr><th>Book Name</th></tr>";

            // Add books as rows
            for (String book : books.split(",")) {
                htmlContent += "<tr><td>" + book.trim() + "</td></tr>";
            }

            htmlContent += "</table>" +
                    "<p><strong>Total Amount:</strong> Rs." + total + "</p>" +
                    "<p><strong>Order Status:</strong> " + status + "</p>" +
                    "<br><p>Thank you for shopping with us!</p>";

            message.setContent(htmlContent, "text/html");

            Transport.send(message);
            request.getSession().setAttribute("alert", "Order summary sent to user email.");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("alert", "Failed to send email.");
        }

        response.sendRedirect("admin/orders.jsp");
    }
}
