<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<div class="publisher-content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <h1 class="mt-4">Manage Books</h1>
                <div class="card mt-4">
                    <!-- <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>Book List</h4>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                                <i class="fas fa-plus"></i> Add Book
                            </button>
                        </div>
                    </div> -->
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>Book List</h4>
                            <div class="input-group" style="width: 70%;">
                                <span class="input-group-text" id="basic-addon1"><i class="fas fa-search"></i></span>
                                <input type="text" id="searchInput" class="form-control" placeholder="Search by Book Name or Author" aria-describedby="basic-addon1">
                            </div>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                                <i class="fas fa-plus"></i> Add Book
                            </button>
                        </div>
                    </div>
                    
                    
                    <div class="card-body">
                        <table id="booksTable" class="publisher-table-container" style="width:100%">
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
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE publisher_email = ?");
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
                                    <td>Rs.<%= rs.getDouble("price") %></td>
                                    <td><%= rs.getString("category") %></td>
                                    <td><%= rs.getInt("stock") %></td>
                                    <td><%= rs.getString("description") %></td>
                                    <td>
                                        <!-- Edit Button -->
                                        <button class="btn btn-warning btn-sm edit-btn"
                                            data-id="<%= rs.getInt("id") %>"
                                            data-name="<%= rs.getString("name") %>"
                                            data-author="<%= rs.getString("author") %>"
                                            data-price="<%= rs.getDouble("price") %>"
                                            data-stock="<%= rs.getInt("stock") %>"
                                            data-description="<%= rs.getString("description") %>"
                                            data-category="<%= rs.getString("category") %>"
                                            data-bs-toggle="modal" data-bs-target="#editBookModal">
                                            <i class="fas fa-edit"></i>
                                        </button>

                                        <!-- Delete Button -->
                                        <button class="btn btn-danger btn-sm delete-btn" data-id="<%= rs.getInt("id") %>">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
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
</div>

<!-- Add Book Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBookModalLabel">Add New Book</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../AddBookServlet" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="bookImage" class="form-label">Book Image</label>
                        <input type="file" class="form-control" name="bookImage" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookName" class="form-label">Book Name</label>
                        <input type="text" class="form-control" name="bookName" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookAuthor" class="form-label">Author</label>
                        <input type="text" class="form-control" name="bookAuthor" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookAuthor" class="form-label">Publisher</label>
                        <input type="text" class="form-control" name="publisherEmail" value="${publisherEmail}" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookPrice" class="form-label">Price</label>
                        <input type="number" step="0.01" class="form-control" name="bookPrice" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookCategory" class="form-label">Category</label>
                        <select class="form-control" name="bookCategory" required>
                            <option value="">Select Category</option>
                            <% 
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT name FROM category");
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("name") %>"><%= rs.getString("name") %></option>
                            <% 
                                    }
                                    con.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="bookStock" class="form-label">Stock</label>
                        <input type="number" class="form-control" name="bookStock" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookDescription" class="form-label">Description</label>
                        <textarea class="form-control" name="bookDescription" rows="3" required></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Book</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="editBookModal" tabindex="-1" aria-labelledby="editBookModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editBookModalLabel">Edit Book</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../EditBookServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="editBookId" name="bookId">
                    <div class="mb-3">
                        <label for="bookImage" class="form-label">Book Image</label>
                        <input type="file" class="form-control" name="bookImage" required>
                    </div>
                    <div class="mb-3">
                        <label for="editBookName" class="form-label">Book Name</label>
                        <input type="text" class="form-control" id="editBookName" name="bookName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editBookAuthor" class="form-label">Author</label>
                        <input type="text" class="form-control" id="editBookAuthor" name="bookAuthor" required>
                    </div>
                    <div class="mb-3">
                        <label for="editBookPrice" class="form-label">Price</label>
                        <input type="number" step="0.01" class="form-control" id="editBookPrice" name="bookPrice" required>
                    </div>
                    <div class="mb-3">
                        <label for="editBookCategory" class="form-label">Category</label>
                        <input type="text" class="form-control" id="editBookCategory" name="bookCategory" required>
                    </div>
                    <div class="mb-3">
                        <label for="editBookStock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="editBookStock" name="bookStock" required>
                    </div>
                    <div class="mb-3">
                        <label for="editBookDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editBookDescription" name="bookDescription" rows="3" required></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Book</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // Populate Edit Modal
    document.querySelectorAll(".edit-btn").forEach(function(button) {
        button.addEventListener("click", function() {
            const bookId = this.getAttribute("data-id");
            document.getElementById("editBookId").value = bookId;
            document.getElementById("editBookName").value = this.getAttribute("data-name");
            document.getElementById("editBookAuthor").value = this.getAttribute("data-author");
            document.getElementById("editBookPrice").value = this.getAttribute("data-price");
            document.getElementById("editBookStock").value = this.getAttribute("data-stock");
            document.getElementById("editBookDescription").value = this.getAttribute("data-description");
            document.getElementById("editBookCategory").value = this.getAttribute("data-category");
        });
    });

    // Handle Delete Book
    document.querySelectorAll(".delete-btn").forEach(function(button) {
        button.addEventListener("click", function() {
            const bookId = this.getAttribute("data-id");

            Swal.fire({
                title: 'Are you sure?',
                text: 'You won\'t be able to revert this!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "../DeleteBookServlet?id=" + bookId;
                }
            });
        });
    });
    // Search Functionality
    const searchInput = document.getElementById("searchInput");
    searchInput.addEventListener("keyup", function() {
        const searchQuery = searchInput.value.toLowerCase();
        const rows = document.querySelectorAll("#booksTable tbody tr");

        rows.forEach(function(row) {
            const bookName = row.cells[2].textContent.toLowerCase();
            const author = row.cells[3].textContent.toLowerCase();

            if (bookName.includes(searchQuery) || author.includes(searchQuery)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });
});
</script>