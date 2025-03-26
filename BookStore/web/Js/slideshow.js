let slideIndex = 1;
showSlides(slideIndex);

// Auto advance slides every 5 seconds
setInterval(() => {
    changeSlide(1);
}, 5000);

function changeSlide(n) {
    showSlides(slideIndex += n);
}

function currentSlide(n) {
    showSlides(slideIndex = n);
}

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