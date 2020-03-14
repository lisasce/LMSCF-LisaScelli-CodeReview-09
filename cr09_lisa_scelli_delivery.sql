-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2020 at 03:58 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cr09_lisa_scelli_delivery`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL,
  `house_nb` int(8) NOT NULL,
  `street` varchar(80) NOT NULL,
  `city` varchar(80) NOT NULL,
  `ZIP` int(5) NOT NULL,
  `country` varchar(3) NOT NULL DEFAULT 'AT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`contact_id`, `house_nb`, `street`, `city`, `ZIP`, `country`) VALUES
(1, 28, 'prinzgasse', 'Vienna', 1100, 'AT'),
(2, 8, 'kingstreet', 'london', 55555, 'UK'),
(3, 2, 'rue des rois', 'Paris', 91300, 'FR'),
(4, 7, 'prinzessinstrasse', 'Steyr', 4400, 'AT'),
(5, 3, 'rue des princesses', 'Paris', 95000, 'FR'),
(6, 17, 'princess street', 'London', 32486, 'UK'),
(7, 6, 'katzengasse', 'Vienna', 1200, 'AT'),
(8, 75, 'cat street', 'London', 44444, 'UK'),
(9, 7, 'rue des gros chats noirs', 'Paris', 92000, 'FR');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `tel` bigint(20) NOT NULL,
  `fk_contact_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `tel`, `fk_contact_id`) VALUES
(1, 'lisa', 'scelli', 436706061313, 7),
(2, 'nihad', 'abou-zid', 436706042683, 7),
(3, 'nihad', 'abou-zid', 436706042683, 7),
(4, 'guizmo', 'scelli', 0, 7),
(5, 'caecilia', 'levraut', 447706061313, 8),
(6, 'elodie', 'mous', 336788061313, 9);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `department_id` int(11) NOT NULL,
  `dep_name` varchar(50) NOT NULL,
  `dep_nb` tinyint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`department_id`, `dep_name`, `dep_nb`) VALUES
(1, 'DELIVERY', 1),
(2, 'RECEPTION', 2),
(3, 'WAREHOUSE', 3),
(4, 'PICKUP', 4);

-- --------------------------------------------------------

--
-- Table structure for table `description`
--

CREATE TABLE `description` (
  `description_id` int(11) NOT NULL,
  `customs_nb` int(50) NOT NULL,
  `mail_category` enum('letter','package') DEFAULT 'letter',
  `content_category` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `description`
--

INSERT INTO `description` (`description_id`, `customs_nb`, `mail_category`, `content_category`) VALUES
(1, 2415345, 'letter', 'small book'),
(2, 2475645, 'package', 'parfum'),
(3, 2414535, 'letter', 'documents'),
(4, 7535645, 'package', 'cakes'),
(5, 1255345, 'letter', 'love letter'),
(6, 2474535, 'package', 'souvenir');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `bithdate` date NOT NULL,
  `hire_date` date NOT NULL,
  `fk_contact_id` int(11) NOT NULL,
  `fk_department_id` int(11) NOT NULL,
  `fk_processing_system_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `first_name`, `last_name`, `bithdate`, `hire_date`, `fk_contact_id`, `fk_department_id`, `fk_processing_system_id`) VALUES
(1, 'ghiath', 'serri', '1990-05-23', '2018-10-23', 1, 1, 1),
(2, 'nadine', 'abou-zid', '1994-03-05', '2019-08-01', 1, 2, 1),
(3, 'adam', 'abou-zid', '1999-04-05', '2006-02-01', 9, 2, 2),
(4, 'valeria', 'ignaz', '1990-12-17', '2019-08-01', 5, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `firm_info`
--

CREATE TABLE `firm_info` (
  `firm_info_id` int(11) NOT NULL,
  `corporate_form` varchar(15) NOT NULL DEFAULT 'GmbH',
  `commercial_registration` varchar(25) NOT NULL,
  `VAT_nb` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `firm_info`
--

INSERT INTO `firm_info` (`firm_info_id`, `corporate_form`, `commercial_registration`, `VAT_nb`) VALUES
(1, 'GmbH', ' 180219d', 46674503),
(2, 'AG', ' 185319d', 42854503),
(3, 'KG', ' 127219d', 4286842);

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `fk_contact_id` int(11) NOT NULL,
  `fk_firm_info_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `name`, `fk_contact_id`, `fk_firm_info_id`) VALUES
(1, 'post office 1', 1, 1),
(2, 'post office 2', 1, 1),
(3, 'post office 3', 2, 2),
(4, 'post office 4', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `mail`
--

CREATE TABLE `mail` (
  `mail_id` int(11) NOT NULL,
  `weight_gr` int(11) NOT NULL DEFAULT 30,
  `date_sent` datetime NOT NULL,
  `date_received` datetime NOT NULL,
  `fk_description_id` int(11) NOT NULL,
  `fk_location_id` int(11) NOT NULL,
  `fk_sender_id` int(11) NOT NULL,
  `fk_receiver_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mail`
--

INSERT INTO `mail` (`mail_id`, `weight_gr`, `date_sent`, `date_received`, `fk_description_id`, `fk_location_id`, `fk_sender_id`, `fk_receiver_id`) VALUES
(1, 10, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 1, 1, 1, 2),
(2, 10, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 3, 1, 3, 4),
(3, 500, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 2, 2, 5, 6),
(4, 1000, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 4, 2, 6, 1),
(5, 50, '2020-03-02 00:00:00', '2020-03-08 00:00:00', 5, 2, 2, 5),
(6, 1000, '2020-03-02 00:00:00', '2020-03-08 00:00:00', 6, 2, 4, 2),
(7, 10, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 3, 1, 3, 5),
(8, 1000, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 4, 2, 3, 4),
(9, 20, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 5, 3, 2, 1),
(10, 1000, '2020-02-02 00:00:00', '2020-02-08 00:00:00', 6, 3, 2, 5),
(11, 50, '2020-03-02 00:00:00', '2020-03-08 00:00:00', 5, 2, 2, 5),
(12, 1000, '2020-03-02 00:00:00', '2020-03-08 00:00:00', 6, 2, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `processing_system`
--

CREATE TABLE `processing_system` (
  `processing_system_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `capacity_package` int(11) DEFAULT NULL,
  `fk_contact_id` int(11) NOT NULL,
  `fk_firm_info_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `processing_system`
--

INSERT INTO `processing_system` (`processing_system_id`, `name`, `capacity_package`, `fk_contact_id`, `fk_firm_info_id`) VALUES
(1, 'post warehouse 1', 500, 4, 1),
(2, 'post warehouse 2', 1500, 5, 2),
(3, 'post warehouse 3', 500, 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `send_receive`
--

CREATE TABLE `send_receive` (
  `send_receive_id` int(11) NOT NULL,
  `status` enum('received','sent') DEFAULT 'received',
  `fk_location_id` int(11) DEFAULT NULL,
  `fk_processing_system_id` int(11) DEFAULT NULL,
  `fk_receiver_id` int(11) DEFAULT NULL,
  `fk_mail_id` int(11) NOT NULL,
  `fk_employee_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `send_receive`
--

INSERT INTO `send_receive` (`send_receive_id`, `status`, `fk_location_id`, `fk_processing_system_id`, `fk_receiver_id`, `fk_mail_id`, `fk_employee_id`) VALUES
(1, 'sent', 1, 1, NULL, 1, 1),
(2, 'sent', 2, 1, NULL, 2, 2),
(3, 'sent', 3, 1, NULL, 3, 3),
(4, 'sent', 1, 1, NULL, 4, 4),
(6, 'sent', 1, 1, NULL, 1, 2),
(7, 'sent', 2, 1, NULL, 2, 3),
(8, 'sent', 3, 1, NULL, 3, 4),
(9, 'sent', 1, 1, NULL, 4, 1),
(10, 'received', 1, 1, NULL, 5, 1),
(11, 'received', 2, 1, NULL, 6, 2),
(12, 'received', 3, 1, NULL, 7, 3),
(13, 'received', 1, 1, NULL, 8, 4),
(14, 'received', NULL, 1, 1, 9, 1),
(15, 'received', NULL, 1, 2, 10, 2),
(16, 'received', NULL, 2, 3, 11, 3),
(17, 'received', NULL, 3, 4, 12, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `fk_contact_id` (`fk_contact_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `dep_nb` (`dep_nb`);

--
-- Indexes for table `description`
--
ALTER TABLE `description`
  ADD PRIMARY KEY (`description_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `fk_contact_id` (`fk_contact_id`),
  ADD KEY `fk_department_id` (`fk_department_id`),
  ADD KEY `fk_processing_system_id` (`fk_processing_system_id`);

--
-- Indexes for table `firm_info`
--
ALTER TABLE `firm_info`
  ADD PRIMARY KEY (`firm_info_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `fk_contact_id` (`fk_contact_id`),
  ADD KEY `fk_firm_info_id` (`fk_firm_info_id`);

--
-- Indexes for table `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`mail_id`),
  ADD KEY `fk_description_id` (`fk_description_id`),
  ADD KEY `fk_location_id` (`fk_location_id`),
  ADD KEY `fk_sender_id` (`fk_sender_id`),
  ADD KEY `fk_receiver_id` (`fk_receiver_id`);

--
-- Indexes for table `processing_system`
--
ALTER TABLE `processing_system`
  ADD PRIMARY KEY (`processing_system_id`),
  ADD KEY `fk_contact_id` (`fk_contact_id`),
  ADD KEY `fk_firm_info_id` (`fk_firm_info_id`);

--
-- Indexes for table `send_receive`
--
ALTER TABLE `send_receive`
  ADD PRIMARY KEY (`send_receive_id`),
  ADD KEY `fk_location_id` (`fk_location_id`),
  ADD KEY `fk_processing_system_id` (`fk_processing_system_id`),
  ADD KEY `fk_receiver_id` (`fk_receiver_id`),
  ADD KEY `fk_mail_id` (`fk_mail_id`),
  ADD KEY `fk_employee_id` (`fk_employee_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `description`
--
ALTER TABLE `description`
  MODIFY `description_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `firm_info`
--
ALTER TABLE `firm_info`
  MODIFY `firm_info_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mail`
--
ALTER TABLE `mail`
  MODIFY `mail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `processing_system`
--
ALTER TABLE `processing_system`
  MODIFY `processing_system_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `send_receive`
--
ALTER TABLE `send_receive`
  MODIFY `send_receive_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`fk_contact_id`) REFERENCES `contact` (`contact_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`fk_contact_id`) REFERENCES `contact` (`contact_id`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`fk_department_id`) REFERENCES `department` (`department_id`),
  ADD CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`fk_processing_system_id`) REFERENCES `processing_system` (`processing_system_id`);

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_1` FOREIGN KEY (`fk_contact_id`) REFERENCES `contact` (`contact_id`),
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`fk_firm_info_id`) REFERENCES `firm_info` (`firm_info_id`);

--
-- Constraints for table `mail`
--
ALTER TABLE `mail`
  ADD CONSTRAINT `mail_ibfk_1` FOREIGN KEY (`fk_description_id`) REFERENCES `description` (`description_id`),
  ADD CONSTRAINT `mail_ibfk_2` FOREIGN KEY (`fk_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `mail_ibfk_3` FOREIGN KEY (`fk_sender_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `mail_ibfk_4` FOREIGN KEY (`fk_receiver_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `processing_system`
--
ALTER TABLE `processing_system`
  ADD CONSTRAINT `processing_system_ibfk_1` FOREIGN KEY (`fk_contact_id`) REFERENCES `contact` (`contact_id`),
  ADD CONSTRAINT `processing_system_ibfk_2` FOREIGN KEY (`fk_firm_info_id`) REFERENCES `firm_info` (`firm_info_id`);

--
-- Constraints for table `send_receive`
--
ALTER TABLE `send_receive`
  ADD CONSTRAINT `send_receive_ibfk_1` FOREIGN KEY (`fk_location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `send_receive_ibfk_2` FOREIGN KEY (`fk_processing_system_id`) REFERENCES `processing_system` (`processing_system_id`),
  ADD CONSTRAINT `send_receive_ibfk_3` FOREIGN KEY (`fk_receiver_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `send_receive_ibfk_4` FOREIGN KEY (`fk_mail_id`) REFERENCES `mail` (`mail_id`),
  ADD CONSTRAINT `send_receive_ibfk_5` FOREIGN KEY (`fk_employee_id`) REFERENCES `employee` (`employee_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
