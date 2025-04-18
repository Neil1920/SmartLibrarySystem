<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.TransactionDAO" %>
<%@ page import="model.Transaction" %>
<%@ page import="model.User, model.Book" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    String result = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String txnIdStr = request.getParameter("transaction_id");
            String action = request.getParameter("action");

            if (txnIdStr != null && !txnIdStr.isEmpty()) {
                int txnId = Integer.parseInt(txnIdStr);
                TransactionDAO dao = new TransactionDAO();

                if ("approve".equals(action)) {
                    if (dao.updateStatus(txnId, "approved")) {
                        result = "<span style='color:green;'>Request approved successfully.</span>";
                    } else {
                        result = "<span style='color:red;'>Failed to approve request.</span>";
                    }
                } else if ("reject".equals(action)) {
                    if (dao.updateStatus(txnId, "rejected")) {
                        result = "<span style='color:green;'>Request rejected successfully.</span>";
                    } else {
                        result = "<span style='color:red;'>Failed to reject request.</span>";
                    }
                }
            } else {
                result = "<span style='color:red;'>Transaction ID is required!</span>";
            }
        } catch (NumberFormatException e) {
            result = "<span style='color:red;'>Invalid Transaction ID format!</span>";
        } catch (Exception e) {
            result = "<span style='color:red;'>Error: " + e.getMessage() + "</span>";
        }
    }

    List<Transaction> transactions = new ArrayList<>();
    try {
        TransactionDAO dao = new TransactionDAO();
        transactions = dao.getAllTransactions();
    } catch (Exception e) {
        result = "<span style='color:red;'>Error loading transactions: " + e.getMessage() + "</span>";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approve Borrow Request</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
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
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    padding: 40px 20px;
		    max-width: 1000px;
		    width: 90%;
		    background: rgba(255, 255, 255, 0.2);
		    backdrop-filter: blur(10px);
		    -webkit-backdrop-filter: blur(10px);
		    border-radius: 15px;
		    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
}


        h2 {
            color: #003366;
            text-align: center;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .message {
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .approve-btn, .reject-btn {
            padding: 8px 12px;
            border: none;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .approve-btn {
            background-color: #28a745;
        }

        .approve-btn:hover {
            background-color: #218838;
        }

        .reject-btn {
            background-color: #dc3545;
        }

        .reject-btn:hover {
            background-color: #c82333;
        }

        .nav {
            text-align: center;
            margin-top: 30px;
        }

        .nav a {
            display: inline-block;
            margin: 0 10px;
            padding: 12px 25px;
            font-weight: bold;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .nav a[href="librarianDashboard.jsp"] {
            background-color: #007bff;
        }

        .nav a[href="librarianDashboard.jsp"]:hover {
            background-color: white;
            color: #007bff;
            transform: scale(1.05);
        }

        .nav a[href="logout.jsp"] {
            background-color: #FF3B30;
        }

        .nav a[href="logout.jsp"]:hover {
            background-color: white;
            color: #ff6600;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="background"></div>
    <div class="container">
        <h2>Approve Borrow Request</h2>
        <div class="message"><%= result %></div>

        <table>
            <tr>
                <th>Transaction ID</th>
                <th>User</th>
                <th>Book</th>
                <th>Borrow Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% if (!transactions.isEmpty()) {
                for (Transaction txn : transactions) {
            %>
            <tr>
                <td><%= txn.getTransactionId() %></td>
                <td><%= txn.getUser().getUsername() %></td>
                <td><%= txn.getBook().getTitle() %></td>
                <td><%= txn.getBorrowDate() %></td>
                <td><%= txn.getStatus() %></td>
                <td>
                    <% if ("pending".equals(txn.getStatus())) { %>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="transaction_id" value="<%= txn.getTransactionId() %>">
                        <input type="hidden" name="action" value="approve">
                        <input type="submit" class="approve-btn" value="Approve">
                    </form>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="transaction_id" value="<%= txn.getTransactionId() %>">
                        <input type="hidden" name="action" value="reject">
                        <input type="submit" class="reject-btn" value="Reject">
                    </form>
                    <% } else { %>
                        <em>No actions available</em>
                    <% } %>
                </td>
            </tr>
            <% }} else { %>
            <tr><td colspan="6" style="text-align:center;">No transactions found.</td></tr>
            <% } %>
        </table>

        <div class="nav">
            <a href="librarianDashboard.jsp">Back to Dashboard</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
</body>
</html>
