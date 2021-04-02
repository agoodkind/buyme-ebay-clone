CREATE DATABASE  IF NOT EXISTS `group37db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `group37db`;
-- MySQL dump 10.13  Distrib 5.6.40, for macos10.13 (x86_64)
--
-- Host: group37db.cu5z78pch9rp.us-east-2.rds.amazonaws.com    Database: group37db
-- ------------------------------------------------------
-- Server version	5.6.40-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Accessories`
--

DROP TABLE IF EXISTS `Accessories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Accessories` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `occasion` enum('Summer','Party','Formal','Date','Winter','Funeral') DEFAULT NULL COMMENT 'Ocassion',
  PRIMARY KEY (`item_id`),
  CONSTRAINT `Accessories_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Clothing_Item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accessories`
--

LOCK TABLES `Accessories` WRITE;
/*!40000 ALTER TABLE `Accessories` DISABLE KEYS */;
INSERT INTO `Accessories` VALUES (96,'Summer'),(100,'Summer');
/*!40000 ALTER TABLE `Accessories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account`
--

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_address` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `account_type` enum('Administrator','End User','Customer Service Representative') NOT NULL DEFAULT 'End User',
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_address_UNIQUE` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account`
--

LOCK TABLES `Account` WRITE;
/*!40000 ALTER TABLE `Account` DISABLE KEYS */;
INSERT INTO `Account` VALUES (1,'test@test.com','test1234','End User','test','test'),(3,'michael@wang','test1234','Customer Service Representative','michael','wang'),(4,'root@root.com','root1234','End User','root','root'),(8,'alexander@goodkind.io','lolololo','Administrator','alexander','goodkind'),(9,'test1@test.com','12345678','End User','test','test'),(10,'test1@test2.com','122345678','End User','test','test'),(11,'v@v.com','valia1234567','End User','valia','k'),(13,'buttbuddy@goodkind.io','12345678','End User','Alex\'s Butt','Buddy'),(14,'madhu@gmail.com','madhu123','End User','Madhu','Sivaraj'),(15,'madhu2@com','00000000','End User','Madhu2','siv');
/*!40000 ALTER TABLE `Account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account_Bids_On_Auction`
--

DROP TABLE IF EXISTS `Account_Bids_On_Auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_Bids_On_Auction` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `auction_id` int(11) NOT NULL DEFAULT '0',
  `upper_limit` float DEFAULT NULL,
  `current_bid` float DEFAULT NULL,
  PRIMARY KEY (`account_id`,`auction_id`),
  KEY `Account_Bids_On_Auction_auction_id_fk` (`auction_id`),
  CONSTRAINT `Account_Bids_On_Account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Account_Bids_On_Auction_auction_id_fk` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_Bids_On_Auction`
--

LOCK TABLES `Account_Bids_On_Auction` WRITE;
/*!40000 ALTER TABLE `Account_Bids_On_Auction` DISABLE KEYS */;
INSERT INTO `Account_Bids_On_Auction` VALUES (1,28,0,146),(1,33,0,146),(8,28,10,40),(8,33,0,40),(11,33,0,70),(13,28,0,14),(14,27,34,145),(14,28,0,145),(14,29,20,145),(14,30,20,145),(15,28,4,136),(15,29,0,136),(15,31,0,136);
/*!40000 ALTER TABLE `Account_Bids_On_Auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account_Sells_In_Auction`
--

DROP TABLE IF EXISTS `Account_Sells_In_Auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_Sells_In_Auction` (
  `auction_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`auction_id`,`account_id`),
  KEY `Account_Sells_In_Auction_Account_id_fk` (`account_id`),
  CONSTRAINT `Account_Sells_In_Auction_Account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`),
  CONSTRAINT `Account_Sells_In_Auction_Auction_auction_id_fk` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_Sells_In_Auction`
--

LOCK TABLES `Account_Sells_In_Auction` WRITE;
/*!40000 ALTER TABLE `Account_Sells_In_Auction` DISABLE KEYS */;
INSERT INTO `Account_Sells_In_Auction` VALUES (26,1),(27,8),(28,8),(33,8),(34,8),(29,13),(30,14),(31,14),(32,15);
/*!40000 ALTER TABLE `Account_Sells_In_Auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alerts`
--

DROP TABLE IF EXISTS `Alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Alerts` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_read` tinyint(1) DEFAULT '0',
  `alert_timestamp` datetime DEFAULT NULL,
  `alert_type` enum('Wishlist_Alerts','Bids_Alerts','Auto_Bid_Alerts','Auction_Close_Alerts') DEFAULT NULL,
  `alert_message` varchar(80) DEFAULT NULL,
  `auction_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `bid_amount` double DEFAULT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `Alerts_alert_id_uindex` (`alert_id`),
  KEY `Alerts_Account_id_fk` (`account_id`),
  KEY `Alerts_Auction_auction_id_fk` (`auction_id`),
  CONSTRAINT `Alerts_Account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `Alerts_Auction_auction_id_fk` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`auction_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alerts`
--

LOCK TABLES `Alerts` WRITE;
/*!40000 ALTER TABLE `Alerts` DISABLE KEYS */;
INSERT INTO `Alerts` VALUES (19,1,'2019-04-20 01:03:41','Wishlist_Alerts','An item on your wishlist is now up for auction',28,8,NULL);
/*!40000 ALTER TABLE `Alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Auction`
--

DROP TABLE IF EXISTS `Auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Auction` (
  `auction_id` int(11) NOT NULL AUTO_INCREMENT,
  `initial_price` double DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `closing_datetime` datetime DEFAULT NULL,
  `current_bid` double DEFAULT '0',
  `item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`auction_id`),
  UNIQUE KEY `Auction_auction_id_uindex` (`auction_id`),
  KEY `Auction_Clothing_Item_item_id_fk` (`item_id`),
  CONSTRAINT `Auction_Clothing_Item_item_id_fk` FOREIGN KEY (`item_id`) REFERENCES `Clothing_Item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Auction`
--

LOCK TABLES `Auction` WRITE;
/*!40000 ALTER TABLE `Auction` DISABLE KEYS */;
INSERT INTO `Auction` VALUES (26,50,70,'2019-04-19 23:44:28','2019-04-20 01:26:19',1,90),(27,50,70,'2019-04-19 23:49:04','2019-04-25 23:49:04',101,91),(28,10,15,'2019-04-20 01:03:41','2019-04-26 22:11:20',146,93),(29,5,10,'2019-04-20 01:44:05','2019-05-10 22:06:51',100,95),(30,25,50,'2019-04-20 17:00:35','2019-04-21 17:00:35',80,96),(31,50,80,'2019-04-20 17:01:18','2019-04-23 17:01:18',3,97),(32,3,90,'2019-04-20 17:14:32','2019-04-21 17:14:32',0,98),(33,50,70,'2019-04-20 18:30:39','2019-04-20 18:42:58',70,99),(34,300,1000,'2019-04-20 21:06:59','2019-04-25 21:06:59',0,100);
/*!40000 ALTER TABLE `Auction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`group37`@`%`*/ /*!50003 trigger alert_if_on_wishlist
    after INSERT
    on Auction
    for each row
BEGIN

    SET @item_type = 'null';
    SET @item_size = 0;
    set @item_gender = 'null';
    set @item_name = 'null';
    set @item_id = new.item_id; #new.item_id
    set @auction_id = new.auction_id; #new.auction_id


    Select ci.item_type, ci.size, ci.gender, ci.item_name into @item_type, @item_size, @item_gender, @item_name
    from Clothing_Item ci
    where ci.item_id = @item_id;
# new.item_id
    INSERT INTO Alerts(alert_timestamp, alert_type, alert_message, auction_id, account_id)
    SELECT NOW(),
           'Wishlist_Alerts',
           'An item on your wishlist is now up for auction',
           @auction_id,
           w.account_id
    from Wishlist w
    where w.item_id in (
        select ci1.item_id
        from Clothing_Item ci1, # wishlist items
             Clothing_Item ci2  # new item
        where ci1.item_name SOUNDS LIKE ci2.item_name #LIKE CONCAT('%', ci2.item_name ,'%')
          and ci2.item_id = @item_id
          and ci1.item_type = @item_type
          and ci1.size = @item_size
          and ci1.gender = @item_gender
          and ci1.item_id in (select w.item_id from Wishlist w));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Auto_Bid_On`
--

DROP TABLE IF EXISTS `Auto_Bid_On`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Auto_Bid_On` (
  `auction_id` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  KEY `Auto_Bid_On_Account_id_fk` (`account_id`),
  KEY `Auto_Bid_On_Auction_auction_id_fk` (`auction_id`),
  CONSTRAINT `Auto_Bid_On_Account_id_fk` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`),
  CONSTRAINT `Auto_Bid_On_Auction_auction_id_fk` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`auction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Auto_Bid_On`
--

LOCK TABLES `Auto_Bid_On` WRITE;
/*!40000 ALTER TABLE `Auto_Bid_On` DISABLE KEYS */;
/*!40000 ALTER TABLE `Auto_Bid_On` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `Bids`
--

DROP TABLE IF EXISTS `Bids`;
/*!50001 DROP VIEW IF EXISTS `Bids`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Bids` AS SELECT 
 1 AS `amount`,
 1 AS `auction_id`,
 1 AS `account_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Clothing_Item`
--

DROP TABLE IF EXISTS `Clothing_Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Clothing_Item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `size` varchar(10) DEFAULT NULL,
  `gender` enum('Male','Female','Unisex') DEFAULT NULL,
  `item_name` varchar(50) DEFAULT NULL,
  `item_type` enum('Accessories','Pants','Shirts','Undergarments') DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `Clothing_Item_item_id_uindex` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clothing_Item`
--

LOCK TABLES `Clothing_Item` WRITE;
/*!40000 ALTER TABLE `Clothing_Item` DISABLE KEYS */;
INSERT INTO `Clothing_Item` VALUES (1,'99','Male','test_male_jeans','Pants'),(2,'5','Female','test_female_jeans','Pants'),(3,'5','Male','gray pants','Pants'),(4,'5','Male','white pants','Pants'),(5,'5','Male','yellow pants','Pants'),(6,NULL,NULL,NULL,NULL),(7,'4','Male','4',NULL),(8,'4','Male','4',NULL),(9,'5','Male','blue pants','Pants'),(10,'5','Male','gray pants','Pants'),(11,'5','Male','gray pants','Pants'),(12,'4','Male','gray pants','Pants'),(13,NULL,NULL,NULL,NULL),(14,NULL,NULL,NULL,NULL),(15,NULL,NULL,NULL,NULL),(16,'df','Male','fg','Accessories'),(17,'5','Male','gray pants','Pants'),(18,'5','Male','gray pants','Pants'),(19,'5','Male','white pants','Pants'),(20,'F','Male','Try','Accessories'),(21,'F','Male','Try','Accessories'),(22,'F','Male','Try','Accessories'),(23,'F','Male','Try','Accessories'),(24,NULL,NULL,NULL,NULL),(25,'5','Male','gray pants','Pants'),(26,'2','Male','Pants','Pants'),(27,NULL,NULL,NULL,NULL),(28,'df','Male','fg','Accessories'),(29,'df','Male','fg','Accessories'),(30,'5','Male','gray pants','Pants'),(31,'5','Male','gray pants','Pants'),(32,'5','Male','gray pants','Pants'),(33,'df','Male','fg','Accessories'),(34,'4','Male','gray pants','Pants'),(35,'df','Male','fg','Accessories'),(36,'32','Male','My Pants','Pants'),(37,'32','Male','My Pants','Pants'),(38,'32','Male','My Pants','Pants'),(39,'32','Male','My Pants','Pants'),(40,'32','Male','My Pants','Pants'),(41,'32','Male','My Pants','Pants'),(42,NULL,NULL,NULL,NULL),(43,'32','Male','Alex\'s Amazing USED Pants','Pants'),(44,NULL,NULL,NULL,NULL),(45,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(46,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(47,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(48,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(49,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(50,'32','Male','Alex\'s AMAZINGLY USED PANTS','Pants'),(51,'32','Male','Alex\'s AMAZINGLY USED PANTS','Pants'),(52,'32','Male','Alex\'s AMAZINGLY USED PANTS','Pants'),(53,'32','Male','Alex\'s AMAZINGLY USED PANTS','Pants'),(54,'32','Male','Alex\'s AMAZINGLY USED PANTS','Pants'),(55,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(56,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(57,'32','Male','Alex\'s AMAZING USED Pants','Pants'),(58,'32','Male','Alex\'s AMAZING USED PANTS','Pants'),(59,NULL,NULL,NULL,NULL),(60,'32','Male','Test1','Undergarments'),(61,'123','Male','test2','Pants'),(62,'123','Male','test2','Pants'),(63,'123','Male','test2','Pants'),(64,'123','Male','test2','Pants'),(65,'123','Male','test2','Pants'),(66,'123','Male','test2','Pants'),(67,'123','Male','test2','Pants'),(68,'smol','Female','cute shorts','Pants'),(69,'smol','Female','cute shorts','Pants'),(70,'small','Female','cute booty shorts','Pants'),(71,'10','Female','cute bb shorts test','Pants'),(72,'10','Female','cute bb shorts test Alex','Pants'),(73,'10','Female','cute bb shorts test Alex','Pants'),(74,'10','Female','cute bb shorts test Alex','Pants'),(75,'10','Female','cute','Pants'),(76,'10','Female','cute','Pants'),(77,'10','Female','cute','Pants'),(78,NULL,NULL,NULL,NULL),(79,'10','Female','cute','Pants'),(80,'10','Female','cute','Pants'),(81,'32','Male','cute','Pants'),(82,'32','Male','cute','Pants'),(83,'5','Male','gray pants','Pants'),(84,'5','Female','gray pants','Pants'),(85,'6','Female','Green','Pants'),(86,'20','Female','madhu\'s boots','Accessories'),(87,'5','Male','gray pants','Pants'),(88,'5','Male','gray pants','Pants'),(89,'3','Male','black tee','Shirts'),(90,'5','Male','gray pants','Pants'),(91,'4','Female','white pants','Pants'),(92,'32','Female','Cute Bebe Top','Shirts'),(93,'32','Female','Cute Bebe Top','Shirts'),(94,'1','Male','pants','Pants'),(95,'10','Male','Used Cute Men\'s Jeans','Pants'),(96,'4','Female','Blue Earrings','Accessories'),(97,'2','Female','mom jeans','Pants'),(98,'0','Female','tank top','Shirts'),(99,'5','Female','gray pants','Pants'),(100,'13','Male','New Jordan Shoes!','Accessories');
/*!40000 ALTER TABLE `Clothing_Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Email`
--

DROP TABLE IF EXISTS `Email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Email` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_subject` varchar(1000) DEFAULT NULL,
  `timesent` datetime DEFAULT NULL,
  `content` varchar(10000) DEFAULT NULL,
  `from_account_id` int(11) DEFAULT NULL,
  `to_account_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Email`
--

LOCK TABLES `Email` WRITE;
/*!40000 ALTER TABLE `Email` DISABLE KEYS */;
INSERT INTO `Email` VALUES (7,'Alex','2019-04-14 18:45:05','badkind',11,8),(10,'reply','2019-04-15 21:48:44','this is a reply',1,11),(11,'hi','2019-04-15 21:50:36','hello',1,11),(20,'test1','2019-04-18 19:01:33','test_content',1,1),(22,'hi','2019-04-20 01:45:51','hey loser',1,8),(23,'ugh','2019-04-20 21:07:49','dont call me loser',8,1);
/*!40000 ALTER TABLE `Email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Forum`
--

DROP TABLE IF EXISTS `Forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Forum` (
  `auction_id` int(11) NOT NULL,
  `asked_by_account_id` int(11) NOT NULL,
  `answered_by_account_id` int(11) DEFAULT NULL,
  `question` varchar(1000) NOT NULL,
  `answer` varchar(1000) DEFAULT NULL,
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`question_id`),
  UNIQUE KEY `Forum_question_id_uindex` (`question_id`),
  KEY `Forum_Auction_auction_id_fk` (`auction_id`),
  KEY `Forum_Account_id_fk` (`asked_by_account_id`),
  KEY `Forum_Account_id_fk_2` (`answered_by_account_id`),
  CONSTRAINT `Forum_Account_id_fk` FOREIGN KEY (`asked_by_account_id`) REFERENCES `Account` (`id`),
  CONSTRAINT `Forum_Account_id_fk_2` FOREIGN KEY (`answered_by_account_id`) REFERENCES `Account` (`id`),
  CONSTRAINT `Forum_Auction_auction_id_fk` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`auction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='auction forum for q&a on items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Forum`
--

LOCK TABLES `Forum` WRITE;
/*!40000 ALTER TABLE `Forum` DISABLE KEYS */;
INSERT INTO `Forum` VALUES (33,8,8,'Is this item in good condition?','Yes!!!',1),(28,8,8,'Is this item in good condition?','Yes!!!',2);
/*!40000 ALTER TABLE `Forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `List_Active_Auctions`
--

DROP TABLE IF EXISTS `List_Active_Auctions`;
/*!50001 DROP VIEW IF EXISTS `List_Active_Auctions`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `List_Active_Auctions` AS SELECT 
 1 AS `email_address`,
 1 AS `account_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `current_bid`,
 1 AS `closing_datetime`,
 1 AS `start_datetime`,
 1 AS `item_type`,
 1 AS `item_name`,
 1 AS `item_id`,
 1 AS `gender`,
 1 AS `min_price`,
 1 AS `auction_id`,
 1 AS `size`,
 1 AS `highest_bidder_account_id`,
 1 AS `highest_bidder_first_name`,
 1 AS `highest_bidder_last_name`,
 1 AS `highest_bidder_email_address`,
 1 AS `auction_closed`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Manually_Bid_On`
--

DROP TABLE IF EXISTS `Manually_Bid_On`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manually_Bid_On` (
  `amount` double NOT NULL DEFAULT '0',
  `auction_id` int(11) NOT NULL DEFAULT '0',
  `account_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`amount`,`account_id`,`auction_id`),
  KEY `Bids_ibfk_1` (`auction_id`),
  KEY `Bids_ibfk_2` (`account_id`),
  CONSTRAINT `Manually_Bid_On_ibfk_1` FOREIGN KEY (`auction_id`) REFERENCES `Auction` (`auction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Manually_Bid_On_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manually_Bid_On`
--

LOCK TABLES `Manually_Bid_On` WRITE;
/*!40000 ALTER TABLE `Manually_Bid_On` DISABLE KEYS */;
INSERT INTO `Manually_Bid_On` VALUES (1,26,8),(75,27,14),(101,27,14),(1,28,8),(2,28,8),(3,28,8),(4,28,8),(5,28,13),(6,28,13),(8,28,8),(9,28,8),(10,28,8),(11,28,8),(12,28,8),(13,28,8),(14,28,13),(15,28,14),(135,28,14),(136,28,15),(145,28,14),(146,28,1),(50,29,14),(100,29,15),(80,30,14),(3,31,15),(40,33,8),(41,33,1),(42,33,1),(50,33,11),(70,33,11);
/*!40000 ALTER TABLE `Manually_Bid_On` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`group37`@`%`*/ /*!50003 trigger do_auto_bid_and_send_alerts
    before INSERT
    on Manually_Bid_On
    for each row
begin
    set @upper_limit = 0.0;
    set @auto_bidder_id = 0;
    set @auto_increment_amount = 1.0;
    set @max_bid = new.amount;

    select abo.account_id,
           max(abo.upper_limit)
           into @auto_bidder_id,
               @upper_limit
    from Account_Bids_On_Auction abo
    where abo.auction_id = new.auction_id
      and abo.upper_limit >= new.amount + @auto_increment_amount;


    # essentially we are making two bids, the first being the new.amount, and second being new.amount + 1 but by the higher limit bidder

    if (@upper_limit >= new.amount + @auto_increment_amount) then
        set @max_bid = new.amount + @auto_increment_amount;

        insert into Auto_Bid_On (amount, account_id, auction_id)
        VALUES (@max_bid, @auto_bidder_id, new.auction_id);

        update Account_Bids_On_Auction
        set current_bid = @max_bid
        where account_id = @auto_bidder_id;

        insert into Alerts(auction_id, account_id, alert_type, alert_message, alert_timestamp, bid_amount)
        select new.auction_id,
               abo.account_id,
               'Auto_Bid_Alerts',
               'An auction you are bidding on has received a new bid, we have automatically placed a new bid for you.',
               NOW(),
               @max_bid
        from Account_Bids_On_Auction abo
        where abo.auction_id = new.auction_id and abo.account_id = @auto_bidder_id;

    end if;

    update Auction
    set current_bid = @max_bid
    where auction_id = new.auction_id;


    update Account_Bids_On_Auction
    set current_bid = new.amount
    where account_id = new.account_id;

    insert into Alerts(auction_id, account_id, alert_type, alert_message, alert_timestamp, bid_amount)
    select new.auction_id,
           abo.account_id,
           'Bids_Alerts',
           'A new bid has been placed on an auction you are also bidding on participating in.',
           NOW(),
           @max_bid
    from Account_Bids_On_Auction abo
    where abo.auction_id = new.auction_id and abo.account_id <> @auto_bidder_id and abo.account_id <> new.account_id; # send an alert to all except the auto bidder and new bidder, who gets their own alert

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Pants`
--

DROP TABLE IF EXISTS `Pants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pants` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `pant_cut` enum('Shorts','Boot','Booty','Capri','Short Short','Other') DEFAULT NULL COMMENT 'Pant Cut',
  `fit_type` enum('Skinny','Slim','Regular','Relaxed','Loose','Other') DEFAULT NULL COMMENT 'Fit Type',
  PRIMARY KEY (`item_id`),
  CONSTRAINT `Pants_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Clothing_Item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pants`
--

LOCK TABLES `Pants` WRITE;
/*!40000 ALTER TABLE `Pants` DISABLE KEYS */;
INSERT INTO `Pants` VALUES (90,'Shorts','Skinny'),(91,'Boot','Skinny'),(94,'Booty','Slim'),(95,'Other','Relaxed'),(97,'Booty','Slim'),(99,'Shorts','Skinny');
/*!40000 ALTER TABLE `Pants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shirts`
--

DROP TABLE IF EXISTS `Shirts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shirts` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `sleeve_type` enum('Short','Long','Polo','Muscle','Crop Top','Belly','Tank Top') DEFAULT NULL COMMENT 'Sleeve',
  `shirt_fit` enum('Loose','Tight','Fitted','Muscle','Baggy') DEFAULT NULL COMMENT 'Shirt Fit',
  PRIMARY KEY (`item_id`),
  CONSTRAINT `Shirts_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Clothing_Item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shirts`
--

LOCK TABLES `Shirts` WRITE;
/*!40000 ALTER TABLE `Shirts` DISABLE KEYS */;
INSERT INTO `Shirts` VALUES (92,'Crop Top','Tight'),(93,'Crop Top','Tight'),(98,'Belly','Tight');
/*!40000 ALTER TABLE `Shirts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Undergarments`
--

DROP TABLE IF EXISTS `Undergarments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Undergarments` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `body_part` enum('Top','Lower') DEFAULT NULL COMMENT 'Body Part',
  PRIMARY KEY (`item_id`),
  CONSTRAINT `Undergarments_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `Clothing_Item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Undergarments`
--

LOCK TABLES `Undergarments` WRITE;
/*!40000 ALTER TABLE `Undergarments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Undergarments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wishlist`
--

DROP TABLE IF EXISTS `Wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Wishlist` (
  `account_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) DEFAULT NULL,
  KEY `account_id` (`account_id`),
  KEY `Wishlist_Clothing_Item_item_id_fk` (`item_id`),
  CONSTRAINT `Wishlist_Clothing_Item_item_id_fk` FOREIGN KEY (`item_id`) REFERENCES `Clothing_Item` (`item_id`),
  CONSTRAINT `Wishlist_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wishlist`
--

LOCK TABLES `Wishlist` WRITE;
/*!40000 ALTER TABLE `Wishlist` DISABLE KEYS */;
INSERT INTO `Wishlist` VALUES (3,94);
/*!40000 ALTER TABLE `Wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `account`
--

DROP TABLE IF EXISTS `account`;
/*!50001 DROP VIEW IF EXISTS `account`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `account` AS SELECT 
 1 AS `email_address`,
 1 AS `password`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `forum_q_a_list`
--

DROP TABLE IF EXISTS `forum_q_a_list`;
/*!50001 DROP VIEW IF EXISTS `forum_q_a_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `forum_q_a_list` AS SELECT 
 1 AS `auction_id`,
 1 AS `question`,
 1 AS `answer`,
 1 AS `asked_by_account_id`,
 1 AS `answered_by_account_id`,
 1 AS `question_id`,
 1 AS `asker_first_name`,
 1 AS `asker_last_name`,
 1 AS `answerer_first_name`,
 1 AS `answerer_last_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'group37db'
--

--
-- Dumping routines for database 'group37db'
--

--
-- Final view structure for view `Bids`
--

/*!50001 DROP VIEW IF EXISTS `Bids`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`group37`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Bids` AS select `m`.`amount` AS `amount`,`m`.`auction_id` AS `auction_id`,`m`.`account_id` AS `account_id` from `Manually_Bid_On` `m` union select `a`.`amount` AS `amount`,`a`.`auction_id` AS `auction_id`,`a`.`account_id` AS `account_id` from `Auto_Bid_On` `a` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `List_Active_Auctions`
--

/*!50001 DROP VIEW IF EXISTS `List_Active_Auctions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`group37`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `List_Active_Auctions` AS select `ac`.`email_address` AS `email_address`,`ac`.`id` AS `account_id`,`ac`.`first_name` AS `first_name`,`ac`.`last_name` AS `last_name`,`au`.`current_bid` AS `current_bid`,`au`.`closing_datetime` AS `closing_datetime`,`au`.`start_datetime` AS `start_datetime`,`ci`.`item_type` AS `item_type`,`ci`.`item_name` AS `item_name`,`ci`.`item_id` AS `item_id`,`ci`.`gender` AS `gender`,`au`.`min_price` AS `min_price`,`au`.`auction_id` AS `auction_id`,`ci`.`size` AS `size`,(select distinct `b2`.`account_id` from `Bids` `b2` where ((`b2`.`auction_id` = `au`.`auction_id`) and (`b2`.`amount` = (select max(`b3`.`amount`) from `Bids` `b3` where (`b3`.`auction_id` = `au`.`auction_id`))))) AS `highest_bidder_account_id`,(select `a1`.`first_name` from `Account` `a1` where (`a1`.`id` = (select distinct `b2`.`account_id` from `Bids` `b2` where ((`b2`.`auction_id` = `au`.`auction_id`) and (`b2`.`amount` = (select max(`b3`.`amount`) from `Bids` `b3` where (`b3`.`auction_id` = `au`.`auction_id`))))))) AS `highest_bidder_first_name`,(select `a1`.`last_name` from `Account` `a1` where (`a1`.`id` = (select distinct `b2`.`account_id` from `Bids` `b2` where ((`b2`.`auction_id` = `au`.`auction_id`) and (`b2`.`amount` = (select max(`b3`.`amount`) from `Bids` `b3` where (`b3`.`auction_id` = `au`.`auction_id`))))))) AS `highest_bidder_last_name`,(select `a1`.`email_address` from `Account` `a1` where (`a1`.`id` = (select distinct `b2`.`account_id` from `Bids` `b2` where ((`b2`.`auction_id` = `au`.`auction_id`) and (`b2`.`amount` = (select max(`b3`.`amount`) from `Bids` `b3` where (`b3`.`auction_id` = `au`.`auction_id`))))))) AS `highest_bidder_email_address`,if((now() > `au`.`closing_datetime`),1,0) AS `auction_closed` from (((`Auction` `au` join `Account` `ac`) join `Clothing_Item` `ci`) join `Account_Sells_In_Auction` `asi`) where ((`ac`.`id` = `asi`.`account_id`) and (`asi`.`auction_id` = `au`.`auction_id`) and (`au`.`item_id` = `ci`.`item_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `account`
--

/*!50001 DROP VIEW IF EXISTS `account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`group37`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `account` AS select `Account`.`email_address` AS `email_address`,`Account`.`password` AS `password` from `Account` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `forum_q_a_list`
--

/*!50001 DROP VIEW IF EXISTS `forum_q_a_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`group37`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `forum_q_a_list` AS select `f`.`auction_id` AS `auction_id`,`f`.`question` AS `question`,`f`.`answer` AS `answer`,`f`.`asked_by_account_id` AS `asked_by_account_id`,`f`.`answered_by_account_id` AS `answered_by_account_id`,`f`.`question_id` AS `question_id`,`a`.`first_name` AS `asker_first_name`,`a`.`last_name` AS `asker_last_name`,`a2`.`first_name` AS `answerer_first_name`,`a2`.`last_name` AS `answerer_last_name` from ((`Forum` `f` left join `Account` `a` on((`f`.`asked_by_account_id` = `a`.`id`))) left join `Account` `a2` on((`f`.`answered_by_account_id` = `a2`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-21 20:59:27
