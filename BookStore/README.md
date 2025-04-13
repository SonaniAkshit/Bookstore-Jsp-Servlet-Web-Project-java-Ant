# 📚 BookStore Web Application

A fully functional and modern digital bookstore built using **Java Servlets**, **JSP**, and **MySQL**. This platform provides a seamless experience for customers, publishers, and administrators to manage, browse, and purchase e-books online.

![Project Banner](web/images/banner.png)

---

## 🚀 Live Demo

> 🔗 *Coming Soon*

---

## 🌟 Key Features

### 👤 **Customer**
- 🔍 Browse and search books by title, author, or category
- 🛒 Add to cart, update quantity, and remove items
- 📄 View book details with cover image, price, and author
- 🔐 User registration, login, and logout
- 📦 View order history and profile details

### 📝 **Publisher**
- 📚 Upload and manage books with images and metadata
- ✏️ Edit book details (price, description, category)
- 🗃️ Manage personal dashboard and sales stats
- 🗂️ Add and manage book categories

### 🛠️ **Admin**
- 👥 Manage users and publishers
- 📘 Full book and category control
- 📈 Monitor sales and analytics
- ✅ Approve or remove publishers
- ⚙️ Configure system-wide settings

---

## 🛠️ Tech Stack

| Layer     | Technologies                          |
|-----------|----------------------------------------|
| Frontend  | HTML5, CSS3, JavaScript, Bootstrap 5   |
| Backend   | Java Servlets, JSP, JDBC               |
| Database  | MySQL                                  |
| Build     | Apache Ant                             |
| Styling   | Font Awesome, SweetAlert2              |
| Email     | JavaMail API                           |

---

## 📁 Project Structure

```bash
   BookStore/
   ├── src/                        # Java source files (servlets)
   ├── web/                        # Web content (JSP, CSS, JS, images)
   │   ├── images/                 # Book covers & assets
   │   ├── css/                    # Custom styles
   │   └── js/                     # Custom JS files
   ├── build.xml                   # Apache Ant build file
   ├── Database(SQL)/              # SQL schema and sample data
   └── README.md                   # Project documentation
```
---
## 💾 Database Overview
MySQL database named bookstore with tables:
- users – Customer and publisher accounts
- books – Book listings
- categories – Book categories
- orders – Customer orders
- cart – Shopping cart items
- publishers – Publisher profiles
- ubscribers – Newsletter emails
- contact_messages – User inquiries
---
## 💡 How It Works
- All books and categories are dynamically fetched from the database.
- Real-time search functionality filters books as the user types.
- SweetAlert2 provides beautiful and responsive alerts.
- Servlet-based routing handles authentication, cart, orders, and admin functions.
---
## 🧪 Setup Instructions
### 1. Prerequisites
- JDK 8 or above
- Apache Tomcat 9.x
- MySQL 8.x
- Apache Ant
---


