<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"librarian".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Librarian Dashboard</title>
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
            padding: 40px 30px;
            width: 100%;
            max-width: 450px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
        }

        h1 {
            color: #003366;
            margin-bottom: 10px;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }

        p {
            color: #333;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .dashboard-content {
            margin-top: 20px;
        }

        .dashboard-content h3 {
            color: #003366;
            margin-bottom: 15px;
        }

        .dashboard-content a {
            display: block;
            margin: 10px 0;
            padding: 12px;
            background-color: #B87012;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .dashboard-content a:hover {
            background-color: white;
            color: #B87012;
            border: 1px solid #B87012;
            transform: scale(1.02);
        }

        .logout {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background-color: #FF3B30;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 14px;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.4);
            transition: all 0.3s ease;
        }

        .logout:hover {
            background-color: #D32F2F;
            color: white;
            border: 1px solid #28a745;
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
        <h1>Welcome, <%= user.getUsername() %> (Librarian)</h1>
        <p>Email: <%= user.getEmail() %></p>

        <div class="dashboard-content">
            <h3>Your Dashboard</h3>
            <a href="addBook.jsp">Add New Book</a>
            <a href="deleteBook.jsp">Delete Book</a>
            <a href="approveRequest.jsp">Approve Book Requests</a>
            <a href="bookList.jsp">View Book List</a>
        </div>

        <a href="logout.jsp" class="logout">Logout</a>
    </div>
</div>
</body>
</html>
