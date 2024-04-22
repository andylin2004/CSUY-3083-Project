-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 22, 2024 at 09:31 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `criminals`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_alias_for_criminal` (`Alias_ID` INT(6), `Criminal_ID` INT(6), `Alias_name` VARCHAR(20))   BEGIN
	INSERT INTO Alias (Alias_ID, Criminal_ID, Alias)
	VALUES (Alias_ID, Criminal_ID, Alias_name);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_appeal` (`Appeal_ID` INT(5), `Crime_ID` INT(9), `Filing_date` DATE, `Hearing_date` DATE, `Status` CHAR(1))   BEGIN
	INSERT INTO Appeals (Appeal_ID, Crime_ID, Filing_date, Hearing_date, Status)
VALUES (Appeal_ID, Crime_ID, Filing_date, Hearing_date, Status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_crime` (`Crime_ID` INT(9), `Criminal_ID` INT(6), `Classification` CHAR(1), `Date_charged` DATE, `Status` CHAR(2), `Hearing_date` DATE, `Appeal_cut_date` DATE)   BEGIN
	INSERT INTO Crimes (Crime_ID, Criminal_ID, Classification, Date_charged, Status, Hearing_date, Appeal_cut_date)
VALUES (Crime_ID, Criminal_ID, Classification, Date_charged, Status, Hearing_date, Appeal_cut_date);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_Crime_charge` (`Charge_ID` INT(10), `Crime_ID` INT(9), `Crime_code` INT(3), `Charge_status` CHAR(2), `Fine_amount` NUMERIC(7,2), `Court_fee` NUMERIC(7,2), `Amount_paid` NUMERIC(7,2), `Pay_due_date` DATE)   BEGIN
	INSERT INTO Crime_charges(Charge_ID, Crime_ID, Crime_code, Charge_status, Fine_amount, Court_fee, Amount_paid, Pay_due_date)
VALUES (Charge_ID, Crime_ID, Crime_code, Charge_status, Fine_amount, Court_fee, Amount_paid, Pay_due_date);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_crime_code` (`Crime_code` INT(3), `Code_description` VARCHAR(30))   BEGIN
	INSERT INTO Crime_codes (Crime_code, Code_description)
	VALUES (Crime_code, Code_description);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_Crime_officer` (`Crime_ID` INT(9), `Officer_ID` INT(8))   BEGIN
	INSERT INTO Crime_officers (Crime_ID, Officer_ID)
VALUES (Crime_ID, Officer_ID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_criminal` (`Criminal_ID` INT(6), `last_name` VARCHAR(15), `first_name` VARCHAR(10), `street` VARCHAR(30), `city` VARCHAR(20), `state` CHAR(2), `zip` CHAR(5), `phone` CHAR(10), `v_status` CHAR(1), `p_status` CHAR(1))   BEGIN
	INSERT INTO Criminals(Criminal_ID, last, first, street, city, state, zip, phone, v_status, p_status)
VALUES(Criminal_ID, last_name, first_name, street, city, state, zip, phone, v_status, p_status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_officer` (`Officer_ID` INT(8), `Last` VARCHAR(15), `First` VARCHAR(10), `Precinct` CHAR(4), `Badge` VARCHAR(14), `Phone` CHAR(10), `Status` CHAR(1))   BEGIN
	INSERT INTO Officers (Officer_ID, Last, First, Precinct, Badge, Phone, Status)
VALUES (Officer_ID, Last, First, Precinct, Badge, Phone, Status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_officer_to_crime` (`Crime_ID` INT(6), `Officer_ID` INT(6))   BEGIN
	INSERT INTO crime_officers(Crime_ID,Officer_ID) 
	VALUES(Crime_ID,Officer_ID);
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_prob_officer` (`Prob_ID` INT(5), `Last` VARCHAR(15), `First` VARCHAR(10), `Street` VARCHAR(30), `City` VARCHAR(20), `State` CHAR(2), `Zip` CHAR(5), `Phone` CHAR(10), `Email` VARCHAR(30), `Status` CHAR(1))   BEGIN
INSERT INTO Prob_officers (Prob_ID, Last, First, Street, City, State, Zip, Phone, Email, Status)
VALUES (Prob_ID, Last, First, Street, City, State, Zip, Phone, Email, Status);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_sentence` (`Sentence_ID` INT(6), `Criminal_ID` INT(6), `Type` CHAR(1), `Prob_ID` INT(5), `Start_date` DATE, `End_date` DATE, `Violations` INT(3))   BEGIN
	INSERT INTO Sentences (Sentence_ID, Criminal_ID, Type, Prob_ID, Start_date, End_date, Violations)
	VALUES (Sentence_ID, Criminal_ID, Type, Prob_ID, Start_date, End_date, Violations);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user` (`Username` VARCHAR(30), `Password` VARCHAR(30), `Clearance_ID` INT)   BEGIN
	INSERT INTO Users(Username, Password, Clearance_ID)
	VALUES (Username, Password, Clearance_ID);

CALL add_user_procedure(Username, Password, Clearance_ID);




END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user_procedure` (IN `new_username` VARCHAR(255), IN `new_password` VARCHAR(255), IN `new_clearance_id` INT)   BEGIN
  -- Insert into the Users table
  INSERT INTO Users (Username, Password, Clearance_id) 
  VALUES (new_username, new_password, new_clearance_id);

  -- Create the user with the given username and password
  SET @sql1 = CONCAT('CREATE USER \'', new_username, '\'@\'%\' IDENTIFIED BY \'', new_password, '\'');
  PREPARE stmt1 FROM @sql1;
  EXECUTE stmt1;

  -- Grant specific privileges based on clearance level
  IF new_clearance_id = 3083 THEN
    SET @sql2 = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON criminals.* TO \'', new_username, '\'@\'%\'');
    PREPARE stmt2 FROM @sql2;
    EXECUTE stmt2;
  ELSE
    SET @sql3 = CONCAT('GRANT SELECT ON criminals.* TO \'', new_username, '\'@\'%\'');
    PREPARE stmt3 FROM @sql3;
    EXECUTE stmt3;
  END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_user` (`username` VARCHAR(50), `password` VARCHAR(50))   BEGIN
SELECT COUNT(*) FROM users u
WHERE username = u.username AND password = u.password;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_user_grant` (IN `username` VARCHAR(255))   BEGIN
DECLARE exit_handler INT;

  -- Construct SQL to drop the specified user
  SET @sql = CONCAT('SHOW GRANTS FOR \'', username, '\'@\'%\'');
  
  -- Prepare and execute the statement
  PREPARE stmt FROM @sql;
  
  -- Try to execute the DROP USER command
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
      SET exit_handler = 1;
    END;
    
    EXECUTE stmt;
  END;
  
  -- Clean up the prepared statement
  DEALLOCATE PREPARE stmt;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAlias` (`A_ID` INT(8))   BEGIN
	DELETE FROM Alias WHERE Alias_ID = A_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAppeals` (`Ap_ID` INT(8))   BEGIN
	DELETE FROM Appeals WHERE Appeal_ID = Ap_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCrimeCharges` (`Ch_ID` INT(8))   BEGIN
	DELETE FROM Crime_charges WHERE Charge_ID = Ch_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCrimeCodes` (`Cc_ID` INT(8))   BEGIN
	DELETE FROM Crime_codes WHERE Crime_code = Cc_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCrimes` (`Cr_ID` INT(8))   BEGIN
	DELETE FROM Crimes WHERE Crime_ID = Cr_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCriminal` (`C_ID` INT(6))   BEGIN
	DELETE FROM Criminals WHERE Criminal_ID = C_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOfficer` (`O_ID` INT(8))   BEGIN
	DELETE FROM Officers WHERE Officer_ID = O_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProb` (`P_ID` INT(8))   BEGIN
	DELETE FROM Prob_officers WHERE Prob_ID = P_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSentences` (`S_ID` INT(8))   BEGIN
	DELETE FROM Sentences WHERE Sentence_ID = S_ID;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `drop_user_procedure` (IN `drop_username` VARCHAR(255))   BEGIN


  -- Construct SQL to drop the specified user
  SET @sql = CONCAT('DROP USER \'', drop_username, '\'@\'%\'');
  
  PREPARE stmt FROM @sql;
  
    
    EXECUTE stmt;
  
  DEALLOCATE PREPARE stmt;

  

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_alias_for_criminal_id` (`Criminal_ID` INT(6))   BEGIN
 SELECT a.alias, a.alias_id
 FROM Alias a
WHERE a.Criminal_ID = Criminal_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_appeals` (`Appeal_ID` VARCHAR(102), `Crime_ID` VARCHAR(102), `Filing_date` VARCHAR(102), `Hearing_date` VARCHAR(102), `Status` VARCHAR(102))   BEGIN
	SET Appeal_ID = CONCAT('%', Appeal_ID, '%');
 SET Crime_ID = CONCAT('%', Crime_ID, '%');
 SET Filing_date = CONCAT('%', Filing_date, '%');
 SET Hearing_date = CONCAT('%', Hearing_date, '%');
 SET Status = CONCAT('%', Status, '%');
 SELECT *
 FROM Appeals a
 WHERE a.Appeal_ID LIKE Appeal_ID
 AND a.Crime_ID LIKE Crime_ID
 AND a.Filing_date LIKE Filing_date
 AND a.Hearing_date LIKE Hearing_date
 AND a.Status LIKE Status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_appeals_by_criminal_id` (`Criminal_ID` INT(6))   BEGIN
	
 SELECT a.*
 FROM Appeals a
 INNER JOIN Crimes c
 ON a.Crime_ID = c.Crime_ID
 WHERE c.Criminal_ID = Criminal_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_charges` (`Charge_ID` VARCHAR(102), `Crime_ID` VARCHAR(102), `Crime_code` VARCHAR(102), `Charge_status` VARCHAR(102), `Fine_amount` VARCHAR(102), `Court_fee` VARCHAR(102), `Amount_paid` VARCHAR(102), `Pay_due_date` VARCHAR(102))   BEGIN
SET Charge_ID = CONCAT('%', Charge_ID, '%');
SET Crime_ID = CONCAT('%', Crime_ID, '%');
SET Crime_code = CONCAT('%', Crime_code, '%');
SET Charge_status = CONCAT('%', Charge_status, '%');
SET Fine_amount = CONCAT('%', Fine_amount, '%');
SET Court_fee = CONCAT('%', Court_fee, '%');
SET Amount_paid = CONCAT('%', Amount_paid, '%');
SET Pay_due_date = CONCAT('%', Pay_due_date, '%');
	SELECT *
	FROM Crime_charges cch
	WHERE cch.Charge_ID LIKE Charge_ID AND cch.Crime_ID LIKE Crime_ID AND cch.Crime_code LIKE Crime_code AND cch.Charge_status LIKE Charge_status AND cch.Fine_amount LIKE Fine_amount AND cch.Court_fee LIKE Court_fee AND cch.Amount_paid LIKE Amount_paid AND cch.Pay_due_date LIKE Pay_due_date;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_charges_by_criminal_id` (`Criminal_ID` INT(6))   BEGIN
	SELECT cch.*
	FROM Crime_charges cch
	INNER JOIN Crimes c
	ON c.Crime_ID = cch.Crime_ID
	WHERE c.Criminal_ID = Criminal_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_crimes` (`Crime_ID` VARCHAR(102), `Criminal_ID` VARCHAR(102), `Classification` VARCHAR(102), `Date_charged` VARCHAR(102), `Status` VARCHAR(102), `Hearing_date` VARCHAR(102), `Appeal_cut_date` VARCHAR(102))   BEGIN
	SET Crime_ID = CONCAT('%', Crime_ID, '%');
	SET Criminal_ID = CONCAT('%', Criminal_ID, '%');
	SET Classification = CONCAT('%', Classification, '%');
	SET Date_charged = CONCAT('%', Date_charged, '%');
	SET Status = CONCAT('%', Status, '%');
	SET Hearing_date = CONCAT('%', Hearing_date, '%');
	SET Appeal_cut_date = CONCAT('%', Appeal_cut_date, '%');
	SELECT c.*, co.Officer_id
	FROM Crimes c
	LEFT JOIN crime_officers co
	ON c.Crime_id = co.Crime_id
	WHERE c.Crime_ID LIKE Crime_ID AND c.Criminal_ID LIKE Criminal_ID AND c.Classification LIKE Classification AND c.Date_charged LIKE Date_charged AND c.Status LIKE Status AND c.Hearing_date LIKE Hearing_date AND c.Appeal_cut_date LIKE Appeal_cut_date;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_criminals` (`Criminal_ID` VARCHAR(102), `last_name` VARCHAR(102), `first_name` VARCHAR(102), `street` VARCHAR(102), `city` VARCHAR(102), `state` VARCHAR(102), `zip` VARCHAR(102), `phone` VARCHAR(102), `v_status` VARCHAR(102), `p_status` VARCHAR(102))   BEGIN
	SET Criminal_ID = CONCAT('%', Criminal_ID, '%');
 SET last_name = CONCAT('%', last_name, '%');
 SET first_name = CONCAT('%', first_name, '%');
 SET street = CONCAT('%', street, '%');
 SET city = CONCAT('%', city, '%');
 SET state = CONCAT('%', state, '%');
 SET zip = CONCAT('%', zip, '%');
 SET phone = CONCAT('%', phone, '%');
 SET v_status = CONCAT('%', v_status, '%');
 SET p_status = CONCAT('%', p_status, '%');
 SELECT c.*
 FROM Criminals c
 WHERE c.Criminal_ID LIKE Criminal_ID
 AND c.Last LIKE last_name
 AND c.First LIKE first_name
 AND c.Street LIKE street
 AND c.City LIKE city
 AND c.State LIKE state
 AND c.Zip LIKE zip
 AND c.Phone LIKE phone
 AND c.V_status LIKE v_status
 AND c.P_status LIKE p_status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_criminal_detailsl` (`Criminal_ID` INT(6))   BEGIN
	SELECT *
	FROM Crimes C
	INNER JOIN Alias a
	ON c.Criminal_ID = a.Criminal_ID
	INNER JOIN Sentences s
ON c.Criminal_ID = s.Criminal_ID
WHERE Criminal_ID = c.Criminal_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_officers` (`Officer_ID` VARCHAR(102), `Last` VARCHAR(102), `First` VARCHAR(102), `Precinct` VARCHAR(102), `Badge` VARCHAR(102), `Phone` VARCHAR(102), `Status` VARCHAR(102))   BEGIN
SET Officer_ID = CONCAT('%', Officer_ID, '%');
SET Last = CONCAT('%', Last, '%');
SET First = CONCAT('%', First, '%');
SET Precinct = CONCAT('%', Precinct, '%');
SET Badge = CONCAT('%', Badge, '%');
SET Phone = CONCAT('%', Phone, '%');
SET Status = CONCAT('%', Status, '%');
	SELECT *
	FROM Officers o
WHERE o.Last LIKE Last AND o.First LIKE First AND o.Precinct LIKE Precinct AND o.Badge LIKE Badge AND o.Phone LIKE Phone AND o.Status LIKE Status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prob_officers` (`Prob_ID` VARCHAR(102), `Last` VARCHAR(102), `First` VARCHAR(102), `Street` VARCHAR(102), `City` VARCHAR(102), `State` VARCHAR(102), `Zip` VARCHAR(102), `Phone` VARCHAR(102), `Email` VARCHAR(102), `Status` VARCHAR(102))   BEGIN
	SET Prob_ID = CONCAT('%', Prob_ID, '%');
SET Last = CONCAT('%', Last, '%');
SET First = CONCAT('%', First, '%');
SET Street = CONCAT('%', Street, '%');
SET City = CONCAT('%', City, '%');
SET State = CONCAT('%', State, '%');
SET Zip = CONCAT('%', Zip, '%');
SET Phone = CONCAT('%', Phone, '%');
SET Email = CONCAT('%', Email, '%');
SET Status = CONCAT('%', Status, '%');

	SELECT *
	FROM Prob_officers po
	WHERE po.Prob_ID LIKE Prob_ID AND po.Last LIKE Last AND po.First LIKE First AND po.Street LIKE Street AND po.City LIKE City AND po.State LIKE State AND po.Zip LIKE Zip AND po.Phone LIKE Phone and po.Email LIKE Email AND po.Status LIKE Status;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sentences` (`Sentence_ID` VARCHAR(102), `Criminal_ID` VARCHAR(102), `Type` VARCHAR(102), `Prob_ID` VARCHAR(102), `Start_date` VARCHAR(102), `End_date` VARCHAR(102), `Violations` VARCHAR(102))   BEGIN
	SET Sentence_ID = CONCAT('%', Sentence_ID, '%');
SET Criminal_ID = CONCAT('%', Criminal_ID, '%');
SET Type = CONCAT('%', Type, '%');
SET Prob_ID = CONCAT('%', Prob_ID, '%');
SET Start_date = CONCAT('%', Start_date, '%');
SET End_date = CONCAT('%', End_date, '%');
SET Violations = CONCAT('%', Violations, '%');
	SELECT *
	FROM Sentences s
	WHERE s.Sentence_ID LIKE Sentence_ID AND s.Criminal_ID LIKE Criminal_ID AND s.Type LIKE Type AND s.Prob_ID LIKE Prob_ID and s.Start_date LIKE Start_date AND s.End_date LIKE End_date AND s.Violations LIKE Violations;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_alias` (`Alias_ID` INT(6), `Criminal_ID` INT(6), `Alias_name` VARCHAR(20))   BEGIN
	UPDATE Alias
	SET Alias_name = Alias_name
	WHERE Alias_ID = Alias_ID AND Criminal_ID = Criminal_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_appeal` (`Appeal_ID` INT(5), `Crime_ID` INT(9), `Filing_date` DATE, `Hearing_date` DATE, `Status` CHAR(1))   BEGIN
	UPDATE Appeals
	SET Filing_date = Filing_date, Hearing_date = Hearing_date, Status = Status
	WHERE Appeals.Appeal_ID = Appeal_ID AND Appeals.Crime_ID = Crime_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_crime` (`Crime_ID` INT(9), `Criminal_ID` INT(6), `Classification` CHAR(1), `Date_charged` DATE, `Status` CHAR(2), `Hearing_date` DATE, `Appeal_cut_date` DATE)   BEGIN
	UPDATE Crimes
	SET Classification = Classification, Date_charged = Date_charged, Status = Status, Hearing_date = Hearing_date, Appeal_cut_date = Appeal_cut_date
	WHERE Crimes.Criminal_ID = Criminal_ID AND Crimes.Crime_ID = Crime_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_crime_charge` (`Charge_ID` INT(10), `Crime_ID` INT(9), `Crime_code` INT(3), `Charge_status` CHAR(2), `Fine_amount` NUMERIC(7,2), `Court_fee` NUMERIC(7,2), `Amount_paid` NUMERIC(7,2), `Pay_due_date` DATE)   BEGIN
	UPDATE Crime_charges
	SET Crime_code = Crime_code, Charge_status = Charge_status, Fine_amount = Fine_amount, Court_fee = Court_fee, Amount_paid = Amount_paid, Pay_due_date = Pay_due_date
	WHERE Crime_charges.Charge_ID = Charge_ID AND Crime_charges.Crime_ID = Crime_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_Crime_code` (`Crime_code` INT(3), `Code_description` VARCHAR(30))   BEGIN
	UPDATE Crime_codes
	SET Code_description = Code_description
	WHERE Crime_code = Crime_code ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_criminal` (`Criminal_ID` INT(6), `last_name` VARCHAR(15), `first_name` VARCHAR(10), `street` VARCHAR(30), `city` VARCHAR(20), `state` CHAR(2), `zip` CHAR(5), `phone` CHAR(10), `v_status` CHAR(1), `p_status` CHAR(1))   BEGIN
	UPDATE Criminals
	SET last_name = last_name, first_name = first_name, street = street, city = city, state = state, zip = zip, phone = phone, v_status = v_status, p_status = p_status
	WHERE Criminal_ID = Criminal_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_officer` (`Officer_ID` INT(8), `Last` VARCHAR(15), `First` VARCHAR(10), `Precinct` CHAR(4), `Badge` VARCHAR(14), `Phone` CHAR(10), `Status` CHAR(1))   BEGIN
	UPDATE Officers
	SET Last = Last, First = First, Precinct = Precinct, Badge = Badge, Phone = Phone, Status = Status
	WHERE Officers.Officer_ID = Officer_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_prob_officer` (`Prob_ID` INT(5), `Last` VARCHAR(15), `First` VARCHAR(10), `Street` VARCHAR(30), `City` VARCHAR(20), `State` CHAR(2), `Zip` CHAR(5), `Phone` CHAR(10), `Email` VARCHAR(30), `Status` CHAR(1))   BEGIN
	UPDATE Prob_officers
	SET Last = Last, First = First, Street = Street, City = City, State = State, Zip = Zip, Phone = Phone, Email = Email, Status = Status
	WHERE Prob_officers.Prob_ID = Prob_ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sentence` (`Sentence_ID` INT(6), `Criminal_ID` INT(6), `Type` CHAR(1), `Prob_ID` INT(5), `Start_date` DATE, `End_date` DATE, `Violations` INT(3))   BEGIN
	UPDATE Sentences
	SET Type = Type, Prob_ID = Prob_ID, Start_date = Start_date, End_date = End_date, Violations = Violations
	WHERE Sentences.Sentence_ID = Sentence_ID  AND Sentences.Criminal_ID = Criminal_ID;
END$$

DELIMITER ;

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
(20, 5, 'meme'),
(32, 5, 'ss'),
(2021, 3, 'donald');

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
(1, 1, '2023-02-25', '2023-03-15', 'P'),
(2, 2, '2023-02-16', '2023-03-16', 'P'),
(3, 3, '2023-02-17', '2023-03-17', 'P'),
(4, 4, '2023-02-18', '2023-03-18', 'P'),
(6, 6, '2023-02-20', '2023-03-20', 'D'),
(8, 8, '2023-02-22', '2023-03-22', 'P'),
(9, 9, '2023-02-23', '2023-03-23', 'P');

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
(1, NULL, 'M', '2023-01-01', 'NC', '2023-02-01', '2023-03-01'),
(2, NULL, 'F', '2023-01-02', 'NC', '2023-02-02', '2023-03-02'),
(3, 3, 'O', '2023-01-03', '', '2023-02-03', '2023-03-03'),
(4, NULL, 'M', '2023-01-04', 'NC', '2023-02-04', '2023-03-04'),
(5, 5, 'F', '2023-01-05', 'NC', '2023-02-05', '2023-03-05'),
(6, NULL, 'U', '2023-01-06', 'NC', '2023-02-06', '2023-03-06'),
(7, NULL, 'M', '2023-01-07', 'NC', '2023-02-07', '2023-03-07'),
(8, NULL, 'F', '2023-01-08', 'NC', '2023-02-08', '2023-03-08'),
(9, NULL, 'U', '2023-01-09', 'NC', '2023-02-09', '2023-03-09'),
(10, 10, 'M', '2023-01-10', 'NC', '2023-02-10', '2023-03-10'),
(20, NULL, 'F', '2024-04-19', 'IA', '2024-05-01', '2024-05-10');

--
-- Triggers `crimes`
--
DELIMITER $$
CREATE TRIGGER `delete_crime` BEFORE DELETE ON `crimes` FOR EACH ROW BEGIN
    UPDATE Crime_charges SET Crime_ID = NULL WHERE Crime_ID = OLD.Crime_ID;
    UPDATE Appeals SET Crime_ID = NULL WHERE Crime_ID = OLD.Crime_ID;
     
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
(9, 9, 9, 'A', 4500.00, 450.00, 4000.00, '2023-02-09'),
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
(3, 7),
(3, 9),
(5, 5),
(5, 10),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 3),
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
(3, 'South', 'Kanye', '666 St Mary St', 'Dayton', 'OH', '30010', '3355555665', 'N', 'Y'),
(5, 'Swift', 'Taylor', '123 Canal St', 'New York', 'NY', '10003', '6465555665', 'N', 'N'),
(10, 'East', 'Kanye', '42 Poor St', 'Los Angeles', 'CA', '91508', '4455555565', 'Y', 'Y'),
(34, 'world', 'hello', '153 Miles Street', 'Brooklyn', 'NJ', '11201', '2018887869', 'N', 'Y');

--
-- Triggers `criminals`
--
DELIMITER $$
CREATE TRIGGER `delete_criminal` BEFORE DELETE ON `criminals` FOR EACH ROW BEGIN
     DELETE FROM Alias WHERE Criminal_ID  = OLD.Criminal_ID;

    UPDATE Crimes SET  Criminal_ID  = NULL WHERE Criminal_ID = OLD.Criminal_ID;
UPDATE Sentences SET  Criminal_ID  = NULL WHERE Criminal_ID = OLD.Criminal_ID;

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
(1, NULL, 'F', 1, '2023-01-01', '2023-06-01', 1),
(2, NULL, 'M', 2, '2023-01-02', '2023-06-02', 1),
(3, 3, 'H', 3, '2023-01-03', '2023-06-03', 2),
(4, NULL, 'F', 4, '2023-01-04', '2023-06-04', 2),
(5, 5, 'M', 5, '2023-01-05', '2023-06-05', 3),
(6, NULL, 'U', 6, '2023-01-06', '2023-06-06', 2),
(7, NULL, 'F', 7, '2023-01-07', '2023-06-07', 3),
(8, NULL, 'M', 8, '2023-01-08', '2023-06-08', 1),
(9, NULL, 'U', NULL, '2023-01-09', '2023-06-09', 1),
(10, 10, 'F', 10, '2023-01-10', '2023-06-10', 1),
(13, NULL, 'J', 2, '2024-04-26', '2024-05-08', 3);

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
('admin', '123456789', 10),
('bofa', 'bofadeez', 3083),
('dummy', 'password', 10),
('iluvbirds33', '123456789', 3083),
('iluvbirdspp', '123456789', 10),
('qwerty', '!QAZ1qaz', 3083),
('qwerty2', '!QAZ1qaz', 10),
('username', 'password', 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alias`
--
ALTER TABLE `alias`
  ADD PRIMARY KEY (`Alias_ID`),
  ADD KEY `Criminal_ID` (`Criminal_ID`);

--
-- Indexes for table `appeals`
--
ALTER TABLE `appeals`
  ADD PRIMARY KEY (`Appeal_ID`),
  ADD KEY `Crime_ID` (`Crime_ID`);

--
-- Indexes for table `crimes`
--
ALTER TABLE `crimes`
  ADD PRIMARY KEY (`Crime_ID`),
  ADD KEY `Criminal_ID` (`Criminal_ID`);

--
-- Indexes for table `crime_charges`
--
ALTER TABLE `crime_charges`
  ADD PRIMARY KEY (`Charge_ID`),
  ADD KEY `Crime_ID` (`Crime_ID`),
  ADD KEY `Crime_code` (`Crime_code`);

--
-- Indexes for table `crime_codes`
--
ALTER TABLE `crime_codes`
  ADD PRIMARY KEY (`Crime_code`),
  ADD UNIQUE KEY `Code_description` (`Code_description`);

--
-- Indexes for table `crime_officers`
--
ALTER TABLE `crime_officers`
  ADD PRIMARY KEY (`Crime_ID`,`Officer_ID`),
  ADD KEY `Officer_ID` (`Officer_ID`);

--
-- Indexes for table `criminals`
--
ALTER TABLE `criminals`
  ADD PRIMARY KEY (`Criminal_ID`);

--
-- Indexes for table `officers`
--
ALTER TABLE `officers`
  ADD PRIMARY KEY (`Officer_ID`),
  ADD UNIQUE KEY `Badge` (`Badge`);

--
-- Indexes for table `prob_officers`
--
ALTER TABLE `prob_officers`
  ADD PRIMARY KEY (`Prob_ID`);

--
-- Indexes for table `sentences`
--
ALTER TABLE `sentences`
  ADD PRIMARY KEY (`Sentence_ID`),
  ADD KEY `Criminal_ID` (`Criminal_ID`),
  ADD KEY `Prob_ID` (`Prob_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alias`
--
ALTER TABLE `alias`
  ADD CONSTRAINT `alias_ibfk_1` FOREIGN KEY (`Criminal_ID`) REFERENCES `criminals` (`Criminal_ID`);

--
-- Constraints for table `appeals`
--
ALTER TABLE `appeals`
  ADD CONSTRAINT `appeals_ibfk_1` FOREIGN KEY (`Crime_ID`) REFERENCES `crimes` (`Crime_ID`);

--
-- Constraints for table `crimes`
--
ALTER TABLE `crimes`
  ADD CONSTRAINT `crimes_ibfk_1` FOREIGN KEY (`Criminal_ID`) REFERENCES `criminals` (`Criminal_ID`);

--
-- Constraints for table `crime_charges`
--
ALTER TABLE `crime_charges`
  ADD CONSTRAINT `crime_charges_ibfk_1` FOREIGN KEY (`Crime_ID`) REFERENCES `crimes` (`Crime_ID`),
  ADD CONSTRAINT `crime_charges_ibfk_2` FOREIGN KEY (`Crime_code`) REFERENCES `crime_codes` (`Crime_code`);

--
-- Constraints for table `crime_officers`
--
ALTER TABLE `crime_officers`
  ADD CONSTRAINT `crime_officers_ibfk_1` FOREIGN KEY (`Crime_ID`) REFERENCES `crimes` (`Crime_ID`),
  ADD CONSTRAINT `crime_officers_ibfk_2` FOREIGN KEY (`Officer_ID`) REFERENCES `officers` (`Officer_ID`);

--
-- Constraints for table `sentences`
--
ALTER TABLE `sentences`
  ADD CONSTRAINT `sentences_ibfk_1` FOREIGN KEY (`Criminal_ID`) REFERENCES `criminals` (`Criminal_ID`),
  ADD CONSTRAINT `sentences_ibfk_2` FOREIGN KEY (`Prob_ID`) REFERENCES `prob_officers` (`Prob_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
