
# 📚 Smart Library Management System

A complete web-based solution for managing library operations, built using **Java Servlets**, **JSP**, and **JDBC**. Designed for both librarians and users, this system streamlines the borrowing process, book management, and user registration with an intuitive dashboard interface.

---

## 🚀 Features

- 🧑‍💼 **Role-Based Login System**
  - Admin (Librarian)
  - Regular Users

- 📖 **Book Management**
  - Add, edit, delete books
  - View complete book list

- 🔄 **Book Transactions**
  - Borrow and return functionality
  - View borrowing history

- 👥 **User Registration and Authentication**
  - Secure login and session handling
  - Separate dashboards for users and librarians

- 📊 **Dashboard Overview**
  - Interactive dashboards showing system stats and user actions

---

## 🛠️ Technologies Used

| Layer        | Technology                    |
|--------------|-------------------------------|
| Frontend     | HTML, JSP, CSS                |
| Backend      | Java Servlets, JDBC           |
| Database     | MySQL                         |
| IDE          | Eclipse                       |
| Server       | Apache Tomcat                 |

---

## 📁 Project Structure

```
SmartLib/
├── src/main/java/
│   ├── controller/        # Servlets (e.g., LoginServlet)
│   ├── dao/               # Data Access Objects
│   ├── model/             # JavaBeans / POJOs
│   └── util/              # DB Utility classes
├── src/main/webapp/       # JSP pages, static HTML
├── .settings/             # Eclipse project settings
```

---

## ⚙️ How to Run

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/smart-library-management-system.git
   ```

2. **Import into Eclipse**
   - File > Import > Existing Projects into Workspace
   - Select the extracted project folder

3. **Set Up the Database**
   - Create a MySQL database (e.g., `library_db`)
   - Import the provided SQL script (if available)
   - Update DB credentials in `DBUtil.java`

4. **Run the Project**
   - Deploy on Apache Tomcat server
   - Access via `http://localhost:8080/SmartLib/`

---

## 📸 Screenshots


- <img src = "output screenshots/1.png" alt = "1 image">
- <img src = "output screenshots/2.png" alt = "2 image">
- <img src = "output screenshots/3.png" alt = "3 image">
- <img src = "output screenshots/4.png" alt = "4 image">
- <img src = "output screenshots/5.png" alt = "5 image">
- <img src = "output screenshots/6.png" alt = "6 image">
- <img src = "output screenshots/7.png" alt = "7 image">
- <img src = "output screenshots/8.png" alt = "8 image">
- <img src = "output screenshots/9.png" alt = "9 image">
- <img src = "output screenshots/10.png" alt = "10 image">
- <img src = "output screenshots/11.png" alt = "11 image">
- <img src = "output screenshots/12.png" alt = "12 image">

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve this system.

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙌 Acknowledgements

Thanks to open-source contributors and the Java community for resources and libraries that made this project possible.
