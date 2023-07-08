-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 08, 2023 at 05:56 PM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ccr`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `Address_ID` int NOT NULL,
  `country` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `District` varchar(50) NOT NULL,
  `Street` varchar(50) NOT NULL,
  PRIMARY KEY (`Address_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `Customer_ID` int NOT NULL,
  `Address_ID` int NOT NULL,
  `Customer_First_Name` varchar(50) NOT NULL,
  `Customer_Last_Name` varchar(50) NOT NULL,
  `Customer_Number` int NOT NULL,
  `Customer_Email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`Customer_ID`),
  KEY `Address_ID` (`Address_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_info`
--

DROP TABLE IF EXISTS `customer_info`;
CREATE TABLE IF NOT EXISTS `customer_info` (
  `Customer_ID` int NOT NULL,
  `Customer_Birthday` year DEFAULT NULL,
  `Customer_Age` int GENERATED ALWAYS AS (timediff(2022,`Customer_Birthday`)) VIRTUAL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `Employee_ID` int NOT NULL,
  `manager_ID` int DEFAULT NULL,
  `Restaurant_ID` int DEFAULT NULL,
  `Storage_ID` int DEFAULT NULL,
  `Employee_First_Name` varchar(50) NOT NULL,
  `Employee_Last_Name` varchar(50) NOT NULL,
  `Employee_home_number` int DEFAULT NULL,
  `Employee_Phone_Number` int NOT NULL,
  `Employee_Email` varchar(50) NOT NULL,
  `Salary` int NOT NULL,
  `Job_Type` varchar(50) NOT NULL,
  PRIMARY KEY (`Employee_ID`),
  KEY `manager_ID` (`manager_ID`),
  KEY `Restaurant_ID` (`Restaurant_ID`),
  KEY `Storage_ID` (`Storage_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_info`
--

DROP TABLE IF EXISTS `employee_info`;
CREATE TABLE IF NOT EXISTS `employee_info` (
  `Employee_ID` int DEFAULT NULL,
  `Employee_Birthday` year DEFAULT NULL,
  `age` int GENERATED ALWAYS AS (timediff(2022,`Employee_Birthday`)) VIRTUAL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `Item_ID` int NOT NULL,
  `Item_Name` varchar(50) NOT NULL,
  `Item_Tax` int NOT NULL,
  `expiry_Date` date NOT NULL,
  PRIMARY KEY (`Item_ID`),
  KEY `Item_Name` (`Item_Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_info`
--

DROP TABLE IF EXISTS `item_info`;
CREATE TABLE IF NOT EXISTS `item_info` (
  `Item_Name` varchar(50) NOT NULL,
  `Item_Price` int NOT NULL,
  PRIMARY KEY (`Item_Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_in_meal`
--

DROP TABLE IF EXISTS `item_in_meal`;
CREATE TABLE IF NOT EXISTS `item_in_meal` (
  `Item_In_Meal_ID` int NOT NULL,
  `Meal_ID` int NOT NULL,
  `Item_ID` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`Item_In_Meal_ID`),
  KEY `Meal_ID` (`Meal_ID`),
  KEY `Item_ID` (`Item_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_in_storage`
--

DROP TABLE IF EXISTS `item_in_storage`;
CREATE TABLE IF NOT EXISTS `item_in_storage` (
  `Item_In_Storage_ID` int NOT NULL,
  `Storage_ID` int NOT NULL,
  `Item_ID` int NOT NULL,
  `Quantity` int NOT NULL,
  `Minimum_Quantity` int NOT NULL,
  PRIMARY KEY (`Item_In_Storage_ID`),
  KEY `Storage_ID` (`Storage_ID`),
  KEY `Item_ID` (`Item_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Triggers `item_in_storage`
--
DROP TRIGGER IF EXISTS `MinQ_trigger`;
DELIMITER $$
CREATE TRIGGER `MinQ_trigger` BEFORE INSERT ON `item_in_storage` FOR EACH ROW Begin
     If Quantity < Minimum_Quantity then
     Signal sqlstate '45000';
    end if;
     end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `meal`
--

DROP TABLE IF EXISTS `meal`;
CREATE TABLE IF NOT EXISTS `meal` (
  `Meal_ID` int NOT NULL,
  `Section_ID` int NOT NULL,
  `Meal_Name` varchar(50) NOT NULL,
  `Meal_Price` decimal(10,10) DEFAULT NULL,
  PRIMARY KEY (`Meal_ID`),
  KEY `section_ID` (`Section_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meals_in_order`
--

DROP TABLE IF EXISTS `meals_in_order`;
CREATE TABLE IF NOT EXISTS `meals_in_order` (
  `Meals_In_Order_ID` int NOT NULL,
  `Order_ID` int NOT NULL,
  `Meal_ID` int NOT NULL,
  `Quantity` int NOT NULL,
  `Notes` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Meals_In_Order_ID`),
  KEY `Order_ID` (`Order_ID`),
  KEY `Meal_ID` (`Meal_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meal_info`
--

DROP TABLE IF EXISTS `meal_info`;
CREATE TABLE IF NOT EXISTS `meal_info` (
  `Meal_Name` varchar(50) NOT NULL,
  `Meal_Description` varchar(50) NOT NULL,
  PRIMARY KEY (`Meal_Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `meal_in_offer`
--

DROP TABLE IF EXISTS `meal_in_offer`;
CREATE TABLE IF NOT EXISTS `meal_in_offer` (
  `Meal_In_Offer_ID` int NOT NULL,
  `Offer_ID` int NOT NULL,
  `Meal_ID` int NOT NULL,
  `Meal_New_Price` int DEFAULT NULL,
  PRIMARY KEY (`Meal_In_Offer_ID`),
  KEY `Offer_ID` (`Offer_ID`),
  KEY `Meal_ID` (`Meal_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
CREATE TABLE IF NOT EXISTS `offer` (
  `Offer_ID` int NOT NULL,
  `Offer_Name` varchar(50) NOT NULL,
  `Discount` double DEFAULT NULL,
  `Offer_Price` int NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  PRIMARY KEY (`Offer_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
CREATE TABLE IF NOT EXISTS `order_info` (
  `Order_ID` int NOT NULL,
  `Customer_ID` int NOT NULL,
  `Order_Date` date NOT NULL,
  `Order_description` varchar(100) DEFAULT NULL,
  `Order_Total_Price` int NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Customer_ID` (`Customer_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `Reservation_ID` int NOT NULL,
  `Restaurant_ID` int NOT NULL,
  `Customer_ID` int NOT NULL,
  `Reservation_Date` date NOT NULL,
  `Reservation_Type` varchar(50) DEFAULT NULL,
  `Number_of_People` int NOT NULL,
  PRIMARY KEY (`Reservation_ID`),
  KEY `Restaurant_ID` (`Restaurant_ID`),
  KEY `Customer_ID` (`Customer_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
CREATE TABLE IF NOT EXISTS `restaurant` (
  `Restaurant_ID` int NOT NULL,
  `Address_ID` int NOT NULL,
  `Restaurant_Number` int NOT NULL,
  PRIMARY KEY (`Restaurant_ID`),
  KEY `Address_ID` (`Address_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_storage`
--

DROP TABLE IF EXISTS `restaurant_storage`;
CREATE TABLE IF NOT EXISTS `restaurant_storage` (
  `Restaurant_Storage_ID` int NOT NULL,
  `Restaurant_ID` int NOT NULL,
  `Storage_ID` int NOT NULL,
  PRIMARY KEY (`Restaurant_Storage_ID`),
  KEY `Restaurant_ID` (`Restaurant_ID`),
  KEY `Storage_ID` (`Storage_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `Section_ID` int NOT NULL,
  `Restaurant_ID` int NOT NULL,
  `Section_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Section_ID`),
  KEY `Restaurant_ID` (`Restaurant_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
CREATE TABLE IF NOT EXISTS `storage` (
  `Storage_ID` int NOT NULL,
  `Address_ID` int NOT NULL,
  PRIMARY KEY (`Storage_ID`),
  KEY `Address_ID` (`Address_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
