-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 04, 2014 at 01:41 PM
-- Server version: 5.5.34
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
-- Table structure for table `house_points`
--

CREATE TABLE IF NOT EXISTS `house_points` (
  `uname` varchar(8) NOT NULL,
  `beta_f` int(11) NOT NULL DEFAULT '0',
  `beta_s` int(11) NOT NULL DEFAULT '0',
  `sigma_f` int(11) NOT NULL DEFAULT '0',
  `sigma_s` int(11) NOT NULL DEFAULT '0',
  `zeta_f` int(11) NOT NULL DEFAULT '0',
  `zeta_s` int(11) NOT NULL DEFAULT '0',
  `epsilon_f` int(11) NOT NULL DEFAULT '0',
  `epsilon_s` int(11) NOT NULL DEFAULT '0',
  `delta_f` int(11) NOT NULL DEFAULT '0',
  `delta_s` int(11) NOT NULL DEFAULT '0',
  `gamma_f` int(11) NOT NULL DEFAULT '0',
  `gamma_s` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
