import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String messageContent = request.getParameter("message");

        // Database config
        String dbURL = "jdbc:mysql://localhost:3306/bookstore";
        String dbUser = "root";
        String dbPass = "";

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // 1. Store message in DB
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, subject);
            stmt.setString(4, messageContent);
            stmt.executeUpdate();

            // 2. SweetAlert success
            out.println("<html><head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head><body>");
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'Message Sent!',");
            out.println("  text: 'Thanks for contacting E-Books. We’ll get back to you shortly.',");
            out.println("  confirmButtonText: 'OK'");
            out.println("}).then(() => {");
            out.println("  window.location.href = 'contact.jsp';");
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
            out.println("  title: 'Oops!',");
            out.println("  html: 'Something went wrong while submitting your message.<br><code>" + e.getMessage().replace("'", "\\'") + "</code>',");
            out.println("  confirmButtonText: 'Try Again'");
            out.println("}).then(() => {");
            out.println("  window.location.href = 'contact.jsp';");
            out.println("});");
            out.println("</script>");
            out.println("</body></html>");
        }
    }
}
