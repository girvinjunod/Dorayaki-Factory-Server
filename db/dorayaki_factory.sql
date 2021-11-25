-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: dorayaki_factory
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

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
-- Table structure for table `log_request`
--

DROP TABLE IF EXISTS `log_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_request` (
  `id_log_request` int NOT NULL AUTO_INCREMENT,
  `ip_store` text NOT NULL,
  `endpoint_request` text NOT NULL,
  `time_request` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log_request`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_request`
--

LOCK TABLES `log_request` WRITE;
/*!40000 ALTER TABLE `log_request` DISABLE KEYS */;
INSERT INTO `log_request` VALUES (1,'1.2.3.4.5','somewhere','2021-11-21 13:45:42'),(2,'1.2.3.4.5','somewhere','2021-11-21 13:50:47'),(3,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-21 14:06:07'),(4,'6.6.6.6','http://0.0.0.0:8080/webservice/apelmanggakucing','2021-11-23 07:52:21'),(5,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:37:25'),(6,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:39:13'),(7,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:39:44'),(8,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:45:42'),(9,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:45:53'),(10,'127.0.0.1:4040','http://0.0.0.0:8080/webservice/apelmanggakucing','2021-11-24 05:48:23'),(11,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:54:37'),(12,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:55:02'),(13,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 14:41:47'),(14,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 16:26:13'),(15,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 16:39:46'),(16,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 18:04:32'),(17,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 18:09:43'),(18,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 18:10:43');
/*!40000 ALTER TABLE `log_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `id_material` int NOT NULL AUTO_INCREMENT,
  `material_name` text NOT NULL,
  `material_stock` int NOT NULL,
  PRIMARY KEY (`id_material`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'Flour',600),(2,'Apple',12),(4,'Fish',10);
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `id_recipe` int NOT NULL AUTO_INCREMENT,
  `recipe_name` text NOT NULL,
  `recipe_desc` text,
  PRIMARY KEY (`id_recipe`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,'Apple','Steve Jobs\'s secret recipe.'),(2,'Generic','They say the best dorayaki is without any flavoring at all.'),(33,'Fish','Taste of the sea');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_material`
--

DROP TABLE IF EXISTS `recipe_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_material` (
  `id_recipe` int NOT NULL,
  `id_material` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`id_recipe`,`id_material`),
  KEY `id_material` (`id_material`),
  CONSTRAINT `recipe_material_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`),
  CONSTRAINT `recipe_material_ibfk_2` FOREIGN KEY (`id_material`) REFERENCES `material` (`id_material`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_material`
--

LOCK TABLES `recipe_material` WRITE;
/*!40000 ALTER TABLE `recipe_material` DISABLE KEYS */;
INSERT INTO `recipe_material` VALUES (1,1,50),(1,2,1),(2,1,1000),(33,4,1);
/*!40000 ALTER TABLE `recipe_material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request` (
  `id_request` int NOT NULL AUTO_INCREMENT,
  `ip_store` text NOT NULL,
  `status_request` text NOT NULL,
  `id_recipe` int NOT NULL,
  `count_request` int NOT NULL,
  `updated` tinyint(1) NOT NULL,
  `created_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_request`),
  KEY `id_recipe` (`id_recipe`),
  CONSTRAINT `request_ibfk_1` FOREIGN KEY (`id_recipe`) REFERENCES `recipe` (`id_recipe`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (1,'1.2.3.4.5','ACCEPTED',1,1,0,'2021-11-25 13:45:20'),(2,'1.2.3.4.5','REJECTED',1,7,0,'2021-11-25 13:45:20'),(3,'127.0.0.1:4040','REJECTED',1,69,0,'2021-11-25 13:45:20'),(4,'6.6.6.6','REJECTED',1,5,0,'2021-11-25 13:45:20'),(10,'127.0.0.1:4040','REJECTED',1,5,0,'2021-11-25 13:45:20'),(11,'127.0.0.1:4040','ACCEPTED',1,3,0,'2021-11-25 13:45:20'),(12,'127.0.0.1:4040','REJECTED',2,5,0,'2021-11-25 13:45:20'),(13,'127.0.0.1','ACCEPTED',1,7,1,'2021-11-25 13:45:20'),(14,'127.0.0.1','ACCEPTED',1,3,1,'2021-11-25 13:45:20'),(15,'127.0.0.1','ACCEPTED',1,1,1,'2021-11-25 13:45:20'),(16,'127.0.0.1','ACCEPTED',1,4,1,'2021-11-25 13:45:20'),(17,'127.0.0.1','ACCEPTED',1,3,1,'2021-11-25 13:45:20'),(19,'1.2.327.0.0.1','REJECTED',2,10,0,'2021-11-25 13:49:56'),(20,'127.0.0.1','REJECTED',2,10,0,'2021-11-25 13:51:01');
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `email` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'pisangjerukanjing@gmail.com','pisangjerukanjing','$2b$10$K1/CWIK.BOGRGP6MlSlz7.qWuFP/7m/1fjoPRp28EwrZnWVHXO1de'),(4,'13519096@std.stei.itb.ac.id','girvinjunod','$2b$10$UsOKl5hXxql3NjNhMcSua.tfc5vdEJpp5U6kz8iGRmAf49qgFYcuG'),(6,'yudistira@yudis.yu.di.ss','siduy','$2b$10$W/sQBKKZAt9W2gNe3ca4NeQ6nBoefsAgTsXdXmOW4nJfYuiPQK9/6'),(8,'13519096@std.stei.itb.ac.id','girvinjunodddd','$2b$10$0F47gjxgWUJem3sqAdruiOoWtdc9gOgV9HYDCFvzMIcnqAQno13pu'),(9,'bella@meong.co.id','bella','$2b$10$B8/dwSBdQcs7XtTdf3ERm.QdroRRdTkxbtULBYniWtcBTdPLjn9MC'),(10,'apelmanggakucing@gmail.com','apelmanggakucing','$2b$10$h6kOZaAmUgExRIfm7lvuFObU0rOBhVQ9e85LJBRO2RUajIyiyRLPu');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-25 20:52:31
