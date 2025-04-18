<%@ page import="model.Transaction, dao.TransactionDAO, model.User, model.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"User".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    String msg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int userId = user.getUserId();  // from session
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        java.sql.Date borrow = java.sql.Date.valueOf(request.getParameter("borrow_date"));
        java.sql.Date due = java.sql.Date.valueOf(request.getParameter("due_date"));

        Book book = new Book();
        book.setBookId(bookId);

        Transaction txn = new Transaction();
        txn.setUser(user);
        txn.setBook(book);
        txn.setBorrowDate(borrow);
        txn.setDueDate(due);
        txn.setStatus("pending");

        TransactionDAO dao = new TransactionDAO();
        if (dao.recordTransaction(txn)) {
            msg = "<span style='color:green;'>Borrow request submitted.</span>";
        } else {
            msg = "<span style='color:red;'>Failed to submit request.</span>";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow Book</title>
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
        }

        .card {
            background: rgba(255, 255, 255, 0.25);
            padding: 40px 30px;
            width: 450px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
            z-index: 1;
        }

        h2 {
            color: #003366;
            margin-bottom: 20px;
        }

        input[type="number"],
        input[type="text"],
        input[type="submit"] {
            width: 100%;
            margin: 10px 0;
            padding: 12px 15px;
            font-size: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #003366;
            color: white;
            border: none;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: scale(1.02);
        }

        .nav-links a {
            display: inline-block;
            margin: 10px 10px;
            padding: 12px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        .nav-links a:hover {
            background-color: #1e7e34;
            transform: scale(1.02);
        }

        .msg {
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="background"></div>
<div class="container">
    <div class="card">
        <h2>Borrow Book</h2>

        <form method="post">
            <input type="number" name="book_id" placeholder="Enter Book ID (from Book List)" required><br>

            <input type="text" name="borrow_date" placeholder="Select Borrow Date"
                   onfocus="(this.type='date')" onblur="if(this.value==''){this.type='text'}" required><br>

            <input type="text" name="due_date" placeholder="Select Return Date (Due Date)"
                   onfocus="(this.type='date')" onblur="if(this.value==''){this.type='text'}" required><br>

            <input type="submit" value="Request Book">
        </form>

        <div class="msg"><%= msg %></div>

        <div class="nav-links">
            <a href="userDashboard.jsp">Back to Dashboard</a>
        </div>
    </div>
</div>
</body>
</html>
