<%@ page import="model.Book, dao.BookDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String msg = "";
    Book book = null;
    BookDAO dao = new BookDAO();
    int bookId = -1;

    try {
        // Get the book_id from the form input (if available)
        String bookIdStr = request.getParameter("book_id");

        if (bookIdStr != null && !bookIdStr.isEmpty()) {
            bookId = Integer.parseInt(bookIdStr);

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Get updated form data
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                String isbn = request.getParameter("isbn");
                int publicationYear = Integer.parseInt(request.getParameter("year"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                // Validation
                if (title.isEmpty() || author.isEmpty() || isbn.isEmpty()) {
                    msg = "<span style='color:red;'>All fields are required!</span>";
                } else if (publicationYear <= 0 || quantity <= 0) {
                    msg = "<span style='color:red;'>Invalid publication year or quantity!</span>";
                } else {
                    // Set values
                    book = new Book();
                    book.setBookId(bookId);
                    book.setTitle(title);
                    book.setAuthor(author);
                    book.setIsbn(isbn);
                    book.setPublicationYear(publicationYear);
                    book.setQuantity(quantity);

                    if (dao.updateBook(book)) {
                        msg = "<span style='color:green;'>Book updated successfully!</span>";
                    } else {
                        msg = "<span style='color:red;'>Failed to update book. Please try again.</span>";
                    }
                }
            } else {
                // Load existing book
                book = dao.getBookById(bookId);
                if (book == null) {
                    msg = "<span style='color:red;'>Book not found!</span>";
                }
            }
        } else {
            msg = "<span style='color:red;'>Book ID is missing!</span>";
        }
    } catch (NumberFormatException e) {
        msg = "<span style='color:red;'>Invalid Book ID format!</span>";
    } catch (Exception e) {
        msg = "<span style='color:red;'>Error: " + e.getMessage() + "</span>";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef;
            text-align: center;
            padding-top: 70px;
        }
        .box {
            background: white;
            width: 350px;
            padding: 20px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input {
            width: 90%;
            margin: 8px 0;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type=submit] {
            background-color: #007BFF;
            color: white;
            border: none;
        }
        input[type=submit]:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 20px;
            font-size: 16px;
        }
        .message span {
            font-weight: bold;
        }
        a {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="box">
    <h2>Edit Book</h2>
    <!-- Form to input Book ID and update book information -->
    <form method="post">
        <!-- Input field for Book ID -->
        <input type="number" name="book_id" placeholder="Enter Book ID" required><br>
        <!-- Display and allow editing of book details if the book is found -->
        <% if (book != null) { %>
            <input type="text" name="title" value="<%= book.getTitle() %>" required><br>
            <input type="text" name="author" value="<%= book.getAuthor() %>" required><br>
            <input type="text" name="isbn" value="<%= book.getIsbn() %>" required><br>
            <input type="number" name="year" value="<%= book.getPublicationYear() %>" required><br>
            <input type="number" name="quantity" value="<%= book.getQuantity() %>" required><br>
            <input type="submit" value="Update Book">
        <% } else { %>
            <!-- Message if no book is found -->
            <p style="color: red;">No book selected or found.</p>
        <% } %>
    </form>

    <!-- Display message about the status of the operation -->
    <div class="message"><%= msg %></div>

    <!-- Link to go back to the book list -->
    <a href="bookList.jsp">Back to Book List</a>
</div>
</body>
</html>
