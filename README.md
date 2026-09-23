# FinTrack - Personal Finance Manager

FinTrack is a Java-based web application designed to help users manage their personal finances.

The application allows users to record income and expenses, organize transactions into categories, view financial summaries, generate reports, and manage their account settings.

---

## 📌 Project Overview

FinTrack provides a centralized platform for tracking personal financial activity.

Users can:

- Create an account
- Login and logout securely through session management
- Record income and expenses
- Categorize transactions
- View transaction history
- Edit and delete transactions
- View financial summaries on the dashboard
- Analyze expenses through reports and charts
- Update their profile
- Change their password

---

## ✨ Features

### 🔐 Authentication

- User registration
- User login
- User logout
- Session-based authentication
- Protected application pages

### 💰 Transaction Management

- Add income transactions
- Add expense transactions
- Select transaction categories
- Add descriptions
- Select transaction dates
- Edit existing transactions
- Delete transactions
- View transaction history

### 📊 Dashboard

The dashboard provides an overview of:

- Total balance
- Total income
- Total expenses
- Recent transactions

### 📈 Reports

The Reports module provides:

- Total income
- Total expenses
- Expense-by-category summary
- Expense pie chart
- Monthly income and expense chart
- Monthly financial summary

### ⚙️ Settings

Users can:

- View account information
- Update their full name
- View their registered email
- Change their password

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Application development |
| JSP | Web page development |
| Servlets | Request and business flow handling |
| JDBC | Database connectivity |
| MySQL / MariaDB | Database |
| HTML5 | Page structure |
| CSS3 | User interface styling |
| JavaScript | Interactive functionality and charts |
| Chart.js | Financial charts |
| NetBeans 8.2 | Development environment |
| GlassFish Server 4.1.1 | Application server |
| XAMPP | Local database/server environment |
| GitHub | Version control and collaboration |

---

## 🏗️ Project Architecture

FinTrack follows a simple MVC-style architecture.

```text
                User
                  │
                  ▼
             JSP Pages
                  │
                  ▼
              Servlets
                  │
                  ▼
                DAO
                  │
                  ▼
              JDBC / SQL
                  │
                  ▼
          MySQL / MariaDB