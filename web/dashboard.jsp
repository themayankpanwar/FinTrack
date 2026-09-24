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

<style>

/* =========================================================
   GLOBAL THEME TOGGLE
   ========================================================= */

.theme-toggle {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    border: 1px solid #334155;
    background: #1e293b;
    color: #f8fafc;
    padding: 9px 13px;
    border-radius: 10px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    transition: all 0.2s ease;
}

.theme-toggle:hover {
    background: #334155;
    transform: translateY(-1px);
}

body.light-mode .theme-toggle {
    background: #f8fafc !important;
    color: #334155 !important;
    border-color: #cbd5e1 !important;
    box-shadow: 0 2px 6px rgba(15, 23, 42, 0.05);
}

body.light-mode .theme-toggle:hover {
    background: #e2e8f0 !important;
}

/* =========================================================
   FINTRACK PAGE LIGHT MODE OVERRIDES
   ========================================================= */

body.light-mode .transaction-form-card,
body.light-mode .edit-form-card,
body.light-mode .transaction-card,
body.light-mode .report-section,
body.light-mode .report-stat,
body.light-mode .settings-card {
    background: #ffffff !important;
    color: #1e293b !important;
    border-color: #e5e7eb !important;
    box-shadow: 0 4px 15px rgba(15, 23, 42, 0.05) !important;
}

body.light-mode .form-header h1,
body.light-mode .edit-header h1,
body.light-mode .transaction-header h1,
body.light-mode .report-header h1,
body.light-mode .settings-header h1,
body.light-mode .transaction-card-header h2,
body.light-mode .report-section-header h2,
body.light-mode .settings-card-header h2 {
    color: #111827 !important;
}

body.light-mode .form-header p,
body.light-mode .edit-header p,
body.light-mode .transaction-header p,
body.light-mode .report-header p,
body.light-mode .settings-header p,
body.light-mode .form-note,
body.light-mode .security-note {
    color: #64748b !important;
}

body.light-mode .form-group label {
    color: #334155 !important;
}

body.light-mode .transaction-form-card input,
body.light-mode .transaction-form-card select,
body.light-mode .transaction-form-card textarea,
body.light-mode .edit-form-card input,
body.light-mode .edit-form-card select,
body.light-mode .edit-form-card textarea,
body.light-mode .settings-input {
    background: #ffffff !important;
    color: #1e293b !important;
    border-color: #cbd5e1 !important;
}

body.light-mode .transaction-form-card input::placeholder,
body.light-mode .edit-form-card input::placeholder,
body.light-mode .settings-input::placeholder {
    color: #94a3b8 !important;
}

body.light-mode .currency-symbol {
    color: #64748b !important;
    background: #f8fafc !important;
    border-color: #cbd5e1 !important;
}

body.light-mode .transaction-id {
    background: #f8fafc !important;
    color: #64748b !important;
    border-color: #e2e8f0 !important;
}

body.light-mode .transaction-count,
body.light-mode .report-section-header span {
    color: #64748b !important;
}

body.light-mode .empty-state,
body.light-mode .report-empty {
    color: #64748b !important;
}

body.light-mode .empty-state h3 {
    color: #334155 !important;
}

body.light-mode .empty-icon {
    background: #eff6ff !important;
    color: #2563eb !important;
}

body.light-mode .report-table th {
    background: #f8fafc !important;
    color: #64748b !important;
    border-color: #e2e8f0 !important;
}

body.light-mode .report-table td {
    background: #ffffff !important;
    color: #334155 !important;
    border-color: #eef2f7 !important;
}

body.light-mode .report-table tr:hover td {
    background: #f8fafc !important;
}

body.light-mode .report-stat-label {
    color: #64748b !important;
}

body.light-mode .report-income {
    color: #16a34a !important;
}

body.light-mode .report-expense {
    color: #dc2626 !important;
}

body.light-mode .report-balance {
    color: #2563eb !important;
}

body.light-mode .category-name,
body.light-mode .month-name {
    color: #334155 !important;
}

body.light-mode .expense-value {
    color: #dc2626 !important;
}

body.light-mode .income-value {
    color: #16a34a !important;
}

body.light-mode .report-footer {
    color: #64748b !important;
    border-color: #e5e7eb !important;
}

body.light-mode .settings-icon {
    background: #eff6ff !important;
    color: #2563eb !important;
}

body.light-mode .profile-summary {
    background: #f8fafc !important;
    border-color: #e2e8f0 !important;
}

body.light-mode .profile-avatar {
    background: #dbeafe !important;
    color: #2563eb !important;
}

body.light-mode .profile-info strong {
    color: #111827 !important;
}

body.light-mode .profile-info span {
    color: #64748b !important;
}

body.light-mode .account-row {
    border-color: #e5e7eb !important;
}

body.light-mode .account-label {
    color: #64748b !important;
}

body.light-mode .account-value {
    color: #334155 !important;
}

body.light-mode .settings-button {
    background: #2563eb !important;
    color: #ffffff !important;
}

body.light-mode .settings-button:hover {
    background: #1d4ed8 !important;
}

body.light-mode .success-alert {
    background: #dcfce7 !important;
    color: #166534 !important;
    border-color: #bbf7d0 !important;
}

body.light-mode .error-alert {
    background: #fee2e2 !important;
    color: #991b1b !important;
    border-color: #fecaca !important;
}

/* Keep native controls readable */
body.light-mode option {
    background: #ffffff !important;
    color: #1e293b !important;
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
        
         <button type="button" id="themeToggle" class="theme-toggle">
        ☀️ Light
        </button>


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
<script src="js/theme.js"></script>
</body>
</html>