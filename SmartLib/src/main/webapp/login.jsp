<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMessage = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            UserDAO dao = new UserDAO();
            User user = dao.login(username, password);

            if (user != null) {
                session.setAttribute("user", user);
                String role = user.getRole() != null ? user.getRole().trim().toLowerCase() : "";

                if ("librarian".equals(role)) {
                    response.sendRedirect("librarianDashboard.jsp");
                } else if ("user".equals(role)) {
                    response.sendRedirect("userDashboard.jsp");
                } else {
                    errorMessage = "Invalid role detected.";
                }
                return;
            } else {
                errorMessage = "Invalid username or password.";
            }
        } catch (Exception e) {
            errorMessage = "An error occurred: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Library Login</title>
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

        .form-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-box {
            background: rgba(255, 255, 255, 0.25);
            padding: 40px 30px;
            width: 350px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
            position: relative;
            z-index: 1;
        }

        h2 {
            margin-bottom: 25px;
            font-size: 24px;
            color: #003366;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        input[type=submit] {
            background-color: #003366;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        input[type=submit]:hover {
            background-color: #0056b3;
            transform: scale(1.02);
        }

        .error {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }

        p {
            margin-top: 20px;
            font-size: 14px;
            color: #333;
        }

        .register-btn {
            display: inline-block;
            padding: 10px 18px;
            background-color: #28a745;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            margin-top: 8px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.3);
        }

        .register-btn:hover {
            background-color: #1e7e34;
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="background"></div>

    <div class="form-container">
        <div class="form-box">
            <h2>Library Login</h2>
            <form method="post">
                <input type="text" name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <input type="submit" value="Login">
            </form>

            <% if (!errorMessage.isEmpty()) { %>
                <div class="error"><%= errorMessage %></div>
            <% } %>

            <p>Don't have an account?</p>
            <a href="register.jsp" class="register-btn">Create an Account</a>
        </div>
    </div>
</body>
</html>
