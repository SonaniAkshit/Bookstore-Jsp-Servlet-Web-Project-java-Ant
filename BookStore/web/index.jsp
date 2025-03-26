<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Include Header -->
<jsp:include page="header.jsp" />

<!-- Main Content -->
<main class="main-content">
<section class="hero-section">
    <div class="slideshow-container">
        <div class="slides fade active">
            <img src="images/slideshow/bookslide (1).jpg" alt="Book Collection">
            <div class="slide-content">
                <h1>Browse & Select E-Books</h1>
                <p class="lead">Find the best e-books from your favorite authors, with all genres available at your fingertips.</p>
                <!-- <a href="#Featuredbooks"><button class="btn btn-primary">Explore Now</button></a> -->
            </div>
        </div>
        <div class="slides fade">
            <img src="images/slideshow/bookslide (2).jpg" alt="Reading Time">
            <div class="slide-content">
                <h1>Read Anywhere, Anytime</h1>
                <p class="lead">Access your digital library on any device, perfect for your reading journey.</p>
                <!-- <a href="#categories"><button class="btn btn-primary">View Categories</button></a> -->
                    </div>
                </div>
        <div class="slides fade">
            <img src="images/slideshow/bookslide (3).jpg" alt="Special Offers">
            <div class="slide-content">
                <h1>Special Offers</h1>
                <p class="lead">Discover amazing deals on bestsellers and new releases every week.</p>
                <!-- <a href="#Featuredbooks"><button class="btn btn-primary">Shop Now</button></a> -->
            </div>
        </div>
        <div class="slides fade">
            <img src="images/slideshow/bookslide (4).jpg" alt="Digital Reading">
            <div class="slide-content">
                <h1>Digital Reading Experience</h1>
                <p class="lead">Customize your reading with adjustable fonts, themes, and bookmarking features.</p>
                <!-- <a href="#features"><button class="btn btn-primary">Learn More</button></a> -->
            </div>
        </div>

        <!-- Navigation Arrows -->
        <button class="prev" onclick="changeSlide(-1)">
            <i class="fas fa-chevron-left"></i>
        </button>
        <button class="next" onclick="changeSlide(1)">
            <i class="fas fa-chevron-right"></i>
        </button>

        <!-- Dots Navigation -->
        <div class="dots-container">
            <span class="dot active" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(3)"></span>
            <span class="dot" onclick="currentSlide(4)"></span>
        </div>
    </div>
</section>
<section id="categories" class="categories-section">
    <div class="container">
        <h2 class="section-title">Popular Categories</h2>
        <p class="text-center text-muted mb-5">Find your favorite genre</p>
        <div class="row">
            <div class="col-lg-3 col-md-6 mb-4">
                <a href="categories.jsp#thriller" style="text-decoration: none; color: inherit;">
                <div class="category-card">
                    <div class="category-icon">
                        <i class="fas fa-mask"></i>
                    </div>
                    <h3>Thriller</h3>
                    <!-- <p>850+ Books</p> -->
                </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <a href="categories.jsp#horror" style="text-decoration: none; color: inherit;">
                <div class="category-card">
                    <div class="category-icon">
                        <i class="fas fa-ghost"></i>
                    </div>
                    <h3>Horror</h3>
                    <!-- <p>600+ Books</p> -->
                </div>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <a href="categories.jsp#mystery" style="text-decoration: none; color: inherit;">
                <div class="category-card">
                    <div class="category-icon">
                        <i class="fas fa-magnifying-glass"></i>
                    </div>
                    <h3>Mystery</h3>
                    <!-- <p>750+ Books</p> -->
                </div>
            </a>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <a href="categories.jsp#fantasy" style="text-decoration: none; color: inherit;">
                <div class="category-card">
                    <div class="category-icon">
                        <i class="fas fa-dragon"></i>
                    </div>
                    <h3>Fantasy</h3>
                    <!-- <p>900+ Books</p> -->
                </div>
            </a>
            </div>
                        </div>
                    </div>
</section>

<section id="Featuredbooks" class="new-books-section">
    <div class="container">
        <h2 class="section-title">Featured Books</h2>
        <div class="row">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="book-card">
                    <div class="book-image-container">
                        <img src="images/hp.jpg" alt="The Silent Patient">
                        <div class="book-overlay">
                            <button class="btn quick-view">Quick View</button>
                            <button class="btn add-to-cart">Add to Cart</button>
                        </div>
                    </div>
                    <div class="book-info">
                        <h3>The Silent Patient</h3>
                        <p class="book-author">Alex Michaelides</p>
                        <div class="price">$19.99</div>
                        <div class="category-tag">Thriller</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="book-card">
                    <div class="book-image-container">
                        <img src="images/ml.jpg" alt="The Midnight Library">
                        <div class="book-overlay">
                            <button class="btn quick-view">Quick View</button>
                            <button class="btn add-to-cart">Add to Cart</button>
                        </div>
                    </div>
                    <div class="book-info">
                        <h3>The Midnight Library</h3>
                        <p class="book-author">Matt Haig</p>
                        <div class="price">$21.99</div>
                        <div class="category-tag">Fantasy</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="book-card">
                    <div class="book-image-container">
                        <img src="images/sdp.jpeg" alt="Project Hail Mary">
                        <div class="book-overlay">
                            <button class="btn quick-view">Quick View</button>
                            <button class="btn add-to-cart">Add to Cart</button>
                        </div>
                    </div>
                    <div class="book-info">
                        <h3>Project Hail Mary</h3>
                        <p class="book-author">Andy Weir</p>
                        <div class="price">$24.99</div>
                        <div class="category-tag">Sci-Fi</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 
<section class="subscribe-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <h2>Subscribe To Receive The Latest Updates</h2>
                <form class="subscribe-form">
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Enter your email">
                        <button type="submit" class="btn btn-primary">Subscribe</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section> -->
</main>

<!-- Include Footer -->
<jsp:include page="footer.jsp" />

<!-- JavaScript Dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="Js/search.js"></script>
<script src="Js/slideshow.js"></script>
