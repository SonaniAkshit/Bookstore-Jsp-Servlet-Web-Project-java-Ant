<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="publisher-content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <h1 class="mt-4">Manage Books</h1>
                <div class="card mt-4">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>Book List</h4>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                                <i class="fas fa-plus"></i> Add Book
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <table id="booksTable" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Book data will be loaded here via AJAX -->
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
                <form id="addBookForm">
                    <div class="mb-3">
                        <label for="bookTitle" class="form-label">Title</label>
                        <input type="text" class="form-control" id="bookTitle" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookAuthor" class="form-label">Author</label>
                        <input type="text" class="form-control" id="bookAuthor" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookPrice" class="form-label">Price</label>
                        <input type="number" step="0.01" class="form-control" id="bookPrice" required>
                    </div>
                    <div class="mb-3">
                        <label for="bookDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="bookDescription" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="saveBookBtn">Save Book</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="js/publisher-script.js"></script>