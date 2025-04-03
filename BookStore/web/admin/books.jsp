<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<script>
    document.querySelector('a[href="books.jsp"]').classList.add('active');
</script>

<!-- Main Content -->
<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none">
            <i class="fas fa-bars"></i>
        </button>
        <h2 class="mb-0">Book Management</h2>
    </div>

    <!-- Search Box with Search Icon -->
    <div class="mb-4">
        <div class="input-group">
            <span class="input-group-text">
                <i class="fas fa-search"></i> <!-- Search Icon -->
            </span>
            <input type="text" id="searchInput" class="form-control" placeholder="Search by Title, Author, or Category" onkeyup="searchBooks()">
        </div>
    </div>

    <!-- Books Table -->
    <div class="card">
        <div class="card-body">
            <table class="table admin-table" id="booksTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cover</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Publisher</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                            
                            PreparedStatement ps = conn.prepareStatement("SELECT * FROM books");
                            ResultSet rs = ps.executeQuery();
                            
                            while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td>
                                <img src="../<%= rs.getString("image") %>" alt="Book Cover" style="width: 50px; height: 70px; object-fit: cover;">
                            </td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("author") %></td>
                            <td><%= rs.getString("publisher_email") %></td>
                            <td><%= rs.getString("category") %></td>
                            <td>Rs.<%= rs.getDouble("price") %></td>
                            <td><%= rs.getInt("stock") %></td>
                            <td><%= rs.getString("description") %></td>
                        </tr>
                    <%
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="js/admin-script.js"></script>

<script>
// Function to filter the books table based on the search query
function searchBooks() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toLowerCase();
    let table = document.getElementById("booksTable");
    let tr = table.getElementsByTagName("tr");

    // Loop through all table rows and hide those that don't match the search query
    for (let i = 1; i < tr.length; i++) { // Start at 1 to skip the header row
        let td = tr[i].getElementsByTagName("td");
        let match = false;
        
        // Loop through all columns of the row
        for (let j = 0; j < td.length; j++) {
            if (td[j]) {
                let textValue = td[j].textContent || td[j].innerText;
                if (textValue.toLowerCase().indexOf(filter) > -1) {
                    match = true;
                }
            }
        }

        // Show or hide row based on whether it matches the search term
        if (match) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }
}
</script>

</body>
</html>
