<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories - E-Books Digital Library</title>
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <main>
        <section class="category-search-section">
            <div class="container">
                <div class="search-container my-5">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="search-results" id="categorySearchResults"></div>
                            <div class="category-filter mt-3 text-center">
                                <button class="btn filter-btn active" data-category="all">All</button>
                                <%
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT * FROM category");

                                        while (rs.next()) {
                                %>
                                <button class="btn filter-btn" data-category="<%= rs.getString("name") %>"><%= rs.getString("name") %></button>
                                <%
                                        }
                                        conn.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="category-books-section">
            <div class="container">
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "");
                        Statement categoryStmt = conn.createStatement();
                        ResultSet categoryRs = categoryStmt.executeQuery("SELECT * FROM category");

                        while (categoryRs.next()) {
                            String categoryName = categoryRs.getString("name");
                %>
                <h2 class="section-title"><%= categoryName %> Books</h2>
                <div class="row">
                    <%
                        PreparedStatement bookStmt = conn.prepareStatement("SELECT * FROM books WHERE category = ?");
                        bookStmt.setString(1, categoryName);
                        ResultSet bookRs = bookStmt.executeQuery();

                        while (bookRs.next()) {
                    %>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="<%= categoryName %>">
                            <div class="book-image-container">
                                <img src="<%= bookRs.getString("image") %>" alt="<%= bookRs.getString("name") %>">
                                <div class="book-overlay">
                                    <a href="book-detail.jsp?id=<%= bookRs.getInt("id") %>" class="btn quick-view">Quick View</a>
                                    <!-- <button class="btn add-to-cart">Add to Cart</button> -->
                                </div>
                            </div>
                            <div class="book-info">
                                <h3><%= bookRs.getString("name") %></h3>
                                <p class="book-author"><%= bookRs.getString("author") %>(Author)</p>
                                <p class="book-author"><%= bookRs.getString("publisher_email") %>(Publisher)</p>
                                <div class="price">Rs. <%= bookRs.getDouble("price") %></div>
                                <div class="category-tag"><%= bookRs.getString("category") %></div>
                            </div> 
                        </div>
                    </div>
                    <%
                        }
                        bookRs.close();
                        bookStmt.close();
                    %>
                </div>
                <%
                        }
                        categoryRs.close();
                        categoryStmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </section>
    </main>

    <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="Js/search.js"></script>
    <script>
        const searchInput = document.getElementById('categorySearchInput');
        const searchResults = document.getElementById('categorySearchResults');
        const bookCards = document.querySelectorAll('.book-card');

        function filterVisibleBooks(searchTerm) {
            bookCards.forEach(card => {
                const title = card.querySelector('h3').textContent.toLowerCase();
                const author = card.querySelector('.book-author').textContent.toLowerCase();
                
                if (searchTerm === '' || title.includes(searchTerm) || author.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        function getVisibleBooksData() {
            return Array.from(bookCards).filter(card => 
                card.style.display !== 'none'
            ).map(card => ({
                title: card.querySelector('h3').textContent,
                author: card.querySelector('.book-author').textContent,
                price: card.querySelector('.price').textContent,
                image: card.querySelector('img').src,
                category: card.querySelector('.category-tag').textContent
            }));
        }

        searchInput.addEventListener('input', (e) => {
            const searchTerm = e.target.value.toLowerCase().trim();
            filterVisibleBooks(searchTerm);
        });

        document.addEventListener('click', (e) => {
            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.style.display = 'none';
            }
        });
    </script>
</body>
</html>
