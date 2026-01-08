-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 08, 2026 at 01:08 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bankdb`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `transfer_funds`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `transfer_funds` (IN `from_acc` INT, IN `to_acc` INT, IN `amt` DECIMAL(12,2))   BEGIN
    DECLARE sender_balance DECIMAL(12,2);
    START TRANSACTION;

    SELECT balance INTO sender_balance
    FROM accounts
    WHERE account_id = from_acc
    FOR UPDATE;

    IF sender_balance >= amt THEN
        UPDATE accounts SET balance = balance - amt WHERE account_id = from_acc;
        UPDATE accounts SET balance = balance + amt WHERE account_id = to_acc;

        INSERT INTO transactions (account_id, trans_type, amount) VALUES
        (from_acc,'Withdraw',amt),
        (to_acc,'Deposit',amt);

        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `account_type` varchar(50) DEFAULT NULL,
  `balance` decimal(12,2) DEFAULT '0.00',
  `status` varchar(20) DEFAULT 'ACTIVE',
  PRIMARY KEY (`account_id`),
  KEY `client_id` (`client_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`account_id`, `client_id`, `account_type`, `balance`, `status`) VALUES
(1, 1, 'Savings', 12000.00, 'ACTIVE'),
(2, 2, 'Checking', 27000.00, 'ACTIVE'),
(3, 3, 'Savings', 35000.00, 'ACTIVE'),
(4, 4, 'Checking', 23000.00, 'ACTIVE'),
(5, 5, 'Savings', 10000.00, 'ACTIVE'),
(6, 6, 'Checking', 36000.00, 'ACTIVE');

-- --------------------------------------------------------

--
-- Stand-in structure for view `account_summary`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `account_summary`;
CREATE TABLE IF NOT EXISTS `account_summary` (
`account_id` int
,`account_type` varchar(50)
,`balance` decimal(12,2)
,`full_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE IF NOT EXISTS `audit_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `log_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `account_id`, `action`, `log_date`) VALUES
(1, 1, 'Transaction: Withdraw', '2026-01-07 05:14:25'),
(2, 2, 'Transaction: Deposit', '2026-01-07 05:14:25'),
(3, 1, 'Transaction: Deposit', '2026-01-07 05:34:42'),
(4, 1, 'Transaction: Withdraw', '2026-01-07 05:34:42'),
(5, 2, 'Transaction: Deposit', '2026-01-07 05:34:42'),
(6, 2, 'Transaction: Withdraw', '2026-01-07 05:34:42'),
(7, 3, 'Transaction: Deposit', '2026-01-07 05:34:42'),
(8, 3, 'Transaction: Withdraw', '2026-01-07 05:34:42');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
CREATE TABLE IF NOT EXISTS `branches` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`branch_id`, `branch_name`, `location`) VALUES
(1, 'Main Branch', 'Manila'),
(2, 'City Branch', 'Biñan City');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`client_id`),
  KEY `branch_id` (`branch_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `branch_id`, `full_name`, `email`, `phone`, `created_at`) VALUES
(1, 1, 'Arian Mance', 'arian@example.com', '09666876822', '2026-01-07 05:11:42'),
(2, 2, 'Wendelyn Salazar', 'wendelyn@example.com', '09183079258', '2026-01-07 05:11:42'),
(3, 1, 'Taniah Versoza', 'taniah@example.com', '09465003812', '2026-01-07 05:11:42'),
(4, 2, 'Ceejay Bayran', 'ceejay@example.com', '09925485082', '2026-01-07 05:11:42'),
(5, 1, 'Jayboy Casubuan', 'jayboy@example.com', '09202044365', '2026-01-07 05:11:42'),
(6, 2, 'Friscel Rivera', 'friscel@example.com', '09693178832', '2026-01-07 05:11:42');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `trans_type` varchar(20) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `trans_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `account_id`, `trans_type`, `amount`, `trans_date`) VALUES
(1, 1, 'Withdraw', 2000.00, '2026-01-07 05:14:25'),
(2, 2, 'Deposit', 2000.00, '2026-01-07 05:14:25'),
(3, 1, 'Deposit', 5000.00, '2026-01-01 16:00:00'),
(4, 1, 'Withdraw', 2000.00, '2026-01-02 16:00:00'),
(5, 2, 'Deposit', 3000.00, '2026-01-01 16:00:00'),
(6, 2, 'Withdraw', 1500.00, '2026-01-03 16:00:00'),
(7, 3, 'Deposit', 10000.00, '2025-12-31 16:00:00'),
(8, 3, 'Withdraw', 5000.00, '2026-01-04 16:00:00');

--
-- Triggers `transactions`
--
DROP TRIGGER IF EXISTS `trg_after_transaction_log`;
DELIMITER $$
CREATE TRIGGER `trg_after_transaction_log` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    INSERT INTO audit_logs (account_id, action)
    VALUES (NEW.account_id, CONCAT('Transaction: ', NEW.trans_type));
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_update_balance_after_transaction`;
DELIMITER $$
CREATE TRIGGER `trg_update_balance_after_transaction` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    IF NEW.trans_type = 'Deposit' THEN
        UPDATE accounts SET balance = balance + NEW.amount
        WHERE account_id = NEW.account_id;

    ELSEIF NEW.trans_type = 'Withdraw' THEN
        UPDATE accounts SET balance = balance - NEW.amount
        WHERE account_id = NEW.account_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` enum('ADMIN','TELLER') DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin123', 'ADMIN'),
(2, 'teller1', 'teller123', 'TELLER');

-- --------------------------------------------------------

--
-- Structure for view `account_summary`
--
DROP TABLE IF EXISTS `account_summary`;

DROP VIEW IF EXISTS `account_summary`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `account_summary`  AS SELECT `c`.`full_name` AS `full_name`, `a`.`account_id` AS `account_id`, `a`.`account_type` AS `account_type`, `a`.`balance` AS `balance` FROM (`accounts` `a` join `clients` `c` on((`a`.`client_id` = `c`.`client_id`))) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
