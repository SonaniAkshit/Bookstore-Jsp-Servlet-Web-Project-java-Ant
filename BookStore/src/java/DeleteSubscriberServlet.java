import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteSubscriberServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        response.setContentType("text/html");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM subscriber WHERE id=?");
            ps.setInt(1, id);
            int i = ps.executeUpdate();
            conn.close();

            if (i > 0) {
                response.getWriter().println(getAlertHTML("Subscriber deleted successfully!", "success", "admin/subscriber.jsp"));
            } else {
                response.getWriter().println(getAlertHTML("Subscriber not found!", "error", "admin/subscriber.jsp"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println(getAlertHTML("Error occurred while deleting!", "error", "admin/subscriber.jsp"));
        }
    }

    private String getAlertHTML(String msg, String icon, String redirectTo) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <title>Deleting Subscriber</title>
                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            </head>
            <body>
                <script>
                    Swal.fire({
                        icon: '%s',
                        title: '%s',
                        text: '%s',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        window.location.href = '%s';
                    });
                </script>
            </body>
            </html>
        """.formatted(icon, icon.equals("success") ? "Success" : "Oops!", msg, redirectTo);
    }
}
