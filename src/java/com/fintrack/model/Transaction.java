package com.fintrack.model;

import java.sql.Date;

public class Transaction {

    private int transactionId;
    private int userId;
    private int categoryId;
    private double amount;
    private String description;
    private Date transactionDate;
    private String categoryName;

    public Transaction() {
    }

    public Transaction(int userId, int categoryId, double amount,
                       String description, Date transactionDate) {

        this.userId = userId;
        this.categoryId = categoryId;
        this.amount = amount;
        this.description = description;
        this.transactionDate = transactionDate;
    }

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
    public String getCategoryName() {
    return categoryName;
    }

    public void setCategoryName(String categoryName) {
    this.categoryName = categoryName;
}
}