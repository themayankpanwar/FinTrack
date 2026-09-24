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
<script src="js/theme.js"></script>
</body>

</html>