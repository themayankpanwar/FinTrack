package com.fintrack.controller;

import com.fintrack.dao.TransactionDAO;
import com.fintrack.model.Transaction;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fintrack.model.User;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {

    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
            (User) session.getAttribute("loggedInUser");
        
        String action = request.getParameter("action");
        if ("update".equals(action)) {

    int transactionId =
            Integer.parseInt(
                    request.getParameter("transactionId"));

    int categoryId =
            Integer.parseInt(
                    request.getParameter("categoryId"));

    double amount =
            Double.parseDouble(
                    request.getParameter("amount"));

    String description =
            request.getParameter("description");

    Date transactionDate =
            Date.valueOf(
                    request.getParameter("transactionDate"));

    Transaction transaction = new Transaction();

    transaction.setTransactionId(transactionId);
    transaction.setUserId(user.getUserId());
    transaction.setCategoryId(categoryId);
    transaction.setAmount(amount);
    transaction.setDescription(description);
    transaction.setTransactionDate(transactionDate);

    boolean updated =
            transactionDAO.updateTransaction(transaction);

    if (updated) {
        response.sendRedirect("transactions.jsp?updated=1");
    } else {
        response.sendRedirect(
                "edit-transaction.jsp?error=1");
    }

    return;
}

        int categoryId =
            Integer.parseInt(request.getParameter("categoryId"));

        double amount =
            Double.parseDouble(request.getParameter("amount"));

        String description =
            request.getParameter("description");

        Date transactionDate =
            Date.valueOf(request.getParameter("transactionDate"));

        Transaction transaction = new Transaction();

        transaction.setUserId(user.getUserId());
        transaction.setCategoryId(categoryId);
        transaction.setAmount(amount);
        transaction.setDescription(description);
        transaction.setTransactionDate(transactionDate);

        boolean success =
            transactionDAO.addTransaction(transaction);

        if (success) {

            response.sendRedirect("transactions.jsp?success=1");

        } else {

            response.sendRedirect("add-transaction.jsp?error=1");
        }
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

    User user =
            (User) session.getAttribute("loggedInUser");

    String action = request.getParameter("action");

    if ("delete".equals(action)) {

        int transactionId =
                Integer.parseInt(request.getParameter("id"));

        boolean deleted =
                transactionDAO.deleteTransaction(
                        transactionId,
                        user.getUserId());

        if (deleted) {
            response.sendRedirect("transactions.jsp?deleted=1");
        } else {
            response.sendRedirect("transactions.jsp?error=delete");
        }

    } else if ("edit".equals(action)) {

        int transactionId =
                Integer.parseInt(request.getParameter("id"));

        Transaction transaction =
                transactionDAO.getTransactionById(
                        transactionId,
                        user.getUserId());

        if (transaction != null) {

            request.setAttribute(
                    "transaction",
                    transaction);

            request.getRequestDispatcher(
                    "edit-transaction.jsp")
                    .forward(request, response);

        } else {

            response.sendRedirect(
                    "transactions.jsp?error=notfound");
        }

    } else {

        response.sendRedirect("add-transaction.jsp");
    }
}
}