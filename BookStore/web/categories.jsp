<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories - E-Books Digital Library</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://raw.githubusercontent.com/FortAwesome/Font-Awesome/master/svgs/solid/book-reader.svg">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp" />

    <main>
        <!-- Category Search Section -->
        <section class="category-search-section">
            <div class="container">
                <div class="search-container my-5">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <!-- <div class="search-wrapper">
                                <input type="text" class="search-input" id="categorySearchInput" placeholder="Search books by title, author, or category...">
                                <i class="fas fa-search search-icon"></i>
                            </div> -->
                            <div class="search-results" id="categorySearchResults"></div>
                            <div class="category-filter mt-3 text-center">
                                <button class="btn filter-btn active" data-category="all">All</button>
                                <button class="btn filter-btn" data-category="thriller">Thriller</button>
                                <button class="btn filter-btn" data-category="horror">Horror</button>
                                <button class="btn filter-btn" data-category="mystery">Mystery</button>
                                <button class="btn filter-btn" data-category="fantasy">Fantasy</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Thriller Books Section -->
        <section id="thriller" class="category-books-section">
            <div class="container">
                <h2 class="section-title">Thriller Books</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="thriller">
                            <div class="book-image-container">
                                <img src="images/books/thriller1.jpg" alt="The Silent Patient">
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
                        <div class="book-card" data-category="thriller">
                            <div class="book-image-container">
                                <img src="images/books/thriller2.jpg" alt="Gone Girl">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>Gone Girl</h3>
                                <p class="book-author">Gillian Flynn</p>
                                <div class="price">$18.99</div>
                                <div class="category-tag">Thriller</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="thriller">
                            <div class="book-image-container">
                                <img src="images/books/thriller3.jpg" alt="The Girl on the Train">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Girl on the Train</h3>
                                <p class="book-author">Paula Hawkins</p>
                                <div class="price">$17.99</div>
                                <div class="category-tag">Thriller</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="thriller">
                            <div class="book-image-container">
                                <img src="images/books/thriller4.jpg" alt="The Da Vinci Code">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Da Vinci Code</h3>
                                <p class="book-author">Dan Brown</p>
                                <div class="price">$20.99</div>
                                <div class="category-tag">Thriller</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Horror Books Section -->
        <section id="horror" class="category-books-section">
            <div class="container">
                <h2 class="section-title">Horror Books</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="horror">
                            <div class="book-image-container">
                                <img src="images/books/horror1.jpg" alt="The Shining">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Shining</h3>
                                <p class="book-author">Stephen King</p>
                                <div class="price">$21.99</div>
                                <div class="category-tag">Horror</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="horror">
                            <div class="book-image-container">
                                <img src="images/books/horror2.jpg" alt="Dracula">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>Dracula</h3>
                                <p class="book-author">Bram Stoker</p>
                                <div class="price">$16.99</div>
                                <div class="category-tag">Horror</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="horror">
                            <div class="book-image-container">
                                <img src="images/books/horror3.jpg" alt="Pet Sematary">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>Pet Sematary</h3>
                                <p class="book-author">Stephen King</p>
                                <div class="price">$19.99</div>
                                <div class="category-tag">Horror</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="horror">
                            <div class="book-image-container">
                                <img src="images/books/horror4.jpg" alt="The Exorcist">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Exorcist</h3>
                                <p class="book-author">William Peter Blatty</p>
                                <div class="price">$18.99</div>
                                <div class="category-tag">Horror</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Mystery Books Section -->
        <section id="mystery" class="category-books-section">
            <div class="container">
                <h2 class="section-title">Mystery Books</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="mystery">
                            <div class="book-image-container">
                                <img src="images/books/mystery1.jpg" alt="And Then There Were None">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>And Then There Were None</h3>
                                <p class="book-author">Agatha Christie</p>
                                <div class="price">$15.99</div>
                                <div class="category-tag">Mystery</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="mystery">
                            <div class="book-image-container">
                                <img src="images/books/mystery2.jpg" alt="The Thursday Murder Club">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Thursday Murder Club</h3>
                                <p class="book-author">Richard Osman</p>
                                <div class="price">$22.99</div>
                                <div class="category-tag">Mystery</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="mystery">
                            <div class="book-image-container">
                                <img src="images/books/mystery3.jpg" alt="The Seven Deaths">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Seven Deaths</h3>
                                <p class="book-author">Stuart Turton</p>
                                <div class="price">$20.99</div>
                                <div class="category-tag">Mystery</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="mystery">
                            <div class="book-image-container">
                                <img src="images/books/mystery4.jpg" alt="In the Woods">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>In the Woods</h3>
                                <p class="book-author">Tana French</p>
                                <div class="price">$19.99</div>
                                <div class="category-tag">Mystery</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Fantasy Books Section -->
        <section id="fantasy" class="category-books-section">
            <div class="container">
                <h2 class="section-title">Fantasy Books</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="fantasy">
                            <div class="book-image-container">
                                <img src="images/books/fantasy1.jpg" alt="The Name of the Wind">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Name of the Wind</h3>
                                <p class="book-author">Patrick Rothfuss</p>
                                <div class="price">$24.99</div>
                                <div class="category-tag">Fantasy</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="fantasy">
                            <div class="book-image-container">
                                <img src="images/books/fantasy2.jpg" alt="The Way of Kings">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Way of Kings</h3>
                                <p class="book-author">Brandon Sanderson</p>
                                <div class="price">$27.99</div>
                                <div class="category-tag">Fantasy</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="fantasy">
                            <div class="book-image-container">
                                <img src="images/books/fantasy3.jpg" alt="The Night Circus">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>The Night Circus</h3>
                                <p class="book-author">Erin Morgenstern</p>
                                <div class="price">$21.99</div>
                                <div class="category-tag">Fantasy</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="book-card" data-category="fantasy">
                            <div class="book-image-container">
                                <img src="images/books/fantasy4.jpg" alt="Uprooted">
                                <div class="book-overlay">
                                    <button class="btn quick-view">Quick View</button>
                                    <button class="btn add-to-cart">Add to Cart</button>
                                </div>
                            </div>
                            <div class="book-info">
                                <h3>Uprooted</h3>
                                <p class="book-author">Naomi Novik</p>
                                <div class="price">$23.99</div>
                                <div class="category-tag">Fantasy</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="Js/search.js"></script>
    <!-- Search Functionality -->
   <script>
    // Get DOM elements
    const searchInput = document.getElementById('searchInput');
    const searchResults = document.getElementById('searchResults');
            const bookCards = document.querySelectorAll('.book-card');

    // Function to show/hide books based on search
    function filterVisibleBooks(searchTerm) {
        bookCards.forEach(card => {
            const title = card.querySelector('h3').textContent.toLowerCase();
            const author = card.querySelector('.book-author').textContent.toLowerCase();
            
            if (searchTerm === '' || 
                title.includes(searchTerm) || 
                author.includes(searchTerm)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // Function to get visible books data
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

    // Function to display search results dropdown
    function displaySearchResults(results) {
        if (results.length === 0) {
            searchResults.innerHTML = '<div class="no-results">No books found</div>';
        } else {
            const html = results.map(book => `
                <div class="search-result-item" onclick="selectBook('${book.title}')">
                    <img src="${book.image}" alt="${book.title}">
                    <div class="book-details">
                        <div class="book-title">${book.title}</div>
                        <div class="book-author">${book.author}</div>
                        <div class="book-price">${book.price}</div>
                    </div>
                </div>
            `).join('');
            searchResults.innerHTML = html;
        }
        searchResults.style.display = 'block';
    }

    // Function to handle book selection
    function selectBook(title) {
        searchInput.value = title;
        searchResults.style.display = 'none';
        // Filter books to show only the selected one
        filterVisibleBooks(title.toLowerCase());
        // Scroll to the book section
        const bookSection = document.querySelector('.new-books-section');
        bookSection.scrollIntoView({ behavior: 'smooth' });
    }

    // Search input event listener
    searchInput.addEventListener('input', (e) => {
        const searchTerm = e.target.value.toLowerCase().trim();
        
        // Show/hide books based on search
        filterVisibleBooks(searchTerm);
        
        if (searchTerm === '') {
            searchResults.style.display = 'none';
            return;
        }

        // Update dropdown with visible books
        const visibleBooks = getVisibleBooksData();
        displaySearchResults(visibleBooks);
    });

    // Close search results when clicking outside
    document.addEventListener('click', (e) => {
        if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
            searchResults.style.display = 'none';
        }
    });
</script>

<!-- Slideshow Script -->
<script>
    let slideIndex = 1;
    let slideInterval;

    // Show slides
    function showSlides(n) {
        const slides = document.getElementsByClassName("slides");
        const dots = document.getElementsByClassName("dot");
        
        if (n > slides.length) {
            slideIndex = 1;
        }
        if (n < 1) {
            slideIndex = slides.length;
        }
        
        // Hide all slides
        for (let i = 0; i < slides.length; i++) {
            slides[i].classList.remove("active");
            dots[i].classList.remove("active");
        }
        
        // Show current slide
        slides[slideIndex - 1].classList.add("active");
        dots[slideIndex - 1].classList.add("active");
    }

    // Next/previous controls
    function changeSlide(n) {
        clearInterval(slideInterval);
        showSlides(slideIndex += n);
        startSlideshow();
    }

    // Dot controls
    function currentSlide(n) {
        clearInterval(slideInterval);
        showSlides(slideIndex = n);
        startSlideshow();
    }

    // Auto slideshow
    function startSlideshow() {
        slideInterval = setInterval(() => {
            showSlides(slideIndex += 1);
        }, 5000); // Change slide every 5 seconds
    }

    // Initialize slideshow
    document.addEventListener('DOMContentLoaded', function() {
        showSlides(slideIndex);
        startSlideshow();
    });
</script>

<!-- Category Search Script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Get all filter buttons and book cards
        const filterButtons = document.querySelectorAll('.filter-btn');
        const bookCards = document.querySelectorAll('.book-card');
        const searchInput = document.getElementById('categorySearchInput');
        const searchResults = document.getElementById('categorySearchResults');

        // Function to filter books by category and search term
        function filterBooks() {
            const activeCategory = document.querySelector('.filter-btn.active').dataset.category;
            const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';

            bookCards.forEach(card => {
                const title = card.querySelector('h3').textContent.toLowerCase();
                const author = card.querySelector('.book-author').textContent.toLowerCase();
                const category = card.dataset.category;
                
                const matchesSearch = !searchTerm || 
                                    title.includes(searchTerm) || 
                                    author.includes(searchTerm);
                const matchesCategory = activeCategory === 'all' || 
                                      category === activeCategory;

                // Get the parent section
                const parentSection = card.closest('.category-books-section');
                
                if (matchesSearch && matchesCategory) {
                    card.style.display = 'block';
                    if (parentSection) {
                        parentSection.style.display = 'block';
                    }
                } else {
                    card.style.display = 'none';
                    // Check if all cards in this section are hidden
                    if (parentSection) {
                        const visibleCards = parentSection.querySelectorAll('.book-card[style="display: block;"]');
                        if (visibleCards.length === 0) {
                            parentSection.style.display = 'none';
                        }
                    }
                }
            });

            // Update search results if search input exists
            if (searchInput && searchTerm) {
                updateSearchResults(searchTerm);
            }
        }

        // Function to update search results dropdown
        function updateSearchResults(searchTerm) {
            const visibleBooks = Array.from(bookCards)
                .filter(card => {
                    const title = card.querySelector('h3').textContent.toLowerCase();
                    const author = card.querySelector('.book-author').textContent.toLowerCase();
                    return title.includes(searchTerm) || author.includes(searchTerm);
                })
                .map(card => ({
                    title: card.querySelector('h3').textContent,
                    author: card.querySelector('.book-author').textContent,
                    price: card.querySelector('.price').textContent,
                    image: card.querySelector('img').src,
                    category: card.querySelector('.category-tag').textContent
                }));

            if (visibleBooks.length === 0) {
                searchResults.innerHTML = '<div class="no-results">No books found</div>';
            } else {
                const html = visibleBooks.map(book => `
                    <div class="search-result-item" onclick="scrollToBook('${book.title}')">
                        <img src="${book.image}" alt="${book.title}">
                        <div class="book-details">
                            <div class="book-title">${book.title}</div>
                            <div class="book-author">${book.author}</div>
                            <div class="book-price">${book.price}</div>
                        </div>
                    </div>
                `).join('');
                searchResults.innerHTML = html;
            }
            searchResults.style.display = 'block';
        }

        // Function to scroll to a book
        window.scrollToBook = function(title) {
            const book = Array.from(bookCards).find(card => 
                card.querySelector('h3').textContent === title
            );
            if (book) {
                book.scrollIntoView({ behavior: 'smooth', block: 'center' });
                searchResults.style.display = 'none';
                if (searchInput) {
                    searchInput.value = '';
                }
            }
        };

        // Add click event listeners to filter buttons
        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                // Remove active class from all buttons
                filterButtons.forEach(btn => btn.classList.remove('active'));
                // Add active class to clicked button
                button.classList.add('active');
                // Filter books
                filterBooks();
            });
        });

        // Add input event listener to search input if it exists
        if (searchInput) {
            searchInput.addEventListener('input', filterBooks);
        }

        // Close search results when clicking outside
        document.addEventListener('click', (e) => {
            if (searchResults && !searchInput?.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.style.display = 'none';
            }
        });

        // Initial filter
        filterBooks();
    });
</script>
</body>
</html>