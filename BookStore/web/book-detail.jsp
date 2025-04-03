<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String bookId = request.getParameter("id");
    if (bookId == null || bookId.isEmpty()) {
        response.sendRedirect("categories.jsp");
        return;
    }

    String title = "", author = "", category = "", image = "images/default-book.jpg", description = "", publisher = "";
    int pages = 0;
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
            publisher = rs.getString("publisher_email");
            publishdate = rs.getDate("created_at"); // Fetch Date
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Format Date
    String formattedDate = (publishdate != null) ? new java.text.SimpleDateFormat("dd MMM yyyy").format(publishdate) : "N/A";
%>

<jsp:include page="header.jsp" />

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

                        <!-- Purchase Buttons (Buy Now & Add to Cart) -->
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
/* Modal Background */
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

/* Fullscreen Image */
/* Medium-Sized Image */
.modal-content {
    display: block;
    width: 40%;  /* Set medium width */
    max-width: 500px;  /* Restrict maximum width */
    height: auto;
    max-height: 70vh; /* Limit height for responsiveness */
    margin: auto;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}


/* Close Button */
.close {
    position: absolute;
    top: 15px;
    right: 25px;
    color: white;
    font-size: 40px;
    font-weight: bold;
    cursor: pointer;
}
</style>

<jsp:include page="footer.jsp" />
