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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_request`
--

LOCK TABLES `log_request` WRITE;
/*!40000 ALTER TABLE `log_request` DISABLE KEYS */;
INSERT INTO `log_request` VALUES (1,'1.2.3.4.5','somewhere','2021-11-21 13:45:42'),(2,'1.2.3.4.5','somewhere','2021-11-21 13:50:47'),(3,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-21 14:06:07'),(4,'6.6.6.6','http://0.0.0.0:8080/webservice/apelmanggakucing','2021-11-23 07:52:21'),(5,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:37:25'),(6,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:39:13'),(7,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:39:44'),(8,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:45:42'),(9,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:45:53'),(10,'127.0.0.1:4040','http://0.0.0.0:8080/webservice/apelmanggakucing','2021-11-24 05:48:23'),(11,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:54:37'),(12,'127.0.0.1:4040','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 05:55:02'),(13,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 14:41:47'),(14,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 16:26:13'),(15,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 16:39:46'),(16,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 18:04:32'),(17,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 18:09:43'),(18,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-24 18:10:43'),(19,'127.0.0.1','http://localhost:8080/webservice/apelmanggakucing','2021-11-26 02:14:54');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'Flour',60000),(2,'Apple',12),(4,'Fish',3),(6,'Mango',10),(7,'Cat',5),(8,'Bird',15),(9,'Magic Powder',100),(10,'Mushroom',30),(11,'Water',1000),(12,'Tea',1000),(13,'Fire',1000),(14,'Earth',3),(15,'French Fries',100),(16,'Ice Cream',200),(17,'Carrot',15),(18,'Ham',15),(19,'Cheese',50),(20,'Tomato',100),(21,'Binturong',1),(22,'Soap',15),(23,'Spinach',10),(24,'Taco',10),(25,'Potato',200),(26,'Garlic',30),(27,'Dolphin',20),(28,'Whale',5),(29,'Shark',3),(30,'Bread',10),(31,'Dorayaki',3),(32,'Oil',1000),(33,'Gear',50);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,'Apple','Steve Jobs\'s secret recipe.'),(2,'Mango','Mango mango mango mango mango mango mango'),(3,'Cat','Most people don\'t like eating cats because they\'re cute. Well, they don\'t know that cat actually tastes really good. Now we only need to turn the cat into a dorayaki and they won\'t know any better lol.'),(4,'Bird','Don\'t you just want to eat birds. I like birds.'),(5,'Sharky','Apex predator of the ocean, now inside a dorayaki'),(6,'Alien','It tastes like an alien all right. You wouldn\'t know how an alien taste like though.'),(7,'Doraemon','Ah ah ah, I love you so much, Doraemon'),(8,'Worm','Wormy. I like worms.'),(9,'ITB','Elephant, Gajah Mada, Ganesha'),(10,'Bat','Bringer of disease and plague'),(11,'Snake','Snake? Snake? SNAKEEEEEEEEEEE!'),(12,'Exotic','Exotic animals, rare treasures, natural wonders.'),(13,'Family','Nothing is more important than family'),(14,'Robot','Beep Boop I\'m a robot');
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
INSERT INTO `recipe_material` VALUES (1,1,50),(1,2,1),(2,1,1000),(3,1,50),(3,7,1),(3,17,10),(3,31,5),(4,1,100),(4,8,10),(4,22,10),(4,25,5),(4,27,10),(5,4,20),(5,27,3),(5,28,1),(5,29,10),(6,1,500),(6,11,10),(6,13,10),(6,14,1),(7,9,10),(7,10,10),(7,15,9),(7,24,3),(7,26,20),(8,1,100),(8,7,1),(8,10,1),(8,22,10),(8,30,1),(9,1,10),(9,9,100),(10,9,10),(10,16,1),(10,18,10),(10,26,100),(10,28,10),(11,1,10),(11,8,10),(11,22,10),(11,25,10),(12,1,500),(12,9,100),(12,14,3),(12,21,10),(12,27,10),(13,1,1),(13,11,1),(14,32,10),(14,33,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (1,'1.2.3.4.5','ACCEPTED',1,1,0,'2021-11-25 13:45:20'),(2,'1.2.3.4.5','REJECTED',1,7,0,'2021-11-25 13:45:20');
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
  `username` varchar(255) NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'pisangjerukanjing@gmail.com','pisangjerukanjing','$2b$10$K1/CWIK.BOGRGP6MlSlz7.qWuFP/7m/1fjoPRp28EwrZnWVHXO1de'),(4,'13519096@std.stei.itb.ac.id','girvinjunod','$2b$10$UsOKl5hXxql3NjNhMcSua.tfc5vdEJpp5U6kz8iGRmAf49qgFYcuG'),(6,'yudistira@yudis.yu.di.ss','siduy','$2b$10$W/sQBKKZAt9W2gNe3ca4NeQ6nBoefsAgTsXdXmOW4nJfYuiPQK9/6'),(8,'13519096@std.stei.itb.ac.id','girvinjunodddd','$2b$10$0F47gjxgWUJem3sqAdruiOoWtdc9gOgV9HYDCFvzMIcnqAQno13pu'),(9,'bella@meong.co.id','bella','$2b$10$B8/dwSBdQcs7XtTdf3ERm.QdroRRdTkxbtULBYniWtcBTdPLjn9MC'),(10,'apelmanggakucing@gmail.com','apelmanggakucing','$2b$10$h6kOZaAmUgExRIfm7lvuFObU0rOBhVQ9e85LJBRO2RUajIyiyRLPu'),(11,'apelkucing123@gmail.com','apelkucing','$2b$10$bQvGQzjzaFTmnZvLwLJ9peUCcY2gLQhpW7Xq.aJ3WvO0UGXAbE4S.'),(12,'apelmanggakucing@gmail.com','apel22','$2b$10$S2Npr//wpLixFvlW...PUemF606eGaCMV1WKS/2mI0jJVFACCsIju'),(13,'apelkucing123@gmail.com','apelkucing123','$2b$10$BjbUlUQhnP3byWgXUpJpwuwz9ghau1CVYZeIobO2eG41NFkFlWYLO');
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

-- Dump completed on 2021-11-26 12:47:10
