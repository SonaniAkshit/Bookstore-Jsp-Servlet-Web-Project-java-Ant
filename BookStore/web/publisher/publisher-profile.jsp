<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<div class="publisher-content">
    <div class="container-fluid">
        <div class="profile-section">
            <div class="profile-header">
                <img src="https://i.pravatar.cc/150?img=12" alt="Profile Image" class="profile-image">
                <div class="profile-info">
                    <h2>${publisherName}</h2>
                    <p><i class="fas fa-envelope"></i> ${publisherEmail}</p>
                    <!-- <div class="profile-stats">
                        <div class="stat-item">
                            <div class="stat-value" id="totalBooks">0</div>
                            <div class="stat-label">Published Books</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value" id="totalSales">0</div>
                            <div class="stat-label">Total Sales</div>
                        </div>
                    </div> -->
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h4>Account Info !</h4>
                </div>
                <div class="card-body">
                    <form id="profileForm" class="publisher-form">
                            <div class="mb-3">
                                <label for="publisherName" class="form-label">Name</label>
                                <input type="text" class="form-control" id="publisherName" value="<%= publisherName %>" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="publisherEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="publisherEmail" value="<%= publisherEmail %>" readonly>
                            </div>
                            <!-- <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="currentPassword" required>
                                    <button class="btn btn-outline-secondary toggle-password" type="button" data-target="currentPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div> -->
                            <!-- <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" required>
                                    <button class="btn btn-outline-secondary toggle-password" type="button" data-target="newPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="password-strength mt-2">
                                    <div class="progress" style="height: 5px;">
                                        <div class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <small class="form-text text-muted">Password strength: <span class="strength-text">None</span></small>
                                </div>
                            </div> -->
                            <!-- <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" required>
                                    <button class="btn btn-outline-secondary toggle-password" type="button" data-target="confirmPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="invalid-feedback">Passwords do not match</div>
                            </div> -->
                            <!-- <button type="submit" class="btn btn-primary btn-lg w-100">Update Profile</button> -->
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/publisher-script.js"></script>