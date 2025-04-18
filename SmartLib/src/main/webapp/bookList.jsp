<%@ page import="java.util.*, dao.BookDAO, model.Book, model.User" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .background {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            background: url('assets/img/profile/login.jpg') no-repeat center center;
            background-size: cover;
            filter: blur(6px);
            z-index: -1;
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 90%;
            margin: 60px auto;
            background: rgba(255, 255, 255, 0.25);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 26px;
            color: #B87012;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .edit-btn {
            display: inline-block;
            padding: 8px 15px;
            background-color: #B87012;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
            text-decoration: none;
            box-shadow: 0 4px 10px rgba(184, 112, 18, 0.3);
        }

        .edit-btn:hover {
            background-color: #007BFF;
            color: black;
            transform: scale(1.02);
        }

        .nav {
            text-align: center;
            margin-top: 30px;
        }

        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.4);
            transition: all 0.3s ease;
            margin: 10px;
        }

        .back-link:hover {
            background-color: white;
            color: #007bff;
            transform: scale(1.02);
        }

        .logout-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
            transition: all 0.3s ease;
            margin: 10px;
        }

        .logout-link:hover {
            background-color: white;
            color: #dc3545;
            transform: scale(1.02);
        }

        .edit-form {
            margin-top: 30px;
        }

        .edit-form h3 {
            text-align: center;
            color: #003366;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="background"></div>

    <div class="container">
        <h2>Book List</h2>

        <%
            List<Book> books = null;
            try {
                BookDAO dao = new BookDAO();
                books = dao.getAllBooks();
            } catch (Exception e) {
                out.println("<div style='color:red;'>Error loading book list: " + e.getMessage() + "</div>");
            }
        %>

        <table>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>ISBN</th>
                <th>Year</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>

            <% 
                if (books != null && !books.isEmpty()) {
                    for (Book book : books) {
            %>
            <tr>
                <td><%= book.getTitle() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getIsbn() %></td>
                <td><%= book.getPublicationYear() %></td>
                <td><%= book.getQuantity() %></td>
                <td>
                    <a href="bookList.jsp?book_id=<%= book.getBookId() %>" class="edit-btn">Edit</a>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="6" style="text-align:center; color:red;">No books available.</td>
            </tr>
            <% 
                }
            %>
        </table>

        <% 
            String bookIdStr = request.getParameter("book_id");
            if (bookIdStr != null) {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = null;
                try {
                    BookDAO dao = new BookDAO();
                    book = dao.getBookById(bookId);
                } catch (Exception e) {
                    out.println("<div style='color:red;'>Error loading book details: " + e.getMessage() + "</div>");
                }

                if (book != null) {
        %>
        <div class="edit-form">
            <h3>Edit Book</h3>
            <form action="editBook.jsp" method="post">
                <input type="hidden" name="book_id" value="<%= book.getBookId() %>">
                <label>Title:</label>
                <input type="text" name="title" value="<%= book.getTitle() %>" required><br>
                <label>Author:</label>
                <input type="text" name="author" value="<%= book.getAuthor() %>" required><br>
                <label>ISBN:</label>
                <input type="text" name="isbn" value="<%= book.getIsbn() %>" required><br>
                <label>Year:</label>
                <input type="number" name="year" value="<%= book.getPublicationYear() %>" required><br>
                <label>Quantity:</label>
                <input type="number" name="quantity" value="<%= book.getQuantity() %>" required><br>
                <input type="submit" value="Update Book">
            </form>
        </div>
        <% 
                }
            }
        %>

        <div class="nav">
            <% if ("user".equalsIgnoreCase(user.getRole())) { %>
                <a href="userDashboard.jsp" class="back-link">Back to Dashboard</a>
            <% } else { %>
                <a href="librarianDashboard.jsp" class="back-link">Back to Dashboard</a>
            <% } %>
            <a href="logout.jsp" class="logout-link">Logout</a>
        </div>
    </div>
</body>
</html>
