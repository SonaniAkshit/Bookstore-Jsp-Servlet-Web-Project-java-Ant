<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<div class="publisher-content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <h1 class="mt-4">Publisher Dashboard</h1>
                <div class="card mt-4">
                    <div class="card-header">
                        <h4>Quick Stats</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <%
                                try {
                                    // Load JDBC driver
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    // Connect to the database
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                    
                                    // Prepare SQL statement to count total books
                                    PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) AS total_books FROM books WHERE publisher_email = ?");
                                    ps.setString(1, publisherEmail); // Set publisher's email parameter
                                    ResultSet rs = ps.executeQuery();
                                    
                                    // Get the result (total books)
                                    int totalBooks = 0;
                                    if (rs.next()) {
                                        totalBooks = rs.getInt("total_books");
                                    }
                                    
                                    conn.close();
                            %>
                            <!-- Total Books Card with Icon -->
                            <div class="col-md-4">
                                <div class="card text-white bg-success mb-3">
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <i class="fas fa-book"></i> Total Books
                                        </h5>
                                        <h3><p class="card-text"><%= totalBooks %></p></h3>
                                    </div>
                                </div>
                            </div>
                            <%
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                            <%
                                try {
                                    // Load JDBC driver
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    // Connect to the database
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                    
                                    // Prepare SQL statement to count total categories
                                    PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) AS total_category FROM category");
                                    ResultSet rs = ps.executeQuery();
                                    
                                    // Get the result (total categories)
                                    int totalCategory = 0;
                                    if (rs.next()) {
                                        totalCategory = rs.getInt("total_category");
                                    }
                                    
                                    conn.close();
                            %>
                            <!-- Total Categories Card with Icon -->
                            <div class="col-md-4">
                                <div class="card text-white bg-info mb-3">
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <i class="fas fa-th-list"></i> Total Categories
                                        </h5>
                                        <h3><p class="card-text"><%= totalCategory %></p></h3>
                                    </div>
                                </div>
                            </div>
                            <%
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mt-4">
                <div class="card-header">
                    <h4>Books Added in the Last 24 Hours</h4>
                </div>
                <div class="card-body">
                    <table id="booksTable" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Book Name</th>
                                <th>Author</th>
                                <!-- <th>Publisher</th> -->
                                <th>Price</th>
                                <th>Category</th>
                                <th>Stock</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE publisher_email = ? AND created_at >= NOW() - INTERVAL 1 DAY");
                                    ps.setString(1, publisherEmail);
                                    ResultSet rs = ps.executeQuery();

                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><img src="../<%= rs.getString("image") %>" width="50" height="50"></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("author") %></td>
                                <!-- <td><%= rs.getString("publisher_email") %></td> -->
                                <td>$<%= rs.getDouble("price") %></td>
                                <td><%= rs.getString("category") %></td>
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
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script> <!-- FontAwesome CDN -->
<script src="js/publisher-script.js"></script>
</body>
</html>
