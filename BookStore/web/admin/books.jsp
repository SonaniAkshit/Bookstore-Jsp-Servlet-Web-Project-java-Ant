<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<%
    int totalBooks = 0;
    int addedToday = 0;

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        Statement stmt = conn.createStatement();

        ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM books");
        if (rs1.next()) totalBooks = rs1.getInt(1);

        ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM books WHERE DATE(created_at) = CURDATE()");
        if (rs2.next()) addedToday = rs2.getInt(1);

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
    document.querySelector('a[href="books.jsp"]').classList.add('active');
</script>

<div class="admin-main">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <button id="sidebar-toggle" class="btn btn-primary d-md-none"><i class="fas fa-bars"></i></button>
        <h2 class="mb-0"> <i class="fas fa-book"></i> Book Management</h2>
    </div>

    <!-- Book Statistics -->
    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="stats-card">
                <div class="icon bg-primary text-white"><i class="fas fa-book"></i></div>
                <h3><%= totalBooks %></h3>
                <p class="text-muted mb-0">Total Books</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="stats-card">
                <div class="icon bg-success text-white"><i class="fas fa-calendar-plus"></i></div>
                <h3><%= addedToday %></h3>
                <p class="text-muted mb-0">Books Added Today</p>
            </div>
        </div>
    </div>


    <!-- Search Box -->
    <div class="card mb-4">
        <div class="card-body">
            <div class="input-group">
                <span class="input-group-text bg-primary text-white">
                    <i class="fas fa-search"></i>
                </span>
                <input type="text" id="searchInput" class="form-control" placeholder="Search by Title, Author, or Category" onkeyup="searchBooks()">
            </div>
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
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM books");

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><img src="../<%= rs.getString("image") %>" alt="Cover" style="width: 50px; height: 70px; object-fit: cover;"></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("author") %></td>
                        <td><%= rs.getString("publisher_email") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td>Rs.<%= rs.getDouble("price") %></td>
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

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function searchBooks() {
    let input = document.getElementById("searchInput");
    let filter = input.value.toLowerCase();
    let table = document.getElementById("booksTable");
    let tr = table.getElementsByTagName("tr");

    for (let i = 1; i < tr.length; i++) {
        let td = tr[i].getElementsByTagName("td");
        let match = false;
        for (let j = 0; j < td.length; j++) {
            if (td[j] && (td[j].textContent || td[j].innerText).toLowerCase().indexOf(filter) > -1) {
                match = true;
                break;
            }
        }
        tr[i].style.display = match ? "" : "none";
    }
}
</script>

</body>
</html>
