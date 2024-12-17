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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `start_date` datetime(3) DEFAULT NULL,
  `end_date` datetime(3) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `status` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `name` longtext,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Bangalore'),(2,'Pune'),(3,'Mumbai'),(4,'Delhi'),(5,'Nagpur'),(6,'Jaipur'),(7,'Ahmedabad'),(8,'Kolkata'),(9,'Indore');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `email` varchar(255) DEFAULT NULL,
  `mobile` longtext,
  `address` longtext,
  `license_number` longtext,
  `role` longtext,
  `password` longtext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Payal','payalrocks@yahoo.com','8668396480','wardha','123443211234','customer','$2a$10$1nPmIfmdwFJYSs2.D.L/QOE8mhdPhfN4YQNwuWAI45hnNDVPKc5NC','2024-10-11 06:44:26','2024-10-11 06:44:26');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_costs`
--

DROP TABLE IF EXISTS `vehicle_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_costs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vehicle_id` bigint NOT NULL,
  `base_price` double DEFAULT NULL,
  `hourly_rate` double DEFAULT NULL,
  `km_limit` bigint DEFAULT NULL,
  `extra_rate_per_km` double DEFAULT NULL,
  `daily_rate` double DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `vehicle_costs_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_costs`
--

LOCK TABLES `vehicle_costs` WRITE;
/*!40000 ALTER TABLE `vehicle_costs` DISABLE KEYS */;
INSERT INTO `vehicle_costs` VALUES (1,1,240,40,60,5,500,'08:00:00','21:00:00'),(2,2,250,45,70,6,550,'08:00:00','21:00:00'),(3,3,200,35,60,4,450,'08:00:00','21:00:00'),(4,4,180,30,50,3,400,'08:00:00','21:00:00'),(5,5,300,50,80,7,700,'08:00:00','21:00:00');
/*!40000 ALTER TABLE `vehicle_costs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_location`
--

DROP TABLE IF EXISTS `vehicle_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_location` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `available` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=424 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_location`
--

LOCK TABLES `vehicle_location` WRITE;
/*!40000 ALTER TABLE `vehicle_location` DISABLE KEYS */;
INSERT INTO `vehicle_location` VALUES (1,1,1,'yes'),(2,2,2,'yes'),(3,3,4,'yes'),(7,4,6,'yes'),(8,5,7,'yes'),(10,7,9,'yes'),(11,8,1,'yes'),(12,9,1,'yes'),(13,10,2,'yes'),(14,11,2,'yes'),(15,12,2,'yes'),(16,13,2,'yes'),(17,14,2,'yes'),(18,15,2,'yes'),(19,16,2,'yes'),(20,17,2,'yes'),(21,18,2,'yes'),(22,19,2,'yes'),(23,20,2,'yes'),(24,21,3,'yes'),(25,22,3,'yes'),(26,23,3,'yes'),(27,24,3,'yes'),(28,25,3,'yes'),(29,26,3,'yes'),(30,27,3,'yes'),(31,28,3,'yes'),(32,29,3,'yes'),(33,30,3,'yes'),(34,31,4,'yes'),(35,32,4,'yes'),(36,33,4,'yes'),(37,34,4,'yes'),(38,35,4,'yes'),(39,36,4,'yes'),(40,37,4,'yes'),(41,38,4,'yes'),(42,39,4,'yes'),(43,40,4,'yes'),(44,41,5,'yes'),(45,42,5,'yes'),(46,43,5,'yes'),(47,44,5,'yes'),(48,45,5,'yes'),(49,46,5,'yes'),(50,47,5,'yes'),(51,48,5,'yes'),(52,49,5,'yes'),(53,50,5,'yes'),(54,51,6,'yes'),(55,52,6,'yes'),(56,53,6,'yes'),(57,54,6,'yes'),(58,55,6,'yes'),(59,56,6,'yes'),(60,57,6,'yes'),(61,58,6,'yes'),(62,59,6,'yes'),(63,60,6,'yes'),(64,61,7,'yes'),(65,62,7,'yes'),(66,63,7,'yes'),(67,64,7,'yes'),(68,65,7,'yes'),(69,66,7,'yes'),(70,67,7,'yes'),(71,68,7,'yes'),(72,69,7,'yes'),(73,70,7,'yes'),(74,71,8,'yes'),(75,72,8,'yes'),(76,73,8,'yes'),(77,74,8,'yes'),(78,75,8,'yes'),(79,76,8,'yes'),(80,77,8,'yes'),(81,78,8,'yes'),(82,79,8,'yes'),(83,80,8,'yes'),(84,81,9,'yes'),(85,82,9,'yes'),(86,83,9,'yes'),(87,84,9,'yes'),(88,85,9,'yes'),(89,86,9,'yes'),(90,87,9,'yes'),(91,88,9,'yes'),(92,89,9,'yes'),(93,90,9,'yes'),(94,91,1,'yes'),(95,92,1,'yes');
/*!40000 ALTER TABLE `vehicle_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_types`
--

DROP TABLE IF EXISTS `vehicle_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_types` (
  `type_id` bigint NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `description` longtext,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_types`
--

LOCK TABLES `vehicle_types` WRITE;
/*!40000 ALTER TABLE `vehicle_types` DISABLE KEYS */;
INSERT INTO `vehicle_types` VALUES (1,'Electric Bike','Battery-powered bike'),(2,'Gear Bike','Bike with gears'),(3,'Non-Gear Bike','Bike without gears');
/*!40000 ALTER TABLE `vehicle_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `model` longtext,
  `year` bigint DEFAULT NULL,
  `type_id` bigint DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `booked_till_date` longtext,
  `price_per_hour` double DEFAULT NULL,
  `image` longtext,
  `vehicle_type_name` longtext,
  PRIMARY KEY (`id`),
  KEY `fk_vehicles_vehicle_type` (`type_id`),
  CONSTRAINT `fk_vehicles_vehicle_type` FOREIGN KEY (`type_id`) REFERENCES `vehicle_types` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=448 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (1,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg','Gear'),(2,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg','Gear'),(3,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg','Non-Gear'),(4,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg','Non-Gear'),(5,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg','Electric'),(6,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg','Electric'),(13,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(14,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(15,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(16,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(17,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(18,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(20,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(21,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(22,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(23,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(24,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(25,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(26,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(27,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(28,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(29,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(30,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(31,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(35,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(36,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(37,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(38,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(39,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(40,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(41,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(42,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(43,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(44,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(45,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(46,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(47,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(48,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(49,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(50,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(51,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(52,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(53,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(54,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(55,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(56,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(57,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(58,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(66,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(67,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(68,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(69,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(70,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(71,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(72,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(73,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(74,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(75,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(76,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(77,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(78,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(79,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(80,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(81,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(82,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(83,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(84,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(85,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(86,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(87,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(88,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(89,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(90,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(91,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(92,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(93,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(94,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(95,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(96,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(97,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(98,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(99,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(100,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(101,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(102,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(103,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(104,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(105,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(106,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(107,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(108,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(109,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(110,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(111,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(112,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(113,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(129,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(130,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(131,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(132,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(133,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(134,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(135,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(136,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(137,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(138,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(139,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(140,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(141,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(142,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(143,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(144,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(145,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(146,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(147,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(148,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(149,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(150,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(151,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(152,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(153,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(154,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(155,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(156,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(157,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(158,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(159,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(160,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(161,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(162,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(163,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(164,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(165,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(166,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(167,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(168,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(169,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(170,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(171,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(172,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(173,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(174,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(175,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(176,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(177,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(178,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(179,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(180,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(181,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(182,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(183,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(184,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(185,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(186,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(187,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(188,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(189,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(190,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(191,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(192,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(193,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(194,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(195,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(196,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(197,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(198,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(199,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(200,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(201,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(202,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(203,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(204,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(205,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(206,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(207,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(208,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(209,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(210,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(211,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(212,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(213,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(214,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(215,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(216,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(217,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(218,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(219,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(220,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(221,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(222,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(223,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(224,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(256,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(257,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(258,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(259,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(260,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(261,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(262,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(263,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(264,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(265,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(266,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(267,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(268,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(269,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(270,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(271,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(272,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(273,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(274,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(275,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(276,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(277,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(278,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(279,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(280,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(281,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(282,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(283,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(284,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(285,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(286,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(287,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(288,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(289,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(290,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(291,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(292,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(293,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(294,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(295,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(296,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(297,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(298,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(299,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(300,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(301,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(302,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(303,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(304,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(305,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(306,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(307,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(308,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(309,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(310,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(311,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(312,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(313,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(314,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(315,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(316,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(317,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(318,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(319,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(320,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(321,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(322,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(323,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(324,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(325,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(326,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(327,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(328,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(329,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(330,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(331,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(332,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(333,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(334,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(335,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(336,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(337,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(338,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(339,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(340,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(341,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(342,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(343,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(344,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(345,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(346,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(347,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(348,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(349,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(350,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(351,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(352,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(353,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(354,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(355,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(356,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(357,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(358,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(359,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(360,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(361,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(362,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(363,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(364,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(365,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(366,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(367,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(368,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(369,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(370,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(371,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(372,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(373,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(374,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(375,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(376,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(377,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(378,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(379,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(380,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(381,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(382,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(383,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(384,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(385,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(386,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(387,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(388,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(389,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(390,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(391,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(392,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(393,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(394,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(395,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(396,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(397,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(398,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(399,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(400,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(401,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(402,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(403,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(404,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(405,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(406,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(407,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(408,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(409,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(410,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(411,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(412,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(413,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(414,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(415,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(416,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(417,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(418,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(419,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(420,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(421,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(422,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(423,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(424,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(425,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(426,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(427,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(428,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(429,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(430,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(431,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(432,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(433,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(434,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(435,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(436,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(437,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(438,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(439,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(440,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(441,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL),(442,'Yamaha MT-15',2022,3,1,NULL,10,'https://example.com/yamaha_mt15.jpg',NULL),(443,'KTM Duke 390',2023,3,1,NULL,12,'https://example.com/ktm_duke390.jpg',NULL),(444,'Bajaj Pulsar 150',2021,2,1,NULL,8,'https://example.com/bajaj_pulsar150.jpg',NULL),(445,'Honda Shine',2020,2,0,'2024-10-25',7.5,'https://example.com/honda_shine.jpg',NULL),(446,'Hero Electric Photon',2022,1,1,NULL,9,'https://example.com/hero_electric_photon.jpg',NULL),(447,'Ather 450X',2023,1,1,NULL,11,'https://example.com/ather_450x.jpg',NULL);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-16 10:43:23
