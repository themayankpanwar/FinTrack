package com.fintrack.dao;

import com.fintrack.model.Transaction;
import com.fintrack.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    // Add a new transaction
    public boolean addTransaction(Transaction transaction) {

        String sql = "INSERT INTO transactions "
                   + "(user_id, category_id, amount, description, transaction_date) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, transaction.getUserId());
            statement.setInt(2, transaction.getCategoryId());
            statement.setDouble(3, transaction.getAmount());
            statement.setString(4, transaction.getDescription());
            statement.setDate(5, transaction.getTransactionDate());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all transactions for a user
    public List<Transaction> getTransactionsByUser(int userId) {

    List<Transaction> transactions = new ArrayList<>();

    String sql = "SELECT t.transaction_id, t.user_id, "
           + "t.category_id, t.amount, t.description, "
           + "t.transaction_date, c.category_name "
           + "FROM transactions t "
           + "INNER JOIN categories c "
           + "ON t.category_id = c.category_id "
           + "WHERE t.user_id = ? "
           + "ORDER BY t.transaction_date DESC";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {

            Transaction transaction = new Transaction();

            transaction.setTransactionId(
                    resultSet.getInt("transaction_id"));

            transaction.setUserId(
                    resultSet.getInt("user_id"));

            transaction.setCategoryId(
                    resultSet.getInt("category_id"));
            
            transaction.setCategoryName(
                    resultSet.getString("category_name"));

            transaction.setAmount(
                    resultSet.getDouble("amount"));

            transaction.setDescription(
                    resultSet.getString("description"));

            transaction.setTransactionDate(
                    resultSet.getDate("transaction_date"));

            transactions.add(transaction);
        }

    } catch (SQLException e) {

        e.printStackTrace();
    }

    return transactions;
}
public double getTotalIncome(int userId) {

    double total = 0;

    String sql = "SELECT COALESCE(SUM(t.amount), 0) AS total "
               + "FROM transactions t "
               + "INNER JOIN categories c "
               + "ON t.category_id = c.category_id "
               + "WHERE t.user_id = ? "
               + "AND c.type = 'INCOME'";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            total = resultSet.getDouble("total");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return total;
}
public double getTotalExpense(int userId) {

    double total = 0;

    String sql = "SELECT COALESCE(SUM(t.amount), 0) AS total "
               + "FROM transactions t "
               + "INNER JOIN categories c "
               + "ON t.category_id = c.category_id "
               + "WHERE t.user_id = ? "
               + "AND c.type = 'EXPENSE'";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            total = resultSet.getDouble("total");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return total;
}
public double getBalance(int userId) {

    double income = getTotalIncome(userId);
    double expense = getTotalExpense(userId);

    return income - expense;
}
public boolean deleteTransaction(int transactionId, int userId) {

    String sql = "DELETE FROM transactions "
               + "WHERE transaction_id = ? "
               + "AND user_id = ?";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, transactionId);
        statement.setInt(2, userId);

        return statement.executeUpdate() > 0;

    } catch (SQLException e) {

        e.printStackTrace();
        return false;
    }
}
public Transaction getTransactionById(int transactionId, int userId) {

    Transaction transaction = null;

    String sql = "SELECT transaction_id, user_id, category_id, "
               + "amount, description, transaction_date "
               + "FROM transactions "
               + "WHERE transaction_id = ? "
               + "AND user_id = ?";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, transactionId);
        statement.setInt(2, userId);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {

            transaction = new Transaction();

            transaction.setTransactionId(
                    resultSet.getInt("transaction_id"));

            transaction.setUserId(
                    resultSet.getInt("user_id"));

            transaction.setCategoryId(
                    resultSet.getInt("category_id"));

            transaction.setAmount(
                    resultSet.getDouble("amount"));

            transaction.setDescription(
                    resultSet.getString("description"));

            transaction.setTransactionDate(
                    resultSet.getDate("transaction_date"));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return transaction;
}public boolean updateTransaction(Transaction transaction) {

    String sql = "UPDATE transactions "
               + "SET category_id = ?, "
               + "amount = ?, "
               + "description = ?, "
               + "transaction_date = ? "
               + "WHERE transaction_id = ? "
               + "AND user_id = ?";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, transaction.getCategoryId());
        statement.setDouble(2, transaction.getAmount());
        statement.setString(3, transaction.getDescription());
        statement.setDate(4, transaction.getTransactionDate());
        statement.setInt(5, transaction.getTransactionId());
        statement.setInt(6, transaction.getUserId());

        return statement.executeUpdate() > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
    
}// Get expense summary by category
public List<Transaction> getExpenseByCategory(int userId) {

    List<Transaction> expenses = new ArrayList<>();

    String sql = "SELECT c.category_name, SUM(t.amount) AS total_amount "
               + "FROM transactions t "
               + "INNER JOIN categories c "
               + "ON t.category_id = c.category_id "
               + "WHERE t.user_id = ? "
               + "AND c.type = 'EXPENSE' "
               + "GROUP BY c.category_id, c.category_name "
               + "ORDER BY total_amount DESC";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {

            Transaction transaction = new Transaction();

            transaction.setCategoryName(
                    resultSet.getString("category_name"));

            transaction.setAmount(
                    resultSet.getDouble("total_amount"));

            expenses.add(transaction);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return expenses;
}
public List<Transaction> getMonthlySummary(int userId) {

    List<Transaction> monthlyData = new ArrayList<>();

    String sql = "SELECT DATE_FORMAT(t.transaction_date, '%Y-%m') AS month, " +
                 "SUM(CASE WHEN c.type = 'INCOME' THEN t.amount ELSE 0 END) AS income, " +
                 "SUM(CASE WHEN c.type = 'EXPENSE' THEN t.amount ELSE 0 END) AS expense " +
                 "FROM transactions t " +
                 "JOIN categories c ON t.category_id = c.category_id " +
                 "WHERE t.user_id = ? " +
                 "GROUP BY DATE_FORMAT(t.transaction_date, '%Y-%m') " +
                 "ORDER BY month DESC";

    try (Connection connection = DBConnection.getConnection();
         PreparedStatement statement = connection.prepareStatement(sql)) {

        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {

            Transaction transaction = new Transaction();

            transaction.setDescription(
                    resultSet.getString("month"));

            transaction.setAmount(
                    resultSet.getDouble("income"));

            transaction.setCategoryId(
                    (int) resultSet.getDouble("expense"));

            monthlyData.add(transaction);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return monthlyData;
}}