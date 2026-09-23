<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.fintrack.model.User"%>
<%@page import="com.fintrack.model.Transaction"%>
<%@page import="com.fintrack.dao.TransactionDAO"%>
<%@page import="java.util.List"%>

<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    TransactionDAO transactionDAO = new TransactionDAO();

    List<Transaction> transactions =
            transactionDAO.getTransactionsByUser(user.getUserId());

    String success = request.getParameter("success");
    String updated = request.getParameter("updated");
    String deleted = request.getParameter("deleted");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FinTrack - Transactions</title>

    <link rel="stylesheet" href="css/style.css">

    <style>

        .transaction-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .transaction-header h1 {
            margin: 0;
            color: #f8fafc;
            font-size: 28px;
        }

        .transaction-header p {
            margin: 6px 0 0;
            color: #94a3b8;
        }

        .transaction-card {
            background: #111827;
            border: 1px solid #1e293b;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.22);
        }

        .transaction-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .transaction-card-header h2 {
            margin: 0;
            color: #f8fafc;
            font-size: 18px;
        }

        .transaction-count {
            color: #94a3b8;
            font-size: 13px;
        }

        .amount-cell {
            font-weight: 600;
            color: #f8fafc;
        }

        .category-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: #1e293b;
            color: #cbd5e1;
            font-size: 12px;
            font-weight: 600;
        }

        .action-links {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .action-edit,
        .action-delete {
            display: inline-block;
            padding: 7px 11px;
            border-radius: 7px;
            font-size: 12px;
            font-weight: 600;
        }

        .action-edit {
            background: rgba(37, 99, 235, 0.15);
            color: #60a5fa;
        }

        .action-edit:hover {
            background: #2563eb;
            color: white;
        }

        .action-delete {
            background: rgba(220, 38, 38, 0.15);
            color: #f87171;
        }

        .action-delete:hover {
            background: #dc2626;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 18px;
            border-radius: 16px;
            background: #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
        }

        .empty-state h3 {
            color: #f8fafc;
            margin: 0 0 8px;
        }

        .empty-state p {
            color: #94a3b8;
            margin-bottom: 20px;
        }

    </style>

</head>

<body>

<div class="app-layout">

    <!-- ================= SIDEBAR ================= -->

    <aside class="sidebar">

        <div class="logo">

            <div class="logo-icon">
                F
            </div>

            <div class="logo-text">
                FinTrack
            </div>

        </div>


        <div class="nav-title">
            Main Menu
        </div>


        <a href="dashboard.jsp">

            <span class="nav-icon">⌂</span>

            Dashboard

        </a>


        <a href="add-transaction.jsp">

            <span class="nav-icon">＋</span>

            Add Transaction

        </a>


        <a href="transactions.jsp" class="active">

            <span class="nav-icon">▤</span>

            Transactions

        </a>


        <a href="reports.jsp">

            <span class="nav-icon">◔</span>

            Reports

        </a>


        <div class="nav-title">
            Account
        </div>


        <a href="#">

            <span class="nav-icon">⚙</span>

            Settings

        </a>


        <a href="LogoutServlet"
           onclick="return confirm('Are you sure you want to logout?');">

            <span class="nav-icon">↪</span>

            Logout

        </a>

    </aside>


    <!-- ================= MAIN CONTENT ================= -->

    <main class="main-content">


        <!-- TOPBAR -->

        <header class="topbar">

            <div class="topbar-title">
                Transactions
            </div>


            <div class="user-info">

                <strong>
                    <%= user.getFullName() %>
                </strong>

                <div class="user-avatar">

                    <%= user.getFullName().substring(0, 1).toUpperCase() %>

                </div>

            </div>

        </header>


        <!-- ================= PAGE CONTENT ================= -->

        <div class="page-content">


            <!-- PAGE HEADER -->

            <div class="transaction-header">

                <div>

                    <h1>
                        Transactions
                    </h1>

                    <p>
                        View and manage your income and expenses.
                    </p>

                </div>


                <a href="add-transaction.jsp"
                   class="btn btn-primary">

                    ＋ Add Transaction

                </a>

            </div>


            <!-- ================= MESSAGES ================= -->

            <% if ("1".equals(success)) { %>

                <div class="alert alert-success">

                    ✓ Transaction added successfully.

                </div>

            <% } else if ("1".equals(updated)) { %>

                <div class="alert alert-success">

                    ✓ Transaction updated successfully.

                </div>

            <% } else if ("1".equals(deleted)) { %>

                <div class="alert alert-success">

                    ✓ Transaction deleted successfully.

                </div>

            <% } else if (error != null) { %>

                <div class="alert alert-error">

                    Something went wrong. Please try again.

                </div>

            <% } %>


            <!-- ================= TRANSACTION TABLE ================= -->

            <div class="transaction-card">


                <div class="transaction-card-header">

                    <h2>
                        All Transactions
                    </h2>

                    <span class="transaction-count">

                        <%= transactions.size() %> transaction(s)

                    </span>

                </div>


                <% if (transactions.isEmpty()) { %>


                    <!-- EMPTY STATE -->

                    <div class="empty-state">

                        <div class="empty-icon">
                            ▤
                        </div>

                        <h3>
                            No transactions yet
                        </h3>

                        <p>
                            Start tracking your finances by adding your first transaction.
                        </p>

                        <a href="add-transaction.jsp"
                           class="btn btn-primary">

                            ＋ Add First Transaction

                        </a>

                    </div>


                <% } else { %>


                    <div class="table-wrapper">

                        <table class="modern-table">

                            <thead>

                                <tr>

                                    <th>ID</th>

                                    <th>Category</th>

                                    <th>Amount</th>

                                    <th>Description</th>

                                    <th>Date</th>

                                    <th>Actions</th>

                                </tr>

                            </thead>


                            <tbody>


                            <% for (Transaction transaction : transactions) { %>


                                <tr>

                                    <td>
                                        #<%= transaction.getTransactionId() %>
                                    </td>


                                    <td>

                                        <span class="category-badge">

                                            <%= transaction.getCategoryName() %>

                                        </span>

                                    </td>


                                    <td class="amount-cell">

                                        &#8377;<%= String.format("%.2f",
                                                transaction.getAmount()) %>

                                    </td>


                                    <td>

                                        <%= transaction.getDescription() %>

                                    </td>


                                    <td>

                                        <%= transaction.getTransactionDate() %>

                                    </td>


                                    <td>

                                        <div class="action-links">

                                            <a class="action-edit"
                                               href="TransactionServlet?action=edit&id=<%= transaction.getTransactionId() %>">

                                                Edit

                                            </a>


                                            <a class="action-delete"
                                               href="TransactionServlet?action=delete&id=<%= transaction.getTransactionId() %>"
                                               onclick="return confirm('Are you sure you want to delete this transaction?');">

                                                Delete

                                            </a>

                                        </div>

                                    </td>

                                </tr>


                            <% } %>


                            </tbody>

                        </table>

                    </div>


                <% } %>


            </div>


        </div>

    </main>

</div>

</body>

</html>