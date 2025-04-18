<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        body { font-family: Arial; background-color: #eef; text-align: center; padding-top: 100px; }
        .box { background: white; padding: 20px; width: 400px; margin: auto; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        a { display: block; margin: 10px 0; color: #007BFF; text-decoration: none; }
    </style>
</head>
<body>
<div class="box">
    <h2>Welcome, <%= user.getUsername() %></h2>
    <p>Role: <%= user.getRole() %></p>
    <hr>
    <%
        if ("librarian".equals(user.getRole())) {
    %>
        <a href="addBook.jsp">Add New Book</a>
        <a href="bookList.jsp">View Book List</a>
        <a href="borrowRequests.jsp">View Borrow Requests</a>
    <%
        } else {
    %>
        <a href="bookList.jsp">Browse Books</a>
        <a href="borrowHistory.jsp">Your Borrow History</a>
    <%
        }
    %>
    <a href="logout.jsp">Logout</a>
</div>
</body>
</html>
