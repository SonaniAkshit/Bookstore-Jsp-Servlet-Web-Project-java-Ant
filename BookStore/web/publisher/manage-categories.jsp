<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<div class="publisher-content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <h1 class="mt-4">Manage Categories</h1>
                <div class="card mt-4">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>Category List</h4>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                <i class="fas fa-plus"></i> Add Category
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <table id="categoriesTable" class="table publisher-table-container">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Category Name</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT * FROM category");

                                        while (rs.next()) {
                                %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td><%= rs.getString("name") %></td>
                                    <td><%= rs.getString("description") %></td>
                                    <td>
                                        <!-- Edit Button -->
                                        <button class="btn btn-warning btn-sm edit-btn"
                                            data-id="<%= rs.getInt("id") %>"
                                            data-name="<%= rs.getString("name") %>"
                                            data-description="<%= rs.getString("description") %>"
                                            data-bs-toggle="modal" data-bs-target="#editCategoryModal">
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

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../AddCategoryServlet" method="post">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="categoryDescription" name="categoryDescription" rows="3"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Category Modal -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="../EditCategoryServlet" method="post">
                    <input type="hidden" id="editCategoryId" name="categoryId">
                    <div class="mb-3">
                        <label for="editCategoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="editCategoryName" name="categoryName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editCategoryDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editCategoryDescription" name="categoryDescription" rows="3"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Update Category</button>
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
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", function() {
            document.getElementById("editCategoryId").value = this.dataset.id;
            document.getElementById("editCategoryName").value = this.dataset.name;
            document.getElementById("editCategoryDescription").value = this.dataset.description;
        });
    });

    // Delete Category
    document.querySelectorAll(".delete-btn").forEach(button => {
        button.addEventListener("click", function() {
            let categoryId = this.dataset.id;
            Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "Yes, delete it!"
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "../DeleteCategoryServlet?categoryId=" + categoryId;
                }
            });
        });
    });
});
</script>
