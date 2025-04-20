import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        Connection conn = null;
        PreparedStatement selectStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;
        HttpSession session = request.getSession();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            // 1. Get current order details
            String email = null, name = null, currentStatus = null;
            String getOrderSql = "SELECT email, customer_name, status FROM orders WHERE id = ?";
            selectStmt = conn.prepareStatement(getOrderSql);
            selectStmt.setString(1, orderId);
            rs = selectStmt.executeQuery();

            if (rs.next()) {
                email = rs.getString("email");
                name = rs.getString("customer_name");
                currentStatus = rs.getString("status");
            }

            // 2. Prevent update if already cancelled or delivered
            if (currentStatus == null || (!currentStatus.equalsIgnoreCase("pending"))) {
                session.setAttribute("alert", "Order cannot be updated as it is already " + currentStatus + ".");
            } else {
                // 3. Proceed with update if current status is pending
                String updateSql = "UPDATE orders SET status = ? WHERE id = ?";
                updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, newStatus);
                updateStmt.setString(2, orderId);

                int rowsUpdated = updateStmt.executeUpdate();

                if (rowsUpdated > 0) {
                    session.setAttribute("alert", "Order status updated successfully!");
                    if (email != null) {
                        sendStatusUpdateEmail(email, name, orderId, newStatus);
                    }
                } else {
                    session.setAttribute("alert", "Failed to update order status.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alert", "Something went wrong!");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (selectStmt != null) selectStmt.close(); } catch (Exception ignored) {}
            try { if (updateStmt != null) updateStmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }

        response.sendRedirect("profile.jsp");
    }

    private void sendStatusUpdateEmail(String recipient, String name, String orderId, String status) {
        final String senderEmail = "sonaniakshit777@gmail.com";
        final String senderPassword = "oost nblh rcet vyjt"; // App Password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(senderEmail, "BookStore Admin"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject("Order Cancelled - BookStore");
            message.setText("Dear " + name + ",\n\nYour order (ID: " + orderId + ") has been cancelled.\n\nThank you for using BookStore!");

            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
