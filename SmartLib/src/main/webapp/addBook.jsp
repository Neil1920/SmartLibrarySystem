<%@ page import="model.Book, dao.BookDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            int publicationYear = Integer.parseInt(request.getParameter("year"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (title.isEmpty() || author.isEmpty() || isbn.isEmpty()) {
                message = "<span style='color:red;'>All fields are required!</span>";
            } else if (publicationYear <= 0 || quantity <= 0) {
                message = "<span style='color:red;'>Invalid publication year or quantity!</span>";
            } else {
                Book book = new Book();
                book.setTitle(title);
                book.setAuthor(author);
                book.setIsbn(isbn);
                book.setPublicationYear(publicationYear);
                book.setQuantity(quantity);

                BookDAO dao = new BookDAO();
                if (dao.addBook(book)) {
                    message = "<span style='color:green;'>Book added successfully!</span>";
                } else {
                    message = "<span style='color:red;'>Failed to add book. Please try again.</span>";
                }
            }
        } catch (Exception e) {
            message = "<span style='color:red;'>Error: " + e.getMessage() + "</span>";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .card {
            background: rgba(255, 255, 255, 0.25);
            padding: 30px 25px;
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
        }

        h2 {
            color: #003366;
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="number"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        input[type="submit"] {
            width: 91%;
            padding: 12px;
            background-color: #003366;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.4);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: scale(1.02);
        }

        .message {
            margin-top: 15px;
            font-size: 14px;
        }

        @media (max-width: 500px) {
            .card {
                width: 90%;
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="container">
        <div class="card">
            <h2>Add New Book</h2>
            <form method="post">
                <input type="text" name="title" placeholder="Title" required><br>
                <input type="text" name="author" placeholder="Author" required><br>
                <input type="text" name="isbn" placeholder="ISBN" required><br>
                <input type="number" name="year" placeholder="Publication Year" required><br>
                <input type="number" name="quantity" placeholder="Quantity" required><br>
                <input type="submit" value="Add Book">
            </form>
            <div class="message"><%= message %></div>
        </div>
    </div>
</body>
</html>
