<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.fintrack.model.User"%>
<%@page import="com.fintrack.model.Transaction"%>
<%@page import="com.fintrack.model.Category"%>
<%@page import="com.fintrack.dao.CategoryDAO"%>
<%@page import="java.util.List"%>

<%
    User user =
            (User) session.getAttribute("loggedInUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Transaction transaction =
            (Transaction) request.getAttribute("transaction");

    if (transaction == null) {
        response.sendRedirect("transactions.jsp");
        return;
    }

    CategoryDAO categoryDAO = new CategoryDAO();

    List<Category> incomeCategories =
            categoryDAO.getCategoriesByType("INCOME");

    List<Category> expenseCategories =
            categoryDAO.getCategoriesByType("EXPENSE");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FinTrack - Edit Transaction</title>

    <link rel="stylesheet" href="css/style.css">

    <style>

        /* =========================================
           EDIT TRANSACTION PAGE
           ========================================= */

        .edit-form-card {
            max-width: 760px;
            margin: 0 auto;
            background: #111827;
            border: 1px solid #1e293b;
            border-radius: 18px;
            padding: 32px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
        }

        .edit-header {
            margin-bottom: 30px;
        }

        .edit-header h1 {
            margin: 0 0 8px;
            color: #f8fafc;
            font-size: 28px;
        }

        .edit-header p {
            margin: 0;
            color: #94a3b8;
        }

        .edit-form .form-group {
            margin-bottom: 22px;
        }

        .edit-form label {
            display: block;
            margin-bottom: 8px;
            color: #cbd5e1;
            font-size: 14px;
            font-weight: 600;
        }

        .edit-form input,
        .edit-form select,
        .edit-form textarea {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #334155;
            border-radius: 10px;
            background: #0f172a;
            color: #f8fafc;
            font-size: 14px;
            outline: none;
            transition: 0.2s ease;
        }

        .edit-form input:focus,
        .edit-form select:focus,
        .edit-form textarea:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12);
        }

        .edit-form input::placeholder,
        .edit-form textarea::placeholder {
            color: #64748b;
        }

        .edit-form select option,
        .edit-form select optgroup {
            background: #0f172a;
            color: #f8fafc;
        }

        .edit-form textarea {
            min-height: 110px;
            resize: vertical;
        }

        .amount-wrapper {
            position: relative;
        }

        .currency-symbol {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-weight: 600;
            pointer-events: none;
        }

        .amount-input {
            padding-left: 34px !important;
        }

        .form-note {
            margin-top: 7px;
            color: #64748b;
            font-size: 12px;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .form-actions .btn {
            flex: 1;
        }

        .btn-cancel {
            background: #1e293b;
            color: #cbd5e1;
            border: 1px solid #334155;
        }

        .btn-cancel:hover {
            background: #334155;
            color: #fff;
        }

        .transaction-id {
            display: inline-block;
            margin-bottom: 20px;
            padding: 6px 10px;
            border-radius: 20px;
            background: #1e293b;
            color: #94a3b8;
            font-size: 12px;
        }

        @media (max-width: 700px) {

            .edit-form-card {
                padding: 22px;
            }

            .form-actions {
                flex-direction: column;
            }

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
                Edit Transaction
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


            <div class="edit-form-card">


                <!-- HEADER -->

                <div class="edit-header">

                    <h1>
                        Edit Transaction
                    </h1>

                    <p>
                        Update the details of your transaction.
                    </p>

                </div>


                <div class="transaction-id">

                    Transaction #<%= transaction.getTransactionId() %>

                </div>


                <!-- FORM -->

                <form class="edit-form"
                      action="TransactionServlet"
                      method="post">


                    <input type="hidden"
                           name="action"
                           value="update">


                    <input type="hidden"
                           name="transactionId"
                           value="<%= transaction.getTransactionId() %>">


                    <!-- CATEGORY -->

                    <div class="form-group">

                        <label for="categoryId">
                            Category
                        </label>

                        <select name="categoryId"
                                id="categoryId"
                                required>

                            <option value="">
                                Select category
                            </option>


                            <optgroup label="Income">

                                <% for (Category category : incomeCategories) { %>

                                    <option
                                        value="<%= category.getCategoryId() %>"
                                        <%= category.getCategoryId()
                                            == transaction.getCategoryId()
                                            ? "selected" : "" %>>

                                        <%= category.getCategoryName() %>

                                    </option>

                                <% } %>

                            </optgroup>


                            <optgroup label="Expense">

                                <% for (Category category : expenseCategories) { %>

                                    <option
                                        value="<%= category.getCategoryId() %>"
                                        <%= category.getCategoryId()
                                            == transaction.getCategoryId()
                                            ? "selected" : "" %>>

                                        <%= category.getCategoryName() %>

                                    </option>

                                <% } %>

                            </optgroup>

                        </select>

                    </div>


                    <!-- AMOUNT -->

                    <div class="form-group">

                        <label for="amount">
                            Amount
                        </label>

                        <div class="amount-wrapper">

                            <span class="currency-symbol">
                                ₹
                            </span>

                            <input type="number"
                                   id="amount"
                                   name="amount"
                                   class="amount-input"
                                   step="0.01"
                                   min="0"
                                   value="<%= transaction.getAmount() %>"
                                   required>

                        </div>

                    </div>


                    <!-- DESCRIPTION -->

                    <div class="form-group">

                        <label for="description">
                            Description
                        </label>

                        <textarea id="description"
                                  name="description"
                                  placeholder="Enter transaction description..."><%= transaction.getDescription() == null
                                      ? "" : transaction.getDescription() %></textarea>

                    </div>


                    <!-- DATE -->

                    <div class="form-group">

                        <label for="transactionDate">
                            Transaction Date
                        </label>

                        <input type="date"
                               id="transactionDate"
                               name="transactionDate"
                               value="<%= transaction.getTransactionDate() %>"
                               required>

                    </div>


                    <!-- ACTIONS -->

                    <div class="form-actions">

                        <a href="transactions.jsp"
                           class="btn btn-cancel">

                            Cancel

                        </a>


                        <button type="submit"
                                class="btn btn-primary">

                            ✓ Update Transaction

                        </button>

                    </div>


                </form>

            </div>


        </div>

    </main>

</div>
<script src="js/theme.js"></script>

</body>

</html>