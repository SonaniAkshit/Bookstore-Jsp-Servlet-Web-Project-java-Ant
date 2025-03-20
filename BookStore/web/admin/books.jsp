<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books Management - BookStore Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Mobile Navigation Toggle -->
            <button class="navbar-toggler d-md-none" type="button" data-bs-toggle="collapse" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Sidebar -->
            <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky">
                    <div class="text-center mb-4">
                        <h4 class="text-white">BookStore Admin</h4>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">
                                <i class="fas fa-home"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="books.jsp">
                                <i class="fas fa-book"></i> Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="users.jsp">
                                <i class="fas fa-users"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="orders.jsp">
                                <i class="fas fa-shopping-cart"></i> Orders
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="categories.jsp">
                                <i class="fas fa-tags"></i> Categories
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../logout">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Books Management</h1>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                        <i class="fas fa-plus"></i> Add New Book
                    </button>
                </div>

                <!-- Books Table -->
                <div class="card">
                    <div class="card-body">
                        <table id="booksTable" class="table table-striped">
                            <thead>
                                <tr>
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
                                    <td><img src="../images/hp.jpg" class="book-cover" alt="Book Cover"></td>
                                    <td>The Silent Patient</td>
                                    <td>Alex Michaelides</td>
                                    <td>Thriller</td>
                                    <td>$19.99</td>
                                    <td>45</td>
                                    <td>
                                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editBookModal">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-danger ms-1">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
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
                            <input type="text" class="form-control" name="title" required>
                            <div class="invalid-feedback">Please enter a title.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author</label>
                            <input type="text" class="form-control" name="author" required>
                            <div class="invalid-feedback">Please enter an author name.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">ISBN</label>
                            <input type="text" class="form-control" name="isbn" pattern="[0-9-]{10,17}" required>
                            <div class="invalid-feedback">Please enter a valid ISBN (10 or 13 digits).</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="category" required>
                                <option value="">Select Category</option>
                                <option value="thriller">Thriller</option>
                                <option value="horror">Horror</option>
                                <option value="mystery">Mystery</option>
                                <option value="fantasy">Fantasy</option>
                                <option value="romance">Romance</option>
                                <option value="scifi">Science Fiction</option>
                                <option value="biography">Biography</option>
                                <option value="history">History</option>
                            </select>
                            <div class="invalid-feedback">Please select a category.</div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Price ($)</label>
                                <input type="number" step="0.01" min="0" class="form-control" name="price" required>
                                <div class="invalid-feedback">Please enter a valid price.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Stock</label>
                                <input type="number" min="0" class="form-control" name="stock" required>
                                <div class="invalid-feedback">Please enter a valid stock quantity.</div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" required></textarea>
                            <div class="invalid-feedback">Please provide a book description.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cover Image</label>
                            <div class="d-flex align-items-center gap-3">
                                <div class="flex-grow-1">
                                    <input type="file" class="form-control" name="coverImage" accept="image/*" required>
                                    <div class="invalid-feedback">Please select a cover image.</div>
                                </div>
                                <img id="coverPreview" src="#" alt="Cover preview" style="display: none; width: 60px; height: 80px; object-fit: cover;">
                            </div>
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
                    <form id="editBookForm">
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" class="form-control" value="The Silent Patient" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author</label>
                            <input type="text" class="form-control" value="Alex Michaelides" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" required>
                                <option value="thriller" selected>Thriller</option>
                                <option value="horror">Horror</option>
                                <option value="mystery">Mystery</option>
                                <option value="fantasy">Fantasy</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" step="0.01" class="form-control" value="19.99" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Stock</label>
                            <input type="number" class="form-control" value="45" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Cover Image</label>
                            <input type="file" class="form-control" accept="image/*">
                            <small class="text-muted">Leave empty to keep current image</small>
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.all.min.js"></script>
    <!-- Custom JS -->
    <script src="Js/admin.js"></script>
    <style>
        .book-cover {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
        }
        .image-preview {
            max-width: 200px;
            max-height: 280px;
            margin-top: 10px;
            border-radius: 4px;
            display: none;
        }
    </style>
    <script>
        $(document).ready(function() {
            // Initialize DataTable with enhanced features
            $('#booksTable').DataTable({
                pageLength: 10,
                responsive: true,
                order: [[1, 'asc']],  // Sort by title by default
                columnDefs: [{
                    targets: 0,  // Cover column
                    orderable: false
                }, {
                    targets: -1,  // Actions column
                    orderable: false
                }]
            });
    
            // Image preview functionality
            function handleImagePreview(input, previewId) {
                const preview = $(previewId);
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.attr('src', e.target.result).show();
                    }
                    reader.readAsDataURL(input.files[0]);
                } else {
                    preview.hide();
                }
            }
    
            // Add image preview elements
            $('#addBookForm .mb-3:last-child').append('<img id="addImagePreview" class="image-preview">');
            $('#editBookForm .mb-3:last-child').append('<img id="editImagePreview" class="image-preview">');
    
            // Bind image preview handlers
            $('#addBookForm input[type="file"]').change(function() {
                handleImagePreview(this, '#addImagePreview');
            });
            $('#editBookForm input[type="file"]').change(function() {
                handleImagePreview(this, '#editImagePreview');
            });
    
            // Form validation and submission
            function validateForm(form) {
                const title = form.find('input[name="title"]').val();
                const author = form.find('input[name="author"]').val();
                const category = form.find('select[name="category"]').val();
                const price = form.find('input[name="price"]').val();
                const stock = form.find('input[name="stock"]').val();
    
                if (!title || !author || !category || !price || !stock) {
                    alert('Please fill in all required fields');
                    return false;
                }
    
                if (price <= 0) {
                    alert('Price must be greater than 0');
                    return false;
                }
    
                if (stock < 0) {
                    alert('Stock cannot be negative');
                    return false;
                }
    
                return true;
            }
    
            // Add name attributes to form inputs
            $('#addBookForm, #editBookForm').find('input, select').each(function() {
                const label = $(this).prev('label').text().toLowerCase();
                $(this).attr('name', label);
            });
    
            // Handle form submissions
            $('#addBookForm').submit(function(e) {
                e.preventDefault();
                if (validateForm($(this))) {
                    // TODO: Add AJAX call to submit form data
                    alert('Book added successfully!');
                    $('#addBookModal').modal('hide');
                    $(this)[0].reset();
                    $('#addImagePreview').hide();
                }
            });
    
            $('#editBookForm').submit(function(e) {
                e.preventDefault();
                if (validateForm($(this))) {
                    // TODO: Add AJAX call to submit form data
                    alert('Book updated successfully!');
                    $('#editBookModal').modal('hide');
                }
            });
    
            // Handle delete button with SweetAlert2
            $('.btn-danger').click(function() {
                const button = $(this);
                Swal.fire({
                    title: 'Delete Book',
                    text: 'Are you sure you want to delete this book?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // TODO: Add AJAX call to delete book
                        button.closest('tr').remove();
                        Swal.fire(
                            'Deleted!',
                            'The book has been deleted successfully.',
                            'success'
                        );
                    }
                });
            });
        });
    </script>
</body>
</html>