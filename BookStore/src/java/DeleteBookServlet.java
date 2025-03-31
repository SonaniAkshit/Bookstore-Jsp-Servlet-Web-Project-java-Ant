import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Delete Book</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head><body>");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
            PreparedStatement ps = con.prepareStatement("DELETE FROM books WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            con.close();

            out.println("<script>");
            out.println("Swal.fire({ title: 'Deleted!', text: 'Book Deleted Successfully!', icon: 'success' })");
            out.println(".then(() => { window.location='publisher/manage-books.jsp'; });");
            out.println("</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>");
            out.println("Swal.fire({ title: 'Error!', text: 'Failed to delete book!', icon: 'error' })");
            out.println(".then(() => { window.location='publisher/manage-books.jsp'; });");
            out.println("</script>");
        }

        out.println("</body></html>");
    }
}
