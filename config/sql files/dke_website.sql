-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 14, 2014 at 06:55 PM
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
-- Table structure for table `brothers_dke`
--

CREATE TABLE IF NOT EXISTS `brothers_dke` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(8) DEFAULT NULL,
  `pname` text NOT NULL,
  `project` text NOT NULL,
  `big` text NOT NULL,
  `littles` text NOT NULL,
  `cur_pos` text NOT NULL,
  `past_pos` text NOT NULL,
  `residence` text NOT NULL,
  `p_class` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=77 ;

--
-- Dumping data for table `brothers_dke`
--

INSERT INTO `brothers_dke` (`id`, `uname`, `pname`, `project`, `big`, `littles`, `cur_pos`, `past_pos`, `residence`, `p_class`) VALUES
(1, 'dblake', '', '', '', '', '', '', '', 2012),
(3, 'ambition', '', '', '', '', '', '', '', 2012),
(49, 'pjmaster', 'Captain Telechubby', 'Making Russell go to meetings', 'jlara', 'jhanley,atitus', '', '', '5th Stair', 2015),
(5, 'wsantos', '', '', 'Todd Kane', 'jlara', '', '', '', 2012),
(6, 'tzanetos', '', '', '', '', '', '', '', 2012),
(7, 'wagnert', '', '', '', '', '', '', '', 2012),
(8, 'kcweaver', '', '', '', '', '', '', '', 2012),
(9, 'cdville', 'Shenanigans', 'DKE website', 'Stephen Yablonski', 'josephdr', '', 'Zeta (Spring 2012), Bro Chicken', '', 2013),
(10, 'jhedrick', '', '', '', '', '', '', '', 2013),
(11, 'kalinich', 'Aseel Tare', '', 'Jordan Meenan', 'acboesch,wallace4', '', '', '', 2013),
(12, 'mnackoul', '', '', '', '', '', '', '', 2013),
(13, 'cholle', '', '', '', '', '', '', '', 2013),
(14, 'eep77', '', '', '', '', '', '', '', 2013),
(15, 'aprindle', '', '', '', '', '', '', '', 2013),
(16, 'rspivak', '', '', '', '', '', '', '', 2013),
(17, 'jbalchun', '', '', '', '', '', 'Delta (Spring 2013), Delta (Spring 2013)', '', 2014),
(18, 'acboesch', '', '', 'kalinich', 'eklinkha', '', '', '', 2014),
(19, 'phillipm', '', '', '', '', '', '', '', 2014),
(20, 'rhys34', '', '', '', '', '', '', '', 2014),
(21, 'toolman7', '', '', '', '', '', '', '', 2014),
(22, 'wwaste', '', '', '', '', 'Pi, Psi', '', '', 2014),
(23, 'jlara', 'Lemon Pledge', '', 'wsantos', 'pjmaster,lvbanner', '', 'Pi (Spring 2013), Pi (Spring 2013)', '', 2014),
(24, 'dvaughn', '', '', '', '', '', 'Epsilon (Spring 2013)', '', 2014),
(25, 'josephdr', '', '', '', '', '', '', '', 2014),
(26, 'gillund', '', '', '', '', '', '', '', 2014),
(27, 'jlaux', '', '', '', '', 'Sigma', '', '', 2014),
(28, 'hgould', '', '', '', '', 'Upsilon', '', '', 2014),
(29, 'rfried16', '', '', '', '', '', '', '', 2014),
(30, 'pjupe', 'Smiley', '', '', '', '', '', '', 2012),
(31, 'rmancuso', '', '', '', '', '', '', '', 2009),
(32, 'bgaffney', '', '', 'Sean Jameson', 'aprindle', '', '', '', 2011),
(33, 'wrvb', 'Hi, my name is Will, and I''m an alcoholic', '', 'Todd Kane', 'jhedrick,jbalchun', '', '', '', 2011),
(34, 'cpatrick', '', '', '', '', '', '', '', 2005),
(35, 'halloran', 'Fart Catcher', '', 'rspivak', 'djbattag', 'Kappa', 'Gamma', '', 2015),
(36, 'bradgold', '', '', '', '', '', '', '', 2015),
(37, 'evaten', '', '', '', '', '', '', '', 2015),
(38, 'mhildner', '', '', '', '', '', '', '', 2015),
(39, 'cameronw', '', '', '', '', '', '', '', 2015),
(40, 'tellis', '', '', '', '', '', '', '', 2015),
(41, 'jcampion', '', '', '', '', '', '', '', 2015),
(42, 'bengreen', '', '', '', '', '', 'Zeta (Spring 2013)', '', 2015),
(43, 'wallace4', 'Curb Stomp', '', 'kalinich', 'csparano', 'Beta', 'Gamma (Spring 2013)', '5th Back Single', 2015),
(44, 'bj1992', '', '', '', '', '', '', '', 2015),
(45, 'nmagu', '', '', '', '', 'Epsilon', '', '', 2015),
(46, 'jismith', '', '', '', '', '', '', '', 2015),
(47, 'warnera', '', '', '', '', 'Gamma', '', '', 2015),
(48, 'laithm', '', '', '', '', '', '', '', 2015),
(51, 'jmcunnin', '', '', '', '', 'Zeta', '', '', 2016),
(52, 'lvbanner', 'Precious', '', 'jlara', '', 'Delta', '', '', 2016),
(53, 'csparano', 'buttered walrus', 'magazine holders', 'wallace4', '', '', '', '', 2016),
(54, 'ghegg', '', '', '', '', '', '', '', 2016),
(55, 'jhanley', '', '', '', '', '', '', '', 2016),
(56, 'andresw', '', '', '', '', '', '', '', 2016),
(57, 'esparrs', 'Keebler Cumguzzler', 'Hand Sanitizers', 'Laith Maswadeh', '', '', 'Pledge Captain - DKE Class of 2016', '4th Pit', 2016),
(58, 'ctk1994', '', '', 'nmagu', '', '', '', '', 2016),
(59, 'bcope', '', '', '', '', '', '', '', 2016),
(60, 'djbattag', '', '', '', '', '', '', '', 2016),
(61, 'asnoakes', '', '', '', '', '', '', '', 2016),
(62, 'eklinkha', '', '', 'acboesch', '', '', '', '', 2016),
(63, 'ehuppert', '', '', '', '', '', '', '', 2016),
(64, 'atitus', '', '', '', '', '', '', '', 2017),
(65, 'bwalcher', '', '', '', '', '', '', '', 2017),
(66, 'cargenti', '', '', '', '', '', '', '', 2017),
(67, 'chrissan', '', '', '', '', '', '', '', 2017),
(68, 'dhoule', '', '', '', '', '', '', '', 2017),
(69, 'kvnkusch', '', '', '', '', '', '', '', 2017),
(70, 'mtiovino', '', '', '', '', '', '', '', 2017),
(71, 'lindsaym', '', '', '', '', '', '', '', 2017),
(72, 'nanaya', '', '', '', '', '', '', '', 2017),
(73, 'rkarnish', '', '', '', '', '', '', '', 2017),
(74, 'sethstud', '', '', '', '', '', '', '', 2017),
(76, 'herbanek', '', '', '', '', '', '', '', 2017);

-- --------------------------------------------------------

--
-- Table structure for table `brothers_mit`
--

CREATE TABLE IF NOT EXISTS `brothers_mit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(8) DEFAULT NULL,
  `majors` varchar(10) NOT NULL DEFAULT '',
  `minors` varchar(10) NOT NULL DEFAULT '',
  `concentration` varchar(20) NOT NULL DEFAULT '',
  `extracurriculars` text NOT NULL,
  `interests` text NOT NULL,
  `urops` text NOT NULL,
  `internships` text NOT NULL,
  `fav_classes` text NOT NULL,
  `year` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=78 ;

--
-- Dumping data for table `brothers_mit`
--

INSERT INTO `brothers_mit` (`id`, `uname`, `majors`, `minors`, `concentration`, `extracurriculars`, `interests`, `urops`, `internships`, `fav_classes`, `year`) VALUES
(1, 'dblake', '2', '', '', '', '', '', '', '', 2012),
(3, 'ambition', '15', 'MusPer', '', '', '', '', '', '', 2012),
(49, 'pjmaster', '6', '', '', '', '', '', '', '', 2015),
(5, 'wsantos', '8', '5,EDU', '', '', '', '', '', '', 2012),
(6, 'tzanetos', '6.2', '', '', '', '', '', '', '', 2012),
(7, 'wagnert', '10', '', '', '', '', '', '', '', 2012),
(8, 'kcweaver', '16', '', '', '', '', '', '', '', 2012),
(9, 'cdville', '6.3', '', 'CMS', 'Football, TAing', '', 'MIT Game Labs (GAMBIT)', '', '', 2013),
(10, 'jhedrick', '10B', '', '', '', '', '', '', '', 2013),
(11, 'kalinich', '10B', '7', '', '', '', '', '', '', 2013),
(12, 'mnackoul', '15', '', '', '', '', '', '', '', 2013),
(13, 'cholle', '2', 'PSY', '', '', '', '', '', '', 2013),
(14, 'eep77', '8,22', '', '', '', '', '', '', '', 2013),
(15, 'aprindle', '6.2', '', '', '', '', '', '', '', 2013),
(16, 'rspivak', '15,17', '14', '', '', '', '', '', '', 2013),
(17, 'jbalchun', '3', '', '', '', '', '', '', '', 2014),
(18, 'acboesch', '0', '', '', '', '', '', '', '', 2014),
(19, 'phillipm', '2', '', '', '', '', '', '', '', 2014),
(20, 'rhys34', '8', 'Philosophy', '', '', '', '', '', '', 2014),
(21, 'toolman7', '1', '', '', '', '', '', '', '', 2014),
(22, 'wwaste', '16.1', 'Music', '', '', '', 'Space Propulsion Lab (SPL), Aerospace Controls Lab (ACL)', '', '', 2014),
(23, 'jlara', '2', '14', '', '', '', '', '', '', 2014),
(24, 'dvaughn', '6.3,8', '', '', '', '', '', '', '', 2014),
(25, 'josephdr', '6.2', '', '', '', '', '', '', '', 2014),
(26, 'gillund', '2', '8', '', '', '', '', '', '', 2014),
(27, 'jlaux', '5', '7', '', '', '', '', '', '', 2014),
(28, 'hgould', '5,9', '', '', '', '', '', '', '', 2014),
(29, 'rfried16', '10', 'ENERGY', '', '', '', '', '', '', 2014),
(30, 'pjupe', '2', 'EngMan', '', '', '', '', '', '', 2012),
(31, 'rmancuso', '6.3', '', '', '', '', '', '', '', 2009),
(32, 'bgaffney', '6.3', '', '', '', '', '', '', '', 2011),
(33, 'wrvb', '2,8', '21W', '', '', '', '', '', '', 2011),
(34, 'cpatrick', '16', '14', '', '', '', '', '', '', 2005),
(35, 'halloran', '17', 'Management', 'Economics', '', '', 'w/ Prof Roger Petersen - Social Science & the Iraq War', 'MIT Washington Office; BK Trading (NYMEX)', '', 2015),
(36, 'bradgold', '6', '', '', '', '', '', '', '', 2015),
(37, 'evaten', '14,15', '', '', '', '', '', '', '', 2015),
(38, 'mhildner', '2', '', '', '', '', '', '', '', 2015),
(39, 'cameronw', '2', '', '', '', '', '', '', '', 2015),
(40, 'tellis', '2', '', '', '', '', '', '', '', 2015),
(41, 'jcampion', '2', '8', '', '', '', '', '', '', 2015),
(42, 'bengreen', '6', '', '', '', '', '', '', '', 2015),
(43, 'wallace4', '16-2, 6-2', '', '', 'Football', '', 'SSL: Zero Robotics, SSL: VERTIGO', '', '6.004', 2015),
(44, 'bj1992', '18c', 'GERMAN', '', '', '', '', '', '', 2014),
(45, 'nmagu', '10', '', '', '', '', '', '', '', 2014),
(46, 'jismith', '2', '', '', '', '', '', '', '', 2015),
(47, 'warnera', '2', '', '', '', '', '', '', '', 2015),
(48, 'laithm', '2', '', '', '', '', '', '', '', 2015),
(51, 'jmcunnin', '6.3', '', '', '', '', '', '', '', 2016),
(52, 'lvbanner', '2', '', '', '', '', '', '', '', 2016),
(53, 'csparano', '6', '', '', '', '', '', '', '', 2016),
(54, 'ghegg', '', '', '', '', '', '', '', '', 2016),
(55, 'jhanley', '', '', '', '', '', '', '', '', 2016),
(56, 'andresw', '2', '', '', '', '', '', '', '', 2016),
(57, 'esparrs', '6-3', '', '', 'StartLabs', 'Entrepreneurship', 'CSAIL - SLS', '', 'GSD', 2016),
(58, 'ctk1994', '2', '', '', '', '', '', '', '', 2016),
(59, 'bcope', '8', '', '', '', '', '', '', '', 2016),
(60, 'djbattag', '16', '', '', '', '', '', '', '', 2016),
(61, 'asnoakes', '6', '', '', '', '', '', '', '', 2016),
(62, 'eklinkha', '10', '', '', '', '', 'Work in Professor Trout''s group under a Dr. Vaysel Kayser on improving flu vaccine testing efficacy', '', '', 2015),
(64, 'ehuppert', '', '', '', '', '', '', '', '', 2016),
(65, 'atitus', '', '', '', '', '', '', '', '', 2017),
(66, 'bwalcher', '', '', '', '', '', '', '', '', 2017),
(67, 'cargenti', 'Course 2', 'Course 20', '', 'Football', '', '', '', '', 2017),
(68, 'chrissan', '', '', '', '', '', '', '', '', 2017),
(69, 'dhoule', '', '', '', '', '', '', '', '', 2017),
(70, 'kvnkusch', '', '', '', '', '', '', '', '', 2017),
(71, 'mtiovino', '10B', '7', '21M', 'Football, Theater', '', '', '', '', 2017),
(72, 'lindsaym', '18', '', '', 'Football', '', '', '', '', 2017),
(73, 'nanaya', '', '', '', '', '', '', '', '', 2015),
(74, 'rkarnish', '', '', '', 'Football', 'Sports', '', '', '', 2017),
(75, 'sethstud', '', '', '', '', '', '', '', '', 2017),
(77, 'herbanek', 'Course 6', '', '', 'Football', '', '', '', '', 2017);

-- --------------------------------------------------------

--
-- Table structure for table `brothers_personal`
--

CREATE TABLE IF NOT EXISTS `brothers_personal` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(8) NOT NULL DEFAULT '',
  `last_name` text NOT NULL,
  `first_name` text NOT NULL,
  `phone` varchar(10) NOT NULL DEFAULT '',
  `bio` text NOT NULL,
  `activities` text NOT NULL,
  `hobbies` text NOT NULL,
  `pro_team` text NOT NULL,
  `college_team` text NOT NULL,
  `movie` text NOT NULL,
  `quote` text NOT NULL,
  `hometown` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=116 ;

--
-- Dumping data for table `brothers_personal`
--

INSERT INTO `brothers_personal` (`id`, `uname`, `last_name`, `first_name`, `phone`, `bio`, `activities`, `hobbies`, `pro_team`, `college_team`, `movie`, `quote`, `hometown`) VALUES
(1, 'dblake', 'Blake', 'Douglas', '', '', 'Football', 'Computer building, hanging out with friends, fishing', '', 'Florida Gators', '', '', 'Tampa, Florida'),
(3, 'ambition', 'Krolewicz', 'Edan', '', 'I am interested in Entrepreneurship, Music, Travel, and philosophy.', 'Logarhythms, UA Finboard', 'Travel, Music, Basketball, Badminton, Swimming', 'New York Jets', 'MIT Engineers', 'Gladiator', '"Jesus take the wheel"', 'Patchogue, New York'),
(49, 'pjmaster', 'Masterson', 'Jacob', '7408192202', '', 'Football', 'Becoming the very best, like no one ever was.', 'New York Jets', 'Notre Dame Fighting Irish', 'Anchorman', '', 'Zanesville, OH'),
(5, 'wsantos', 'Santos', 'William', '', 'I couldn''t be who I am today without my parents, Martha and Alonso Santos, and my sisters Joanna and Kacy. My goal is to contribute to a better understanding of the physical world and to expand the appeal of higher education to disadvantaged students.', 'MIT Scheller Teacher Ed Program, Tutoring', 'Baseball, Pick-up sports, Fishing, Driving', 'Lakers, Raiders, White Sox', 'USC Trojans, CSUF (Fullerton) Titans', 'Stand & Deliver', '"Strength does not come from physical capacity. It comes from an indomitable will." - Mahatma Ghandi ', 'Diamond Bar, California'),
(6, 'tzanetos', 'Tzanetos', 'Theodore', '', 'President of DKE. Defensive end of the MIT Football team. Aspire to be a real life Tony Stark.', 'Football, MIT RC Flight Club, Maslab, 6.270', 'Sports, RC Aviation, Embedded controllers', 'New York Jets', 'MIT Engineers', 'Gladiator', '"You''ll never shine if you don''t glow" - Smashmouth', 'Plainview, New York'),
(7, 'wagnert', 'Wagner', 'Tyler', '', 'I''m Tyler, a Senior in Chemical Engineering with an interest in synthetic biology. I am a member of the 2011 MIT International Genetically Engineered Machines (iGEM) team and am hoping to pursue a grauduate education in biological engineering. Outside of school, I have played football, baseball, and wrestled for the majority of my life.', 'Football, iGEM', 'COD, lifting, baseball', 'Baltimore Ravens', 'UMD', 'The Matrix', '', 'Bel Air, Maryland'),
(8, 'kcweaver', 'Weaver', 'KC', '', '', '', '', '', '', '', '', 'Sheldon, Iowa'),
(9, 'cdville', 'Dessonville', 'Chris', '', 'From Omaha, Nebraska, Chris is a die-hard Nebraska football fan. He plays tight end for the MIT varsity football team.', 'Football', 'Web Development, Video Games, Sports', '', 'Nebraska Cornhuskers', '', '', 'Omaha, Nebraska'),
(10, 'jhedrick', 'Hedrick', 'James', '', 'As I child I enjoyed ice cream, insightful cartoons, and tossing the football, come to think of it, not much has changed.', 'Football, Society of Biological Engineering', 'Guitar', 'Pittsburgh Steelers, Los Angeles Lakers', 'Stanford Cardinal, Virginia Tech Hokies', 'Donnie Darko', '"Veni, Vidi, Veci" - Julius Caesar', 'Pleasanton, California'),
(11, 'kalinich', 'Kalinich', 'Mark', '', '', 'AiChE, SBE, Undergraduate Research', 'Weight lifting', 'Chicago Bears', 'Purdue Boilermakers', 'Dark Knight', '', 'St. John, Indiana'),
(12, 'mnackoul', 'Nackoul', 'Michael', '', 'I am from Pittsburgh, PA and I am currently a junior at MIT. I played football my freshman year but now i just compete in Olympic Weightlifting. I enjoying many outdoor activities and hanging out with friends.', 'Weightlifting', 'Fishing, White Water Rafting', 'Steelers, Pirates, Penguins', 'MIT Beavers', 'Forrest Gump', '"Our deepest fear is not that we are inadequate, our deepest fear is that we are powerful beyond all measure."', 'Canonsburg, Pennsylvania'),
(13, 'cholle', 'Olle', 'Chase', '', '', '', 'Art', 'Denver Broncos', 'Texas Longhorns', 'Scott Pilgrim vs the World', '"I came, I saw, I conquered" - Julius Cesar', 'Vail, Colorado'),
(14, 'eep77', 'Peterson', 'Ethan', '', 'Ethan is a junior from Rutland, VT majoring in nuclear science and engineering. He is on the varsity football team and club ice hockey team. He enjoys playing and listening to music as well as playing video games.', 'Football, Hockey', '', '', '', '', '', 'Rutland, Vermont'),
(15, 'aprindle', 'Prindle', 'Aaron', '', 'I swag hard....but I make it look like badminton.', 'RC Flying Club, IEEE Social Chair', 'Chess, Scuba Diving, Video Games, Surfing, Being a Gentleman, Dancing', 'Los Angeles Lakers', 'USC Trojans', 'Casablanca', '"You''re talking about practice..."', 'Yorba Linda, California'),
(16, 'rspivak', 'Spivak', 'Russell', '', 'I''m a movie fanatic, book worm, and a philosophy philosophizer. I''m always down for a thought-provoking conversation... with a little crude humor thrown in it.', 'Football, The Tech, Student Ambassadors, The Forum', 'Reading, Watching movies at ad nauseam', 'News York Yankees, New York Jets', 'Syracuse Orange', 'The Shawshank Redemption', '"Is it possible for a man to move the earth? Yes; but he must first find out another earth upon which to stand." - Jeremy Bentham', 'Scarsdale, New York'),
(17, 'jbalchun', 'Balchunas', 'James', '', '', '', '', '', '', '', '', 'Plainview, New York'),
(18, 'acboesch', 'Boesch', 'Austin', '', '', '', '', '', '', '', '', 'Maryland'),
(19, 'phillipm', 'Marmolejo', 'Phil', '', '', '', '', '', '', '', '', 'California'),
(20, 'rhys34', 'Borchert', 'Rhys', '', '', 'Football', 'Living in Idaho; Talking about physics and philosophy; Complaining about American politics', 'Chicago Bears', 'MIT Engineers', 'Avengers', '"We are a way for the universe to know itself." - Carl Sagan', 'Pocatello, Idaho'),
(21, 'toolman7', 'Wilson', 'Tim', '', '', 'Baseball', '', 'Texas Rangers', 'Texas A&M Aggies', 'The Rookie', '', 'Nacogdoches, Texas'),
(22, 'wwaste', 'Waste', 'Will', '', 'I was born and raised in San Francisco, CA. I am an Eagle Scout and enjoy doing anything outdoors.', 'Lacrosse, Football, RC Flight Club', 'Backpacking, Sailing, Music', 'San Francisco Giants, San Francisco 49ers, Boston Red Sox', 'USC Trojans', '', '"Do or do not, there is not try." - Yoda', 'San Francisco, California'),
(23, 'jlara', 'Lara', 'Jose', '', '', '', '', 'Lakers', 'Miami Hurricanes', 'Dark Knight', '"Life is hell, hell tells lies in your face"', 'El Paso, Texas'),
(24, 'dvaughn', 'Vaughn', 'Derek', '', 'I grew up in Nashville, TN before moving to Cambridge to attend MIT. I play Defensive Tackle for the football team and enjoy long walks on the beach.', 'Football', 'Sports, Outdoors, Video Games', 'Tennessee Titans', 'Vanderbilt', 'Goodfellas', '"You shall not pass!"', 'Nashville, Tennessee'),
(25, 'josephdr', 'Driscoll', 'Joe', '', 'Joseph Driscoll graduated from Torrey Pines High School in San Diego, California. He currently studies electrical engineering and computer science.', 'Football', '', 'San Diego Chargers, Washington Redskins', 'MIT Engineers', 'The Shawshank Redemption', '', 'San Diego, California'),
(26, 'gillund', 'Gillund', 'Daniel', '', 'I grew up on a farm in North Dakota. I''m an old-fashioned country boy making my way in the big city of Boston. In my spare time, I create art by hammering and twisting red-hot steel.', 'Football, Baptist Student Fellowship, Campus Crusade for Christ', 'Blacksmithing, Making Music', 'Green Bay Packers', 'MIT Engineers', 'The Return of the King', '"A man hath no better thing under the sun, than to eat, and to drink, and to be merry." - Ecclesiastes', 'Wildrose, North Dakota'),
(27, 'jlaux', 'Laux', 'Jake', '', 'I generally operate at one speed, that being full.  I''d like to become a government official at some point, so that when I tell someone it''s my way or the highway, both end up being my way.  I joke about most everything, and oftentimes are dead serious at the same time.', 'Football, Wrestling', 'Lifting weights, video games, trolling', 'Green Bay Packers', 'MIT Engineers', 'The Prestige', '"You don''t become great by accident." - Bob McGinn', 'Genesee, WI'),
(28, 'hgould', 'Gould', 'Heath', '', 'I was born and raised in Florida, moved to Vegas for high school. I play Linebacker on the varsity football team and conduct research on neurodegenerative disease in the off season. Upon graduation from MIT, I hope to attend medical school to study neurology / neurosurgery.', 'Football', '', 'Boston Red Sox', 'MIT Engineers', 'Good Will Hunting', '"It''s not the size of the dog in the fight, it''s the size of the fight in the dog." - Mark Twain', 'Las Vegas, Nevada'),
(29, 'rfried16', 'Friedrich', 'Ryan', '', 'I spent most of my life surrounded by women, and that''s the way I like it. I play football, act, occasional video games, and am MIT''s self proclaimed foremost expert on Pokémon.', 'Football, Acting, Stand Up Comedy', 'Chillin'', backyard football, golf, video games', 'Washington Redskins', '', 'Inception', '"I won''t be a rock star. I will be a legend." - Freddie Mercury', 'Waldorf, Maryland'),
(30, 'pjupe', 'Jupe', 'Patrick', '', 'Country Bumpkin.', 'MIT Electric Vehicle Team, Football', 'Pretty much anything not school related.', 'The Underdog', 'Texas Longhorns', 'Rush Hour', 'Every day I''m hustlin''', 'Austin, Texas'),
(31, 'rmancuso', 'Mancuso', 'Rick', '', 'During his years at MIT, Rick could be found shredding a plastic guitar or drum set, picking apart zone coverages (on both the real and virtual gridiron), or catching a game on the 2nd floor with some brothers.', 'Football', 'Video Games, Guitar', 'Miami Dolphins', 'Penn State Football, North Carolina Basketball', 'Anchorman', '"Good judgement comes from experience. Experience comes from bad judgement."', 'Dunmore, Pennsylvania'),
(32, 'bgaffney', 'Gaffney', 'Brad', '', 'I''m going into my first year as a grad student at MIT, trying to get my Master''s in EECS. I came to MIT so that I could learn to make video games, and that''s still my plan. Look for me soon in some credits...', 'MIT DanceTroupe, MIT Football', 'Video Games, Guitar', 'Philadelphia Eagles', '', 'Crash', '"I will punch you right in the mouth" - William Shakespeare', 'Chewelah, Washington'),
(33, 'wrvb', 'Vega-Brown', 'Will', '', 'I''m a first-year grad student working on robotics and autonomy. Since graduation, I''ve made it my mission to bring an element of class to DKE -- because everything is more fun if you do it with style.', 'Jiu-Jitsu', 'Robotics, writing', 'Philadelphia Eagles', 'Hawai''i Warriors', 'The Godfather', '', 'Salem, New Jersey'),
(34, 'cpatrick', 'Patrick', 'Cody', '', 'I''m the Resident Advisor of Delta Kappa Epsilon and was an Active member while at MIT from 2001 to 2005.  I played football for MIT during that time and now play for the MIT Rugby team while pursuing my Masters in Electrical Engineering with a specialty in Signal Processing.', 'Rugby', 'Wakeboarding', 'Dallas Cowboys', 'Texas Longhorns', 'The Big Lebowski', '"The Dude Abides"', 'Austin, Texas'),
(35, 'halloran', 'Halloran', 'John', '', 'John is from Long Island, NY.  ', 'Football', 'Lifting, Watching Jeopardy, Reading', 'New York Yankees', 'Notre Dame Fighting Irish', 'The Departed', '"A man is but the product of his thoughts. What he thinks, he becomes."', 'East Northport, New York'),
(36, 'bradgold', 'Goldsberry', 'Brad', '', 'Brad Goldsberry is from Elizabeth, CO and has often been considered a man among boys. He doesn''t know how to say this, but people know him. He''s kind of a big deal. And yes, his dorm room smells of rich mahogany.', 'Football', 'Lifting, fishing', 'Montreal Expos', 'MIT Engineers', 'Never Say Never', 'What''s done is done.', 'Elizabeth, Colorado'),
(37, 'evaten', 'Tencer', 'Evan', '', 'Evan is from New Milford, NJ where he attended the Bergen County Academies. He plans on majoring in 14/15 and plans on looking into opportunities in entrepreneurship as well as finance.', 'Football', 'Video Games, Movies, Chess, Philosophizing', 'New York Giants', 'MIT Engineers', 'Original Star Wars Trilogy', '"If you''re going through hell, keep going."', 'New Milford, New Jersey'),
(38, 'mhildner', 'Hildner', 'Matt', '', 'I lived in North Carolina for 12 years, then moved to Illinois for high school. In Illinois I attended Oswego East High school where I played on the football team, wrestled, and was captain of the FIRST robotics team. I intend to major in mechanical engineering with a focus in robotics.', 'Football', 'PC gaming, computer constuction, and building robots', 'Chicago Bears', 'Iowa Hawkeyes', 'Fight Club', '"Any intelligent fool can make things bigger and more complex." - Albert Einstein', 'Aurora, Illinois'),
(39, 'cameronw', 'Wagar', 'Cameron', '', 'I grew up in West Richland, Washington before coming to Cambridge to attend MIT. I play defensive back for the football team and I will throw javelin in the spring. I wouldn''t be where I am at today without all the support from my loving family and friends.', 'Football, Javelin', 'Video Games, Sleeping, Hanging out with Friends', 'New England Patriots, Seattle Supersonics', 'Duke Blue Devils', 'Terminator 2', '"I''m just a big, hairy American winning machine." - Ricky Bobby', 'West Richland, Washington'),
(40, 'tellis', 'Ellis', 'Tye', '', 'I''m Tye Ellis, I enjoy discovering new movies and music. I play football for MIT and am always down to chill.', 'Football', 'Photography, Sports, Music', 'Tennessee Titans, Minnesota Twins', '', 'Pulp Fiction', '', 'Shady Side, Maryland'),
(41, 'jcampion', 'Campion', 'Joey', '', 'I was born in Baltimore but grew up in Jamestown. I''ve played football and basketball almost all my life. I want to work hard at MIT so someday my paychecks look like phone numbers. And I love hanging out with my friends.', 'Football, Basketball', 'Music, dancing', 'Buffalo Bills', 'MIT Engineers', 'Shutter Island', '"To conquer without risk is to triumph without glory."', 'Jamestown, New York'),
(42, 'bengreen', 'Greenberg', 'Ben', '', 'I enjoy just hanging around and having a good time.  I never get stressed out, and I''m always down for a little fun.  When I put my mind to something though, watch out.  I don''t have hobbies, I have obsessions.  When I take up a new interest, my life will be so engrossed in mastering this new field that I will hardly think about anything else for weeks at a time.', 'RC flying club, football', 'Unicycling, go, pokemon, distance running, Karate', 'New York Jets', 'MIT Engineers', 'Space Jam', 'Eagles may soar, but weasels don''t get sucked into jet engines', 'Pleasantville, New York'),
(43, 'wallace4', 'Wallace', 'Justin', '2248481556', ' I graduated from Fremd High School in Palatine, Illinois. I play Runningback for MIT''s football team, and enjoy playing video games.', 'Football', '', 'Chicago Blackhawks', 'MIT Engineers', 'Inception', '"No power in the the ''verse can stop me"', 'Palatine, Illinois'),
(44, 'bj1992', 'Johnson', 'Brent', '', '', 'Football, Track and Field', '', 'Green Bay Packers', 'Ohio State Buckeyes', 'Step Brothers', '', 'La Canada, California'),
(45, 'nmagu', 'Nmagu', 'Doug', '', 'I was born and lived in Washington D.C for 10 years. I moved to Maryland afterwards where I attended Eleanor Roosevelt High School. I am the second youngest out of six children(4 sisters, 1 brother).', 'Football, NSBE, ASA, AIChE, BSU, BWA', 'Cars, football, basketball, shoes', 'Washington Redskins', 'University of Miami', 'Dark Knight', '"If you want something done right, you gotta do it yourself."', 'Lanham, Maryland'),
(46, 'jismith', 'Smith', 'Jose', '', 'I''m a Cuban-american who grew up in Miami Florida and have been playing football all my life. I enjoy fishing, hunting and I plan on studying management here at MIT.', 'Football', 'Fishing, Hunting', 'New England Patriots', 'Florida Gators', 'Gangs of New York', '"Speak softly, but carry a big stick."', 'Miami, Florida'),
(47, 'warnera', 'Warner', 'Alex', '', 'I attended Pope John XXIII High School before coming up to MIT.  I play offensive guard and center for the football team.', 'Football', 'Chilling, lacrosse, fishing', 'Oakland Raiders', 'Notre Dame', 'Hunt for the Red October', '"Dictionary is the only place that success comes before work. Hard work is the price we must pay for success. I think you can accomplish anything if you''re willing to pay the price." - Vince Lombardi', 'Rockaway, New Jersey'),
(48, 'laithm', 'Maswadeh', 'Laith', '', 'Laith is an MIT freshman who aspires for world domination. He also enjoys long naps and absolute silence.', 'Football', 'Sleeping', '', '', '', '', 'Fountain Valley, California'),
(51, 'jmcunnin', 'Cunningham', 'Joseph', '', 'I was born in Memphis, TN and then moved to Chicago, where I graduated from St. Ignatius. I play football and will likely play rugby here at MIT.', 'Football, Rugby', '', 'St. Louis Cardinals, Chicago Bears', '', 'Pulp Fiction', 'Only a man who knows what it is like to be defeated can reach down to the bottom of his soul and come up with the extra ounce of ower to win when it is even--- Muhammad Ali', 'Chicago, IL'),
(52, 'lvbanner', 'Banner', 'Luther', '', '', 'Football', 'Music, Sports', 'St. Louis Cardinals, St. Louis Rams, and LA Lakers', 'Missouri Tigers', '', '', 'St. Louis, MO'),
(53, 'csparano', 'Sparano-Huiban', 'Christopher', '', 'I am Christopher Sparano-Huiban and I grew up in Stamford, Connecticut. I play football as an offensive line man and I intend to study civil engineering.', 'Football', 'Model Trains, Fishing', 'New York Giants', '', 'Miracle', '"It''s kind of fun to do the impossible." -Walt Disney', 'Stamford, Connecticut'),
(54, 'ghegg', 'Hegg', 'Geoffrey', '', 'I grew up in the suburbs outside of Philadelphia. I love all aspects of football, playing and watching it. For the Engineers I play offensive line. Other than football my other passion is singing and theater. I''m a fairly easy going and nice guy and will help when needed. I''m looking to major in Course 10 (Chemical Engineering) but I''m not entirely sure yet.', 'Football, Theater', 'Music, Video Games, Board Games', 'Philadelphia Eagles', 'MIT Engineers', 'Forrest Gump', '"With great power comes great responsibility."', 'Devon, PA'),
(55, 'jhanley', 'Hanley', 'Joseph', '', 'Joe was born and raised in New York. He plays offensive line for MIT and plans on studying computer science. Some refer to him as Mongo, and claim that his days consist solely of eating, smashing things, and speaking in the third person. These claims are false and slanderous. Joe is a scholar and a gentleman.', 'Football', 'Basketball, Video Games, Picking up and putting down heavy things', 'New York Giants', '', 'Pulp Fiction', '"Do, or do not. There is no try." - Yoda', 'Somers, New York'),
(56, 'andresw', 'Wallentin', 'Andres', '', 'Andres''s reputation precedes him, like lightning precedes thunder. The ancient Mayans prophesized his birth. As a baby, he taught others how to walk. At the tender age of 7 he quit school, because the teacher called "Recess," and he doesn''t play. At the less tender age of 12 he was pronounced dead for the first time.', 'Football, BGSA, MITI, ORIGAMIT, TMRC, USWIM', 'Hobbies: Films, Cooking, Puzzles, Pina Coladas, Getting Caught in the Rain', 'Washington Redskins', 'Aztecas Universidad de las Americas Puebla', 'Watchmen', '', 'Mexico City, Mexico'),
(57, 'esparrs', 'Esparrago', 'Seve', '', 'I was born and raised in Saint Louis, Missouri. I graduated from Saint Louis Priory School, and I play football for MIT.', 'Football', '', 'Saint Louis Cardinals', 'MIT Engineers', 'Good Will Hunting', '"The greatest pleasure in life is doing what others say you cannot do."', 'Saint Louis, MO'),
(58, 'ctk1994', 'Kufa', 'Cosma', '', '', '', 'Winning in FIFA', 'New Orleans Saints, LA Lakers', 'North Carolina Tarheels, Alabama Crimson Tide', 'Inception', '"What does it take to be number one?"', 'Harare, Zimbabwe'),
(59, 'bcope', 'Copeland', 'Brian', '', '', 'Football', 'Solving Rubik''s Cubes and Playing Chess', 'Seattle Seahawks', 'MIT Engineers', 'Gattaca', '', 'Snoqualmie, WA'),
(60, 'djbattag', 'Battaglia', 'Dillon', '', '', 'Football, Air Force ROTC', '', 'Green Bay Packers, Cleveland Indians, Jeff Gordon', 'MIT Engineers', '', '"A good leader is a person who takes a little more than his share of the blame and a little less than his share of the credit." - John C. Maxwell', 'Henderson, NV'),
(61, 'asnoakes', 'Noakes', 'Alexander', '', '', 'Football, Track (throwing)', '', 'Atlanta Falcons', 'Georgia Bulldogs', 'A Beautiful Mind', '', 'Watkinsville, GA'),
(62, 'eklinkha', 'Klinkhammer', 'Eric', '', 'I''m a rower and I graduated from Middlesex School in Concord, MA. I''m also a dual citizen from Canada and hope to do research after graduating.', 'Rowing', 'Painting, Video Games, Politics', 'Ottawa Senators', 'MIT Engineers', 'V for Vendetta', '"There is advantage in the wisdom won from pain" - Aeschylus', 'Ottawa, Ontario, Canada'),
(102, 'ehuppert', 'Huppert', 'Eric', '', '', '', '', '', '', '', '', ''),
(103, 'atitus', 'Titus', 'Andrew', '4439743937', 'My name is Drew Titus and I play left tackle for the Engineers. People seem to like me because I am polite and rarely late. I like to eat ice cream and really enjoy a nice pair of slacks. Years later, a doctor will tell me that I have an IQ of 48 and am what some people call "mentally retarded"...\r\n\r\nAnyway, I am from Maryland and I enjoy crabs and Old Bay. I love doing all sorts of things and making the most of everything in life. I also have a funny last name and others... make the most of that. Excited to be at MIT!!', '', '', '', '', '', '"I haaardly think that''s any of your business" - Peter Griffin', 'Finksburg, MD'),
(104, 'bwalcher', 'Walcher', 'Bradley', '3035707701', '', '', '', '', '', '', 'Hard work beats talent when talent doesn''t work.', 'Aurora CO'),
(105, 'cargenti', 'Argenti', 'Christian', '6109065989', '', '', '', '', '', '', '', 'Hellertown, PA'),
(106, 'chrissan', 'Sanfilippo', 'Christopher', '', '', '', '', '', '', '', '', 'Orchard Park'),
(107, 'dhoule', 'Houle', 'David', '7342237150', '', '', '', '', '', '', '', 'Plymouth, MI'),
(108, 'kvnkusch', 'Kusch', 'Kevin', '9252166959', '', '', '', '', '', '', '', 'Mobile, Al'),
(109, 'mtiovino', 'Iovino', 'Matthew', '6319219996', '', '', '', '', '', '', '"When you want to succeed as bad as you want to breathe, then you''ll be successful"', 'Sayville, NY'),
(110, 'lindsaym', 'Lindsay', 'Matthew', '6303527088', '', '', '', '', '', '', '', 'Batavia IL'),
(111, 'nanaya', 'Anaya', 'Nicholas', '2037334777', 'I''m a junior in courses 14/15 with a minor in 18. ', '', '', '', '', '', 'Fortune favors the audacious ', 'Brookfield, Connecticut'),
(112, 'rkarnish', 'Karnish', 'Ryan', '', '', '', '', '', '', '', '"When my time on earth is gone, and my activities here are passed, I want they bury me upside down, and my critics can kiss my ass!" - Bob Knight', 'Nesquehoning, Pennsylvania'),
(113, 'sethstud', 'Studebaker', 'Seth', '8304563940', '', '', '', '', '', '', '', 'Fredericksburg, Tx'),
(115, 'herbanek', 'Herbanek', 'Travis', '8326388275', 'I''m a Texan -- born and raised. In Texas, we have God and football. I''m a Christian and play slot receiver for the MIT Engineers. Additionally, I love to hunt and fish. I also enjoy building and working with computers. ''Merica.', '', '', '', '', '', '"Of course not, this is a lovely room of death!"', 'Richmond, TX');

-- --------------------------------------------------------

--
-- Table structure for table `chapter_public`
--

CREATE TABLE IF NOT EXISTS `chapter_public` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pname` varchar(10) DEFAULT NULL,
  `user` varchar(10) DEFAULT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pname` (`pname`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `chapter_public`
--

INSERT INTO `chapter_public` (`id`, `pname`, `user`, `title`, `content`) VALUES
(1, 'letter', 'beta', 'A Letter from the DKE President', 'I am very proud to say that the Delta Kappa Epsilon Sigma Tau chapter has continued it''s tradition of excellence and leadership on the MIT campus. This was made possible by an excellent group of officers who have kept the house running smoothly, and a dedicated, passionate group of actives.\r\n\r\nJose Lara ''14 has provided excellent leadership as the chapter''s vice president and risk manager, working with alumni to re-structure and refine our risk management policies. Ethan Peterson ''13, the house treasurer, has continued to perform very well with the incredibly difficult job of managing the chapter''s finances. Matthew Hildner ''15, our chapter''s house manager, has been going a great job of keeping the house clean as well as maintaining and updating it. James Balchunas ''14, the house social chair, did a great job to take our minds off of academics with some nice parties and mixers. Finally, Ben Greenberg ''15, the house steward, has kept a close relationship with our new chef, Dan West, and done a great job at ensuring that every brother is happy with the meal plan and our formals.\r\n\r\nIf you are walking around the DKE house in the new academic year, you might see some new faces. Our recruitment chair, Phil Marmolejo ''14, facilitated a successful rush in 2012 that resulted in 12 freshmen pledging to Delta Kappa Epsilon. We are happy to welcome Luther Banner III, Joseph Hanley, Joseph Cunningham, Brian Copeland, Geoffrey Hegg, Seve Esparrago, Chris Sparano-Huiban, Eric Klinkhammer, Cosma Kufa, Alexander Noakes, Andres Wallentin, and Dillon Battaglia as the 2016 DKE Sigma Tau pledge class.\r\n\r\nAs always, the DKE brothers at MIT continued their participation and leadership in MIT athletics. The MIT Football team sported a total of 31 DKE brothers and pledges, including 3 brothers as captains of this year''s team. In 2011, DKE saw 13 brothers get placed on the NEFC All-Academic Team, 2 brothers were named Academic All-Americans, and 1 brother was named the ECAC Offensive Rookie of the Year. This winter we saw Ethan Peterson ''13 crush opponents on the ice left and right, helping lead MIT to a second consecutive NECHA championship. Jacob Laux continued his dominant performance on the wrestling mat this past year, qualifying for the national tournament. One of our new pledges, Klinkhammer ''15, is helping represent MIT at the Division I level as part of the heavyweight crew team. Tim Wilson ''14 will continue his role as a relief pitcher for the baseball team this spring when practice resumes. Actives Greenberg and Laith Maswadeh ''15, and alumni Will Vega-Brown ''11 all still actively participating in MIT''s Jiu Jitsu club.\r\n\r\nDKE brothers have also been active across the campus, having brothers participate and help lead The Tech, the MIT Student Ambassadors, Dance Troupe, Mentor Connection, the R.C. Flight Club, the 2013 Ring Committee, and the American Institute of Chemical Engineers. Furthermore, DKEs are academically varied and ambitious, participating in UROPs in courses 2, 5, 6, 7, 8, 10, 16, 17, 22, and CMS.\r\n\r\nAs we look forward to a new year, we perform the sad duty of saying goodbye to the senior class. Many of the graduating class are leaving MIT to start their careers in a number of different fields, and the rest will be off to graduate school. Whatever their destination, we wish them the best of luck and hope they will always remember the good times they had here at Delta Kappa Epsilon.\r\n\r\nRussell Spivak ''13\r\n\r\nPresident, Delta Kappa Epsilon, Sigma Tau Chapter'),
(2, 'about', 'broporn', 'About DKE', 'The Sigma Tau Chapter of Delta Kappa Epsilon is a fraternity at the Massachusetts Institute of Technology. DKE was chartered on November 14th, 1890 as the tenth MIT fraternity. It was founded by members of a local society, Alpha Gamma Kappa, that had been established to petition for a new DKE charter.\r\n\r\nToday, the DKE house stands in the middle of the West Campus, along dorm row between Baker House and Burton-Conner, along with a few fellow fraternities. DKEs are actively involved in all facets of campus life from varsity and club athletics, to The Tech, to community service.');

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

--
-- Dumping data for table `house_points`
--

INSERT INTO `house_points` (`uname`, `beta_f`, `beta_s`, `sigma_f`, `sigma_s`, `zeta_f`, `zeta_s`, `epsilon_f`, `epsilon_s`, `delta_f`, `delta_s`, `gamma_f`, `gamma_s`) VALUES
('acboesch', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('andresw', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('asnoakes', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('atitus', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('bcope', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('bengreen', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('bj1992', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('bradgold', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('bwalcher', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cameronw', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('cargenti', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('chrissan', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('csparano', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('ctk1994', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('dhoule', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('djbattag', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('dvaughn', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('ehuppert', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('eklinkha', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('esparrs', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('evaten', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('ghegg', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('gillund', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('halloran', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('herbanek', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('hgould', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jbalchun', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jcampion', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jhanley', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jismith', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jlara', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jlaux', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('jmcunnin', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('josephdr', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('kvnkusch', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('laithm', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('lindsaym', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('lvbanner', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('mhildner', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('mtiovino', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('nanaya', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('nmagu', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('phillipm', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('pjmaster', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('rfried16', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('rhys34', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('rkarnish', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('sethstud', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('tellis', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('toolman7', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('wallace4', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('warnera', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('wwaste', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `house_rooms`
--

CREATE TABLE IF NOT EXISTS `house_rooms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `floor` int(1) NOT NULL,
  `name` text NOT NULL,
  `capacity` int(1) NOT NULL,
  `occupant0` varchar(8) DEFAULT NULL,
  `occupant1` varchar(8) DEFAULT NULL,
  `occupant2` varchar(8) DEFAULT NULL,
  `occupant3` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=602 ;

--
-- Dumping data for table `house_rooms`
--

INSERT INTO `house_rooms` (`id`, `floor`, `name`, `capacity`, `occupant0`, `occupant1`, `occupant2`, `occupant3`) VALUES
(102, 1, 'Kitchen', 0, '', '', '', ''),
(104, 1, 'First Single', 0, '', '', '', ''),
(105, 1, 'Front Entry', 0, '', '', '', ''),
(106, 1, 'Bar', 0, '', '', '', ''),
(108, 1, 'Pantry', 0, '', '', '', ''),
(201, 2, 'Living Room', 0, '', '', '', ''),
(202, 2, 'Library', 0, '', '', '', ''),
(205, 2, 'Pantry', 0, '', '', '', ''),
(206, 2, 'Dining Room', 0, '', '', '', ''),
(207, 2, 'RA Single', 1, '', '', '', ''),
(301, 3, 'Third Stair Front', 2, 'evaten', '', '', ''),
(302, 3, 'Third Stair Back', 2, 'mhildner', '', '', ''),
(303, 3, 'Third Single', 1, 'wwaste', '', '', ''),
(304, 3, 'Saturn Back', 2, 'rhys34', '', '', ''),
(305, 3, 'Saturn Front', 2, 'eklinkha', 'acboesch', '', ''),
(309, 3, 'Third Pit', 4, 'jbalchun', 'phillipm', '', ''),
(311, 3, 'Panda', 4, 'jmcunnin', 'csparano', '', ''),
(401, 4, 'Fourth Stair Front', 2, 'jlara', 'aprindle', '', ''),
(402, 4, 'Fourth Stair Back', 2, 'toolman7', '', '', ''),
(403, 4, 'Fourth Single', 1, 'dvaughn', '', '', ''),
(404, 4, 'Sunset Back', 2, 'halloran', '', '', ''),
(405, 4, 'Sunset Front', 2, 'ghegg', 'bcope', '', ''),
(409, 4, 'Fourth Pit', 4, 'esparrs', 'lvbanner', '', ''),
(411, 4, 'Carport', 4, 'bengreen', 'jhanley', '', ''),
(500, 5, 'Balcony', 0, '', '', '', ''),
(501, 5, 'Fifth Stair', 2, 'rfried16', 'pjmaster', '', ''),
(503, 5, 'President Single', 1, 'jlaux', '', '', ''),
(505, 5, 'Jungle', 2, 'nmagu', 'ctk1994', '', ''),
(509, 5, 'Ocean', 4, 'warnera', 'tellis', 'asnoakes', ''),
(510, 5, '5th Back Single', 1, 'wallace4', '', '', ''),
(601, 6, 'Roof', 0, '', '', '', '');

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
  `disp` tinyint(1) NOT NULL DEFAULT '0',
  `contact` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `positions`
--

INSERT INTO `positions` (`id`, `position`, `name`, `uname`, `start_date`, `disp`, `contact`) VALUES
(1, 'beta', 'President', 'wallace4', '2013-02-03', 1, 'Major issues; Issues Relevant to entire house'),
(2, 'sigma', 'Vice President & Risk Manager', 'jlaux', '2013-02-03', 1, 'Any serious issues or anything pertaining to risk'),
(3, 'kappa', 'Treasurer', 'halloran', '2013-02-03', 1, 'Financial issues '),
(4, 'zeta', 'House Manager', 'jmcunnin', '2013-09-15', 1, 'Issues pertaining to upkeep of the house '),
(5, 'epsilon', 'House Steward', 'nmagu', '2013-09-15', 0, ''),
(6, 'delta', 'Social Chair', 'lvbanner', '2013-09-15', 1, 'Social event planning '),
(7, 'psi', 'Rush Chair', 'wwaste', '2013-02-03', 0, ''),
(8, 'pi', 'New Member Educator', 'wwaste', '2013-09-15', 0, ''),
(9, 'upsilon', 'Community Service Chair', 'hgould', '2013-02-03', 1, 'Community service events '),
(10, 'gamma', 'Assistant to the Pi', 'warnera', '2014-01-04', 0, ''),
(11, 'broweb', 'Webmaster', 'wallace4', '2014-01-04', 1, 'Issues pertaining to the website'),
(12, 'zeta_s', 'Summer House Manager', '', '2014-01-05', 1, 'Summer housing');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `name` varchar(11) NOT NULL,
  `val` int(11) NOT NULL,
  `desc` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`name`, `val`, `desc`) VALUES
('debug', 1, NULL),
('server', 0, '0 - Local, Server Development Mode\r\n1 - Server Main');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
