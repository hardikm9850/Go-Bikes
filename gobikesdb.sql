-- MySQL dump 10.13  Distrib 9.0.1, for macos14 (arm64)
--
-- Host: localhost    Database: gobikes
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Table structure for table `Booking`
--

DROP TABLE IF EXISTS `Booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Booking` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `VehicleID` int unsigned NOT NULL,
  `UserID` int NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `TotalPrice` decimal(10,2) NOT NULL,
  `Status` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `VehicleID` (`VehicleID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`VehicleID`) REFERENCES `Vehicle` (`ID`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking`
--

LOCK TABLES `Booking` WRITE;
/*!40000 ALTER TABLE `Booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `Booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (1,'Bangalore'),(2,'Mysore'),(3,'Delhi'),(4,'Mumbai'),(5,'Chennai'),(6,'Hyderabad'),(7,'Pune'),(8,'Jaipur'),(9,'Kolkata'),(10,'Ahmedabad');
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `role` enum('admin','customer') NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vehicle`
--

DROP TABLE IF EXISTS `Vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vehicle` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Model` varchar(255) NOT NULL,
  `Year` int NOT NULL,
  `TypeId` int NOT NULL,
  `Available` tinyint(1) NOT NULL,
  `BookedTillDate` varchar(255) DEFAULT NULL,
  `PricePerHour` decimal(10,2) NOT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `VehicleTypeName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `TypeId` (`TypeId`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`TypeId`) REFERENCES `VehicleType` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicle`
--

LOCK TABLES `Vehicle` WRITE;
/*!40000 ALTER TABLE `Vehicle` DISABLE KEYS */;
INSERT INTO `Vehicle` VALUES (1,'Hero Honda CBZ',2020,1,1,NULL,100.00,'images/gear_hero_cbz.jpg','Gear'),(2,'Yamaha YZF R15',2021,1,1,NULL,150.00,'images/gear_yzf_r15.jpg','Gear'),(3,'Bajaj Pulsar 220F',2019,1,1,NULL,120.00,'images/gear_pulsar_220f.jpg','Gear'),(4,'Honda Activa 6G',2021,2,1,NULL,80.00,'images/non_gear_honda_activa.jpg','Non-Gear'),(5,'TVS Jupiter',2020,2,1,NULL,75.00,'images/non_gear_tvs_jupiter.jpg','Non-Gear'),(6,'Bajaj Chetak',2022,2,1,NULL,90.00,'images/non_gear_bajaj_chetak.jpg','Non-Gear'),(7,'Ather 450X',2022,3,1,NULL,200.00,'images/electric_ather_450x.jpg','Electric'),(8,'Ola S1',2022,3,1,NULL,180.00,'images/electric_ola_s1.jpg','Electric'),(9,'Revolt RV400',2021,3,1,NULL,220.00,'images/electric_revolt_rv400.jpg','Electric');
/*!40000 ALTER TABLE `Vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VehicleLocations`
--

DROP TABLE IF EXISTS `VehicleLocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VehicleLocations` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `VehicleId` int unsigned NOT NULL,
  `LocationId` int unsigned NOT NULL,
  `Available` varchar(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `VehicleId` (`VehicleId`),
  KEY `LocationId` (`LocationId`),
  CONSTRAINT `vehiclelocations_ibfk_1` FOREIGN KEY (`VehicleId`) REFERENCES `Vehicle` (`ID`),
  CONSTRAINT `vehiclelocations_ibfk_2` FOREIGN KEY (`LocationId`) REFERENCES `Location` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VehicleLocations`
--

LOCK TABLES `VehicleLocations` WRITE;
/*!40000 ALTER TABLE `VehicleLocations` DISABLE KEYS */;
INSERT INTO `VehicleLocations` VALUES (1,1,1,'yes'),(2,1,2,'no'),(3,2,1,'yes'),(4,2,3,'yes'),(5,3,4,'no'),(6,3,5,'yes'),(7,4,6,'yes'),(8,5,7,'yes'),(9,6,8,'no'),(10,7,9,'yes');
/*!40000 ALTER TABLE `VehicleLocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VehicleType`
--

DROP TABLE IF EXISTS `VehicleType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VehicleType` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VehicleType`
--

LOCK TABLES `VehicleType` WRITE;
/*!40000 ALTER TABLE `VehicleType` DISABLE KEYS */;
INSERT INTO `VehicleType` VALUES (1,'Gear',NULL),(2,'Non-gear',NULL),(3,'Electric',NULL);
/*!40000 ALTER TABLE `VehicleType` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-11 11:37:48
