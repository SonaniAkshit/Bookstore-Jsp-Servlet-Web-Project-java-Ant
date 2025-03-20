// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    initializeSearch();
});

function initializeSearch() {
    // Get DOM elements
    const searchInput = document.getElementById('searchInput');
    const searchResults = document.getElementById('searchResults');
    const bookCards = document.querySelectorAll('.book-card');

    // Check if elements exist
    if (!searchInput || !searchResults) {
        console.warn('Search elements not found');
        return;
    }

    // Function to show/hide books based on search
    function filterVisibleBooks(searchTerm) {
        let foundMatch = false;
        if (!bookCards.length) {
            console.warn('No book cards found on this page');
            return false;
        }

        bookCards.forEach(card => {
            try {
                const title = card.querySelector('h3')?.textContent.toLowerCase() || '';
                const author = card.querySelector('.book-author')?.textContent.toLowerCase() || '';
                const category = card.querySelector('.category-tag')?.textContent.toLowerCase() || '';
                
                if (searchTerm === '' || 
                    title.includes(searchTerm) || 
                    author.includes(searchTerm) ||
                    category.includes(searchTerm)) {
                    card.style.display = 'block';
                    foundMatch = true;
                } else {
                    card.style.display = 'none';
                }
            } catch (error) {
                console.error('Error processing card:', error);
            }
        });
        return foundMatch;
    }

    // Function to get visible books data
    function getVisibleBooksData() {
        return Array.from(bookCards)
            .filter(card => card.style.display !== 'none')
            .map(card => {
                try {
                    const imgElement = card.querySelector('img');
                    const imgSrc = imgElement ? imgElement.src : '';
                    // Extract just the filename from the path
                    const imgPath = imgSrc.split('/').pop();
                    
                    return {
                        title: card.querySelector('h3')?.textContent || '',
                        author: card.querySelector('.book-author')?.textContent || '',
                        price: card.querySelector('.price')?.textContent || '',
                        image: 'images/' + imgPath,
                        category: card.querySelector('.category-tag')?.textContent || ''
                    };
                } catch (error) {
                    console.error('Error getting book data:', error);
                    return null;
                }
            })
            .filter(book => book !== null);
    }

    // Function to display search results dropdown
    function displaySearchResults(results) {
        if (!searchResults) return;

        if (results.length === 0) {
            searchResults.innerHTML = '<div class="no-results">No books found</div>';
        } else {
            const html = results.map(book => `
                <div class="search-result-item" onclick="selectBook('${book.title}')">
                    <img src="${book.image}" alt="${book.title}" onerror="this.src='images/default-book.jpg'">
                    <div class="book-details">
                        <div class="book-title">${book.title}</div>
                        <div class="book-author">by ${book.author}</div>
                        <div class="book-price">${book.price}</div>
                        <div class="book-category">${book.category}</div>
                    </div>
                </div>
            `).join('');
            searchResults.innerHTML = html;
        }
        searchResults.style.display = 'block';
    }

    // Make selectBook function globally available
    window.selectBook = function(title) {
        if (!searchInput || !searchResults) return;
        
        searchInput.value = title;
        searchResults.style.display = 'none';
        filterVisibleBooks(title.toLowerCase());
        
        const bookSection = document.querySelector('.new-books-section');
        if (bookSection) {
            bookSection.scrollIntoView({ behavior: 'smooth' });
        }
    };

    // Search input event listener
    searchInput.addEventListener('input', (e) => {
        const searchTerm = e.target.value.toLowerCase().trim();
        console.log('Searching for:', searchTerm);
        
        const foundMatch = filterVisibleBooks(searchTerm);
        console.log('Found matches:', foundMatch);
        
        if (searchTerm === '') {
            searchResults.style.display = 'none';
            return;
        }

        const visibleBooks = getVisibleBooksData();
        console.log('Visible books:', visibleBooks);
        displaySearchResults(visibleBooks);
    });

    // Close search results when clicking outside
    document.addEventListener('click', (e) => {
        if (searchResults && !searchInput.contains(e.target) && !searchResults.contains(e.target)) {
            searchResults.style.display = 'none';
        }
    });

    console.log('Search functionality initialized');
}

// Slideshow Script
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