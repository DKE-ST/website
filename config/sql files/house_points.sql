-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 02, 2014 at 09:44 AM
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
-- Table structure for table `house_points`
--

CREATE TABLE IF NOT EXISTS `house_points` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(8) NOT NULL,
  `position` text NOT NULL,
  `value` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `house_points`
--

INSERT INTO `house_points` (`id`, `uname`, `position`, `value`, `comment`, `date`) VALUES
(2, 'pjmaster', 'beta', 10, 'Fake Pts', '2014-02-02'),
(3, 'esparrs', 'beta', 5, 'Fake Pts', '2014-01-24'),
(4, 'jmcunnin', 'beta', 5, 'Fake Pts', '2014-01-24'),
(5, 'wallace4', 'sigma', 5, 'Fake Pts', '2014-01-24'),
(6, 'pjmaster', 'sigma', 5, 'Fake Pts', '2014-01-24'),
(7, 'esparrs', 'sigma', 5, 'Fake Pts', '2014-01-24'),
(8, 'jmcunnin', 'sigma', 5, 'Fake Pts', '2014-01-24'),
(9, 'wallace4', 'epsilon', 5, 'Fake Pts', '2014-01-24'),
(10, 'pjmaster', 'epsilon', 5, 'Fake Pts', '2014-01-24'),
(11, 'esparrs', 'epsilon', 5, 'Fake Pts', '2014-01-24'),
(12, 'jmcunnin', 'epsilon', 5, 'Fake Pts', '2014-01-24'),
(13, 'wallace4', 'delta', 5, 'Fake Pts', '2014-01-24'),
(14, 'pjmaster', 'delta', 5, 'Fake Pts', '2014-01-24'),
(15, 'esparrs', 'delta', 5, 'Fake Pts', '2014-01-24'),
(16, 'jmcunnin', 'delta', 5, 'Fake Pts', '2014-01-24'),
(17, 'wallace4', 'beta', -3, 'Missed House Meeting - 10/10', '2014-01-28');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
