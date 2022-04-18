-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: groupomania_database
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `postId` int unsigned NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comContent` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_userId_idx` (`id`),
  KEY `fk-comments_postId_idx` (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,29,'2022-04-16 16:22:17',''),(2,1,29,'2022-04-16 16:27:23','rrrrrrr'),(3,1,29,'2022-04-16 16:27:29','eeeeeee'),(4,1,29,'2022-04-16 16:32:57','hello'),(5,1,28,'2022-04-16 16:50:54','hello2'),(6,1,28,'2022-04-16 16:51:35','bonjour'),(7,1,28,'2022-04-16 16:56:19','hello'),(8,1,29,'2022-04-16 17:02:24','rrrrrrr'),(9,1,30,'2022-04-17 17:35:40','genial'),(10,1,30,'2022-04-18 09:39:19','super'),(11,2,32,'2022-04-18 09:43:33','trop bien'),(12,1,32,'2022-04-18 15:25:17','genial !'),(13,1,32,'2022-04-18 15:30:23','hello'),(14,1,33,'2022-04-18 15:59:27','super'),(15,1,33,'2022-04-18 15:59:33','bon');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `postId` int unsigned NOT NULL,
  `userId` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `fk_like_postId` (`postId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `userId` int unsigned NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` varchar(500) NOT NULL,
  `date` datetime NOT NULL,
  `likes` int(10) unsigned zerofill NOT NULL,
  `img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (30,1,'salut les copains','salut les copains','2022-04-17 17:35:12',0000000000,'http://localhost:3000/images/dragonballzcoloriage_1650213312366.gif'),(31,1,'hello','hello','2022-04-17 17:53:11',0000000000,'http://localhost:3000/images/Raskrasil-loshad-50_1650214391601.jpg'),(32,2,'coucou','coucou','2022-04-18 09:42:55',0000000000,'http://localhost:3000/images/teamwork-3213924_1920_1650271375224.jpg'),(33,1,'top','top','2022-04-18 15:59:18',0000000000,'http://localhost:3000/images/tabasco_1650293958136.jpg'),(34,1,'post','post','2022-04-18 16:35:19',0000000000,'http://localhost:3000/images/sriracha_1650296119275.jpg'),(35,1,'test','test','2022-04-18 16:42:36',0000000000,'http://localhost:3000/images/authentification_1650296556615.jpg'),(36,1,'llll','lllll','2022-04-18 16:49:43',0000000000,'http://localhost:3000/images/wasabi_1650296983273.jpg'),(37,1,'bonjour','bonjour','2022-04-18 18:02:31',0000000000,'http://localhost:3000/images/pexels-asad-photo-maldives-1591375_1650301351636.jpg'),(38,1,'bb','bb','2022-04-18 18:24:51',0000000000,'http://localhost:3000/images/8_1650302691275.jpg'),(39,1,'hello','hello','2022-04-18 21:22:06',0000000000,''),(40,1,'bonjour','bonjour','2022-04-18 21:23:15',0000000000,'http://localhost:3000/images/algérienne_1650313395243.jpg'),(41,1,'hello','hello','2022-04-18 21:24:09',0000000000,'');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lastName` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `moderation` int unsigned DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ponn','barseille','ponn.barseille@groupomania.com',NULL,'$2b$10$YyWrxIrtgAwhVReaDmC5deEeOO6J5c3QDD5RFOLbnhCaDrSFAiWNW'),(2,'admin','admin','admin@groupomania.com',1,'$2b$10$9WZ5FBy6seAuVy1SCzWXyegWpk4x2aiJFjXtFXly7bLWK.JaI7im6'),(3,'z','z','z@groupomania.com',NULL,'$2b$10$kBfNxLb0mJnhtCLS1WdBp.1x59tD9yQPt43XtPshtl4SJExc..Tlm'),(4,'b','b','b@groupomania.com',NULL,'$2b$10$Ll17uhJyTgLcxoI3KJ40EeUiMPtOCkWVTJkMFoppVXTdJiQNStTVq'),(5,'a','a','a@groupomania.com',NULL,'$2b$10$L7/Vv/WmT.vSUSh.5niDAeuk/7NFdIdM75jXmCfjPSQ/Wk83LPsTy'),(6,'f','f','f@groupomania.com',NULL,'$2b$10$Xyoz7CKXc6Siwe9vL63Hnu2fGeWHMpjPMH83.d5JRfJtQhC5/Pelq');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-18 21:41:40
