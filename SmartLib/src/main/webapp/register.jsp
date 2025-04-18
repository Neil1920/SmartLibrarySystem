<%@ page import="dao.UserDAO" %>
<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        UserDAO dao = new UserDAO();

        if (dao.registerUser(user)) {
            message = "<span style='color:green;'>Registered successfully. <a href='login.jsp'>Login</a></span>";
        } else {
            message = "<span style='color:red;'>Registration failed. Try again.</span>";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
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

        input[type=text], input[type=password], input[type=email], select {
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
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
        }

        input[type=submit]:hover {
            background-color: #218838;
            transform: scale(1.02);
        }

        .message {
            margin-top: 10px;
            font-size: 14px;
        }

        p {
            margin-top: 20px;
            font-size: 14px;
            color: #333;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Optional: Style login link as button if needed */
        .link-button {
            display: inline-block;
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            margin-top: 8px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.4);
            transition: background 0.3s ease;
        }

        .link-button:hover {
            background-color: #1e7e34;
        }
    </style>
</head>
<body>
<div class="background"></div>

<div class="form-container">
    <div class="form-box">
        <h2>Register</h2>
        <form method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <select name="role" required>
                <option value="">Select Role</option>
                <option value="User">User</option>
                <option value="Librarian">Librarian</option>
            </select>
            <input type="submit" value="Register">
        </form>

        <div class="message"><%= message %></div>
        <p>Already have an account?</p>
        <a href="login.jsp" class="link-button">Login</a>
    </div>
</div>
</body>
</html>
