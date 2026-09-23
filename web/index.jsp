<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FinTrack - Personal Finance Manager</title>

    <style>

        /* ================= RESET ================= */

        * {
            margin: 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
        }

        html,
        body {
            width: 100% !important;
            min-height: 100% !important;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif !important;
            background: #0b1120 !important;
            color: #f8fafc !important;
            overflow-x: hidden !important;
        }


        /* ================= NAVBAR ================= */

        #ft-navbar {
            width: 100% !important;
            height: 76px !important;

            padding: 0 7% !important;

            display: flex !important;
            flex-direction: row !important;

            align-items: center !important;
            justify-content: space-between !important;

            background: #0f172a !important;

            border-bottom: 1px solid #1e293b !important;

            position: relative !important;
            z-index: 100 !important;
        }


        /* ================= BRAND ================= */

        #ft-brand {
            display: flex !important;
            flex-direction: row !important;

            align-items: center !important;

            gap: 10px !important;

            width: auto !important;
            height: auto !important;

            white-space: nowrap !important;
        }


        #ft-logo {
            width: 42px !important;
            height: 42px !important;

            flex-shrink: 0 !important;

            display: flex !important;
            align-items: center !important;
            justify-content: center !important;

            border-radius: 12px !important;

            background: linear-gradient(
                135deg,
                #2563eb,
                #06b6d4
            ) !important;

            position: relative !important;

            box-shadow:
                0 8px 25px rgba(37, 99, 235, 0.35) !important;
        }


        /* Unique FinTrack logo */

        #ft-logo::before {
            content: "" !important;

            width: 22px !important;
            height: 14px !important;

            border-left: 3px solid white !important;
            border-bottom: 3px solid white !important;

            transform: rotate(-45deg) !important;

            position: absolute !important;

            left: 8px !important;
            top: 12px !important;
        }


        #ft-logo::after {
            content: "" !important;

            width: 7px !important;
            height: 7px !important;

            border-radius: 50% !important;

            background: white !important;

            position: absolute !important;

            right: 7px !important;
            top: 7px !important;
        }


        #ft-brand-name {
            display: block !important;

            width: auto !important;

            color: #f8fafc !important;

            font-size: 25px !important;
            font-weight: 750 !important;

            line-height: 1 !important;

            letter-spacing: -1px !important;

            white-space: nowrap !important;
        }


        #ft-brand-name span {
            color: #3b82f6 !important;

            margin: 0 !important;
            padding: 0 !important;
        }


        /* ================= NAVIGATION ================= */

        #ft-navigation {
            display: flex !important;

            flex-direction: row !important;

            align-items: center !important;

            justify-content: flex-end !important;

            gap: 12px !important;

            width: auto !important;
        }


        #ft-navigation a {
            display: inline-flex !important;

            align-items: center !important;
            justify-content: center !important;

            text-decoration: none !important;

            font-size: 14px !important;
            font-weight: 600 !important;

            white-space: nowrap !important;

            transition: 0.25s ease !important;
        }


        #ft-login {
            color: #cbd5e1 !important;

            padding: 11px 18px !important;

            border-radius: 9px !important;
        }


        #ft-login:hover {
            color: white !important;
            background: #1e293b !important;
        }


        #ft-register {
            color: white !important;

            padding: 11px 19px !important;

            border-radius: 9px !important;

            background: linear-gradient(
                135deg,
                #2563eb,
                #3b82f6
            ) !important;

            box-shadow:
                0 7px 20px rgba(37, 99, 235, 0.25) !important;
        }


        #ft-register:hover {
            transform: translateY(-2px) !important;

            box-shadow:
                0 10px 25px rgba(37, 99, 235, 0.35) !important;
        }


        /* ================= HERO ================= */

        #ft-hero {
            width: 100% !important;

            min-height: 570px !important;

            padding: 100px 20px 80px !important;

            display: flex !important;

            flex-direction: column !important;

            align-items: center !important;

            justify-content: center !important;

            text-align: center !important;

            position: relative !important;

            background:
                radial-gradient(
                    circle at 50% 25%,
                    rgba(37, 99, 235, 0.20),
                    transparent 38%
                ) !important;
        }


        #ft-hero-content {
            width: 100% !important;

            max-width: 850px !important;

            margin: 0 auto !important;
        }


        #ft-badge {
            display: inline-flex !important;

            align-items: center !important;

            gap: 8px !important;

            padding: 8px 15px !important;

            margin-bottom: 25px !important;

            border-radius: 50px !important;

            background: rgba(37, 99, 235, 0.10) !important;

            border: 1px solid rgba(59, 130, 246, 0.30) !important;

            color: #60a5fa !important;

            font-size: 13px !important;

            font-weight: 600 !important;
        }


        #ft-dot {
            width: 7px !important;
            height: 7px !important;

            border-radius: 50% !important;

            background: #22c55e !important;

            box-shadow: 0 0 10px #22c55e !important;
        }


        #ft-hero h1 {
            font-size: 58px !important;

            line-height: 1.08 !important;

            font-weight: 750 !important;

            letter-spacing: -2px !important;

            color: #f8fafc !important;

            margin-bottom: 24px !important;
        }


        #ft-hero h1 span {
            color: #3b82f6 !important;
        }


        #ft-description {
            max-width: 650px !important;

            margin: 0 auto !important;

            color: #94a3b8 !important;

            font-size: 18px !important;

            line-height: 1.7 !important;
        }


        /* ================= HERO BUTTONS ================= */

        #ft-actions {
            display: flex !important;

            flex-direction: row !important;

            align-items: center !important;

            justify-content: center !important;

            gap: 12px !important;

            margin-top: 35px !important;
        }


        #ft-actions a {
            display: inline-flex !important;

            align-items: center !important;

            justify-content: center !important;

            min-width: 135px !important;

            padding: 14px 24px !important;

            border-radius: 10px !important;

            text-decoration: none !important;

            font-size: 14px !important;

            font-weight: 600 !important;

            transition: 0.25s ease !important;
        }


        #ft-get-started {
            color: white !important;

            background: linear-gradient(
                135deg,
                #2563eb,
                #3b82f6
            ) !important;

            box-shadow:
                0 10px 30px rgba(37, 99, 235, 0.28) !important;
        }


        #ft-get-started:hover {
            transform: translateY(-2px) !important;
        }


        #ft-hero-login {
            color: #e2e8f0 !important;

            background: #111827 !important;

            border: 1px solid #334155 !important;
        }


        #ft-hero-login:hover {
            background: #1e293b !important;

            transform: translateY(-2px) !important;
        }


        /* ================= FEATURES ================= */

        #ft-features-section {
            width: 100% !important;

            padding: 20px 7% 90px !important;
        }


        #ft-section-title {
            text-align: center !important;

            margin-bottom: 35px !important;
        }


        #ft-section-title h2 {
            color: #f8fafc !important;

            font-size: 28px !important;

            margin-bottom: 10px !important;
        }


        #ft-section-title p {
            color: #64748b !important;

            font-size: 14px !important;
        }


        #ft-features {
            width: 100% !important;

            max-width: 1050px !important;

            margin: 0 auto !important;

            display: grid !important;

            grid-template-columns:
                repeat(3, 1fr) !important;

            gap: 20px !important;
        }


        .ft-feature {
            padding: 28px !important;

            background: #111827 !important;

            border: 1px solid #1e293b !important;

            border-radius: 16px !important;

            transition: 0.25s ease !important;
        }


        .ft-feature:hover {
            transform: translateY(-5px) !important;

            border-color: #334155 !important;

            box-shadow:
                0 15px 35px rgba(0,0,0,0.25) !important;
        }


        .ft-feature-icon {
            width: 48px !important;
            height: 48px !important;

            display: flex !important;

            align-items: center !important;
            justify-content: center !important;

            border-radius: 12px !important;

            background: rgba(37, 99, 235, 0.12) !important;

            font-size: 22px !important;

            margin-bottom: 18px !important;
        }


        .ft-feature h3 {
            color: #f8fafc !important;

            font-size: 17px !important;

            margin-bottom: 10px !important;
        }


        .ft-feature p {
            color: #64748b !important;

            font-size: 14px !important;

            line-height: 1.6 !important;
        }


        /* ================= FOOTER ================= */

        #ft-footer {
            width: 100% !important;

            padding: 25px 7% !important;

            border-top: 1px solid #1e293b !important;

            display: flex !important;

            flex-direction: row !important;

            justify-content: space-between !important;

            align-items: center !important;

            color: #64748b !important;

            font-size: 13px !important;
        }


        /* ================= MOBILE ================= */

        @media (max-width: 768px) {

            #ft-navbar {
                padding: 0 20px !important;
            }

            #ft-navigation {
                gap: 4px !important;
            }

            #ft-login {
                display: none !important;
            }

            #ft-hero {
                min-height: 500px !important;

                padding: 70px 20px 60px !important;
            }

            #ft-hero h1 {
                font-size: 40px !important;

                letter-spacing: -1px !important;
            }

            #ft-description {
                font-size: 16px !important;
            }

            #ft-actions {
                flex-direction: column !important;
            }

            #ft-actions a {
                width: 220px !important;
            }

            #ft-features {
                grid-template-columns: 1fr !important;
            }

            #ft-footer {
                flex-direction: column !important;

                gap: 8px !important;

                text-align: center !important;
            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<header id="ft-navbar">


    <div id="ft-brand">

        <div id="ft-logo"></div>

        <div id="ft-brand-name">
            Fin<span>Track</span>
        </div>

    </div>


    <nav id="ft-navigation">

        <a id="ft-login"
           href="login.jsp">
            Login
        </a>

        <a id="ft-register"
           href="register.jsp">
            Get Started
        </a>

    </nav>


</header>



<!-- ================= HERO ================= -->

<section id="ft-hero">


    <div id="ft-hero-content">


        <div id="ft-badge">

            <span id="ft-dot"></span>

            Smart Personal Finance Management

        </div>


        <h1>

            Take Control of Your
            <span>Finances</span>

        </h1>


        <p id="ft-description">

            FinTrack helps you manage your income,
            track expenses and understand your financial
            activity — all from one simple dashboard.

        </p>


        <div id="ft-actions">

            <a id="ft-get-started"
               href="register.jsp">

                Get Started &nbsp; →

            </a>


            <a id="ft-hero-login"
               href="login.jsp">

                Login

            </a>

        </div>


    </div>


</section>



<!-- ================= FEATURES ================= -->

<section id="ft-features-section">


    <div id="ft-section-title">

        <h2>
            Everything You Need
        </h2>

        <p>
            Simple tools to keep your personal finances organized.
        </p>

    </div>


    <div id="ft-features">


        <div class="ft-feature">

            <div class="ft-feature-icon">
                💰
            </div>

            <h3>
                Track Income
            </h3>

            <p>
                Record and monitor your income sources
                so you always know how much money is coming in.
            </p>

        </div>


        <div class="ft-feature">

            <div class="ft-feature-icon">
                💸
            </div>

            <h3>
                Manage Expenses
            </h3>

            <p>
                Keep track of your spending and understand
                where your money is going.
            </p>

        </div>


        <div class="ft-feature">

            <div class="ft-feature-icon">
                📊
            </div>

            <h3>
                Financial Reports
            </h3>

            <p>
                Visualize your financial activity with
                clear reports and useful charts.
            </p>

        </div>


    </div>

</section>



<!-- ================= FOOTER ================= -->

<footer id="ft-footer">

    <span>
        © 2026 FinTrack
    </span>

    <span>
        Personal Finance Manager
    </span>

</footer>


</body>

</html>