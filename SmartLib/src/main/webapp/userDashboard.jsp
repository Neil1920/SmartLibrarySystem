<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
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

        h1 {
            color: #003366;
            margin-bottom: 10px;
        }

        p {
            color: #000;
            margin-bottom: 25px;
        }

        .nav-links a {
            display: inline-block;
            margin: 10px 10px;
            padding: 12px 20px;
            background-color: #003366;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        .nav-links a:hover {
            background-color: #0056b3;
            transform: scale(1.02);
        }

        .logout {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 20px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.3);
        }

        .logout:hover {
            background-color: #c82333;
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="background"></div>

    <div class="container">
        <div class="card">
            <h1>Welcome, <%= user.getUsername() %> (User)</h1>
            <p>Email: <%= user.getEmail() %></p>

            <div class="nav-links">
                <a href="bookList.jsp">View Book List</a>
                <a href="borrowBook.jsp">Borrow a Book</a>
                <a href="returnBook.jsp">Return a Book</a>
            </div>

            <a href="logout.jsp" class="logout">Logout</a>
        </div>
    </div>
</body>
</html>
