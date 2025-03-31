import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<!DOCTYPE html>");
        response.getWriter().write("<html lang='en'>");
        response.getWriter().write("<head>");
        response.getWriter().write("<meta charset='UTF-8'>");
        response.getWriter().write("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        response.getWriter().write("<title>Edit Category</title>");
        response.getWriter().write("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        response.getWriter().write("</head>");
        response.getWriter().write("<body>");

        String categoryId = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        String categoryDescription = request.getParameter("categoryDescription");

        String jdbcURL = "jdbc:mysql://localhost:3306/bookstore";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "UPDATE category SET name = ?, description = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, categoryName);
            statement.setString(2, categoryDescription);
            statement.setInt(3, Integer.parseInt(categoryId));

            int rowsUpdated = statement.executeUpdate();
            connection.close();

            if (rowsUpdated > 0) {
                response.getWriter().write("<script>");
                response.getWriter().write("Swal.fire({ title: 'Success', text: 'Category updated successfully!', icon: 'success' })");
                response.getWriter().write(".then(() => { window.location='publisher/manage-categories.jsp'; });");
                response.getWriter().write("</script>");
            } else {
                response.getWriter().write("<script>");
                response.getWriter().write("Swal.fire({ title: 'Error', text: 'Failed to update category.', icon: 'error' })");
                response.getWriter().write(".then(() => { window.history.back(); });");
                response.getWriter().write("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("<script>");
            response.getWriter().write("Swal.fire({ title: 'Error', text: 'Something went wrong!', icon: 'error' })");
            response.getWriter().write(".then(() => { window.history.back(); });");
            response.getWriter().write("</script>");
        }

        response.getWriter().write("</body>");
        response.getWriter().write("</html>");
    }
}
