<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.fintrack.model.User"%>

<%
    // Get logged-in user
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    // Protect Settings page
    if (loggedInUser == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Settings - FinTrack</title>

    <link rel="stylesheet"
          href="css/style.css">


    <style>

        /* ================= SETTINGS PAGE ================= */

        .settings-container {
            max-width: 1100px;
            margin: 0 auto;
        }


        .settings-header {
            margin-bottom: 25px;
        }


        .settings-header h1 {
            margin: 0 0 6px 0;
            color: #f8fafc;
            font-size: 28px;
        }


        .settings-header p {
            margin: 0;
            color: #64748b;
            font-size: 14px;
        }


        /* ================= ALERTS ================= */

        .settings-alert {
            padding: 13px 16px;
            border-radius: 10px;
            margin-bottom: 20px;

            font-size: 14px;
            font-weight: 500;
        }


        .success-alert {
            background: rgba(34, 197, 94, 0.10);
            border: 1px solid rgba(34, 197, 94, 0.25);
            color: #4ade80;
        }


        .error-alert {
            background: rgba(239, 68, 68, 0.10);
            border: 1px solid rgba(239, 68, 68, 0.25);
            color: #f87171;
        }


        /* ================= SETTINGS GRID ================= */

        .settings-grid {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 20px;
        }


        .settings-card {
            background: #111827;

            border: 1px solid #1e293b;

            border-radius: 16px;

            padding: 25px;

            box-shadow:
                0 10px 25px rgba(0, 0, 0, 0.12);
        }


        .settings-card.full-width {
            grid-column: 1 / -1;
        }


        /* ================= CARD HEADER ================= */

        .settings-card-header {
            display: flex;

            align-items: center;

            gap: 14px;

            margin-bottom: 24px;
        }


        .settings-icon {
            width: 45px;
            height: 45px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background:
                rgba(37, 99, 235, 0.12);

            font-size: 21px;
        }


        .settings-card-header h2 {
            margin: 0 0 4px 0;

            color: #f8fafc;

            font-size: 18px;
        }


        .settings-card-header p {
            margin: 0;

            color: #64748b;

            font-size: 12px;
        }


        /* ================= PROFILE ================= */

        .profile-summary {
            display: flex;

            align-items: center;

            gap: 15px;

            margin-bottom: 25px;

            padding: 15px;

            background: #0f172a;

            border: 1px solid #1e293b;

            border-radius: 12px;
        }


        .profile-avatar {
            width: 50px;
            height: 50px;

            border-radius: 50%;

            display: flex;

            align-items: center;
            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            color: white;

            font-size: 19px;

            font-weight: 700;

            flex-shrink: 0;
        }


        .profile-info h3 {
            margin: 0 0 4px 0;

            color: #f8fafc;

            font-size: 15px;
        }


        .profile-info p {
            margin: 0;

            color: #64748b;

            font-size: 13px;
        }


        /* ================= FORM ================= */

        .form-group {
            margin-bottom: 18px;
        }


        .form-group label {
            display: block;

            margin-bottom: 7px;

            color: #cbd5e1;

            font-size: 13px;

            font-weight: 600;
        }


        .settings-input {
            width: 100%;

            padding: 12px 13px;

            border-radius: 9px;

            border: 1px solid #334155;

            background: #0f172a;

            color: #f8fafc;

            font-size: 14px;

            outline: none;

            transition: 0.2s;
        }


        .settings-input:focus {
            border-color: #3b82f6;

            box-shadow:
                0 0 0 3px
                rgba(59, 130, 246, 0.10);
        }


        .settings-input:disabled {
            color: #64748b;

            cursor: not-allowed;

            background: #0b1120;
        }


        /* ================= BUTTON ================= */

        .settings-button {
            border: none;

            padding: 12px 20px;

            border-radius: 9px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            color: white;

            font-size: 13px;

            font-weight: 600;

            cursor: pointer;

            transition: 0.25s;
        }


        .settings-button:hover {
            transform: translateY(-1px);

            box-shadow:
                0 8px 20px
                rgba(37, 99, 235, 0.25);
        }


        /* ================= ACCOUNT INFO ================= */

        .account-row {
            display: flex;

            justify-content: space-between;

            align-items: center;

            padding: 15px 0;

            border-bottom: 1px solid #1e293b;
        }


        .account-row:last-child {
            border-bottom: none;
        }


        .account-label {
            color: #64748b;

            font-size: 13px;
        }


        .account-value {
            color: #e2e8f0;

            font-size: 14px;

            font-weight: 500;
        }


        /* ================= SECURITY NOTE ================= */

        .security-note {
            margin-top: 15px;

            padding: 12px;

            border-radius: 9px;

            background:
                rgba(245, 158, 11, 0.08);

            border: 1px solid
                rgba(245, 158, 11, 0.18);

            color: #fbbf24;

            font-size: 12px;

            line-height: 1.5;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 800px) {

            .settings-grid {
                grid-template-columns: 1fr;
            }

            .settings-card.full-width {
                grid-column: auto;
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
                $
            </div>

            <div class="logo-text">
                Fin<span>Track</span>
            </div>

        </div>


        <div class="nav-title">
            MAIN MENU
        </div>


        <a href="dashboard.jsp">

            <span>▦</span>

            Dashboard

        </a>


        <a href="add-transaction.jsp">

            <span>＋</span>

            Add Transaction

        </a>


        <a href="transactions.jsp">

            <span>↔</span>

            Transactions

        </a>


        <a href="reports.jsp">

            <span>◔</span>

            Reports

        </a>


        <a href="settings.jsp"
           class="active">

            <span>⚙</span>

            Settings

        </a>


        
<button type="button" id="themeToggle" class="theme-toggle">
    ☀️ Light
</button>

        <div class="sidebar-spacer"></div>


        <a href="LogoutServlet">

            <span>↪</span>

            Logout

        </a>


    </aside>



    <!-- ================= MAIN CONTENT ================= -->

    <main class="main-content">


        <!-- TOPBAR -->

        <header class="topbar">


            <div class="topbar-title">

                Settings

            </div>


            <div class="user-info">

                <div class="user-avatar">

                    <%= loggedInUser.getFullName()
                            .substring(0, 1)
                            .toUpperCase() %>

                </div>


                <div>

                    <strong>
                        <%= loggedInUser.getFullName() %>
                    </strong>

                </div>

            </div>


        </header>



        <!-- PAGE CONTENT -->

        <div class="page-content">


            <div class="settings-container">


                <!-- PAGE HEADER -->

                <div class="settings-header">

                    <h1>
                        Settings
                    </h1>

                    <p>
                        Manage your profile and account security.
                    </p>

                </div>



                <!-- ================= ALERTS ================= -->

                <%

                    String success =
                            request.getParameter("success");

                    String error =
                            request.getParameter("error");

                    if ("profile".equals(success)) {

                %>

                    <div class="settings-alert success-alert">

                        ✓ Profile updated successfully.

                    </div>

                <%

                    }

                    if ("password".equals(success)) {

                %>

                    <div class="settings-alert success-alert">

                        ✓ Password changed successfully.

                    </div>

                <%

                    }

                    if ("emptyname".equals(error)) {

                %>

                    <div class="settings-alert error-alert">

                        ✕ Full name cannot be empty.

                    </div>

                <%

                    }

                    if ("profile".equals(error)) {

                %>

                    <div class="settings-alert error-alert">

                        ✕ Unable to update profile.

                    </div>

                <%

                    }

                    if ("emptyPassword".equals(error)) {

                %>

                    <div class="settings-alert error-alert">

                        ✕ Please fill in all password fields.

                    </div>

                <%

                    }

                    if ("passwordMismatch".equals(error)) {

                %>

                    <div class="settings-alert error-alert">

                        ✕ New password and confirmation do not match.

                    </div>

                <%

                    }

                    if ("shortPassword".equals(error)) {

                %>

                    <div class="settings-alert error-alert">

                        ✕ New password must contain at least 6 characters.

                    </div>

                <%

                    }

                    if ("wrongPassword".equals(error)) {

                %>

                    <div class="settings-alert error-alert">

                        ✕ Current password is incorrect.

                    </div>

                <%

                    }

                %>



                <!-- ================= SETTINGS GRID ================= -->

                <div class="settings-grid">



                    <!-- ================= PROFILE CARD ================= -->

                    <div class="settings-card">


                        <div class="settings-card-header">

                            <div class="settings-icon">
                                👤
                            </div>

                            <div>

                                <h2>
                                    Profile
                                </h2>

                                <p>
                                    Manage your personal information
                                </p>

                            </div>

                        </div>



                        <div class="profile-summary">


                            <div class="profile-avatar">

                                <%= loggedInUser.getFullName()
                                        .substring(0, 1)
                                        .toUpperCase() %>

                            </div>


                            <div class="profile-info">

                                <h3>
                                    <%= loggedInUser.getFullName() %>
                                </h3>

                                <p>
                                    <%= loggedInUser.getEmail() %>
                                </p>

                            </div>


                        </div>



                        <form action="SettingsServlet"
                              method="post">


                            <input type="hidden"
                                   name="action"
                                   value="updateProfile">


                            <div class="form-group">

                                <label>
                                    Full Name
                                </label>

                                <input
                                    type="text"
                                    name="fullName"
                                    class="settings-input"
                                    value="<%= loggedInUser.getFullName() %>"
                                    required>

                            </div>



                            <div class="form-group">

                                <label>
                                    Email
                                </label>

                                <input
                                    type="email"
                                    class="settings-input"
                                    value="<%= loggedInUser.getEmail() %>"
                                    disabled>

                            </div>



                            <button
                                type="submit"
                                class="settings-button">

                                Save Changes

                            </button>


                        </form>


                    </div>



                    <!-- ================= PASSWORD CARD ================= -->

                    <div class="settings-card">


                        <div class="settings-card-header">

                            <div class="settings-icon">
                                🔐
                            </div>

                            <div>

                                <h2>
                                    Security
                                </h2>

                                <p>
                                    Update your account password
                                </p>

                            </div>

                        </div>



                        <form action="SettingsServlet"
                              method="post">


                            <input type="hidden"
                                   name="action"
                                   value="changePassword">


                            <div class="form-group">

                                <label>
                                    Current Password
                                </label>

                                <input
                                    type="password"
                                    name="currentPassword"
                                    class="settings-input"
                                    placeholder="Enter current password"
                                    required>

                            </div>



                            <div class="form-group">

                                <label>
                                    New Password
                                </label>

                                <input
                                    type="password"
                                    name="newPassword"
                                    class="settings-input"
                                    placeholder="Enter new password"
                                    minlength="6"
                                    required>

                            </div>



                            <div class="form-group">

                                <label>
                                    Confirm New Password
                                </label>

                                <input
                                    type="password"
                                    name="confirmPassword"
                                    class="settings-input"
                                    placeholder="Confirm new password"
                                    minlength="6"
                                    required>

                            </div>



                            <button
                                type="submit"
                                class="settings-button">

                                Change Password

                            </button>


                        </form>


                        <div class="security-note">

                            🔒 Use a strong password that you
                            don't use on other websites.

                        </div>


                    </div>



                    <!-- ================= ACCOUNT CARD ================= -->

                    <div class="settings-card full-width">


                        <div class="settings-card-header">

                            <div class="settings-icon">
                                ⚙️
                            </div>

                            <div>

                                <h2>
                                    Account Information
                                </h2>

                                <p>
                                    Details about your FinTrack account
                                </p>

                            </div>

                        </div>



                        <div class="account-row">

                            <span class="account-label">
                                User ID
                            </span>

                            <span class="account-value">
                                #<%= loggedInUser.getUserId() %>
                            </span>

                        </div>



                        <div class="account-row">

                            <span class="account-label">
                                Full Name
                            </span>

                            <span class="account-value">
                                <%= loggedInUser.getFullName() %>
                            </span>

                        </div>



                        <div class="account-row">

                            <span class="account-label">
                                Email Address
                            </span>

                            <span class="account-value">
                                <%= loggedInUser.getEmail() %>
                            </span>

                        </div>


                    </div>


                </div>


            </div>


        </div>


    </main>


</div>
<script src="js/theme.js"></script>

</body>

</html>