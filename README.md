# BookStore Web Application

## 🚧 Project Status: Under Development 🚧

A comprehensive web-based bookstore application built using JSP, Servlets, and MySQL. This project aims to provide a robust platform for managing and selling books online with both user and administrative interfaces.

## Features

### Admin Dashboard (Implemented ✅)

- **Book Management**
  - Add, edit, and delete books
  - Manage book inventory and stock levels
  - Upload and manage book covers
  - Track comprehensive book details (title, author, ISBN, price)
  - Organize books by categories

- **User Management**
  - View and manage user accounts
  - Monitor user activities and purchase history
  - Handle user roles and permissions

- **Order Management**
  - Process and track customer orders
  - Update order status
  - View order history and details

- **Category Management**
  - Create and manage book categories
  - Organize books by genres and types
  - Easy category navigation

### User Interface (Under Development 🚧)

- **User Authentication**
  - User registration and login
  - Password recovery system
  - Profile management

- **Book Browsing**
  - Browse books by category
  - Advanced search functionality
  - Detailed book information pages
  - Book previews and samples

- **Shopping Features**
  - Shopping cart functionality
  - Wishlist management
  - Secure checkout process
  - Multiple payment options

- **User Engagement**
  - Book reviews and ratings
  - Reading lists
  - Personalized recommendations
  - Email notifications

## Technology Stack

### Backend
- Java Servlets
- JSP (JavaServer Pages)
- Apache Ant (Build Tool)
- MySQL Database

### Frontend
- HTML5/CSS3
- Bootstrap 5.3.2
- JavaScript/jQuery
- DataTables for dynamic tables
- SweetAlert2 for notifications
- Font Awesome Icons

## Project Structure

```
BookStore/
├── src/
│   └── java/
│       ├── com/bookstore/
│       │   ├── controller/    # Servlet controllers
│       │   ├── dao/           # Data Access Objects
│       │   ├── model/         # Entity classes
│       │   ├── service/       # Business logic
│       │   └── util/          # Utility classes
│       └── resources/         # Configuration files
├── web/
│   ├── admin/                 # Admin dashboard JSPs
│   │   ├── books.jsp          # Book management
│   │   ├── users.jsp          # User management
│   │   ├── orders.jsp         # Order management
│   │   ├── categories.jsp     # Category management
│   │   ├── dashboard.jsp      # Admin home
│   │   └── includes/          # Admin page components
│   ├── WEB-INF/
│   │   ├── lib/              # Java libraries
│   │   └── web.xml           # Web configuration
│   ├── user/                  # User-side JSPs
│   │   ├── index.jsp         # Homepage
│   │   ├── login.jsp         # User login
│   │   ├── register.jsp      # User registration
│   │   ├── about.jsp         # About page
│   │   ├── contact.jsp       # Contact page
│   │   ├── profile.jsp       # User profile
│   │   ├── book-details.jsp  # Book information
│   │   ├── cart.jsp          # Shopping cart
│   │   ├── checkout.jsp      # Order checkout
│   │   ├── wishlist.jsp      # User wishlist
│   │   └── includes/         # Reusable components
│   ├── assets/
│   │   ├── css/             # Stylesheets
│   │   ├── js/              # JavaScript files
│   │   ├── images/          # Image assets
│   │   └── fonts/           # Custom fonts
│   ├── META-INF/
│   │   └── context.xml      # Database configuration
│   └── error/               # Error pages
└── build/                   # Compiled files
```

## Setup Instructions

1. **Prerequisites**
   - JDK 8 or higher
   - Apache Tomcat 8.5 or higher
   - MySQL 5.7 or higher
   - Apache Ant

2. **Database Setup**
   - Create a new MySQL database
   - Import the provided SQL schema
   - Configure database connection in `context.xml`

3. **Project Setup**
   ```bash
   # Clone the repository
   git clone [repository-url]
   cd BookStore

   # Build the project using Ant
   ant build

   # Deploy to Tomcat
   ant deploy
   ```

4. **Configuration**
   - Update database credentials in `web/META-INF/context.xml`
   - Configure email settings for notifications (if applicable)
   - Set up environment-specific parameters

## Development Roadmap

### Phase 1 (Completed)
- ✅ Basic project structure
- ✅ Admin dashboard implementation
- ✅ Book management system
- ✅ Category management

### Phase 2 (In Progress)
- 🚧 User authentication system
- 🚧 Shopping cart implementation
- 🚧 Book search and filtering
- 🚧 User reviews and ratings

### Phase 3 (Planned)
- 📅 Payment gateway integration
- 📅 Order tracking system
- 📅 Email notification system
- 📅 Mobile responsive design

## Contributing

This project is currently under active development. Contributions are welcome!

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please open an issue in the repository or contact the development team.
