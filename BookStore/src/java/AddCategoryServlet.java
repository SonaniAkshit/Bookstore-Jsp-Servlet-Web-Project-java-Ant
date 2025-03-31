import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<!DOCTYPE html>");
        response.getWriter().write("<html lang='en'>");
        response.getWriter().write("<head>");
        response.getWriter().write("<meta charset='UTF-8'>");
        response.getWriter().write("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        response.getWriter().write("<title>Category Status</title>");
        response.getWriter().write("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        response.getWriter().write("</head>");
        response.getWriter().write("<body>");

        String categoryName = request.getParameter("categoryName");
        String categoryDescription = request.getParameter("categoryDescription");

        if (categoryName == null || categoryName.trim().isEmpty() || categoryDescription == null || categoryDescription.trim().isEmpty()) {
            response.getWriter().write("<script>");
            response.getWriter().write("Swal.fire({ title: 'Error', text: 'All fields are required!', icon: 'error' }).then(() => { window.history.back(); });");
            response.getWriter().write("</script>");
        } else {
            String jdbcURL = "jdbc:mysql://localhost:3306/bookstore";
            String dbUser = "root";
            String dbPassword = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                
                String sql = "INSERT INTO category (name, description) VALUES (?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, categoryName);
                statement.setString(2, categoryDescription);

                int rowsInserted = statement.executeUpdate();
                connection.close();
                
                if (rowsInserted > 0) {
                    response.getWriter().write("<script>");
                    response.getWriter().write("Swal.fire({ title: 'Success', text: 'Category added successfully!', icon: 'success' }).then(() => { window.location='publisher/manage-categories.jsp'; });");
                    response.getWriter().write("</script>");
                } else {
                    response.getWriter().write("<script>");
                    response.getWriter().write("Swal.fire({ title: 'Error', text: 'Failed to add category. Try again!', icon: 'error' }).then(() => { window.history.back(); });");
                    response.getWriter().write("</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("<script>");
                response.getWriter().write("Swal.fire({ title: 'Error', text: 'Something went wrong!', icon: 'error' }).then(() => { window.history.back(); });");
                response.getWriter().write("</script>");
            }
        }

        response.getWriter().write("</body>");
        response.getWriter().write("</html>");
    }
}
