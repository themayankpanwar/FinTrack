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

</body>

</html>