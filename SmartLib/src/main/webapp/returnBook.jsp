<%@ page import="java.text.SimpleDateFormat, java.util.*, dao.TransactionDAO, model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int transactionId = Integer.parseInt(request.getParameter("transactionId"));
            String returnDateStr = request.getParameter("returnDate");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = sdf.parse(returnDateStr);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

            TransactionDAO dao = new TransactionDAO();
            boolean success = dao.markReturned(transactionId, sqlDate);

            if (success) {
                message = "<span style='color: green;'>Book return marked successfully.</span>";
            } else {
                message = "<span style='color: red;'>Failed to update return.</span>";
            }

        } catch (Exception e) {
            message = "<span style='color: red;'>Error: " + e.getMessage() + "</span>";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Return Book</title>
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

        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 12px 15px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            background-color: #003366;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
            transform: scale(1.02);
        }

        .message {
            margin-top: 15px;
            font-weight: bold;
        }

        .nav-links {
            margin-top: 20px;
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
    </style>
</head>
<body>
<div class="background"></div>
<div class="container">
    <div class="card">
        <h2>Return Book</h2>
        <form method="post">
            <input type="text" name="transactionId" placeholder="Transaction ID" required><br>
            <input type="date" name="returnDate" required><br>
            <input type="submit" value="Mark Returned">
        </form>
        <div class="message"><%= message != null ? message : "" %></div>

        <div class="nav-links">
            <a href="userDashboard.jsp">Back to Dashboard</a>
        </div>
    </div>
</div>
</body>
</html>
