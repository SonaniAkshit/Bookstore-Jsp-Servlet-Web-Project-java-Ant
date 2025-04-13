<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
<!-- Featured Books Section -->
<section id="Featuredbooks" class="new-books-section">
    <div class="container">
        <h2 class="section-title">Featured Books</h2>
        <div class="row">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM books LIMIT 20"); // Fetch only 4 books
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
            %>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="book-card">
                    <div class="book-image-container">
                        <img src="<%= rs.getString("image") %>" alt="<%= rs.getString("name") %>">
                        <div class="book-overlay">
                            <a class="btn quick-view" href="categories.jsp">View Books</a>
                            <!-- <button class="btn add-to-cart">Add to Cart</button> -->
                        </div>
                    </div>
                    <div class="book-info">
                        <h3><%= rs.getString("name") %></h3>
                        <p class="book-author"><%= rs.getString("author") %></p>
                        <div class="price">Rs.<%= rs.getDouble("price") %></div>
                        <div class="category-tag"><%= rs.getString("category") %></div>
                    </div>
                </div>
            </div>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
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
