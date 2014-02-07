-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 07, 2014 at 07:04 AM
-- Server version: 5.5.35
-- PHP Version: 5.3.10-1ubuntu3.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dke_website`
--

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `name` varchar(11) NOT NULL,
  `val` tinytext NOT NULL,
  `desc` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`name`, `val`, `desc`) VALUES
('dinner_wkdy', '6:00PM', 'Time of Dinner during the week'),
('dinner_wknd', '6:00PM', 'Time of Dinner during the week'),
('dlunch_wkdy', '1', 'Default E value for a lunch served during the week'),
('dlunch_wknd', '1', 'Default E value for a lunch served on saturday'),
('d_din_wkdy', '1.5', 'Defualt E value for a dinner served during the week'),
('d_din_wknd', '3', 'Default E value for a dinner served on saturday'),
('e_count', '14', 'E Count for the Semester'),
('lunch_0', '11:30AM', 'Time of First lunch'),
('lunch_1', '12:15PM', 'Time of Second lunch'),
('lunch_2', '1:15PM', 'Time of Third lunch'),
('lunch_wknd', '12:00PM', 'Time of Lunch on weekend'),

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
