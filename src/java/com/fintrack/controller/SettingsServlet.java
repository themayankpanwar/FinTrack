package com.fintrack.controller;

import com.fintrack.dao.UserDAO;
import com.fintrack.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SettingsServlet")
public class SettingsServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        String action = request.getParameter("action");


        // ================= UPDATE PROFILE =================

        if ("updateProfile".equals(action)) {

            String fullName = request.getParameter("fullName");

            if (fullName == null || fullName.trim().isEmpty()) {

                response.sendRedirect(
                    "settings.jsp?error=emptyname"
                );

                return;
            }

            fullName = fullName.trim();

            boolean updated = userDAO.updateProfile(
                user.getUserId(),
                fullName
            );

            if (updated) {

                // Update session user object
                user.setFullName(fullName);

                session.setAttribute(
                    "loggedInUser",
                    user
                );

                response.sendRedirect(
                    "settings.jsp?success=profile"
                );

            } else {

                response.sendRedirect(
                    "settings.jsp?error=profile"
                );
            }

            return;
        }


        // ================= CHANGE PASSWORD =================

        if ("changePassword".equals(action)) {

            String currentPassword =
                    request.getParameter("currentPassword");

            String newPassword =
                    request.getParameter("newPassword");

            String confirmPassword =
                    request.getParameter("confirmPassword");


            if (currentPassword == null ||
                newPassword == null ||
                confirmPassword == null ||
                currentPassword.trim().isEmpty() ||
                newPassword.trim().isEmpty() ||
                confirmPassword.trim().isEmpty()) {

                response.sendRedirect(
                    "settings.jsp?error=emptyPassword"
                );

                return;
            }


            // Check new password confirmation
            if (!newPassword.equals(confirmPassword)) {

                response.sendRedirect(
                    "settings.jsp?error=passwordMismatch"
                );

                return;
            }


            // Basic password length validation
            if (newPassword.length() < 6) {

                response.sendRedirect(
                    "settings.jsp?error=shortPassword"
                );

                return;
            }


            boolean changed = userDAO.changePassword(
                user.getUserId(),
                currentPassword,
                newPassword
            );


            if (changed) {

                // Update password in session object
                user.setPassword(newPassword);

                session.setAttribute(
                    "loggedInUser",
                    user
                );

                response.sendRedirect(
                    "settings.jsp?success=password"
                );

            } else {

                response.sendRedirect(
                    "settings.jsp?error=wrongPassword"
                );
            }

            return;
        }


        // Unknown action
        response.sendRedirect("settings.jsp");

    }


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");

            return;
        }

        response.sendRedirect("settings.jsp");
    }
}