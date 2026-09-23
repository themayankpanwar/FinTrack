<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>FinTrack - Create Account</title>

    <link rel="stylesheet" href="css/style.css">

    <style>

        /* =========================================
           REGISTER PAGE
           ========================================= */

        body {
            min-height: 100vh;
            margin: 0;

            background:
                radial-gradient(
                    circle at top left,
                    rgba(37, 99, 235, 0.16),
                    transparent 35%
                ),
                #0b1120;

            display: flex;
            align-items: center;
            justify-content: center;
        }


        .auth-page {
            width: 100%;
            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 30px;
            box-sizing: border-box;
        }


        .auth-container {
            width: 100%;
            max-width: 430px;
        }


        /* Logo */

        .auth-logo {
            text-align: center;
            margin-bottom: 25px;
        }


        .auth-logo-icon {
            width: 54px;
            height: 54px;

            margin: 0 auto 12px;

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

            border-radius: 14px;

            font-size: 25px;
            font-weight: 700;

            box-shadow:
                0 10px 25px rgba(37, 99, 235, 0.30);
        }


        .auth-logo h1 {
            margin: 0;

            color: #f8fafc;

            font-size: 27px;
            font-weight: 700;
        }


        .auth-logo p {
            margin: 7px 0 0;

            color: #64748b;

            font-size: 13px;
        }


        /* Card */

        .auth-card {
            background: #111827;

            border: 1px solid #1e293b;

            border-radius: 18px;

            padding: 32px;

            box-shadow:
                0 25px 60px rgba(0, 0, 0, 0.35);
        }


        .auth-card-header {
            margin-bottom: 25px;
        }


        .auth-card-header h2 {
            margin: 0 0 7px;

            color: #f8fafc;

            font-size: 22px;
        }


        .auth-card-header p {
            margin: 0;

            color: #94a3b8;

            font-size: 13px;
        }


        /* Form */

        .auth-form-group {
            margin-bottom: 18px;
        }


        .auth-form-group label {
            display: block;

            margin-bottom: 8px;

            color: #cbd5e1;

            font-size: 13px;
            font-weight: 600;
        }


        .auth-input {
            width: 100%;

            box-sizing: border-box;

            padding: 13px 14px;

            background: #0f172a;

            border: 1px solid #334155;

            border-radius: 9px;

            color: #f8fafc;

            font-size: 14px;

            outline: none;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease,
                background 0.2s ease;
        }


        .auth-input::placeholder {
            color: #64748b;
        }


        .auth-input:focus {
            border-color: #3b82f6;

            background: #111827;

            box-shadow:
                0 0 0 3px rgba(59, 130, 246, 0.12);
        }


        /* Register button */

        .auth-button {
            width: 100%;

            padding: 13px;

            margin-top: 5px;

            border: none;

            border-radius: 9px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #3b82f6
                );

            color: white;

            font-size: 14px;
            font-weight: 600;

            cursor: pointer;

            transition:
                transform 0.2s ease,
                box-shadow 0.2s ease;
        }


        .auth-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 8px 20px rgba(37, 99, 235, 0.25);
        }


        .auth-button:active {
            transform: translateY(0);
        }


        /* Login link */

        .auth-link {
            margin-top: 22px;

            padding-top: 20px;

            border-top: 1px solid #1e293b;

            text-align: center;

            color: #64748b;

            font-size: 13px;
        }


        .auth-link a {
            color: #60a5fa;

            font-weight: 600;

            text-decoration: none;
        }


        .auth-link a:hover {
            color: #93c5fd;

            text-decoration: underline;
        }


        /* Footer */

        .auth-footer {
            margin-top: 20px;

            text-align: center;

            color: #475569;

            font-size: 11px;
        }


        /* Mobile */

        @media (max-width: 500px) {

            .auth-page {
                padding: 20px;
            }

            .auth-card {
                padding: 25px 20px;
            }

        }

    </style>

</head>


<body>


<div class="auth-page">


    <div class="auth-container">


        <!-- LOGO -->

        <div class="auth-logo">

            <div class="auth-logo-icon">
                F
            </div>

            <h1>
                FinTrack
            </h1>

            <p>
                Personal Finance Management
            </p>

        </div>


        <!-- REGISTER CARD -->

        <div class="auth-card">


            <div class="auth-card-header">

                <h2>
                    Create your account 🚀
                </h2>

                <p>
                    Start managing your finances with FinTrack.
                </p>

            </div>


            <!-- REGISTER FORM -->

            <form action="RegisterServlet" method="post">


                <div class="auth-form-group">

                    <label for="fullName">
                        Full Name
                    </label>

                    <input
                        type="text"
                        id="fullName"
                        name="fullName"
                        class="auth-input"
                        placeholder="Enter your full name"
                        required
                        autocomplete="name">

                </div>


                <div class="auth-form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        class="auth-input"
                        placeholder="Enter your email"
                        required
                        autocomplete="email">

                </div>


                <div class="auth-form-group">

                    <label for="password">
                        Password
                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="auth-input"
                        placeholder="Create a password"
                        required
                        autocomplete="new-password">

                </div>


                <button
                    type="submit"
                    class="auth-button">

                    Create Account

                </button>


            </form>


            <!-- LOGIN LINK -->

            <div class="auth-link">

                Already have an account?

                <a href="login.jsp">
                    Login
                </a>

            </div>


        </div>


        <div class="auth-footer">

            © FinTrack • Personal Finance Management

        </div>


    </div>


</div>


</body>

</html>