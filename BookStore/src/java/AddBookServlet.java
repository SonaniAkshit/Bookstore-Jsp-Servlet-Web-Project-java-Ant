import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Paths;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.*;

@MultipartConfig
public class AddBookServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "D:/Bookstore-Jsp-Servlet-Web-Project-java-Ant/BookStore/web/images/books"; // Set the correct folder path

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Add Book</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head><body>");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Handle Image Upload
            Part filePart = request.getPart("bookImage");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Ensure upload directory exists
            File uploadFolder = new File(UPLOAD_DIRECTORY);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs(); // Create the directory if it doesn't exist
            }

            // Save the uploaded file
            String uploadPath = UPLOAD_DIRECTORY + File.separator + fileName;
            Files.copy(filePart.getInputStream(), Paths.get(uploadPath), StandardCopyOption.REPLACE_EXISTING);

            // Get Form Data
            String name = request.getParameter("bookName");
            String author = request.getParameter("bookAuthor");
            double price = Double.parseDouble(request.getParameter("bookPrice"));
            int stock = Integer.parseInt(request.getParameter("bookStock"));
            String description = request.getParameter("bookDescription");
            String publisherEmail = request.getParameter("publisherEmail");
            String category = request.getParameter("bookCategory");

            // Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");

            String sql = "INSERT INTO books (image, name, author, price, stock, description, publisher_email, category) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);

            ps.setString(1, "images/books/" + fileName); // Store relative path in database
            ps.setString(2, name);
            ps.setString(3, author);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
            ps.setString(6, description);
            ps.setString(7, publisherEmail);
            ps.setString(8, category);

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script>");
                out.println("Swal.fire({ title: 'Success!', text: 'Book Added Successfully!', icon: 'success' })");
                out.println(".then(() => { window.location='publisher/manage-books.jsp'; });");
                out.println("</script>");
            } else {
                throw new Exception("Failed to insert book.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>");
            out.println("Swal.fire({ title: 'Error!', text: '" + e.getMessage() + "', icon: 'error' })");
            out.println(".then(() => { window.location='publisher/manage-books.jsp'; });");
            out.println("</script>");
        } finally {
            // Close database resources
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        out.println("</body></html>");
    }
}
