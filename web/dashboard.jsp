<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.fintrack.model.User"%>
<%@page import="com.fintrack.dao.TransactionDAO"%>

<%
    User user = (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    TransactionDAO transactionDAO = new TransactionDAO();

    double totalIncome =
            transactionDAO.getTotalIncome(user.getUserId());

    double totalExpense =
            transactionDAO.getTotalExpense(user.getUserId());

    double balance =
            transactionDAO.getBalance(user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>FinTrack - Dashboard</title>

    <link rel="stylesheet" href="css/style.css">

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


        <a href="dashboard.jsp" class="active">

            <span class="nav-icon">⌂</span>

            Dashboard

        </a>


        <a href="add-transaction.jsp">

            <span class="nav-icon">＋</span>

            Add Transaction

        </a>


        <a href="transactions.jsp">

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


        <a href="settings.jsp">

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


        <!-- TOP BAR -->

        <header class="topbar">

            <div class="topbar-title">
                Dashboard
            </div>


            <div class="user-info">

                <div>

                    <strong>
                        <%= user.getFullName() %>
                    </strong>

                </div>


                <div class="user-avatar">

                    <%= user.getFullName().substring(0, 1).toUpperCase() %>

                </div>

            </div>

        </header>


        <!-- ================= PAGE CONTENT ================= -->

        <div class="page-content">


            <!-- PAGE HEADER -->

            <div class="page-header">

                <h1>
                    Welcome back, <%= user.getFullName() %> 👋
                </h1>

                <p>
                    Here's an overview of your financial activity.
                </p>

            </div>


            <!-- ================= STAT CARDS ================= -->

            <div class="stats-grid">


                <!-- BALANCE -->

                <div class="stat-card">

                    <div class="stat-header">

                        <div class="stat-title">
                            Total Balance
                        </div>

                        <div class="stat-icon icon-balance">
                            ₹
                        </div>

                    </div>


                    <div class="stat-value">

                        &#8377;<%= String.format("%.2f", balance) %>

                    </div>

                </div>


                <!-- INCOME -->

                <div class="stat-card">

                    <div class="stat-header">

                        <div class="stat-title">
                            Total Income
                        </div>

                        <div class="stat-icon icon-income">
                            ↑
                        </div>

                    </div>


                    <div class="stat-value">

                        &#8377;<%= String.format("%.2f", totalIncome) %>

                    </div>

                </div>


                <!-- EXPENSE -->

                <div class="stat-card">

                    <div class="stat-header">

                        <div class="stat-title">
                            Total Expenses
                        </div>

                        <div class="stat-icon icon-expense">
                            ↓
                        </div>

                    </div>


                    <div class="stat-value">

                        &#8377;<%= String.format("%.2f", totalExpense) %>

                    </div>

                </div>


            </div>


            <!-- ================= QUICK ACTIONS ================= -->

            <div class="content-card">

                <h2>
                    Quick Actions
                </h2>


                <div style="display:flex; gap:12px; flex-wrap:wrap;">

                    <a href="add-transaction.jsp"
                       class="btn btn-primary">

                        ＋ Add Transaction

                    </a>


                    <a href="transactions.jsp"
                       class="btn btn-secondary">

                        ▤ View Transactions

                    </a>


                    <a href="reports.jsp"
                       class="btn btn-secondary">

                        ◔ View Reports

                    </a>

                </div>

            </div>


            <!-- ================= RECENT TRANSACTIONS ================= -->

            <div class="content-card">

                <h2>
                    Recent Transactions
                </h2>


                <p style="color:#64748b; margin:0;">

                    Your recent transactions will appear here.

                </p>


                <div style="margin-top:18px;">

                    <a href="transactions.jsp"
                       class="btn btn-primary">

                        View All Transactions →

                    </a>

                </div>

            </div>


        </div>

    </main>

</div>

</body>
</html>