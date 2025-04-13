<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String bookId = request.getParameter("id");
    if (bookId == null || bookId.isEmpty()) {
        response.sendRedirect("categories.jsp");
        return;
    }

    String title = "", author = "", category = "", image = "images/default-book.jpg", description = "", publisher = "";
    int pages = 0, stock = 0;
    double price = 0.0;
    java.sql.Date publishdate = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
        stmt.setInt(1, Integer.parseInt(bookId));
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("name");
            author = rs.getString("author");
            category = rs.getString("category");
            image = rs.getString("image");
            description = rs.getString("description");
            price = rs.getDouble("price");
            stock = rs.getInt("stock");
            publisher = rs.getString("publisher_email");
            publishdate = rs.getDate("created_at");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    String formattedDate = (publishdate != null) ? new java.text.SimpleDateFormat("dd MMM yyyy").format(publishdate) : "N/A";
%>

<jsp:include page="header.jsp" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<main class="book-detail-page">
    <section class="book-detail-content">
        <div class="container">
            <div class="row">
                <!-- Book Image -->
                <div class="col-lg-5">
                    <div class="book-gallery">
                        <div class="main-image">
                            <img src="<%= image %>" alt="<%= title %>" class="img-fluid" id="bookImage">
                        </div>
                    </div>
                </div>

                <!-- Book Information -->
                <div class="col-lg-7">
                    <div class="book-info">
                        <span class="category-tag"><%= category %></span>
                        <h1 class="book-title"><%= title %></h1>
                        <span class="author">by <%= author %> (Author)</span>
                        <p class="publisher"><%= publisher %> (Publisher)</p>
                        <p class="publisher">Publish Date: <%= formattedDate %></p>
                        <div class="book-price">
                            <span class="current-price">Rs. <%= price %></span>
                        </div>
                        <div class="book-description">
                            <p><%= description %></p>
                        </div>

                        <% if(stock > 0) { %>
                            <span class="stock-status">
                                <i class="bi bi-check-circle-fill me-2"></i>In Stock (<%= stock %> available)
                            </span>
                        <% } else { %>
                            <span class="stock-status bg-danger text-white">
                                <i class="bi bi-x-circle-fill me-2"></i>Out of Stock
                            </span>
                        <% } %>

                        <!-- Purchase Buttons -->
                        <div class="purchase-options">
                            <form action="AddToCartServlet" method="POST">
                                <input type="hidden" name="bookId" value="<%= bookId %>">
                                <input type="hidden" name="bookName" value="<%= title %>">
                                <input type="hidden" name="author" value="<%= author %>">
                                <input type="hidden" name="publisherEmail" value="<%= publisher %>">
                                <input type="hidden" name="price" value="<%= price %>">
                                <input type="hidden" name="image" value="<%= image %>">
                                <button type="submit" class="btn buy-now-btn">
                                    <i class="fas fa-shopping-cart"></i> Add to Cart
                                </button>
                            </form>
                            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                            <!-- <button class="btn buy-now-btn">Buy Now</button> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Fullscreen Image Modal -->
<div id="imageModal" class="modal">
    <span class="close" onclick="closeImageModal()">&times;</span>
    <img class="modal-content" id="fullImage">
</div>

<!-- JavaScript for Fullscreen Image -->
<script>
document.getElementById("bookImage").addEventListener("click", function() {
    let modal = document.getElementById("imageModal");
    let modalImg = document.getElementById("fullImage");

    modal.style.display = "block";
    modalImg.src = this.src;
});

function closeImageModal() {
    document.getElementById("imageModal").style.display = "none";
}

// Close modal if user clicks outside the image
window.onclick = function(event) {
    let modal = document.getElementById("imageModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }
};
</script>

<!-- CSS for Fullscreen Modal -->
<style>
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.9);
}

.modal-content {
    display: block;
    width: 40%;
    max-width: 500px;
    height: auto;
    max-height: 70vh;
    margin: auto;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.close {
    position: absolute;
    top: 15px;
    right: 25px;
    color: white;
    font-size: 40px;
    font-weight: bold;
    cursor: pointer;
}
.stock-status {
    display: inline-block;
    font-weight: 600;
    font-size: 16px;
    margin-bottom: 25px;
    width: 40%;
    padding: 8px 12px;
    border-radius: 20px;
    background-color: #e6f4ea; /* Light green for in-stock */
    color: #2e7d32;            /* Dark green text */
    margin-top: 15px;
}

.stock-status.bg-danger {
    background-color: #dc3545 !important;  /* Bootstrap red */
    color: #fff !important;
}

.stock-status i {
    vertical-align: middle;
    margin-right: 5px;
}

.buy-now-btn {
    background-color: #007bff; /* Bootstrap primary blue */
    color: #fff;
    font-size: 16px;
    font-weight: 600;
    padding: 10px 20px;
    border: none;
    border-radius: 8px;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.buy-now-btn:hover {
    background-color: #0056b3;
    transform: scale(1.03);
}

.buy-now-btn i {
    font-size: 18px;
}


</style>

<jsp:include page="footer.jsp" />
