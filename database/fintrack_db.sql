-- FinTrack Database
-- Clean database schema for GitHub
-- No personal user or transaction data included

CREATE DATABASE IF NOT EXISTS fintrack_db;
USE fintrack_db;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- Table: users
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS users (
    user_id INT(11) NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id),
    UNIQUE KEY email (email)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------
-- Table: categories
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS categories (
    category_id INT(11) NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    type ENUM('INCOME', 'EXPENSE') NOT NULL,

    PRIMARY KEY (category_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------
-- Default categories
-- --------------------------------------------------------

INSERT INTO categories (category_id, category_name, type) VALUES
(1, 'Salary', 'INCOME'),
(2, 'Freelance', 'INCOME'),
(3, 'Other Income', 'INCOME'),
(4, 'Food', 'EXPENSE'),
(5, 'Transport', 'EXPENSE'),
(6, 'Shopping', 'EXPENSE'),
(7, 'Bills', 'EXPENSE'),
(8, 'Education', 'EXPENSE'),
(9, 'Entertainment', 'EXPENSE'),
(10, 'Other Expense', 'EXPENSE');


-- --------------------------------------------------------
-- Table: transactions
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT(11) NOT NULL AUTO_INCREMENT,
    user_id INT(11) NOT NULL,
    category_id INT(11) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    description VARCHAR(255) DEFAULT NULL,
    transaction_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (transaction_id),

    KEY user_id (user_id),
    KEY category_id (category_id),

    CONSTRAINT transactions_ibfk_1
        FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT transactions_ibfk_2
        FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_general_ci;