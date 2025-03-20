<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Include Header -->
<jsp:include page="header.jsp" />

    <!-- Contact Section -->
    <section class="contact-section">
        <div class="container">
            <!-- Contact Header -->
            <div class="contact-header">
                <h1>Contact Us</h1>
                <p>Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
            </div>

            <div class="row">
                <!-- Contact Information -->
                <div class="col-lg-4">
                    <div class="contact-info-card">
                        <i class="fas fa-map-marker-alt"></i>
                        <h3>Address</h3>
                        <p>Gujarat Vidyapith Library<br>
                           Near Income Tax Circle,<br>
                           Ashram Road, Ahmedabad,<br>
                           Gujarat 380014</p>
                    </div>
                    <div class="contact-info-card">
                        <i class="fas fa-phone"></i>
                        <h3>Phone</h3>
                        <p><a href="tel:+91-79-27540746">+91-79-27540746</a></p>
                    </div>
                    <div class="contact-info-card">
                        <i class="fas fa-envelope"></i>
                        <h3>Email</h3>
                        <p><a href="mailto:library@gujaratvidyapith.org">library@gujaratvidyapith.org</a></p>
                    </div>
                    <div class="contact-info-card">
                        <i class="fas fa-clock"></i>
                        <h3>Working Hours</h3>
                        <p>Monday - Saturday: 8:00 AM - 6:00 PM<br>
                           Sunday: Closed</p>
                    </div>
                </div>

                <!-- Contact Form -->
                <div class="col-lg-8">
                    <div class="contact-form">
                        <form action="ContactServlet" method="POST">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="name">Full Name</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="subject">Subject</label>
                                <input type="text" class="form-control" id="subject" name="subject" required>
                            </div>
                            <div class="form-group">
                                <label for="message">Message</label>
                                <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-submit">Send Message</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Map Section -->
            <div class="map-container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3671.939148967089!2d72.5754!3d23.0365!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395e84c621f2f3d3%3A0x9a7e4588f411d25f!2sGujarat%20Vidyapith%20Library!5e0!3m2!1sen!2sin!4v1647887849264!5m2!1sen!2sin" 
                        allowfullscreen="" loading="lazy"></iframe>
            </div>

            <!-- FAQ Section -->
            <div class="faq-section">
                <div class="container">
                    <h2 class="section-title mb-5">Frequently Asked Questions</h2>
                    <div class="faq-container">
                        <div class="accordion" id="faqAccordion">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                        How do I create an account?
                                    </button>
                                </h2>
                                <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        Click on the "Sign Up" button in the top right corner and fill in your details. You'll need to verify your email address to complete the registration.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                        What payment methods do you accept?
                                    </button>
                                </h2>
                                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        We accept all major credit cards, debit cards, net banking, and popular digital wallets.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                        How do I download my purchased books?
                                    </button>
                                </h2>
                                <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        After purchase, go to "My Library" in your account. You can download books from there or read them directly in our web reader.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                                        What is your refund policy?
                                    </button>
                                </h2>
                                <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        We offer refunds within 7 days of purchase if you haven't downloaded or read more than 10% of the book.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

<!-- Include Footer -->
<jsp:include page="footer.jsp" /> 