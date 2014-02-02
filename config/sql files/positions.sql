-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 02, 2014 at 10:07 AM
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
-- Table structure for table `positions`
--

CREATE TABLE IF NOT EXISTS `positions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `position` text NOT NULL,
  `name` text NOT NULL,
  `uname` varchar(8) NOT NULL,
  `start_date` date NOT NULL,
  `exec` tinyint(1) NOT NULL DEFAULT '0',
  `award_points` tinyint(1) NOT NULL DEFAULT '0',
  `disp` tinyint(1) NOT NULL DEFAULT '0',
  `contact` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`id`, `position`, `name`, `uname`, `start_date`, `exec`, `award_points`, `disp`, `contact`) VALUES
(1, 'beta', 'President', 'wallace4', '2013-02-03', 1, 1, 1, 'Major issues; Issues Relevant to entire house'),
(2, 'sigma', 'Vice President & Risk Manager', 'jlaux', '2013-02-03', 1, 1, 1, 'Any serious issues or anything pertaining to risk'),
(3, 'kappa', 'Treasurer', 'halloran', '2013-02-03', 1, 1, 1, 'Financial issues '),
(4, 'zeta', 'House Manager', 'jmcunnin', '2013-09-15', 1, 1, 1, 'Issues pertaining to upkeep of the house '),
(5, 'epsilon', 'House Steward', 'nmagu', '2013-09-15', 1, 1, 0, ''),
(6, 'delta', 'Social Chair', 'lvbanner', '2013-09-15', 1, 1, 1, 'Social event planning '),
(7, 'psi', 'Rush Chair', 'wwaste', '2013-02-03', 1, 1, 0, ''),
(8, 'pi', 'New Member Educator', 'wwaste', '2013-09-15', 1, 0, 0, ''),
(9, 'upsilon', 'Community Service Chair', 'hgould', '2013-02-03', 0, 0, 1, 'Community service events '),
(10, 'gamma', 'Assistant to the Pi', 'warnera', '2014-01-04', 0, 1, 0, ''),
(11, 'broweb', 'Webmaster', 'wallace4', '2014-01-04', 0, 0, 1, 'Issues pertaining to the website'),
(12, 'zeta_s', 'Summer House Manager', '', '2014-01-05', 0, 0, 1, 'Summer housing');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
