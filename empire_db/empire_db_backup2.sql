-- MySQL dump 10.13  Distrib 8.0.39, for Linux (x86_64)
--
-- Host: localhost    Database: empire_db
-- ------------------------------------------------------
-- Server version	8.0.39-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Assignment`
--

DROP TABLE IF EXISTS `Assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assignment` (
  `AssignmentID` int NOT NULL AUTO_INCREMENT,
  `PersonID` int DEFAULT NULL,
  `LocationID` int DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  PRIMARY KEY (`AssignmentID`),
  KEY `PersonID` (`PersonID`),
  KEY `LocationID` (`LocationID`),
  CONSTRAINT `Assignment_ibfk_1` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`),
  CONSTRAINT `Assignment_ibfk_2` FOREIGN KEY (`LocationID`) REFERENCES `Location` (`LocationID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assignment`
--

LOCK TABLES `Assignment` WRITE;
/*!40000 ALTER TABLE `Assignment` DISABLE KEYS */;
INSERT INTO `Assignment` VALUES (1,1,1,'1977-05-25','2024-09-09'),(2,2,2,'2020-11-24',NULL),(3,3,1,'1977-05-25','2019-12-20'),(4,4,4,'2000-02-01','2024-12-31'),(5,5,1,'1999-12-24','2025-08-15'),(6,6,3,'2024-05-06','2026-10-20'),(7,12,1,'2024-11-13','2024-11-22'),(8,13,1,'2024-11-14','2024-12-07');
/*!40000 ALTER TABLE `Assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Biome`
--

DROP TABLE IF EXISTS `Biome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Biome` (
  `BiomeID` int NOT NULL AUTO_INCREMENT,
  `BiomeType` varchar(50) NOT NULL,
  PRIMARY KEY (`BiomeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Biome`
--

LOCK TABLES `Biome` WRITE;
/*!40000 ALTER TABLE `Biome` DISABLE KEYS */;
INSERT INTO `Biome` VALUES (1,'Space Station'),(2,'Forest Moon'),(3,'Temperate Highlands'),(4,'Artificial Temperate Urban');
/*!40000 ALTER TABLE `Biome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hourly`
--

DROP TABLE IF EXISTS `Hourly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hourly` (
  `PersonID` int NOT NULL,
  `PayTypeID` int DEFAULT NULL,
  `HourlyRate` decimal(10,2) NOT NULL,
  `HoursWorked` int DEFAULT NULL,
  `OvertimeEligibility` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`PersonID`),
  KEY `PayTypeID` (`PayTypeID`),
  CONSTRAINT `Hourly_ibfk_1` FOREIGN KEY (`PayTypeID`) REFERENCES `PayType` (`PayTypeID`),
  CONSTRAINT `Hourly_ibfk_2` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hourly`
--

LOCK TABLES `Hourly` WRITE;
/*!40000 ALTER TABLE `Hourly` DISABLE KEYS */;
INSERT INTO `Hourly` VALUES (2,1,25.00,30,1),(6,1,45.00,40,1);
/*!40000 ALTER TABLE `Hourly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JobRank`
--

DROP TABLE IF EXISTS `JobRank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `JobRank` (
  `RankID` int NOT NULL AUTO_INCREMENT,
  `RankName` varchar(100) NOT NULL,
  `PayTypeID` int DEFAULT NULL,
  PRIMARY KEY (`RankID`),
  KEY `PayTypeID` (`PayTypeID`),
  CONSTRAINT `JobRank_ibfk_1` FOREIGN KEY (`PayTypeID`) REFERENCES `PayType` (`PayTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JobRank`
--

LOCK TABLES `JobRank` WRITE;
/*!40000 ALTER TABLE `JobRank` DISABLE KEYS */;
INSERT INTO `JobRank` VALUES (1,'Trooper',1),(2,'Sergeant',1),(3,'Captain',2),(4,'Commander',2),(5,'Sith',3),(6,'Admiral',2),(7,'Engineer',1);
/*!40000 ALTER TABLE `JobRank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `PlanetName` varchar(100) NOT NULL,
  `BiomeID` int DEFAULT NULL,
  PRIMARY KEY (`LocationID`),
  KEY `BiomeID` (`BiomeID`),
  CONSTRAINT `Location_ibfk_1` FOREIGN KEY (`BiomeID`) REFERENCES `Biome` (`BiomeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (1,'Death Star',1),(2,'Endor',2),(3,'Aldhani',3),(4,'Coruscant',4);
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PayType`
--

DROP TABLE IF EXISTS `PayType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PayType` (
  `PayTypeID` int NOT NULL,
  `PayScale` enum('Hourly','Salary','Per Diem') NOT NULL,
  PRIMARY KEY (`PayTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PayType`
--

LOCK TABLES `PayType` WRITE;
/*!40000 ALTER TABLE `PayType` DISABLE KEYS */;
INSERT INTO `PayType` VALUES (1,'Hourly'),(2,'Salary'),(3,'Per Diem');
/*!40000 ALTER TABLE `PayType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PerDiem`
--

DROP TABLE IF EXISTS `PerDiem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PerDiem` (
  `PersonID` int NOT NULL,
  `PayTypeID` int DEFAULT NULL,
  `DailyRate` decimal(10,2) NOT NULL,
  `ExpenseAllowance` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`PersonID`),
  KEY `PayTypeID` (`PayTypeID`),
  CONSTRAINT `PerDiem_ibfk_1` FOREIGN KEY (`PayTypeID`) REFERENCES `PayType` (`PayTypeID`),
  CONSTRAINT `PerDiem_ibfk_2` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PerDiem`
--

LOCK TABLES `PerDiem` WRITE;
/*!40000 ALTER TABLE `PerDiem` DISABLE KEYS */;
INSERT INTO `PerDiem` VALUES (1,3,50.00,500.00),(3,3,100.00,1000.00);
/*!40000 ALTER TABLE `PerDiem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `PersonID` int NOT NULL AUTO_INCREMENT,
  `Age` int DEFAULT NULL,
  `RankID` int DEFAULT NULL,
  `SpecializationID` int DEFAULT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  PRIMARY KEY (`PersonID`),
  KEY `RankID` (`RankID`),
  KEY `SpecializationID` (`SpecializationID`),
  CONSTRAINT `Person_ibfk_1` FOREIGN KEY (`RankID`) REFERENCES `JobRank` (`RankID`),
  CONSTRAINT `Person_ibfk_2` FOREIGN KEY (`SpecializationID`) REFERENCES `Specialization` (`SpecializationID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (1,41,5,1,'Anakin','Skywalker'),(2,24,1,5,'Jane','Doe'),(3,84,5,1,'Sheev','Palpatine'),(4,58,6,6,'Mitth\'raw','Nuruodo'),(5,30,3,4,'Ciena','Ree'),(6,34,7,7,'Lira','Kent'),(12,32,1,5,'Testy','McTesterton'),(13,55,5,1,'New','Newton');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Salary`
--

DROP TABLE IF EXISTS `Salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Salary` (
  `PersonID` int NOT NULL,
  `PayTypeID` int DEFAULT NULL,
  `AnnualSalary` decimal(10,2) NOT NULL,
  `BonusEligibility` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`PersonID`),
  KEY `PayTypeID` (`PayTypeID`),
  CONSTRAINT `Salary_ibfk_1` FOREIGN KEY (`PayTypeID`) REFERENCES `PayType` (`PayTypeID`),
  CONSTRAINT `Salary_ibfk_2` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Salary`
--

LOCK TABLES `Salary` WRITE;
/*!40000 ALTER TABLE `Salary` DISABLE KEYS */;
INSERT INTO `Salary` VALUES (4,2,150000.00,1),(5,2,90000.00,0);
/*!40000 ALTER TABLE `Salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Specialization`
--

DROP TABLE IF EXISTS `Specialization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Specialization` (
  `SpecializationID` int NOT NULL AUTO_INCREMENT,
  `SpecializationType` varchar(100) NOT NULL,
  PRIMARY KEY (`SpecializationID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Specialization`
--

LOCK TABLES `Specialization` WRITE;
/*!40000 ALTER TABLE `Specialization` DISABLE KEYS */;
INSERT INTO `Specialization` VALUES (1,'Sith Lord'),(2,'Stormtrooper'),(3,'Engineer'),(4,'Tactical Officer'),(5,'Scout Trooper'),(6,'Commanding Officer'),(7,'Droid Technician'),(8,'Imperial Pilot');
/*!40000 ALTER TABLE `Specialization` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-18  3:54:25
