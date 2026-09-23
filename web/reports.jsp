<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.fintrack.dao.TransactionDAO"%>
<%@page import="com.fintrack.model.User"%>
<%@page import="com.fintrack.model.Transaction"%>
<%@page import="java.util.List"%>

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

    List<Transaction> expenseByCategory =
            transactionDAO.getExpenseByCategory(user.getUserId());

    List<Transaction> monthlySummary =
            transactionDAO.getMonthlySummary(user.getUserId());
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FinTrack - Reports</title>

    <link rel="stylesheet" href="css/style.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

        /* =========================================
           REPORTS PAGE
           ========================================= */

        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .report-header h1 {
            margin: 0 0 7px;
            color: #f8fafc;
            font-size: 28px;
        }

        .report-header p {
            margin: 0;
            color: #94a3b8;
        }

        .report-actions {
            display: flex;
            gap: 10px;
        }

        /* Report stat cards */

        .report-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .report-stat {
            background: #111827;
            border: 1px solid #1e293b;
            border-radius: 16px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.22);
            transition: 0.2s ease;
        }

        .report-stat:hover {
            transform: translateY(-3px);
            border-color: #334155;
        }

        .report-stat-label {
            color: #94a3b8;
            font-size: 13px;
            margin-bottom: 12px;
        }

        .report-stat-value {
            font-size: 26px;
            font-weight: 700;
        }

        .report-income {
            color: #4ade80;
        }

        .report-expense {
            color: #f87171;
        }

        .report-balance {
            color: #60a5fa;
        }

        /* Report sections */

        .report-section {
            background: #111827;
            border: 1px solid #1e293b;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.20);
        }

        .report-section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .report-section-header h2 {
            margin: 0;
            color: #f8fafc;
            font-size: 18px;
        }

        .report-section-header span {
            color: #64748b;
            font-size: 12px;
        }

        /* Tables */

        .report-table {
            width: 100%;
            border-collapse: collapse;
        }

        .report-table th {
            background: #1e293b;
            color: #94a3b8;
            border-bottom: 1px solid #334155;
            padding: 14px 16px;
            text-align: left;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .report-table td {
            background: #111827;
            color: #cbd5e1;
            border-bottom: 1px solid #1e293b;
            padding: 15px 16px;
            font-size: 14px;
        }

        .report-table tr:hover td {
            background: #172033;
        }

        .category-name {
            color: #f8fafc;
            font-weight: 600;
        }

        .expense-value {
            color: #f87171 !important;
            font-weight: 600;
        }

        .income-value {
            color: #4ade80 !important;
            font-weight: 600;
        }

        .month-name {
            color: #f8fafc !important;
            font-weight: 600;
        }

        /* Charts */

        .chart-container {
            position: relative;
            width: 100%;
            max-width: 700px;
            height: 350px;
            margin: 0 auto;
        }

        .pie-container {
            max-width: 520px;
            height: 380px;
        }

        /* Empty state */

        .report-empty {
            padding: 35px 20px;
            text-align: center;
            color: #64748b;
        }

        /* Bottom button */

        .report-footer {
            display: flex;
            justify-content: flex-start;
            margin-top: 5px;
            margin-bottom: 20px;
        }

        /* Responsive */

        @media (max-width: 800px) {

            .report-stats {
                grid-template-columns: 1fr;
            }

            .report-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 18px;
            }

            .report-table {
                min-width: 600px;
            }

            .chart-container {
                height: 300px;
            }

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


        <a href="transactions.jsp">

            <span class="nav-icon">▤</span>

            Transactions

        </a>


        <a href="reports.jsp" class="active">

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
                Reports
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


            <!-- HEADER -->

            <div class="report-header">

                <div>

                    <h1>
                        Financial Reports
                    </h1>

                    <p>
                        Understand your income, expenses and financial trends.
                    </p>

                </div>

            </div>


            <!-- ================= SUMMARY ================= -->

            <div class="report-stats">


                <div class="report-stat">

                    <div class="report-stat-label">
                        Total Income
                    </div>

                    <div class="report-stat-value report-income">

                        &#8377;<%= String.format("%.2f", totalIncome) %>

                    </div>

                </div>


                <div class="report-stat">

                    <div class="report-stat-label">
                        Total Expenses
                    </div>

                    <div class="report-stat-value report-expense">

                        &#8377;<%= String.format("%.2f", totalExpense) %>

                    </div>

                </div>


                <div class="report-stat">

                    <div class="report-stat-label">
                        Current Balance
                    </div>

                    <div class="report-stat-value report-balance">

                        &#8377;<%= String.format("%.2f", balance) %>

                    </div>

                </div>


            </div>


            <!-- ================= EXPENSE BY CATEGORY ================= -->

            <div class="report-section">

                <div class="report-section-header">

                    <h2>
                        Expense by Category
                    </h2>

                    <span>
                        Category breakdown
                    </span>

                </div>


                <% if (expenseByCategory.isEmpty()) { %>

                    <div class="report-empty">

                        No expense data available.

                    </div>

                <% } else { %>

                    <div class="table-wrapper">

                        <table class="report-table">

                            <thead>

                                <tr>

                                    <th>
                                        Category
                                    </th>

                                    <th>
                                        Total Expense
                                    </th>

                                </tr>

                            </thead>


                            <tbody>

                            <% for (Transaction transaction : expenseByCategory) { %>

                                <tr>

                                    <td class="category-name">

                                        <%= transaction.getCategoryName() %>

                                    </td>


                                    <td class="expense-value">

                                        &#8377;<%= String.format("%.2f",
                                                transaction.getAmount()) %>

                                    </td>

                                </tr>

                            <% } %>

                            </tbody>

                        </table>

                    </div>

                <% } %>

            </div>


            <!-- ================= EXPENSE CHART ================= -->

            <div class="report-section">

                <div class="report-section-header">

                    <h2>
                        Expense Distribution
                    </h2>

                    <span>
                        By category
                    </span>

                </div>


                <% if (expenseByCategory.isEmpty()) { %>

                    <div class="report-empty">

                        No expense data available for the chart.

                    </div>

                <% } else { %>

                    <div class="chart-container pie-container">

                        <canvas id="expenseChart"></canvas>

                    </div>

                <% } %>

            </div>


            <script>

                const expenseLabels = [

                    <%
                        for (Transaction transaction : expenseByCategory) {
                    %>

                        "<%= transaction.getCategoryName() %>",

                    <%
                        }
                    %>

                ];


                const expenseData = [

                    <%
                        for (Transaction transaction : expenseByCategory) {
                    %>

                        <%= transaction.getAmount() %>,

                    <%
                        }
                    %>

                ];


                const expenseCanvas =
                        document.getElementById('expenseChart');


                if (expenseCanvas) {

                    new Chart(expenseCanvas, {

                        type: 'pie',

                        data: {

                            labels: expenseLabels,

                            datasets: [{

                                label: 'Expenses',

                                data: expenseData

                            }]

                        },

                        options: {

                            responsive: true,

                            maintainAspectRatio: false,

                            plugins: {

                                legend: {

                                    position: 'bottom',

                                    labels: {

                                        color: '#cbd5e1',

                                        padding: 18

                                    }

                                },

                                title: {

                                    display: false

                                }

                            }

                        }

                    });

                }

            </script>


            <!-- ================= MONTHLY SUMMARY ================= -->

            <div class="report-section">

                <div class="report-section-header">

                    <h2>
                        Monthly Income & Expense
                    </h2>

                    <span>
                        Monthly overview
                    </span>

                </div>


                <% if (monthlySummary.isEmpty()) { %>

                    <div class="report-empty">

                        No monthly data available.

                    </div>

                <% } else { %>

                    <div class="table-wrapper">

                        <table class="report-table">

                            <thead>

                                <tr>

                                    <th>
                                        Month
                                    </th>

                                    <th>
                                        Income
                                    </th>

                                    <th>
                                        Expense
                                    </th>

                                </tr>

                            </thead>


                            <tbody>

                            <% for (Transaction transaction : monthlySummary) { %>

                                <tr>

                                    <td class="month-name">

                                        <%= transaction.getDescription() %>

                                    </td>


                                    <td class="income-value">

                                        &#8377;<%= String.format("%.2f",
                                                transaction.getAmount()) %>

                                    </td>


                                    <td class="expense-value">

                                        &#8377;<%= String.format("%.2f",
                                                (double) transaction.getCategoryId()) %>

                                    </td>

                                </tr>

                            <% } %>

                            </tbody>

                        </table>

                    </div>

                <% } %>

            </div>


            <!-- ================= MONTHLY CHART ================= -->

            <div class="report-section">

                <div class="report-section-header">

                    <h2>
                        Monthly Income vs Expense
                    </h2>

                    <span>
                        Financial trend
                    </span>

                </div>


                <% if (monthlySummary.isEmpty()) { %>

                    <div class="report-empty">

                        No monthly data available for the chart.

                    </div>

                <% } else { %>

                    <div class="chart-container">

                        <canvas id="monthlyChart"></canvas>

                    </div>

                <% } %>

            </div>


            <script>

                const monthlyLabels = [

                    <%
                        for (Transaction transaction : monthlySummary) {
                    %>

                        "<%= transaction.getDescription() %>",

                    <%
                        }
                    %>

                ];


                const monthlyIncome = [

                    <%
                        for (Transaction transaction : monthlySummary) {
                    %>

                        <%= transaction.getAmount() %>,

                    <%
                        }
                    %>

                ];


                const monthlyExpense = [

                    <%
                        for (Transaction transaction : monthlySummary) {
                    %>

                        <%= transaction.getCategoryId() %>,

                    <%
                        }
                    %>

                ];


                const monthlyCanvas =
                        document.getElementById('monthlyChart');


                if (monthlyCanvas) {

                    new Chart(monthlyCanvas, {

                        type: 'line',

                        data: {

                            labels: monthlyLabels,

                            datasets: [

                                {

                                    label: 'Income',

                                    data: monthlyIncome,

                                    tension: 0.35,

                                    borderWidth: 2,

                                    pointRadius: 4

                                },

                                {

                                    label: 'Expense',

                                    data: monthlyExpense,

                                    tension: 0.35,

                                    borderWidth: 2,

                                    pointRadius: 4

                                }

                            ]

                        },

                        options: {

                            responsive: true,

                            maintainAspectRatio: false,

                            plugins: {

                                legend: {

                                    position: 'bottom',

                                    labels: {

                                        color: '#cbd5e1',

                                        padding: 18

                                    }

                                }

                            },

                            scales: {

                                x: {

                                    ticks: {

                                        color: '#94a3b8'

                                    },

                                    grid: {

                                        color: 'rgba(148, 163, 184, 0.08)'

                                    }

                                },

                                y: {

                                    beginAtZero: true,

                                    ticks: {

                                        color: '#94a3b8',

                                        callback: function(value) {

                                            return '₹' + value;

                                        }

                                    },

                                    grid: {

                                        color: 'rgba(148, 163, 184, 0.08)'

                                    }

                                }

                            }

                        }

                    });

                }

            </script>


            <!-- ================= FOOTER ACTION ================= -->

            <div class="report-footer">

                <a href="dashboard.jsp"
                   class="btn btn-secondary">

                    ← Back to Dashboard

                </a>

            </div>


        </div>

    </main>

</div>

</body>

</html>