-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 24, 2014 at 01:46 PM
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
-- Table structure for table `e_menu`
--

CREATE TABLE IF NOT EXISTS `e_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` varchar(9) NOT NULL,
  `lunch` text NOT NULL,
  `dinner` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `e_menu`
--

INSERT INTO `e_menu` (`id`, `day`, `lunch`, `dinner`) VALUES
(1, 'monday', 'Steak & Cheese', ''),
(2, 'tuesday', '', ''),
(3, 'wednesday', '', ''),
(4, 'thursday', '', ''),
(5, 'friday', '', ''),
(6, 'saturday', '', '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
