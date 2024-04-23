-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 23, 2024 at 04:41 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Bank`
--
CREATE DATABASE IF NOT EXISTS `Bank` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Bank`;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_number` varchar(11) NOT NULL DEFAULT '',
  `branch_name` varchar(20) DEFAULT NULL,
  `balance` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_number`, `branch_name`, `balance`) VALUES
('A-101', 'Downtown', 500),
('A-102', 'Perryridge', 400),
('A-201', 'Brighton', 900),
('A-215', 'Mianus', 700),
('A-217', 'Brighton', 750),
('A-222', 'Redwood', 700),
('A-305', 'Round Hill', 350),
('A-408', 'Perryridge', 1450),
('A-900', NULL, 1250),
('A-999', NULL, 2110);

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loan_number` varchar(11) NOT NULL DEFAULT '',
  `branch_name` varchar(20) DEFAULT NULL,
  `amount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loan_number`, `branch_name`, `amount`) VALUES
('L-11', 'Round Hill', 900),
('L-14', 'Downtown', 1500),
('L-15', 'Perryridge', 1500),
('L-16', 'Perryridge', 1300),
('L-17', 'Downtown', 1000),
('L-23', 'Redwood', 2000),
('L-93', 'Mianus', 500);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_number`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_number`);
--
-- Database: `Crime_database`
--
CREATE DATABASE IF NOT EXISTS `Crime_database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Crime_database`;

-- --------------------------------------------------------

--
-- Table structure for table `Alias`
--

CREATE TABLE `Alias` (
  `Alias_ID` int(6) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Alias` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Alias`
--

INSERT INTO `Alias` (`Alias_ID`, `Criminal_ID`, `Alias`) VALUES
(1, 4, 'Daniel B.'),
(2, 6, 'Steph Brown'),
(3, 7, 'Mark Brown'),
(4, 4, '#1 Python Hater'),
(5, 9, 'Grandpa Rick'),
(6, 2, 'Michael Borczuk'),
(7, 9, 'Richard Astley'),
(8, 1, 'Evil Kanye'),
(9, 4, 'Apple Hater'),
(10, 5, 'Airplane Enthusiast');

-- --------------------------------------------------------

--
-- Table structure for table `Appeals`
--

CREATE TABLE `Appeals` (
  `Appeal_ID` int(5) NOT NULL,
  `Crime_ID` int(9) DEFAULT NULL,
  `Filing_date` date DEFAULT NULL,
  `Hearing_date` date DEFAULT NULL,
  `Status` char(1) DEFAULT 'P'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Crimes`
--

CREATE TABLE `Crimes` (
  `Crime_ID` int(9) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Classification` char(1) DEFAULT NULL,
  `Date_charged` date DEFAULT NULL,
  `Status` char(2) NOT NULL,
  `Hearing_date` date DEFAULT NULL,
  `Appeal_cut_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Crime_charges`
--

CREATE TABLE `Crime_charges` (
  `Charge_ID` int(10) NOT NULL,
  `Crime_ID` int(9) DEFAULT NULL,
  `Crime_code` int(3) DEFAULT NULL,
  `Charge_status` char(2) DEFAULT NULL,
  `Fine_amount` decimal(7,2) DEFAULT NULL,
  `Court_fee` decimal(7,2) DEFAULT NULL,
  `Amount_paid` decimal(7,2) DEFAULT NULL,
  `Pay_due_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Crime_codes`
--

CREATE TABLE `Crime_codes` (
  `Crime_code` int(3) NOT NULL,
  `Code_description` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Crime_officers`
--

CREATE TABLE `Crime_officers` (
  `Crime_ID` int(9) NOT NULL,
  `Officer_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Criminals`
--

CREATE TABLE `Criminals` (
  `Criminal_ID` int(6) NOT NULL,
  `Last` varchar(15) DEFAULT NULL,
  `First` varchar(10) DEFAULT NULL,
  `Street` varchar(30) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zip` char(5) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `V_status` char(1) DEFAULT 'N',
  `P_status` char(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Criminals`
--

INSERT INTO `Criminals` (`Criminal_ID`, `Last`, `First`, `Street`, `City`, `State`, `Zip`, `Phone`, `V_status`, `P_status`) VALUES
(1, 'West', 'Kanye', '42 Rich St', 'Los Angeles', 'CA', '91504', '4455555555', 'Y', 'N'),
(2, 'North', 'Kanye', '42 Evil St', 'Los Angeles', 'CA', '91588', '4455555665', 'Y', 'Y'),
(3, 'South', 'Kanye', '666 St Mary St', 'Dayton', 'OH', '30010', '3355555665', 'N', 'Y'),
(4, 'Katz', 'Daniel', '123 Peace St', 'Staten Island', 'NY', '11103', '9295555665', 'N', 'N'),
(5, 'Swift', 'Taylor', '123 Canal St', 'New York', 'NY', '10003', '6465555665', 'N', 'N'),
(6, 'Brown', 'Stephan', '123 Sunset Highway', 'Los Angeles', 'CA', '90003', '4455555665', 'Y', 'N'),
(7, 'Brown', 'Marcus', '123 Sunset Highway', 'Los Angeles', 'CA', '90003', '4455555666', 'Y', 'N'),
(8, 'Astley', 'Rick', '456 Never Gonna Give U Up Rd', 'San Diego', 'CA', '91003', '4555556666', 'N', 'N'),
(9, 'Sanchez', 'Rick', '45 Seymour Ave', 'San Diego', 'CA', '91003', '4555556665', 'N', 'N'),
(10, 'East', 'Kanye', '42 Poor St', 'Los Angeles', 'CA', '91508', '4455555565', 'Y', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `Officers`
--

CREATE TABLE `Officers` (
  `Officer_ID` int(8) NOT NULL,
  `Last` varchar(15) DEFAULT NULL,
  `First` varchar(10) DEFAULT NULL,
  `Precinct` char(4) NOT NULL,
  `Badge` varchar(14) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `Status` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Prob_officers`
--

CREATE TABLE `Prob_officers` (
  `Prob_ID` int(5) NOT NULL,
  `Last` varchar(15) DEFAULT NULL,
  `First` varchar(10) DEFAULT NULL,
  `Street` varchar(30) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zip` char(5) DEFAULT '0',
  `Phone` char(10) DEFAULT '0',
  `Email` varchar(30) DEFAULT NULL,
  `Status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Sentences`
--

CREATE TABLE `Sentences` (
  `Sentence_ID` int(6) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Type` char(1) DEFAULT NULL,
  `Prob_ID` int(5) DEFAULT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL CHECK (`End_date` > `Start_date`),
  `Violations` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `Username` varchar(30) NOT NULL,
  `Password` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Alias`
--
ALTER TABLE `Alias`
  ADD PRIMARY KEY (`Alias_ID`),
  ADD KEY `Criminal_ID` (`Criminal_ID`);

--
-- Indexes for table `Appeals`
--
ALTER TABLE `Appeals`
  ADD PRIMARY KEY (`Appeal_ID`),
  ADD KEY `Crime_ID` (`Crime_ID`);

--
-- Indexes for table `Crimes`
--
ALTER TABLE `Crimes`
  ADD PRIMARY KEY (`Crime_ID`),
  ADD KEY `Criminal_ID` (`Criminal_ID`);

--
-- Indexes for table `Crime_charges`
--
ALTER TABLE `Crime_charges`
  ADD PRIMARY KEY (`Charge_ID`),
  ADD KEY `Crime_ID` (`Crime_ID`),
  ADD KEY `Crime_code` (`Crime_code`);

--
-- Indexes for table `Crime_codes`
--
ALTER TABLE `Crime_codes`
  ADD PRIMARY KEY (`Crime_code`),
  ADD UNIQUE KEY `Code_description` (`Code_description`);

--
-- Indexes for table `Crime_officers`
--
ALTER TABLE `Crime_officers`
  ADD PRIMARY KEY (`Crime_ID`,`Officer_ID`),
  ADD KEY `Officer_ID` (`Officer_ID`);

--
-- Indexes for table `Criminals`
--
ALTER TABLE `Criminals`
  ADD PRIMARY KEY (`Criminal_ID`);

--
-- Indexes for table `Officers`
--
ALTER TABLE `Officers`
  ADD PRIMARY KEY (`Officer_ID`),
  ADD UNIQUE KEY `Badge` (`Badge`);

--
-- Indexes for table `Prob_officers`
--
ALTER TABLE `Prob_officers`
  ADD PRIMARY KEY (`Prob_ID`);

--
-- Indexes for table `Sentences`
--
ALTER TABLE `Sentences`
  ADD PRIMARY KEY (`Sentence_ID`),
  ADD KEY `Criminal_ID` (`Criminal_ID`),
  ADD KEY `Prob_ID` (`Prob_ID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`Username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Alias`
--
ALTER TABLE `Alias`
  ADD CONSTRAINT `alias_ibfk_1` FOREIGN KEY (`Criminal_ID`) REFERENCES `Criminals` (`Criminal_ID`);

--
-- Constraints for table `Appeals`
--
ALTER TABLE `Appeals`
  ADD CONSTRAINT `appeals_ibfk_1` FOREIGN KEY (`Crime_ID`) REFERENCES `Crimes` (`Crime_ID`);

--
-- Constraints for table `Crimes`
--
ALTER TABLE `Crimes`
  ADD CONSTRAINT `crimes_ibfk_1` FOREIGN KEY (`Criminal_ID`) REFERENCES `Criminals` (`Criminal_ID`);

--
-- Constraints for table `Crime_charges`
--
ALTER TABLE `Crime_charges`
  ADD CONSTRAINT `crime_charges_ibfk_1` FOREIGN KEY (`Crime_ID`) REFERENCES `Crimes` (`Crime_ID`),
  ADD CONSTRAINT `crime_charges_ibfk_2` FOREIGN KEY (`Crime_code`) REFERENCES `Crime_codes` (`Crime_code`);

--
-- Constraints for table `Crime_officers`
--
ALTER TABLE `Crime_officers`
  ADD CONSTRAINT `crime_officers_ibfk_1` FOREIGN KEY (`Crime_ID`) REFERENCES `Crimes` (`Crime_ID`),
  ADD CONSTRAINT `crime_officers_ibfk_2` FOREIGN KEY (`Officer_ID`) REFERENCES `Officers` (`Officer_ID`);

--
-- Constraints for table `Sentences`
--
ALTER TABLE `Sentences`
  ADD CONSTRAINT `sentences_ibfk_1` FOREIGN KEY (`Criminal_ID`) REFERENCES `Criminals` (`Criminal_ID`),
  ADD CONSTRAINT `sentences_ibfk_2` FOREIGN KEY (`Prob_ID`) REFERENCES `Prob_officers` (`Prob_ID`);
--
-- Database: `criminals`
--
CREATE DATABASE IF NOT EXISTS `criminals` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `criminals`;

-- --------------------------------------------------------

--
-- Table structure for table `alias`
--

CREATE TABLE `alias` (
  `Alias_ID` int(6) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Alias` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `alias`
--

INSERT INTO `alias` (`Alias_ID`, `Criminal_ID`, `Alias`) VALUES
(1, 4, 'Daniel B.'),
(2, 6, 'Steph Brown'),
(3, 7, 'Mark Brown'),
(4, 4, '#1 Python Hater'),
(5, 9, 'Grandpa Rick'),
(6, 2, 'Michael Borczuk'),
(7, 9, 'Richard Astley'),
(8, 1, 'Evil Kanye'),
(9, 4, 'Apple Hater'),
(10, 5, 'Airplane Enthusiast');

-- --------------------------------------------------------

--
-- Table structure for table `appeals`
--

CREATE TABLE `appeals` (
  `Appeal_ID` int(5) NOT NULL,
  `Crime_ID` int(9) DEFAULT NULL,
  `Filing_date` date DEFAULT NULL,
  `Hearing_date` date DEFAULT NULL,
  `Status` char(1) DEFAULT 'P'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `appeals`
--

INSERT INTO `appeals` (`Appeal_ID`, `Crime_ID`, `Filing_date`, `Hearing_date`, `Status`) VALUES
(1, 1, '2023-02-15', '2023-03-15', 'P'),
(2, 2, '2023-02-16', '2023-03-16', 'P'),
(3, 3, '2023-02-17', '2023-03-17', 'P'),
(4, 4, '2023-02-18', '2023-03-18', 'P'),
(5, 5, '2023-02-19', '2023-03-19', 'A'),
(6, 6, '2023-02-20', '2023-03-20', 'D'),
(7, 7, '2023-02-21', '2023-03-21', 'P'),
(8, 8, '2023-02-22', '2023-03-22', 'P'),
(10, 10, '2023-02-24', '2023-03-24', 'P');

-- --------------------------------------------------------

--
-- Table structure for table `crimes`
--

CREATE TABLE `crimes` (
  `Crime_ID` int(9) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Classification` char(1) DEFAULT NULL,
  `Date_charged` date DEFAULT NULL,
  `Status` char(2) NOT NULL,
  `Hearing_date` date DEFAULT NULL,
  `Appeal_cut_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `crimes`
--

INSERT INTO `crimes` (`Crime_ID`, `Criminal_ID`, `Classification`, `Date_charged`, `Status`, `Hearing_date`, `Appeal_cut_date`) VALUES
(1, 1, 'M', '2023-01-01', 'NC', '2023-02-01', '2023-03-01'),
(2, 2, 'F', '2023-01-02', 'NC', '2023-02-02', '2023-03-02'),
(3, 3, 'U', '2023-01-03', 'NC', '2023-02-03', '2023-03-03'),
(4, 4, 'M', '2023-01-04', 'NC', '2023-02-04', '2023-03-04'),
(5, 5, 'F', '2023-01-05', 'NC', '2023-02-05', '2023-03-05'),
(6, 6, 'U', '2023-01-06', 'NC', '2023-02-06', '2023-03-06'),
(7, 7, 'M', '2023-01-07', 'NC', '2023-02-07', '2023-03-07'),
(8, 8, 'F', '2023-01-08', 'NC', '2023-02-08', '2023-03-08'),
(10, 10, 'M', '2023-01-10', 'NC', '2023-02-10', '2023-03-10');

--
-- Triggers `crimes`
--
DELIMITER $$
CREATE TRIGGER `delete_crime` BEFORE DELETE ON `crimes` FOR EACH ROW BEGIN
      DELETE FROM  Crime_charges WHERE Crime_ID = OLD.Crime_ID;
      DELETE FROM appeals WHERE Crime_ID = OLD.Crime_ID;
     
DELETE FROM Crime_officers WHERE Crime_ID = OLD.Crime_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `crime_charges`
--

CREATE TABLE `crime_charges` (
  `Charge_ID` int(10) NOT NULL,
  `Crime_ID` int(9) DEFAULT NULL,
  `Crime_code` int(3) DEFAULT NULL,
  `Charge_status` char(2) DEFAULT NULL,
  `Fine_amount` decimal(7,2) DEFAULT NULL,
  `Court_fee` decimal(7,2) DEFAULT NULL,
  `Amount_paid` decimal(7,2) DEFAULT NULL,
  `Pay_due_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `crime_charges`
--

INSERT INTO `crime_charges` (`Charge_ID`, `Crime_ID`, `Crime_code`, `Charge_status`, `Fine_amount`, `Court_fee`, `Amount_paid`, `Pay_due_date`) VALUES
(1, 1, 1, 'A', 500.00, 50.00, 0.00, '2023-02-01'),
(2, 2, 2, 'P', 1000.00, 100.00, 500.00, '2023-02-02'),
(3, 3, 3, 'A', 1500.00, 150.00, 1000.00, '2023-02-03'),
(4, 4, 4, 'P', 2000.00, 200.00, 1500.00, '2023-02-04'),
(5, 5, 5, 'A', 2500.00, 250.00, 2000.00, '2023-02-05'),
(6, 6, 6, 'P', 3000.00, 300.00, 2500.00, '2023-02-06'),
(7, 7, 7, 'A', 3500.00, 350.00, 3000.00, '2023-02-07'),
(8, 8, 8, 'P', 4000.00, 400.00, 3500.00, '2023-02-08'),
(10, 10, 10, 'P', 5000.00, 500.00, 4500.00, '2023-02-10');

-- --------------------------------------------------------

--
-- Table structure for table `crime_codes`
--

CREATE TABLE `crime_codes` (
  `Crime_code` int(3) NOT NULL,
  `Code_description` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `crime_codes`
--

INSERT INTO `crime_codes` (`Crime_code`, `Code_description`) VALUES
(1, 'Arson'),
(4, 'Assault'),
(5, 'Burglary'),
(6, 'Drug possession'),
(2, 'Fraud'),
(10, 'Homicide'),
(9, 'Identity theft'),
(3, 'Robbery'),
(8, 'Shoplifting'),
(7, 'Vandalism');

--
-- Triggers `crime_codes`
--
DELIMITER $$
CREATE TRIGGER `delete_crime_code` BEFORE DELETE ON `crime_codes` FOR EACH ROW BEGIN
          UPDATE Crime_charges SET Crime_code = NULL WHERE Crime_code = OLD.Crime_code;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `crime_officers`
--

CREATE TABLE `crime_officers` (
  `Crime_ID` int(9) NOT NULL,
  `Officer_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `crime_officers`
--

INSERT INTO `crime_officers` (`Crime_ID`, `Officer_ID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `criminals`
--

CREATE TABLE `criminals` (
  `Criminal_ID` int(6) NOT NULL,
  `Last` varchar(15) DEFAULT NULL,
  `First` varchar(10) DEFAULT NULL,
  `Street` varchar(30) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zip` char(5) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `V_status` char(1) DEFAULT 'N',
  `P_status` char(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `criminals`
--

INSERT INTO `criminals` (`Criminal_ID`, `Last`, `First`, `Street`, `City`, `State`, `Zip`, `Phone`, `V_status`, `P_status`) VALUES
(1, 'West', 'Kanye', '42 Rich St', 'Los Angeles', 'CA', '91504', '4455555555', 'Y', 'N'),
(2, 'North', 'Kanye', '42 Evil St', 'Los Angeles', 'CA', '91588', '4455555665', 'Y', 'Y'),
(3, 'South', 'Kanye', '666 St Mary St', 'Dayton', 'OH', '30010', '3355555665', 'N', 'Y'),
(4, 'Katz', 'Daniel', '123 Peace St', 'Staten Island', 'NY', '11103', '9295555665', 'N', 'N'),
(5, 'Swift', 'Taylor', '123 Canal St', 'New York', 'NY', '10003', '6465555665', 'N', 'N'),
(6, 'Brown', 'Stephan', '123 Sunset Highway', 'Los Angeles', 'CA', '90003', '4455555665', 'Y', 'N'),
(7, 'Brown', 'Marcus', '123 Sunset Highway', 'Los Angeles', 'CA', '90003', '4455555666', 'Y', 'N'),
(8, 'Astley', 'Rick', '456 Never Gonna Give U Up Rd', 'San Diego', 'CA', '91003', '4555556666', 'N', 'N'),
(9, 'Sanchez', 'Rick', '45 Seymour Ave', 'San Diego', 'CA', '91003', '4555556665', 'N', 'N'),
(10, 'East', 'Kanye', '42 Poor St', 'Los Angeles', 'CA', '91508', '4455555565', 'Y', 'Y');

--
-- Triggers `criminals`
--
DELIMITER $$
CREATE TRIGGER `delete_criminal` BEFORE DELETE ON `criminals` FOR EACH ROW BEGIN
     DELETE FROM Alias WHERE Criminal_ID  = OLD.Criminal_ID;

      DELETE FROM  Crimes WHERE Criminal_ID = OLD.Criminal_ID;
  DELETE FROM  Sentences   WHERE Criminal_ID = OLD.Criminal_ID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `officers`
--

CREATE TABLE `officers` (
  `Officer_ID` int(8) NOT NULL,
  `Last` varchar(15) DEFAULT NULL,
  `First` varchar(10) DEFAULT NULL,
  `Precinct` char(4) NOT NULL,
  `Badge` varchar(14) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `Status` char(1) DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `officers`
--

INSERT INTO `officers` (`Officer_ID`, `Last`, `First`, `Precinct`, `Badge`, `Phone`, `Status`) VALUES
(1, 'Smith', 'John', '1234', 'ABCD1234', '9876543210', 'A'),
(2, 'Johnson', 'David', '5678', 'EFGH5678', '8765432109', 'A'),
(3, 'Williams', 'Emily', '9101', 'IJKL9101', '7654321098', 'A'),
(4, 'Jones', 'Michael', '1121', 'MNOP1121', '6543210987', 'A'),
(5, 'Brown', 'Jessica', '3141', 'QRST3141', '5432109876', 'A'),
(6, 'Rodriguez', 'Christophe', '5161', 'UVWX5161', '4321098765', 'A'),
(7, 'Martinez', 'Anna', '7181', 'YZAB7181', '3210987654', 'A'),
(8, 'Davis', 'Daniel', '9202', 'CDEF9202', '2109876543', 'A'),
(9, 'Hernandez', 'Matthew', '2332', 'GHIJ2332', '1098765432', 'A'),
(10, 'Garcia', 'Emily', '3443', 'KLMN3443', '0987654321', 'A');

--
-- Triggers `officers`
--
DELIMITER $$
CREATE TRIGGER `delete_officer` BEFORE DELETE ON `officers` FOR EACH ROW BEGIN
  DELETE FROM Crime_officers WHERE Officer_id = OLD.Officer_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `prob_officers`
--

CREATE TABLE `prob_officers` (
  `Prob_ID` int(5) NOT NULL,
  `Last` varchar(15) DEFAULT NULL,
  `First` varchar(10) DEFAULT NULL,
  `Street` varchar(30) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zip` char(5) DEFAULT '0',
  `Phone` char(10) DEFAULT '0',
  `Email` varchar(30) DEFAULT NULL,
  `Status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `prob_officers`
--

INSERT INTO `prob_officers` (`Prob_ID`, `Last`, `First`, `Street`, `City`, `State`, `Zip`, `Phone`, `Email`, `Status`) VALUES
(1, 'Johnson', 'Michael', '456 Oak Street', 'Los Angeles', 'CA', '90001', '1234567890', 'michael.johnson@gmail.com', 'A'),
(2, 'Garcia', 'Maria', '789 Elm Street', 'New York', 'NY', '10001', '0987654321', 'maria.garcia@yahoo.com', 'A'),
(3, 'Martinez', 'David', '123 Pine Street', 'Chicago', 'IL', '60601', '5678901234', 'david.martinez@icloud.com', 'A'),
(4, 'Smith', 'Jennifer', '456 Maple Street', 'Houston', 'TX', '77001', '6789012345', 'jennifer.smith@nyu.edu', 'A'),
(5, 'Williams', 'Jessica', '789 Birch Street', 'Phoenix', 'AZ', '85001', '4567890123', 'jessica.williams@gmail.com', 'A'),
(6, 'Brown', 'Christophe', '123 Cedar Street', 'Philadelphia', 'PA', '19001', '7890123456', 'christopher.brown@gmail.com', 'A'),
(7, 'Jones', 'Matthew', '456 Pineapple Street', 'San Antonio', 'TX', '78201', '8901234567', 'matthew.jones@gmail.com', 'A'),
(8, 'Rodriguez', 'Daniel', '789 Strawberry Street', 'San Diego', 'CA', '92101', '9012345678', 'daniel.rodriguez@gmail.com', 'A'),
(9, 'Davis', 'Emily', '123 Banana Street', 'Dallas', 'TX', '75201', '0123456789', 'emily.davis@gmail.com', 'A'),
(10, 'Hernandez', 'Anna', '456 Orange Street', 'San Jose', 'CA', '95101', '8901234567', 'anna.hernandez@gmail.com', 'A');

--
-- Triggers `prob_officers`
--
DELIMITER $$
CREATE TRIGGER `delete_probation_officer` BEFORE DELETE ON `prob_officers` FOR EACH ROW BEGIN
          UPDATE Sentences SET Prob_ID = NULL WHERE Prob_ID = OLD.Prob_ID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sentences`
--

CREATE TABLE `sentences` (
  `Sentence_ID` int(6) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Type` char(1) DEFAULT NULL,
  `Prob_ID` int(5) DEFAULT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL CHECK (`End_date` > `Start_date`),
  `Violations` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew COLLATE=hebrew_bin;

--
-- Dumping data for table `sentences`
--

INSERT INTO `sentences` (`Sentence_ID`, `Criminal_ID`, `Type`, `Prob_ID`, `Start_date`, `End_date`, `Violations`) VALUES
(1, 1, 'F', 1, '2023-01-01', '2023-06-01', 1),
(2, 2, 'M', 2, '2023-01-02', '2023-06-02', 1),
(3, 3, 'U', 3, '2023-01-03', '2023-06-03', 2),
(4, 4, 'F', 4, '2023-01-04', '2023-06-04', 2),
(5, 5, 'M', 5, '2023-01-05', '2023-06-05', 3),
(6, 6, 'U', 6, '2023-01-06', '2023-06-06', 2),
(7, 7, 'F', 7, '2023-01-07', '2023-06-07', 3),
(8, 8, 'M', 8, '2023-01-08', '2023-06-08', 1),
(9, 9, 'U', 9, '2023-01-09', '2023-06-09', 1),
(10, 10, 'F', 10, '2023-01-10', '2023-06-10', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Username` varchar(30) NOT NULL,
  `Password` varchar(30) DEFAULT NULL,
  `Clearance_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Username`, `Password`, `Clearance_ID`) VALUES
('admin', 'password', 3083);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Username`);
--
-- Database: `hotel`
--
CREATE DATABASE IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hotel`;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `roomno` int(11) NOT NULL,
  `hotelno` char(4) NOT NULL,
  `guestno` char(4) NOT NULL,
  `datefrom` date NOT NULL,
  `dateto` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`roomno`, `hotelno`, `guestno`, `datefrom`, `dateto`) VALUES
(223, 'H437', 'G190', '2023-10-04', '2023-10-06'),
(223, 'H437', 'G879', '2023-09-14', '2023-09-17'),
(345, 'H498', 'G256', '2023-11-30', '2023-12-02'),
(345, 'H498', 'G467', '2023-11-03', '2023-11-05'),
(412, 'H111', 'G256', '2023-08-10', '2023-08-15'),
(412, 'H111', 'G367', '2023-08-18', '2023-08-21'),
(467, 'H498', 'G230', '2023-09-15', '2023-09-18'),
(1001, 'H193', 'G190', '2023-11-15', '2023-11-19'),
(1001, 'H193', 'G367', '2023-09-12', '2023-09-14'),
(1201, 'H193', 'G367', '2023-10-01', '2023-10-06'),
(1267, 'H235', 'G879', '2023-09-05', '2023-09-12');

-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

CREATE TABLE `guest` (
  `guestno` char(4) NOT NULL,
  `guestname` varchar(50) DEFAULT NULL,
  `guestcity` varchar(50) DEFAULT NULL,
  `guestemail` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guest`
--

INSERT INTO `guest` (`guestno`, `guestname`, `guestcity`, `guestemail`) VALUES
('G190', 'Edward Cane', 'London', 'edward_cane@gmail.com'),
('G230', 'Tom Hancock', 'Istanbul', 'tom_hancock@gmail.com'),
('G256', 'Adam Wayne', 'New York', 'adam_wayne@gmail.com'),
('G367', 'Tara Cummings', 'London', 'tara_cummings@gmail.com'),
('G467', 'Robert Swift', 'Istanbul', 'robert_swift@gmail.com'),
('G879', 'Vanessa Parry', 'California', 'vanessa_parry@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotelno` char(4) NOT NULL,
  `hotelname` varchar(35) DEFAULT NULL,
  `hotelcity` varchar(50) DEFAULT NULL,
  `hotelphone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotelno`, `hotelname`, `hotelcity`, `hotelphone`) VALUES
('H111', 'Marriott', 'New York', '123-456-7890'),
('H193', 'Ramada Encore', 'Istanbul', '123-456-7894'),
('H235', 'Hilton', 'New York', '123-456-7891'),
('H432', 'Kempinski', 'Cancun', '123-456-7892'),
('H437', 'Primero', 'Istanbul', '123-456-7895'),
('H498', 'Hyatt Zilara', 'Cancun', '123-456-7893');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `roomno` int(11) NOT NULL,
  `roomtype` char(1) DEFAULT 'N',
  `roomprice` decimal(8,2) DEFAULT NULL,
  `hotelno` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`roomno`, `roomtype`, `roomprice`, `hotelno`) VALUES
(223, 'N', 155.00, 'H437'),
(257, 'N', 140.00, 'H437'),
(313, 'S', 152.25, 'H111'),
(345, 'N', 160.00, 'H498'),
(412, 'N', 152.25, 'H111'),
(467, 'N', 180.00, 'H498'),
(876, 'S', 124.00, 'H432'),
(898, 'S', 124.00, 'H432'),
(1001, 'S', 150.00, 'H193'),
(1201, 'N', 175.00, 'H193'),
(1267, 'N', 175.00, 'H235'),
(1289, 'N', 195.00, 'H235');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`roomno`,`hotelno`,`guestno`,`datefrom`),
  ADD KEY `guestno` (`guestno`);

--
-- Indexes for table `guest`
--
ALTER TABLE `guest`
  ADD PRIMARY KEY (`guestno`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotelno`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`roomno`,`hotelno`),
  ADD KEY `hotelno` (`hotelno`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`roomno`,`hotelno`) REFERENCES `room` (`roomno`, `hotelno`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`guestno`) REFERENCES `guest` (`guestno`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`hotelno`) REFERENCES `hotel` (`hotelno`);
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `COURSE`
--

CREATE TABLE `COURSE` (
  `course_id` decimal(6,0) NOT NULL,
  `call_id` varchar(10) DEFAULT NULL,
  `course_name` varchar(25) DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `COURSE`
--

INSERT INTO `COURSE` (`course_id`, `call_id`, `course_name`, `credits`) VALUES
(1, 'MIS 101', 'Intro. to Info. Systems', 3),
(2, 'MIS 301', 'Systems Analysis', 3),
(3, 'MIS 441', 'Database Management', 3),
(4, 'CS 155', 'Programming in C++', 3),
(5, 'MIS 451', 'Web-Based Systems', 3);

-- --------------------------------------------------------

--
-- Table structure for table `COURSE_SECTION`
--

CREATE TABLE `COURSE_SECTION` (
  `c_sec_id` decimal(6,0) NOT NULL,
  `course_id` decimal(6,0) NOT NULL,
  `term_id` decimal(6,0) NOT NULL,
  `sec_num` decimal(2,0) NOT NULL,
  `f_id` decimal(5,0) DEFAULT NULL,
  `cs_day` varchar(10) DEFAULT NULL,
  `cs_time` time DEFAULT NULL,
  `loc_id` decimal(6,0) DEFAULT NULL,
  `max_enrl` decimal(4,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `COURSE_SECTION`
--

INSERT INTO `COURSE_SECTION` (`c_sec_id`, `course_id`, `term_id`, `sec_num`, `f_id`, `cs_day`, `cs_time`, `loc_id`, `max_enrl`) VALUES
(1000, 1, 4, 1, 2, 'MWF', '10:00:00', 45, 140),
(1001, 1, 4, 2, 3, 'TTH', '09:30:00', 51, 35),
(1002, 1, 4, 3, 3, 'MWF', '08:00:00', 46, 35),
(1003, 2, 4, 1, 4, 'TTH', '11:00:00', 50, 35),
(1004, 2, 5, 2, 4, 'TTH', '14:00:00', 50, 35),
(1005, 3, 5, 1, 1, 'MWF', '09:00:00', 49, 30),
(1006, 3, 5, 2, 1, 'MWF', '10:00:00', 49, 30),
(1007, 4, 5, 1, 5, 'TTH', '08:00:00', 47, 35),
(1008, 5, 5, 1, 2, 'MWF', '14:00:00', 49, 35),
(1009, 5, 5, 2, 2, 'MWF', '15:00:00', 49, 35),
(1010, 1, 6, 1, 1, 'M-F', '08:00:00', 45, 50),
(1011, 2, 6, 1, 2, 'M-F', '08:00:00', 50, 35),
(1012, 3, 6, 1, 3, 'M-F', '09:00:00', 49, 35);

-- --------------------------------------------------------

--
-- Table structure for table `ENROLLMENT`
--

CREATE TABLE `ENROLLMENT` (
  `s_id` decimal(6,0) NOT NULL,
  `c_sec_id` decimal(6,0) NOT NULL,
  `grade` char(1) DEFAULT NULL
) ;

--
-- Dumping data for table `ENROLLMENT`
--

INSERT INTO `ENROLLMENT` (`s_id`, `c_sec_id`, `grade`) VALUES
(100, 1000, 'A'),
(100, 1003, 'A'),
(100, 1005, 'B'),
(100, 1008, 'B'),
(101, 1000, 'C'),
(101, 1004, 'B'),
(101, 1005, 'A'),
(101, 1008, 'B'),
(102, 1000, 'C'),
(102, 1011, NULL),
(102, 1012, NULL),
(103, 1010, NULL),
(103, 1011, NULL),
(104, 1000, 'B'),
(104, 1004, 'C'),
(104, 1008, 'C'),
(104, 1010, NULL),
(104, 1012, NULL),
(105, 1010, NULL),
(105, 1011, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `f_id` decimal(6,0) NOT NULL,
  `f_last` varchar(30) DEFAULT NULL,
  `f_first` varchar(30) DEFAULT NULL,
  `f_mi` char(1) DEFAULT NULL,
  `loc_id` decimal(5,0) DEFAULT NULL,
  `f_phone` varchar(10) DEFAULT NULL,
  `f_rank` varchar(8) DEFAULT NULL,
  `f_pin` decimal(4,0) DEFAULT NULL,
  `f_image` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`f_id`, `f_last`, `f_first`, `f_mi`, `loc_id`, `f_phone`, `f_rank`, `f_pin`, `f_image`) VALUES
(1, 'Cox', 'Kim', 'J', 53, '7155551234', 'ASSO', 1181, NULL),
(2, 'Blanchard', 'John', 'R', 54, '7155559087', 'FULL', 1075, NULL),
(3, 'Williams', 'Jerry', 'F', 56, '7155555412', 'ASST', 8531, NULL),
(4, 'Sheng', 'Laura', 'M', 55, '7155556409', 'INST', 1690, NULL),
(5, 'Brown', 'Philip', 'E', 57, '7155556082', 'ASSO', 9899, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `LOCATION`
--

CREATE TABLE `LOCATION` (
  `loc_id` decimal(6,0) NOT NULL,
  `bldg_code` varchar(10) DEFAULT NULL,
  `room` varchar(6) DEFAULT NULL,
  `capacity` decimal(5,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `LOCATION`
--

INSERT INTO `LOCATION` (`loc_id`, `bldg_code`, `room`, `capacity`) VALUES
(45, 'CR', '101', 150),
(46, 'CR', '202', 40),
(47, 'CR', '103', 35),
(48, 'CR', '105', 35),
(49, 'BUS', '105', 42),
(50, 'BUS', '404', 35),
(51, 'BUS', '421', 35),
(52, 'BUS', '211', 55),
(53, 'BUS', '424', 1),
(54, 'BUS', '402', 1),
(55, 'BUS', '433', 1),
(56, 'LIB', '217', 2),
(57, 'LIB', '222', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

--
-- Dumping data for table `pma__bookmark`
--

INSERT INTO `pma__bookmark` (`id`, `dbase`, `user`, `label`, `query`) VALUES
(1, 'hotel', 'root', 'INSERT', 'INSERT INTO hotel (hotelno,hotelname,hotelcity)\r\nVALUES(\"H111\",\"Marriott\", \"New York\"),\r\n(\"H235\", \"Hilton\", \"New York\"),\r\n(\"H432\", \"Kempinski\", \"Cancun\"),\r\n(\"H498\", \"Hyatt Zilara\", \"Cancun\"),\r\n(\"H193\", \"Ramada Encore\", \"Istanbul\"),\r\n(\"H437\", \"Primero\", \"Istanbul\");\r\n\r\nINSERT INTO room (roomno, hotelno, roomtype, roomprice)\r\nVALUES(313, \"H111\", \"N\", 145.00),\r\n(412, \"H111\", \"N\", 145.00),\r\n(1267, \"H235\", \"N\", 175.00),\r\n(1289, \"H235\", \"N\", 195.00),\r\n(876, \"H432\", \"N\", 124.00),\r\n(898, \"H432\", \"N\", 124.00),\r\n(345, \"H498\", \"N\", 160.00),\r\n(467, \"H498\", \"N\", 180.00),\r\n(1001, \"H193\", \"N\", 150.00),\r\n(1201, \"H193\", \"N\", 175.00),\r\n(257, \"H437\", \"N\", 140.00),\r\n(223, \"H437\", \"N\", 155.00);\r\n\r\n\r\n\r\nINSERT INTO guest (guestno, guestname, guestcity)\r\nVALUES(\"G256\", \"Adam Wayne\", \"New York\"),\r\n(\"G367\", \"Tara Cummings\", \"London\"),\r\n(\"G879\", \"Vanessa Parry\", \"California\"),\r\n(\"G230\", \"Tom Hancock\", \"Istanbul\"),\r\n(\"G467\", \"Robert Swift\", \"Istanbul\"),\r\n(\"G190\", \'Edward Cane\', \"London\");\r\n\r\nINSERT INTO booking(hotelno, guestno, datefrom, dateto, roomno)\r\nVALUES(\"H111\", \"G256\", \"2023-08-10\", \"2023-08-15\", 412),\r\n(\"H111\", \"G367\", \"2023-08-18\", \"2023-08-21\", 412),\r\n(\"H235\", \"G879\", \"2023-09-05\", \"2023-09-12\", 1267),\r\n(\"H498\", \"G230\", \"2023-09-15\", \"2023-09-18\", 467),\r\n(\"H498\", \"G256\", \"2023-11-30\", \"2023-12-02\", 345),\r\n(\"H498\", \"G467\", \"2023-11-03\", \"2023-11-05\", 345),\r\n(\"H193\", \"G190\", \"2023-11-15\", \"2023-11-19\", 1001),\r\n(\"H193\", \"G367\", \"2023-09-12\", \"2023-09-14\", 1001),\r\n(\"H193\", \"G367\", \"2023-10-01\", \"2023-10-06\", 1201),\r\n(\"H437\", \"G190\", \"2023-10-04\", \"2023-10-06\", 223),\r\n(\"H437\", \"G879\", \"2023-09-14\", \"2023-09-17\", 223);\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Dumping data for table `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'table', 'pdf', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"allrows\":\"1\",\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@TABLE@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_columns\":\"something\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Content of table @TABLE@\",\"latex_data_continued_caption\":\"Content of table @TABLE@ (continued)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"xml_structure_or_data\":\"data\",\"xml_export_events\":\"something\",\"xml_export_functions\":\"something\",\"xml_export_procedures\":\"something\",\"xml_export_tables\":\"something\",\"xml_export_triggers\":\"something\",\"xml_export_views\":\"something\",\"xml_export_contents\":\"something\",\"yaml_structure_or_data\":\"data\",\"\":null,\"lock_tables\":null,\"csv_removeCRLF\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"texytext_columns\":null}'),
(2, 'root', 'database', 'CREATE', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"structure_or_data_forced\":\"0\",\"table_select[]\":[\"booking\",\"guest\",\"hotel\",\"room\"],\"table_structure[]\":[\"booking\",\"guest\",\"hotel\",\"room\"],\"table_data[]\":[\"booking\",\"guest\",\"hotel\",\"room\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@DATABASE@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_columns\":\"something\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Structure of table @TABLE@\",\"latex_structure_continued_caption\":\"Structure of table @TABLE@ (continued)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Content of table @TABLE@\",\"latex_data_continued_caption\":\"Content of table @TABLE@ (continued)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"structure_and_data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"structure_and_data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_procedure_function\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"xml_structure_or_data\":\"data\",\"xml_export_events\":\"something\",\"xml_export_functions\":\"something\",\"xml_export_procedures\":\"something\",\"xml_export_tables\":\"something\",\"xml_export_triggers\":\"something\",\"xml_export_views\":\"something\",\"xml_export_contents\":\"something\",\"yaml_structure_or_data\":\"data\",\"\":null,\"lock_tables\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_create_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_simple_view_export\":null,\"sql_view_current_user\":null,\"sql_or_replace_view\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"criminals\",\"table\":\"criminals\"},{\"db\":\"criminals\",\"table\":\"prob_officers\"},{\"db\":\"criminals\",\"table\":\"officers\"},{\"db\":\"criminals\",\"table\":\"users\"},{\"db\":\"criminals\",\"table\":\"appeals\"},{\"db\":\"criminals\",\"table\":\"crimes\"},{\"db\":\"criminals\",\"table\":\"crime_officers\"},{\"db\":\"criminals\",\"table\":\"sentences\"},{\"db\":\"criminals\",\"table\":\"crime_codes\"},{\"db\":\"criminals\",\"table\":\"crime_charges\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'hotel', 'room', '{\"sorted_col\":\"roomprice\"}', '2024-03-11 02:45:13');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-04-23 02:41:26', '{\"Console\\/Mode\":\"collapse\",\"NavigationWidth\":376.5,\"DefaultConnectionCollation\":\"hebrew_bin\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `s_id` decimal(6,0) NOT NULL,
  `s_last` varchar(30) DEFAULT NULL,
  `s_first` varchar(30) DEFAULT NULL,
  `s_mi` char(1) DEFAULT NULL,
  `s_add` varchar(25) DEFAULT NULL,
  `s_city` varchar(20) DEFAULT NULL,
  `s_state` char(2) DEFAULT NULL,
  `s_zip` varchar(9) DEFAULT NULL,
  `s_phone` varchar(10) DEFAULT NULL,
  `s_class` char(2) DEFAULT NULL,
  `s_dob` date DEFAULT NULL,
  `s_pin` decimal(4,0) DEFAULT NULL,
  `f_id` decimal(6,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`s_id`, `s_last`, `s_first`, `s_mi`, `s_add`, `s_city`, `s_state`, `s_zip`, `s_phone`, `s_class`, `s_dob`, `s_pin`, `f_id`) VALUES
(100, 'Miller', 'Sarah', 'M', '144 Windridge Blvd.', 'Eau Claire', 'WI', '54703', '7155559876', 'SR', '1982-07-14', 8891, 1),
(101, 'Umato', 'Brian', 'D', '454 St. John\'s Street', 'Eau Claire', 'WI', '54702', '7155552345', 'SR', '1982-08-19', 1230, 1),
(102, 'Black', 'Daniel', NULL, '8921 Circle Drive', 'Bloomer', 'WI', '54715', '7155553907', 'JR', '1979-10-10', 1613, 1),
(103, 'Mobley', 'Amanda', 'J', '1716 Summit St.', 'Eau Claire', 'WI', '54703', '7155556902', 'SO', '1981-09-24', 1841, 2),
(104, 'Sanchez', 'Ruben', 'R', '1780 Samantha Court', 'Eau Claire', 'WI', '54701', '7155558899', 'SO', '1981-11-20', 4420, 4),
(105, 'Connoly', 'Michael', 'S', '1818 Silver Street', 'Elk Mound', 'WI', '54712', '7155554944', 'FR', '1983-12-04', 9188, 3);

-- --------------------------------------------------------

--
-- Table structure for table `TERM`
--

CREATE TABLE `TERM` (
  `term_id` decimal(6,0) NOT NULL,
  `term_desc` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ;

--
-- Dumping data for table `TERM`
--

INSERT INTO `TERM` (`term_id`, `term_desc`, `status`) VALUES
(1, 'Fall 2002', 'CLOSED'),
(2, 'Spring 2003', 'CLOSED'),
(3, 'Summer 2003', 'CLOSED'),
(4, 'Fall 2003', 'CLOSED'),
(5, 'Spring 2004', 'CLOSED'),
(6, 'Summer 2004', 'OPEN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `COURSE`
--
ALTER TABLE `COURSE`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `COURSE_SECTION`
--
ALTER TABLE `COURSE_SECTION`
  ADD PRIMARY KEY (`c_sec_id`),
  ADD KEY `course_section_cid_fk` (`course_id`),
  ADD KEY `course_section_loc_id_fk` (`loc_id`),
  ADD KEY `course_section_termid_fk` (`term_id`),
  ADD KEY `course_section_fid_fk` (`f_id`);

--
-- Indexes for table `ENROLLMENT`
--
ALTER TABLE `ENROLLMENT`
  ADD PRIMARY KEY (`s_id`,`c_sec_id`),
  ADD KEY `enrollment_csecid_fk` (`c_sec_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `faculty_loc_id_fk` (`loc_id`);

--
-- Indexes for table `LOCATION`
--
ALTER TABLE `LOCATION`
  ADD PRIMARY KEY (`loc_id`);

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`s_id`),
  ADD KEY `student_f_id_fk` (`f_id`);

--
-- Indexes for table `TERM`
--
ALTER TABLE `TERM`
  ADD PRIMARY KEY (`term_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `COURSE_SECTION`
--
ALTER TABLE `COURSE_SECTION`
  ADD CONSTRAINT `course_section_cid_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `course_section_fid_fk` FOREIGN KEY (`f_id`) REFERENCES `faculty` (`f_id`),
  ADD CONSTRAINT `course_section_loc_id_fk` FOREIGN KEY (`loc_id`) REFERENCES `location` (`loc_id`),
  ADD CONSTRAINT `course_section_termid_fk` FOREIGN KEY (`term_id`) REFERENCES `term` (`term_id`);

--
-- Constraints for table `ENROLLMENT`
--
ALTER TABLE `ENROLLMENT`
  ADD CONSTRAINT `enrollment_csecid_fk` FOREIGN KEY (`c_sec_id`) REFERENCES `course_section` (`c_sec_id`),
  ADD CONSTRAINT `enrollment_sid_fk` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`);

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_loc_id_fk` FOREIGN KEY (`loc_id`) REFERENCES `location` (`loc_id`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_f_id_fk` FOREIGN KEY (`f_id`) REFERENCES `faculty` (`f_id`);
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `test`;
--
-- Database: `university`
--
CREATE DATABASE IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `university`;

-- --------------------------------------------------------

--
-- Table structure for table `admitted_students`
--

CREATE TABLE `admitted_students` (
  `st_num` decimal(4,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admitted_students`
--

INSERT INTO `admitted_students` (`st_num`) VALUES
(8);

-- --------------------------------------------------------

--
-- Table structure for table `COURSE`
--

CREATE TABLE `COURSE` (
  `course_id` decimal(6,0) NOT NULL,
  `call_id` varchar(10) DEFAULT NULL,
  `course_name` varchar(25) DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `COURSE`
--

INSERT INTO `COURSE` (`course_id`, `call_id`, `course_name`, `credits`) VALUES
(1, 'MIS 101', 'Intro. to Info. Systems', 3),
(2, 'MIS 301', 'Systems Analysis', 3),
(3, 'MIS 441', 'Database Management', 3),
(4, 'CS 155', 'Programming in C++', 3),
(5, 'MIS 451', 'Web-Based Systems', 3);

-- --------------------------------------------------------

--
-- Table structure for table `COURSE_SECTION`
--

CREATE TABLE `COURSE_SECTION` (
  `c_sec_id` decimal(6,0) NOT NULL,
  `course_id` decimal(6,0) NOT NULL,
  `term_id` decimal(6,0) NOT NULL,
  `sec_num` decimal(2,0) NOT NULL,
  `f_id` decimal(5,0) DEFAULT NULL,
  `cs_day` varchar(10) DEFAULT NULL,
  `cs_time` time DEFAULT NULL,
  `loc_id` decimal(6,0) DEFAULT NULL,
  `max_enrl` decimal(4,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `COURSE_SECTION`
--

INSERT INTO `COURSE_SECTION` (`c_sec_id`, `course_id`, `term_id`, `sec_num`, `f_id`, `cs_day`, `cs_time`, `loc_id`, `max_enrl`) VALUES
(1000, 1, 4, 1, 2, 'MWF', '10:00:00', 45, 140),
(1001, 1, 4, 2, 3, 'TTH', '09:30:00', 51, 35),
(1002, 1, 4, 3, 3, 'MWF', '08:00:00', 46, 35),
(1003, 2, 4, 1, 4, 'TTH', '11:00:00', 50, 35),
(1004, 2, 5, 2, 4, 'TTH', '14:00:00', 50, 35),
(1005, 3, 5, 1, 1, 'MWF', '09:00:00', 49, 30),
(1006, 3, 5, 2, 1, 'MWF', '10:00:00', 49, 30),
(1007, 4, 5, 1, 5, 'TTH', '08:00:00', 47, 35),
(1008, 5, 5, 1, 2, 'MWF', '14:00:00', 49, 35),
(1009, 5, 5, 2, 2, 'MWF', '15:00:00', 49, 35),
(1010, 1, 6, 1, 1, 'M-F', '08:00:00', 45, 50),
(1011, 2, 6, 1, 2, 'M-F', '08:00:00', 50, 35),
(1012, 3, 6, 1, 3, 'M-F', '09:00:00', 49, 35);

-- --------------------------------------------------------

--
-- Table structure for table `ENROLLMENT`
--

CREATE TABLE `ENROLLMENT` (
  `s_id` decimal(6,0) NOT NULL,
  `c_sec_id` decimal(6,0) NOT NULL,
  `grade` char(1) DEFAULT NULL
) ;

--
-- Dumping data for table `ENROLLMENT`
--

INSERT INTO `ENROLLMENT` (`s_id`, `c_sec_id`, `grade`) VALUES
(100, 1000, 'A'),
(100, 1003, 'A'),
(100, 1005, 'B'),
(100, 1008, 'B'),
(101, 1000, 'C'),
(101, 1004, 'B'),
(101, 1005, 'A'),
(101, 1008, 'B'),
(102, 1000, 'C'),
(102, 1011, NULL),
(102, 1012, NULL),
(103, 1010, NULL),
(103, 1011, NULL),
(104, 1000, 'B'),
(104, 1004, 'C'),
(104, 1008, 'C'),
(104, 1010, NULL),
(104, 1012, NULL),
(105, 1010, NULL),
(105, 1011, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `f_id` decimal(6,0) NOT NULL,
  `f_last` varchar(30) DEFAULT NULL,
  `f_first` varchar(30) DEFAULT NULL,
  `f_mi` char(1) DEFAULT NULL,
  `loc_id` decimal(5,0) DEFAULT NULL,
  `f_phone` varchar(10) DEFAULT NULL,
  `f_rank` varchar(8) DEFAULT NULL,
  `f_pin` decimal(4,0) DEFAULT NULL,
  `f_image` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`f_id`, `f_last`, `f_first`, `f_mi`, `loc_id`, `f_phone`, `f_rank`, `f_pin`, `f_image`) VALUES
(1, 'Cox', 'Kim', 'J', 53, '7155551234', 'ASSO', 1181, NULL),
(2, 'Blanchard', 'John', 'R', 54, '7155559087', 'FULL', 1075, NULL),
(3, 'Williams', 'Jerry', 'F', 56, '7155555412', 'ASST', 8531, NULL),
(4, 'Sheng', 'Laura', 'M', 55, '7155556409', 'INST', 1690, NULL),
(5, 'Brown', 'Philip', 'E', 57, '7155556082', 'ASSO', 9899, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `LOCATION`
--

CREATE TABLE `LOCATION` (
  `loc_id` decimal(6,0) NOT NULL,
  `bldg_code` varchar(10) DEFAULT NULL,
  `room` varchar(6) DEFAULT NULL,
  `capacity` decimal(5,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `LOCATION`
--

INSERT INTO `LOCATION` (`loc_id`, `bldg_code`, `room`, `capacity`) VALUES
(45, 'CR', '101', 150),
(46, 'CR', '202', 40),
(47, 'CR', '103', 35),
(48, 'CR', '105', 35),
(49, 'BUS', '105', 42),
(50, 'BUS', '404', 35),
(51, 'BUS', '421', 35),
(52, 'BUS', '211', 55),
(53, 'BUS', '424', 1),
(54, 'BUS', '402', 1),
(55, 'BUS', '433', 1),
(56, 'LIB', '217', 2),
(57, 'LIB', '222', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `s_id` decimal(6,0) NOT NULL,
  `s_last` varchar(30) DEFAULT NULL,
  `s_first` varchar(30) DEFAULT NULL,
  `s_mi` char(1) DEFAULT NULL,
  `s_add` varchar(25) DEFAULT NULL,
  `s_city` varchar(20) DEFAULT NULL,
  `s_state` char(2) DEFAULT NULL,
  `s_zip` varchar(9) DEFAULT NULL,
  `s_phone` varchar(10) DEFAULT NULL,
  `s_class` char(2) DEFAULT NULL,
  `s_dob` date DEFAULT NULL,
  `s_pin` decimal(4,0) DEFAULT NULL,
  `f_id` decimal(6,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`s_id`, `s_last`, `s_first`, `s_mi`, `s_add`, `s_city`, `s_state`, `s_zip`, `s_phone`, `s_class`, `s_dob`, `s_pin`, `f_id`) VALUES
(100, 'Miller', 'Sarah', 'M', '144 Windridge Blvd.', 'Eau Claire', 'WI', '54703', '7155559876', 'SR', '1982-07-14', 8891, 1),
(101, 'Umato', 'Brian', 'D', '454 St. John\'s Street', 'Eau Claire', 'WI', '54702', '7155552345', 'SR', '1982-08-19', 1230, 1),
(102, 'Black', 'Daniel', NULL, '8921 Circle Drive', 'Bloomer', 'WI', '54715', '7155553907', 'JR', '1979-10-10', 1613, 1),
(103, 'Mobley', 'Amanda', 'J', '1716 Summit St.', 'Eau Claire', 'WI', '54703', '7155556902', 'SO', '1981-09-24', 1841, 2),
(104, 'Sanchez', 'Ruben', 'R', '1780 Samantha Court', 'Eau Claire', 'WI', '54701', '7155558899', 'SO', '1981-11-20', 4420, 4),
(105, 'Connoly', 'Michael', 'S', '1818 Silver Street', 'Elk Mound', 'WI', '54712', '7155554944', 'FR', '1983-12-04', 9188, 3),
(106, 'Cruz', 'Ana', 'S', '100 Northern Blvd.', 'Eau Claire', 'WI', '54703', '7154449870', 'SR', '1982-08-13', 8891, 1),
(107, 'Katz', 'Daniel', 'B', '400 St. John\'s Street', 'Eau Claire', 'WI', '54702', '7155552000', 'SR', '1982-04-10', 1230, 1);

--
-- Triggers `student`
--
DELIMITER $$
CREATE TRIGGER `student_watch_dog` AFTER INSERT ON `student` FOR EACH ROW BEGIN
    UPDATE admitted_students
    SET st_num = (SELECT count(s_id) FROM student);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `TERM`
--

CREATE TABLE `TERM` (
  `term_id` decimal(6,0) NOT NULL,
  `term_desc` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ;

--
-- Dumping data for table `TERM`
--

INSERT INTO `TERM` (`term_id`, `term_desc`, `status`) VALUES
(1, 'Fall 2002', 'CLOSED'),
(2, 'Spring 2003', 'CLOSED'),
(3, 'Summer 2003', 'CLOSED'),
(4, 'Fall 2003', 'CLOSED'),
(5, 'Spring 2004', 'CLOSED'),
(6, 'Summer 2004', 'OPEN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `COURSE`
--
ALTER TABLE `COURSE`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `COURSE_SECTION`
--
ALTER TABLE `COURSE_SECTION`
  ADD PRIMARY KEY (`c_sec_id`),
  ADD KEY `course_section_cid_fk` (`course_id`),
  ADD KEY `course_section_loc_id_fk` (`loc_id`),
  ADD KEY `course_section_termid_fk` (`term_id`),
  ADD KEY `course_section_fid_fk` (`f_id`);

--
-- Indexes for table `ENROLLMENT`
--
ALTER TABLE `ENROLLMENT`
  ADD PRIMARY KEY (`s_id`,`c_sec_id`),
  ADD KEY `enrollment_csecid_fk` (`c_sec_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`f_id`),
  ADD KEY `faculty_loc_id_fk` (`loc_id`);

--
-- Indexes for table `LOCATION`
--
ALTER TABLE `LOCATION`
  ADD PRIMARY KEY (`loc_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`s_id`),
  ADD KEY `student_f_id_fk` (`f_id`);

--
-- Indexes for table `TERM`
--
ALTER TABLE `TERM`
  ADD PRIMARY KEY (`term_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `COURSE_SECTION`
--
ALTER TABLE `COURSE_SECTION`
  ADD CONSTRAINT `course_section_cid_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `course_section_fid_fk` FOREIGN KEY (`f_id`) REFERENCES `faculty` (`f_id`),
  ADD CONSTRAINT `course_section_loc_id_fk` FOREIGN KEY (`loc_id`) REFERENCES `location` (`loc_id`),
  ADD CONSTRAINT `course_section_termid_fk` FOREIGN KEY (`term_id`) REFERENCES `term` (`term_id`);

--
-- Constraints for table `ENROLLMENT`
--
ALTER TABLE `ENROLLMENT`
  ADD CONSTRAINT `enrollment_csecid_fk` FOREIGN KEY (`c_sec_id`) REFERENCES `course_section` (`c_sec_id`),
  ADD CONSTRAINT `enrollment_sid_fk` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`);

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_loc_id_fk` FOREIGN KEY (`loc_id`) REFERENCES `location` (`loc_id`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_f_id_fk` FOREIGN KEY (`f_id`) REFERENCES `faculty` (`f_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
