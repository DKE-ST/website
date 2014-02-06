-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 06, 2014 at 03:23 PM
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
-- Table structure for table `e_sheets`
--

CREATE TABLE IF NOT EXISTS `e_sheets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `e_type` varchar(8) NOT NULL,
  `uname` varchar(8) NOT NULL DEFAULT '',
  `value` float NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `e_sheets`
--

INSERT INTO `e_sheets` (`id`, `date`, `e_type`, `uname`, `value`, `comment`) VALUES
(1, '2014-02-03', 'lunch_0', '', 1, ''),
(2, '2014-02-03', 'lunch_1', '', 1, ''),
(3, '2014-02-03', 'lunch_2', '', 1, ''),
(4, '2014-02-03', 'dinner_0', '', 1.5, ''),
(5, '2014-02-03', 'dinner_1', '', 1.5, ''),
(6, '2014-02-04', 'lunch_0', 'toolman7', 1, ''),
(7, '2014-02-04', 'lunch_1', 'jlara', 1, ''),
(8, '2014-02-04', 'lunch_2', 'jlara', 1, ''),
(9, '2014-02-04', 'dinner_0', 'jlara', 1.5, ''),
(10, '2014-02-04', 'dinner_1', 'jlara', 1.5, ''),
(11, '2014-02-05', 'lunch_0', 'rfried16', 1, ''),
(12, '2014-02-05', 'lunch_1', 'toolman7', 1, ''),
(13, '2014-02-05', 'lunch_2', 'toolman7', 1, ''),
(14, '2014-02-05', 'dinner_0', 'jlara', 1.5, ''),
(15, '2014-02-05', 'dinner_1', 'jlara', 1.5, ''),
(16, '2014-02-06', 'lunch_0', 'toolman7', 1, ''),
(17, '2014-02-06', 'lunch_1', 'toolman7', 1, ''),
(18, '2014-02-06', 'lunch_2', 'lvbanner', 1, ''),
(19, '2014-02-06', 'dinner_0', '', 1.5, ''),
(20, '2014-02-06', 'dinner_1', '', 1.5, ''),
(21, '2014-02-07', 'lunch_0', 'warnera', 1, ''),
(22, '2014-02-07', 'lunch_1', 'toolman7', 1, ''),
(23, '2014-02-07', 'lunch_2', 'toolman7', 1, ''),
(24, '2014-02-07', 'dinner_0', 'toolman7', 1.5, ''),
(25, '2014-02-07', 'dinner_1', 'toolman7', 1.5, ''),
(26, '2014-02-08', 'lunch_0', '', 1, ''),
(27, '2014-02-08', 'dinner_0', '', 3, '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
