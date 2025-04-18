<%@ page import="dao.BookDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String bookIdStr = request.getParameter("book_id");
            if (bookIdStr != null && !bookIdStr.isEmpty()) {
                int bookId = Integer.parseInt(bookIdStr);

                BookDAO dao = new BookDAO();
                boolean result = dao.deleteBook(bookId);

                message = result
                    ? "<span style='color:green;'>Book deleted successfully.</span>"
                    : "<span style='color:red;'>Failed to delete book. ID may not exist.</span>";
            } else {
                message = "<span style='color:red;'>Book ID is required!</span>";
            }
        } catch (NumberFormatException e) {
            message = "<span style='color:red;'>Invalid Book ID format!</span>";
        } catch (Exception e) {
            message = "<span style='color:red;'>Error: " + e.getMessage() + "</span>";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Book</title>
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

        input[type="number"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        input[type="submit"] {
            width: 90%;
            padding: 12px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #c82333;
            transform: scale(1.02);
        }

        .message {
            margin-top: 15px;
            font-size: 14px;
        }

        .back-link {
            display: inline-block;
            margin-top: 18px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.4);
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background-color: white;
            color: #007bff;
            transform: scale(1.02);
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
            <h2>Delete Book</h2>
            <form method="post">
                <input type="number" name="book_id" placeholder="Enter Book ID" required><br>
                <input type="submit" value="Delete Book">
            </form>
            <div class="message"><%= message %></div>
            <a class="back-link" href="bookList.jsp">Back to Book List</a>
        </div>
    </div>
</body>
</html>
