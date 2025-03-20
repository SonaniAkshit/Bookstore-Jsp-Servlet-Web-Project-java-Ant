<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<main class="book-detail-page">
    <!-- Book Detail Hero Section -->
    <section class="book-detail-hero">
        <div class="container">
            <nav aria-label="breadcrumb" class="pt-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                    <li class="breadcrumb-item"><a href="categories.jsp">Categories</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Book Detail</li>
                </ol>
            </nav>
        </div>
    </section>

    <!-- Book Detail Content -->
    <section class="book-detail-content">
        <div class="container">
            <div class="row">
                <!-- Book Image Gallery -->
                <div class="col-lg-5">
                    <div class="book-gallery">
                        <div class="main-image">
                            <img src="images/book1.jpg" alt="Book Cover" id="mainImage" class="img-fluid">
                        </div>
                        <div class="thumbnail-images">
                            <img src="images/book1.jpg" alt="Thumbnail 1" onclick="changeImage(this.src)" class="active">
                            <img src="images/book1-back.jpg" alt="Thumbnail 2" onclick="changeImage(this.src)">
                            <img src="images/book1-detail.jpg" alt="Thumbnail 3" onclick="changeImage(this.src)">
                        </div>
                    </div>
                </div>

                <!-- Book Information -->
                <div class="col-lg-7">
                    <div class="book-info">
                        <span class="category-tag">Fiction</span>
                        <h1 class="book-title">The Great Gatsby</h1>
                        <div class="book-meta">
                            <span class="author">by F. Scott Fitzgerald</span>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span>(4.5/5 - 128 reviews)</span>
                            </div>
                        </div>
                        <div class="book-price">
                            <span class="current-price">$24.99</span>
                            <span class="original-price">$29.99</span>
                            <span class="discount">-17%</span>
                        </div>
                        <div class="book-description">
                            <p>Set in the summer of 1922 on New York's Long Island, this classic novel depicts the American Dream through themes of decadence, idealism, social upheaval, and excess, creating a portrait of the Jazz Age that has been described as a cautionary tale of the American Dream.</p>
                        </div>
                        <div class="book-details">
                            <h3>Book Details</h3>
                            <ul class="details-list">
                                <li><span>Publisher:</span> Scribner</li>
                                <li><span>Language:</span> English</li>
                                <li><span>Paperback:</span> 180 pages</li>
                                <li><span>ISBN-10:</span> 0743273567</li>
                                <li><span>ISBN-13:</span> 978-0743273565</li>
                                <li><span>Dimensions:</span> 5.31 x 0.5 x 8.25 inches</li>
                            </ul>
                        </div>
                        <div class="purchase-options">
                            <div class="quantity-selector">
                                <button onclick="decrementQuantity()">-</button>
                                <input type="number" id="quantity" value="1" min="1" max="10">
                                <button onclick="incrementQuantity()">+</button>
                            </div>
                            <button class="btn add-to-cart-btn">
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </button>
                            <button class="btn buy-now-btn">Buy Now</button>
                            <button class="btn wishlist-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Additional Book Information Tabs -->
            <div class="book-tabs mt-5">
                <ul class="nav nav-tabs" id="bookTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description">
                            Description
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews">
                            Reviews
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="shipping-tab" data-bs-toggle="tab" data-bs-target="#shipping">
                            Shipping
                        </button>
                    </li>
                </ul>
                <div class="tab-content" id="bookTabsContent">
                    <div class="tab-pane fade show active" id="description">
                        <h3>About this Book</h3>
                        <p>The Great Gatsby, F. Scott Fitzgerald's third book, stands as the supreme achievement of his career. This exemplary novel of the Jazz Age has been acclaimed by generations of readers. The story is of the fabulously wealthy Jay Gatsby and his new love for the beautiful Daisy Buchanan, of lavish parties on Long Island at a time when The New York Times noted "gin was the national drink and sex the national obsession," it is an exquisitely crafted tale of America in the 1920s.</p>
                        <h4>Key Features</h4>
                        <ul>
                            <li>Classic American Literature</li>
                            <li>Historical Fiction</li>
                            <li>Award-winning Novel</li>
                            <li>Study Guide Included</li>
                        </ul>
                    </div>
                    <div class="tab-pane fade" id="reviews">
                        <div class="reviews-summary">
                            <div class="overall-rating">
                                <h3>Customer Reviews</h3>
                                <div class="rating-big">
                                    <span class="rating-number">4.5</span>
                                    <div class="stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                    <span class="rating-count">Based on 128 reviews</span>
                                </div>
                            </div>
                            <div class="rating-bars">
                                <div class="rating-bar">
                                    <span>5 stars</span>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 75%"></div>
                                    </div>
                                    <span>75%</span>
                                </div>
                                <!-- Add more rating bars for 4, 3, 2, 1 stars -->
                            </div>
                        </div>
                        <div class="user-reviews">
                            <!-- Sample Review -->
                            <div class="review-card">
                                <div class="review-header">
                                    <div class="reviewer-info">
                                        <img src="images/user-avatar.jpg" alt="User" class="reviewer-avatar">
                                        <div class="reviewer-details">
                                            <h5>John Doe</h5>
                                            <div class="rating">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <span class="review-date">2 days ago</span>
                                </div>
                                <p class="review-text">A masterpiece of American literature. The writing is beautiful and the story is timeless. Highly recommended for anyone who loves classic literature.</p>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="shipping">
                        <h3>Shipping Information</h3>
                        <div class="shipping-info">
                            <div class="shipping-option">
                                <i class="fas fa-truck"></i>
                                <h4>Standard Shipping</h4>
                                <p>Delivery in 3-5 business days</p>
                                <span class="shipping-price">$4.99</span>
                            </div>
                            <div class="shipping-option">
                                <i class="fas fa-shipping-fast"></i>
                                <h4>Express Shipping</h4>
                                <p>Delivery in 1-2 business days</p>
                                <span class="shipping-price">$9.99</span>
                            </div>
                        </div>
                        <div class="shipping-notes">
                            <h4>Important Notes:</h4>
                            <ul>
                                <li>Free shipping on orders over $35</li>
                                <li>International shipping available</li>
                                <li>Track your order with our shipping partners</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Related Books -->
            <section class="related-books mt-5">
                <h3>You May Also Like</h3>
                <div class="row">
                    <!-- Related Book Cards -->
                    <div class="col-md-3">
                        <div class="book-card">
                            <img src="images/book2.jpg" alt="Related Book 1">
                            <h4>To Kill a Mockingbird</h4>
                            <p class="author">Harper Lee</p>
                            <span class="price">$19.99</span>
                        </div>
                    </div>
                    <!-- Add more related books -->
                </div>
            </section>
        </div>
    </section>
</main>

<!-- Book Detail JavaScript -->
<script>
function changeImage(src) {
    document.getElementById('mainImage').src = src;
    // Update thumbnail active state
    document.querySelectorAll('.thumbnail-images img').forEach(img => {
        img.classList.remove('active');
        if (img.src === src) {
            img.classList.add('active');
        }
    });
}

function incrementQuantity() {
    const input = document.getElementById('quantity');
    const currentValue = parseInt(input.value);
    if (currentValue < parseInt(input.max)) {
        input.value = currentValue + 1;
    }
}

function decrementQuantity() {
    const input = document.getElementById('quantity');
    const currentValue = parseInt(input.value);
    if (currentValue > parseInt(input.min)) {
        input.value = currentValue - 1;
    }
}

// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});
</script>

<jsp:include page="footer.jsp" /> 