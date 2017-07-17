-- --------------------------------------------------------
-- Host:                         192.168.2.104
-- Server version:               5.5.55-0+deb8u1 - (Debian)
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for memoryBase
CREATE DATABASE IF NOT EXISTS `memoryBase` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `memoryBase`;

-- Dumping structure for table memoryBase.Emotion
CREATE TABLE IF NOT EXISTS `Emotion` (
  `EmotionKey` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`EmotionKey`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Identifies a particular feeling towards a memory.';

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.LifeEvent
CREATE TABLE IF NOT EXISTS `LifeEvent` (
  `LifeEventKey` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(128) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LifeEventKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Represents major life events, such as high school, college, a girlfriend, etc. Memories are grouped and associated by one or more corresponding life events.';

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.Memory
CREATE TABLE IF NOT EXISTS `Memory` (
  `MemoryKey` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Title` varchar(128) NOT NULL,
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`MemoryKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.MemoryEmotion
CREATE TABLE IF NOT EXISTS `MemoryEmotion` (
  `MemoryEmotionKey` int(11) NOT NULL AUTO_INCREMENT,
  `MemoryKey` int(11) NOT NULL,
  `EmotionKey` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  `Intensity` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`MemoryEmotionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.MemoryLifeEvent
CREATE TABLE IF NOT EXISTS `MemoryLifeEvent` (
  `MemoryLifeEventKey` int(11) NOT NULL AUTO_INCREMENT,
  `MemoryKey` int(11) NOT NULL,
  `LifeEventKey` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`MemoryLifeEventKey`),
  KEY `FK_MemoryLifeEventMemoryKey_MemoryMemoryKey` (`MemoryKey`),
  KEY `FK_MemoryLifeEventLifeEventKey_LifeEventLifeEventKey` (`LifeEventKey`),
  CONSTRAINT `FK_MemoryLifeEventMemoryKey_MemoryMemoryKey` FOREIGN KEY (`MemoryKey`) REFERENCES `Memory` (`MemoryKey`),
  CONSTRAINT `FK_MemoryLifeEventLifeEventKey_LifeEventLifeEventKey` FOREIGN KEY (`LifeEventKey`) REFERENCES `LifeEvent` (`LifeEventKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Junction table between Memories and Life Events.';

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.MemoryNote
CREATE TABLE IF NOT EXISTS `MemoryNote` (
  `MemoryNoteKey` int(11) NOT NULL AUTO_INCREMENT,
  `MemoryKey` int(11) NOT NULL,
  `Text` text NOT NULL,
  `DateAdded` datetime NOT NULL,
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`MemoryNoteKey`),
  KEY `FK_MemoryNoteMemoryKey_MemoryMemoryKey` (`MemoryKey`),
  CONSTRAINT `FK_MemoryNoteMemoryKey_MemoryMemoryKey` FOREIGN KEY (`MemoryKey`) REFERENCES `Memory` (`MemoryKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores text descriptions and stories for a particular memory.';

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.MemoryPerson
CREATE TABLE IF NOT EXISTS `MemoryPerson` (
  `MemoryPersonKey` int(11) NOT NULL AUTO_INCREMENT,
  `MemoryKey` int(11) NOT NULL DEFAULT '0',
  `PersonKey` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`MemoryPersonKey`),
  KEY `FK_MemoryPersonMemoryKey_MemoryMemoryKey` (`MemoryKey`),
  KEY `FK_MemoryPersonPersonKey_PersonPersonKey` (`PersonKey`),
  CONSTRAINT `FK_MemoryPersonMemoryKey_MemoryMemoryKey` FOREIGN KEY (`MemoryKey`) REFERENCES `Memory` (`MemoryKey`),
  CONSTRAINT `FK_MemoryPersonPersonKey_PersonPersonKey` FOREIGN KEY (`PersonKey`) REFERENCES `Person` (`PersonKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Associates a list of people with a particular memory.';

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.MemoryTag
CREATE TABLE IF NOT EXISTS `MemoryTag` (
  `MemoryTagKey` int(11) NOT NULL AUTO_INCREMENT,
  `MemoryKey` int(11) NOT NULL,
  `TagKey` int(11) NOT NULL,
  `DateAdded` datetime NOT NULL,
  PRIMARY KEY (`MemoryTagKey`),
  KEY `FK_MemoryTagMemoryKey_MemoryMemoryKey` (`MemoryKey`),
  KEY `FK_MemoryTagTagKey_TagTagKey` (`TagKey`),
  CONSTRAINT `FK_MemoryTagMemoryKey_MemoryMemoryKey` FOREIGN KEY (`MemoryKey`) REFERENCES `Memory` (`MemoryKey`),
  CONSTRAINT `FK_MemoryTagTagKey_TagTagKey` FOREIGN KEY (`TagKey`) REFERENCES `Tag` (`TagKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Junction table betweem Memories and Tags.';

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.Person
CREATE TABLE IF NOT EXISTS `Person` (
  `PersonKey` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) NOT NULL,
  `DateMet` date DEFAULT NULL,
  `FirstMemoryKey` int(11) DEFAULT NULL,
  PRIMARY KEY (`PersonKey`),
  KEY `FK_PersonFirstMemoryKey_MemoryMemoryKey` (`FirstMemoryKey`),
  CONSTRAINT `FK_PersonFirstMemoryKey_MemoryMemoryKey` FOREIGN KEY (`FirstMemoryKey`) REFERENCES `Memory` (`MemoryKey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table memoryBase.Tag
CREATE TABLE IF NOT EXISTS `Tag` (
  `TagKey` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '0',
  `Deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TagKey`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='A list of searchable tags for a memory.';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
