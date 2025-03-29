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
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                <i class="fas fa-plus"></i> Add New Book
            </button>
        </div>

        <!-- Books Table -->
        <div class="card">
            <div class="card-body">
                <table class="table admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cover</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>
                                <img src="../images/hp.jpg" alt="Book Cover" style="width: 50px; height: 70px; object-fit: cover;">
                            </td>
                            <td>Harry Potter</td>
                            <td>J.K. Rowling</td>
                            <td>Fantasy</td>
                            <td>$29.99</td>
                            <td>50</td>
                            <td>
                                <button class="btn btn-sm btn-primary me-1" data-bs-toggle="modal" data-bs-target="#editBookModal">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm btn-danger">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Book Modal -->
    <div class="modal fade" id="addBookModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addBookForm" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author</label>
                            <input type="text" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" required>
                                <option value="">Select Category</option>
                                <option value="Fantasy">Fantasy</option>
                                <option value="Science Fiction">Science Fiction</option>
                                <option value="Mystery">Mystery</option>
                                <option value="Romance">Romance</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" class="form-control" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Stock</label>
                            <input type="number" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cover Image</label>
                            <input type="file" class="form-control" accept="image/*" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" rows="3" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="addBookForm" class="btn btn-primary">Add Book</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Book Modal -->
    <div class="modal fade" id="editBookModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editBookForm" class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" class="form-control" value="Harry Potter" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author</label>
                            <input type="text" class="form-control" value="J.K. Rowling" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" required>
                                <option value="Fantasy" selected>Fantasy</option>
                                <option value="Science Fiction">Science Fiction</option>
                                <option value="Mystery">Mystery</option>
                                <option value="Romance">Romance</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" class="form-control" value="29.99" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Stock</label>
                            <input type="number" class="form-control" value="50" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cover Image</label>
                            <input type="file" class="form-control" accept="image/*">
                            <small class="text-muted">Leave empty to keep current image</small>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" rows="3" required>Harry Potter is a series of fantasy novels written by British author J.K. Rowling.</textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="editBookForm" class="btn btn-primary">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="js/admin-script.js"></script>
</body>
</html>