-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 22, 2024 at 01:10 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vehicle_rental`
--

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE DATABASE vehicle_rental;
USE vehicle_rental;
SELECT DATABASE();
SHOW TABLES;
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE IF NOT EXISTS `vehicle` (
  `VehicleID` varchar(20) NOT NULL,
  `PlateNum` varchar(20) NOT NULL,
  `VehicleType` varchar(50) DEFAULT NULL,
  `VehicleModel` varchar(50) DEFAULT NULL,
  `VehicleColor` varchar(20) DEFAULT NULL,
  `FuelType` varchar(20) DEFAULT NULL CHECK (`FuelType` IN ('Petrol', 'Electric')),
  `MaintenanceStatus` varchar(20) DEFAULT NULL CHECK (`MaintenanceStatus` IN ('In Progress', 'Done')),
  `Price` varchar(100) NOT NULL CHECK (`Price` REGEXP '^[0-9]+$'),
  PRIMARY KEY (`VehicleID`),
  UNIQUE KEY `PlateNum` (`PlateNum`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`VehicleID`, `PlateNum`, `VehicleType`, `VehicleModel`, `VehicleColor`, `FuelType`, `MaintenanceStatus`, `Price`) VALUES
('CID000001', 'A 7267 EFD', 'SUV', 'Lamborghini Urus', 'Black', 'Petrol', 'Done', '9000000'),
('CID000002', 'D 9401 BYW', 'Sedan', 'Honda Civic', 'White', 'Petrol', 'In Progress', '4500000'),
('CID000003', 'F 2438 MSE', 'Sedan', 'Hyundai IONIQ 5', 'Black', 'Electric', 'Done', '5500000'),
('CID000004', 'B 2118 MQW', 'Truck', 'Toyota Tacoma', 'Yellow', 'Petrol', 'Done', '3000000');


-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `CustID` varchar(20) NOT NULL,
  `CustName` varchar(100) NOT NULL CHECK (`CustName` REGEXP '^[A-Za-z ]+$'),
  `PhoneNum` varchar(20) DEFAULT NULL CHECK (`PhoneNum` REGEXP '^\\+[0-9]+$'),
  `EmailAdd` varchar(100) DEFAULT NULL CHECK (`EmailAdd` REGEXP '^[^@]+@[^@]+$'),
  `HomeAdd` varchar(255) DEFAULT NULL,
  `SocialSecNum` varchar(20) NOT NULL CHECK (`SocialSecNum` REGEXP '^[0-9]+$'),
  PRIMARY KEY (`CustID`),
  UNIQUE KEY `SocialSecNum` (`SocialSecNum`),
  UNIQUE KEY `EmailAdd` (`EmailAdd`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustID`, `CustName`, `PhoneNum`, `EmailAdd`, `HomeAdd`, `SocialSecNum`) VALUES
('C00001', 'Niall Morrow', '+62855555092', 'Niall.Morrow@gmail.com', 'Jl. Melati Raya No. 15, Kemang, South Jakarta, DKI Jakarta 12730, Indonesia', '3172012304560001'),
('C00002', 'Oliwia Mcvehiclety', '+62899555568', 'Oliwia.Mcvehiclety@gmail.com', 'Jl. Ahmad Yani No. 8, Senen, Central Jakarta, DKI Jakarta 10410, Indonesia', '3273051406780002'),
('C00003', 'Neve Reyes', '+628555111192', 'Neve.Reyes@gmail.com', 'Jl. Taman Sari No. 3, Kebayoran Baru, South Jakarta, DKI Jakarta 12150, Indonesia', '3174052103890003'),
('C00004', 'Billy Ross', '+62855234111', 'Billy.Ross@gmail.com', 'Residence One', '3174052101190015');


-- --------------------------------------------------------

--
-- Table structure for table `rental`
--

DROP TABLE IF EXISTS `rental`;
CREATE TABLE IF NOT EXISTS `rental` (
  `RentalID` varchar(20) NOT NULL,
  `PlateNum` varchar(20) NOT NULL,
  `RentalDate` date NOT NULL,
  `ReturnDate` date NOT NULL,
  `DaysElapsed` int DEFAULT NULL,
  `customer_CustID` VARCHAR(20) NOT NULL,
  `employee_EmployeeID` VARCHAR(20) NOT NULL,
  `vehicle_VehicleID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`RentalID`),
  KEY `PlateNum` (`PlateNum`),
  KEY `CustID` (`customer_CustID`),
  FOREIGN KEY (`customer_CustID`) REFERENCES `customer`(`CustID`),
  FOREIGN KEY (`employee_EmployeeID`) REFERENCES `employee`(`EmployeeID`),
  FOREIGN KEY (`vehicle_VehicleID`) REFERENCES `vehicle`(`VehicleID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `rental`
--

INSERT INTO `rental` (`RentalID`, `PlateNum`, `RentalDate`, `ReturnDate`, `DaysElapsed`, `customer_CustID`, `employee_EmployeeID`, `vehicle_VehicleID`) VALUES
('R00001', 'A 7267 EFD', '2024-12-01', '2024-12-07', 6, 'C00001', 'EMP0001', 'CID000001'),
('R00002', 'D 9401 BYW', '2024-12-05', '2024-12-10', 5, 'C00002', 'EMP0002', 'CID000002'),
('R00003', 'F 2438 MSE', '2024-12-10', '2024-12-15', 5, 'C00003', 'EMP0003', 'CID000003'),
('R00004', 'B 2118 MQW', '2024-12-02', '2024-12-08', 6, 'C00004', 'EMP0001', 'CID000004');


-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `EmployeeID` VARCHAR(20) NOT NULL,
  `FirstName` VARCHAR(50) NOT NULL CHECK (`FirstName` REGEXP '^[A-Za-z]+$'),
  `LastName` VARCHAR(50) NOT NULL CHECK (`LastName` REGEXP '^[A-Za-z]+$'),
  `Email` VARCHAR(100) DEFAULT NULL CHECK (`Email` LIKE '%@%'),
  `PhoneNumber` VARCHAR(20) DEFAULT NULL CHECK (`PhoneNumber` REGEXP '^\\+[0-9]+$'),
  `Role` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmployeeID`, `FirstName`, `LastName`, `Email`, `PhoneNumber`, `Role`) VALUES
('EMP0001', 'John', 'Williams', 'john.william@gmail.com', '+62510320322', 'Chief Executive Officer'),
('EMP0002', 'Madeline', 'Cruz', 'madeline.cruz@gmail.com', '+62128231427', 'General Manager'),
('EMP0003', 'Michael', 'Sanchez', 'michael.sanchez@gmail.com', '+62215890445', 'Intern');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `PaymentID` varchar(20) NOT NULL,
  `AmountPaid` varchar(100) NOT NULL CHECK (`AmountPaid` REGEXP '^[0-9]+$'),
  `PaymentDate` date NOT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `rental_RentalID` VARCHAR(20) NOT NULL,
  `rental_customer_CustID` VARCHAR(20) NOT NULL,
  `rental_employee_EmployeeID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `RentalID` (`rental_RentalID`),
  FOREIGN KEY (`rental_RentalID`) REFERENCES `rental`(`RentalID`),
  FOREIGN KEY (`rental_customer_CustID`) REFERENCES `customer`(`CustID`),
  FOREIGN KEY (`rental_employee_EmployeeID`) REFERENCES `employee`(`EmployeeID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentID`, `AmountPaid`, `PaymentDate`, `PaymentMethod`, `rental_RentalID`, `rental_customer_CustID`, `rental_employee_EmployeeID`) VALUES
('P0001', '54000000', '2024-12-02', 'Debit Card', 'R00001', 'C00001', 'EMP0001'),
('P0002', '22500000', '2024-12-06', 'Cash', 'R00002', 'C00002', 'EMP0002'),
('P0003', '27500000', '2024-12-11', 'Credit Card', 'R00003', 'C00003', 'EMP0003'),
('P0004', '18000000', '2024-12-03', 'Debit Card', 'R00004', 'C00004', 'EMP0001');

-- --------------------------------------------------------

--
-- Table structure for table `damage`
--

DROP TABLE IF EXISTS `damage`;
CREATE TABLE IF NOT EXISTS `damage` (
  `DmgID` VARCHAR(20) NOT NULL,
  `PlateNum` VARCHAR(20) NOT NULL,
  `VehicleModel` VARCHAR(50) DEFAULT NULL,
  `MaintStatus` VARCHAR(20) DEFAULT NULL,
  `DmgDone` VARCHAR(255) DEFAULT NULL,
  `DmgPrice` VARCHAR(100) DEFAULT NULL CHECK (`DmgPrice` REGEXP '^[0-9]+$'),
  `rental_RentalID` VARCHAR(20) NOT NULL,
  `rental_customer_CustID` VARCHAR(20) NOT NULL,
  `rental_employee_EmployeeID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`DmgID`),
  FOREIGN KEY (`rental_RentalID`) REFERENCES rental(`RentalID`),
  FOREIGN KEY (`rental_customer_CustID`) REFERENCES customer(`CustID`),
  FOREIGN KEY (`rental_employee_EmployeeID`) REFERENCES employee(`EmployeeID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `damage`
--

INSERT INTO `damage` (`DmgID`, `PlateNum`, `VehicleModel`, `MaintStatus`, `DmgDone`, `DmgPrice`, `rental_RentalID`, `rental_customer_CustID`, `rental_employee_EmployeeID`) VALUES
('DMG000000001', 'A 7267 EFD', 'Lamborghini Urus', 'Completed', 'Front bumper damage', '2000000', 'R00001', 'C00001', 'EMP0001'),
('DMG000000002', 'D 9401 BYW', 'Honda Civic', 'In Progress', 'Scratch on rear door', '500000', 'R00002', 'C00002', 'EMP0002'),
('DMG000000003', 'F 2438 MSE', 'Hyundai IONIQ 5', 'Completed', 'Rear bumper cracked', '1500000', 'R00003', 'C00003', 'EMP0003'),
('DMG000000004', 'B 2118 MQW', 'Toyota Tacoma', 'Completed', 'Broken tail light', '300000', 'R00004', 'C00004', 'EMP0001');

-- --------------------------------------------------------

--
-- Table structure for table `maintenancelog`
--

DROP TABLE IF EXISTS `maintenancelog`;
CREATE TABLE IF NOT EXISTS `maintenancelog` (
  `LogID` VARCHAR(20) NOT NULL,
  `PlateNum` VARCHAR(20) NOT NULL,
  `MaintenanceType` VARCHAR(100) DEFAULT NULL,
  `MaintStatus` VARCHAR(20) DEFAULT NULL CHECK (`MaintStatus` IN ('In Progress', 'Done')),
  `WorkshopLocation` VARCHAR(100) DEFAULT NULL,
  `MaintCost` VARCHAR(100) DEFAULT NULL CHECK (`MaintCost` REGEXP '^[0-9]+$'),
  `employee_EmployeeID` VARCHAR(20) NOT NULL,
  `vehicle_VehicleID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`LogID`),
  FOREIGN KEY (`employee_EmployeeID`) REFERENCES employee(`EmployeeID`),
  FOREIGN KEY (`vehicle_VehicleID`) REFERENCES vehicle(`VehicleID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `maintenancelog`
--

INSERT INTO `maintenancelog` (`LogID`, `PlateNum`, `MaintenanceType`, `MaintStatus`, `WorkshopLocation`, `MaintCost`, `employee_EmployeeID`, `vehicle_VehicleID`) VALUES
('M000001', 'A 7267 EFD', 'Oil Change', 'Done', 'Lamborghini Service Center', '2000000', 'EMP0001', 'CID000001'),
('M000002', 'D 9401 BYW', 'Brake Pad Replacement', 'In Progress', 'Honda Service Center', '1500000', 'EMP0002', 'CID000002'),
('M000003', 'F 2438 MSE', 'Battery Check', 'Done', 'Hyundai Service Center', '500000', 'EMP0003', 'CID000003'),
('M000004', 'B 2118 MQW', 'Suspension Inspection', 'Done', 'Toyota Service Center', '1000000', 'EMP0001', 'CID000004');

-- --------------------------------------------------------

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `LocID` VARCHAR(20) NOT NULL,
  `Dropoff` VARCHAR(255) DEFAULT NULL,
  `Pickup` VARCHAR(255) DEFAULT NULL,
  `OrigLoc` VARCHAR(255) DEFAULT NULL,
  `customer_CustID` VARCHAR(20) NOT NULL,
  `vehicle_VehicleID` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`LocID`),
  FOREIGN KEY (`customer_CustID`) REFERENCES `customer`(`CustID`),
  FOREIGN KEY (`vehicle_VehicleID`) REFERENCES `vehicle`(`VehicleID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `maintenancelog`
--

INSERT INTO `location` (`LocID`, `Dropoff`, `Pickup`, `OrigLoc`, `customer_CustID`, `vehicle_VehicleID`) VALUES
('L00001', 'Jl. Melati Raya No. 15, Kemang, South Jakarta', 'Jl. Ahmad Yani No. 8, Senen, Central Jakarta', 'Kemang, South Jakarta', 'C00001', 'CID000001'),
('L00002', 'Jl. Ahmad Yani No. 8, Senen, Central Jakarta', 'Jl. Taman Sari No. 3, Kebayoran Baru, South Jakarta', 'Senen, Central Jakarta', 'C00002', 'CID000002'),
('L00003', 'Jl. Taman Sari No. 3, Kebayoran Baru, South Jakarta', 'Jl. Cempaka No. 18, South Jakarta', 'Kebayoran Baru, South Jakarta', 'C00003', 'CID000003'),
('L00004', 'Jl. Cempaka No. 18, South Jakarta', 'Jl. Melati Raya No. 15, Kemang, South Jakarta', 'South Jakarta', 'C00004', 'CID000004');

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
