<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out</title>
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
            justify-content: center;
            align-items: center;
        }

        .card {
            background: rgba(255, 255, 255, 0.25);
            padding: 40px 30px;
            width: 420px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
            z-index: 1;
        }

        .card h2 {
            color: #003366;;
            margin-bottom: 10px;
        }

        .card p {
            margin-bottom: 20px;
        }

        .card a {
            display: inline-block;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }

        .card a:hover {
           background-color: #1e7e34;
            transform: scale(1.02);
        }
    </style>
</head>
<body>
    <div class="background"></div>

    <div class="container">
        <div class="card">
            <h2>You have been logged out.</h2>
            <p><a href="login.jsp">Login Again</a></p>
        </div>
    </div>
</body>
</html>
