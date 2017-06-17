-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.39-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema ayurwedalkdb
--

CREATE DATABASE IF NOT EXISTS ayurwedalkdb;
USE ayurwedalkdb;

--
-- Definition of table `aboutus`
--

DROP TABLE IF EXISTS `aboutus`;
CREATE TABLE `aboutus` (
  `idAboutus` int(11) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `location` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`idAboutus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aboutus`
--

/*!40000 ALTER TABLE `aboutus` DISABLE KEYS */;
/*!40000 ALTER TABLE `aboutus` ENABLE KEYS */;


--
-- Definition of table `awards`
--

DROP TABLE IF EXISTS `awards`;
CREATE TABLE `awards` (
  `idAwards` int(11) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAwards`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `awards`
--

/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;


--
-- Definition of table `brands`
--

DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `idBrands` int(11) NOT NULL AUTO_INCREMENT,
  `brandname` varchar(45) NOT NULL,
  `country` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idBrands`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `brands`
--

/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` (`idBrands`,`brandname`,`country`) VALUES 
 (9,'LIOXIV-DS','India'),
 (10,'ZANDU','PAKISTAN'),
 (11,'OTHER','No Country'),
 (12,'SBM','Bangaladesh'),
 (13,'JIVA','India'),
 (14,'DHATHRI','SRILANKA'),
 (15,'BHAKTIVEDA','India'),
 (16,'GOODLUCK','SRILANKA'),
 (17,'HIMALAYA','India'),
 (18,'AHR','Malasia'),
 (19,'PEPSODENT','SRILANKA');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;


--
-- Definition of table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `idCart` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `total` double DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  `paystatus` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCart`),
  KEY `fk_Cart_User1` (`User_idUser`),
  CONSTRAINT `fk_Cart_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cart`
--

/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;


--
-- Definition of table `cart_has_p_catergory`
--

DROP TABLE IF EXISTS `cart_has_p_catergory`;
CREATE TABLE `cart_has_p_catergory` (
  `Cart_idCart` int(11) NOT NULL,
  `P_Catergory_idP_Catergory` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `ptotal` int(11) DEFAULT NULL,
  PRIMARY KEY (`Cart_idCart`,`P_Catergory_idP_Catergory`),
  KEY `fk_Cart_has_P_Catergory_P_Catergory1` (`P_Catergory_idP_Catergory`),
  KEY `fk_Cart_has_P_Catergory_Cart1` (`Cart_idCart`),
  CONSTRAINT `fk_Cart_has_P_Catergory_Cart1` FOREIGN KEY (`Cart_idCart`) REFERENCES `cart` (`idCart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cart_has_P_Catergory_P_Catergory1` FOREIGN KEY (`P_Catergory_idP_Catergory`) REFERENCES `p_catergory` (`idP_Catergory`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cart_has_p_catergory`
--

/*!40000 ALTER TABLE `cart_has_p_catergory` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_has_p_catergory` ENABLE KEYS */;


--
-- Definition of table `cart_has_products`
--

DROP TABLE IF EXISTS `cart_has_products`;
CREATE TABLE `cart_has_products` (
  `Cart_idCart` int(11) NOT NULL,
  `Products_idProducts` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `ptotal` double DEFAULT NULL,
  PRIMARY KEY (`Cart_idCart`,`Products_idProducts`),
  KEY `fk_Cart_has_Products_Products1` (`Products_idProducts`),
  KEY `fk_Cart_has_Products_Cart1` (`Cart_idCart`),
  CONSTRAINT `fk_Cart_has_Products_Cart1` FOREIGN KEY (`Cart_idCart`) REFERENCES `cart` (`idCart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cart_has_Products_Products1` FOREIGN KEY (`Products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cart_has_products`
--

/*!40000 ALTER TABLE `cart_has_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_has_products` ENABLE KEYS */;


--
-- Definition of table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `idCompany` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `regi_no` varchar(45) DEFAULT NULL,
  `regi_date` date DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `start_date` varchar(45) DEFAULT NULL,
  `awared` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCompany`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`idCompany`,`name`,`regi_no`,`regi_date`,`description`,`start_date`,`awared`) VALUES 
 (1,'Abana','232332','2016-11-04','elaa','2016-11-04','no'),
 (2,'Sewana','12372','2016-11-16','patta','2016-11-16','no'),
 (5,'ZenonIdeas','450126','2017-01-16','Good suppliers for everything                ','2017-02-16',NULL);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;


--
-- Definition of table `dispatchorders`
--

DROP TABLE IF EXISTS `dispatchorders`;
CREATE TABLE `dispatchorders` (
  `idDispatchOrders` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `Order_idOrder` int(11) NOT NULL,
  `cus_coment` varchar(800) DEFAULT NULL,
  PRIMARY KEY (`idDispatchOrders`),
  KEY `fk_DispatchOrders_Order1` (`Order_idOrder`),
  CONSTRAINT `fk_DispatchOrders_Order1` FOREIGN KEY (`Order_idOrder`) REFERENCES `ordering` (`idOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dispatchorders`
--

/*!40000 ALTER TABLE `dispatchorders` DISABLE KEYS */;
INSERT INTO `dispatchorders` (`idDispatchOrders`,`date`,`time`,`status`,`Order_idOrder`,`cus_coment`) VALUES 
 (15,'2017-02-08','16:07:47','1',55,'Elata thibuna'),
 (16,'2017-02-09','13:55:32','1',56,'Superbbbbbbb brooo'),
 (17,'2017-03-16','09:57:50','0',57,NULL),
 (18,'2017-03-16','12:32:14','0',60,NULL);
/*!40000 ALTER TABLE `dispatchorders` ENABLE KEYS */;


--
-- Definition of table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `idFeedBack` int(11) NOT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  PRIMARY KEY (`idFeedBack`),
  KEY `fk_FeedBack_User1` (`User_idUser`),
  CONSTRAINT `fk_FeedBack_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;


--
-- Definition of table `grn`
--

DROP TABLE IF EXISTS `grn`;
CREATE TABLE `grn` (
  `idGRN` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `p_count` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `Supplier_idSupplier` int(11) NOT NULL,
  `totalqty` int(11) DEFAULT NULL,
  `existqty` int(11) DEFAULT NULL,
  `grnstatus` varchar(45) DEFAULT NULL,
  `addstatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idGRN`),
  KEY `fk_GRN_Supplier1` (`Supplier_idSupplier`),
  CONSTRAINT `fk_GRN_Supplier1` FOREIGN KEY (`Supplier_idSupplier`) REFERENCES `supplier` (`idSupplier`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `grn`
--

/*!40000 ALTER TABLE `grn` DISABLE KEYS */;
INSERT INTO `grn` (`idGRN`,`date`,`p_count`,`total`,`Supplier_idSupplier`,`totalqty`,`existqty`,`grnstatus`,`addstatus`) VALUES 
 (1,'2016-11-05',12,144,1,2000,1983,'1','1'),
 (2,'2016-11-09',12,144,1,400,400,'1','1'),
 (3,'2016-11-24',12,144,1,400,400,'0','1'),
 (5,'2017-02-01',1,9000,2,20,20,'1','1'),
 (6,'2017-02-01',1,11000,2,20,20,'1','1');
/*!40000 ALTER TABLE `grn` ENABLE KEYS */;


--
-- Definition of table `grn_has_products`
--

DROP TABLE IF EXISTS `grn_has_products`;
CREATE TABLE `grn_has_products` (
  `GRN_idGRN` int(11) NOT NULL,
  `Products_idProducts` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `sellprice` double(10,0) DEFAULT NULL,
  `buyprice` double(10,0) DEFAULT NULL,
  `GRNPstatus` varchar(45) DEFAULT NULL,
  `qtystatus` varchar(45) DEFAULT NULL,
  `IdGRNhasProduct` int(11) NOT NULL AUTO_INCREMENT,
  `addqty` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdGRNhasProduct`),
  KEY `fk_GRN_has_Products_Products1` (`Products_idProducts`),
  KEY `fk_GRN_has_Products_GRN1` (`GRN_idGRN`),
  CONSTRAINT `fk_GRN_has_Products_GRN1` FOREIGN KEY (`GRN_idGRN`) REFERENCES `grn` (`idGRN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GRN_has_Products_Products1` FOREIGN KEY (`Products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `grn_has_products`
--

/*!40000 ALTER TABLE `grn_has_products` DISABLE KEYS */;
INSERT INTO `grn_has_products` (`GRN_idGRN`,`Products_idProducts`,`qty`,`sellprice`,`buyprice`,`GRNPstatus`,`qtystatus`,`IdGRNhasProduct`,`addqty`) VALUES 
 (1,14,186,200,250,'1','1',1,200),
 (1,15,177,250,300,'1','1',2,200),
 (1,16,200,300,350,'1','1',3,200),
 (1,17,188,200,250,'1','1',4,200),
 (1,18,200,350,400,'1','1',5,200),
 (1,19,179,150,200,'1','1',6,200),
 (1,20,198,400,450,'1','1',7,200),
 (1,21,199,250,300,'1','1',8,200),
 (1,22,199,300,350,'1','1',9,200),
 (1,23,200,400,450,'1','1',10,200),
 (2,24,200,500,550,'0','0',11,200),
 (2,26,200,400,450,'0','0',12,200),
 (3,25,200,600,650,'0','1',13,200),
 (3,27,200,350,250,'0','1',14,200),
 (1,27,200,350,300,'0','1',16,200),
 (2,27,200,500,450,'1','1',17,200),
 (5,26,20,500,450,'1','1',45,20),
 (6,25,20,600,550,'1','1',46,20);
/*!40000 ALTER TABLE `grn_has_products` ENABLE KEYS */;


--
-- Definition of table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `idInvoice` int(11) NOT NULL AUTO_INCREMENT,
  `total` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  PRIMARY KEY (`idInvoice`),
  KEY `fk_Invoice_User1` (`User_idUser`),
  CONSTRAINT `fk_Invoice_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice`
--

/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` (`idInvoice`,`total`,`date`,`User_idUser`) VALUES 
 (190,400,'2017-01-19',1),
 (191,150,'2017-01-21',1),
 (192,350,'2017-01-21',1),
 (193,1600,'2017-01-21',1),
 (194,725,'2017-01-21',1),
 (195,123,'2017-01-21',1),
 (196,150,'2017-02-02',1),
 (197,150,'2017-02-02',1),
 (198,150,'2017-02-02',1),
 (199,704,'2017-02-02',1),
 (200,176,'2017-02-02',1),
 (201,176,'2017-02-02',1),
 (202,470,'2017-02-03',1),
 (203,150,'2017-02-08',1),
 (204,400,'2017-02-08',1),
 (205,141,'2017-02-08',1),
 (206,541,'2017-02-08',1),
 (207,400,'2017-02-09',1),
 (208,1550,'2017-03-16',1),
 (209,5000,'2017-03-16',1),
 (210,150,'2017-03-16',1),
 (211,1500,'2017-03-16',1);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;


--
-- Definition of table `invoice_has_grn_has_products`
--

DROP TABLE IF EXISTS `invoice_has_grn_has_products`;
CREATE TABLE `invoice_has_grn_has_products` (
  `invoice_idInvoice` int(11) NOT NULL,
  `grn_has_products_IdGRNhasProduct` int(11) NOT NULL,
  `invoqty` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `IDInvohasGrnProducts` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IDInvohasGrnProducts`),
  KEY `fk_invoice_has_grn_has_products_grn_has_products1` (`grn_has_products_IdGRNhasProduct`),
  KEY `fk_invoice_has_grn_has_products_invoice1` (`invoice_idInvoice`),
  CONSTRAINT `fk_invoice_has_grn_has_products_grn_has_products1` FOREIGN KEY (`grn_has_products_IdGRNhasProduct`) REFERENCES `grn_has_products` (`IdGRNhasProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_has_grn_has_products_invoice1` FOREIGN KEY (`invoice_idInvoice`) REFERENCES `invoice` (`idInvoice`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `invoice_has_grn_has_products`
--

/*!40000 ALTER TABLE `invoice_has_grn_has_products` DISABLE KEYS */;
INSERT INTO `invoice_has_grn_has_products` (`invoice_idInvoice`,`grn_has_products_IdGRNhasProduct`,`invoqty`,`total`,`IDInvohasGrnProducts`) VALUES 
 (190,7,1,400,1),
 (191,6,1,150,2),
 (192,1,1,200,3),
 (192,6,1,150,4),
 (193,1,8,1600,5),
 (194,4,2,352,6),
 (194,6,1,123,7),
 (194,8,1,250,8),
 (195,6,1,123,9),
 (196,6,1,150,10),
 (197,6,1,150,11),
 (198,6,1,150,12),
 (199,4,4,704,13),
 (200,4,1,176,14),
 (201,4,1,176,15),
 (202,4,1,200,16),
 (202,9,1,270,17),
 (203,6,1,150,18),
 (204,7,1,400,19),
 (205,6,1,141,20),
 (206,1,1,200,21),
 (206,4,1,200,22),
 (206,6,1,141,23),
 (207,1,1,200,24),
 (207,4,1,200,25),
 (208,1,3,600,26),
 (208,2,3,750,27),
 (208,4,1,200,28),
 (209,2,20,5000,29),
 (210,6,1,150,30),
 (211,6,10,1500,31);
/*!40000 ALTER TABLE `invoice_has_grn_has_products` ENABLE KEYS */;


--
-- Definition of table `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `idLogin` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  PRIMARY KEY (`idLogin`),
  KEY `fk_Login_User1` (`User_idUser`),
  CONSTRAINT `fk_Login_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` (`idLogin`,`username`,`password`,`status`,`User_idUser`) VALUES 
 (1,'Gihan1995','123','0',1),
 (2,'gg','123','0',2),
 (3,'cus123','123','0',3),
 (4,'abc','123','1',4),
 (5,'cs123','123','1',5),
 (6,'Test123','123','1',6);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;


--
-- Definition of table `login_activity`
--

DROP TABLE IF EXISTS `login_activity`;
CREATE TABLE `login_activity` (
  `idLogin_Activity` int(11) NOT NULL AUTO_INCREMENT,
  `Description` text,
  `status` varchar(45) DEFAULT NULL,
  `LoginTimes_idLoginTimes` int(11) NOT NULL,
  PRIMARY KEY (`idLogin_Activity`),
  KEY `fk_Login_Activity_LoginTimes1` (`LoginTimes_idLoginTimes`),
  CONSTRAINT `fk_Login_Activity_LoginTimes1` FOREIGN KEY (`LoginTimes_idLoginTimes`) REFERENCES `logintimes` (`idLoginTimes`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login_activity`
--

/*!40000 ALTER TABLE `login_activity` DISABLE KEYS */;
INSERT INTO `login_activity` (`idLogin_Activity`,`Description`,`status`,`LoginTimes_idLoginTimes`) VALUES 
 (1,'Click Admin button','0',94),
 (2,'Click Admin button/Click Admin Button','0',95),
 (3,'Click Home Button/Click Adminpanel Button/Click Product Button/Click Cart  Button','0',96),
 (4,'Click Home Button/Click Adminpanel Button','0',97),
 (5,'Click Cart  Button/Click Adminpanel Button','0',98),
 (6,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',99),
 (7,'Click Home Button/Click Adminpanel Button/Click Product Button','0',100),
 (8,'Click Cart  Button/Click Home Button/Click Adminpanel Button/Click Product Button','0',101),
 (9,'Click Home Button','0',102),
 (10,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',103),
 (11,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',104),
 (12,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',105),
 (13,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',106),
 (14,'Click Home Button','0',107),
 (15,'Click Home Button/Click Adminpanel Button','0',108),
 (16,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',109),
 (17,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',110),
 (18,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',111),
 (19,'Click Home Button/Click Adminpanel Button','0',112),
 (20,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product Button/Click Product Button/Click Cart  Button/Click Home Button/Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',113),
 (21,'Click Cart  Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',114),
 (22,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button','0',115),
 (23,'Click Home Button/Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',116),
 (24,'Click Home Button/Click Adminpanel Button','0',117),
 (25,'Click Home Button/Click Adminpanel Button/Click Home Button','0',118),
 (26,'Click Cart  Button/Click Cart  Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',119),
 (27,'Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Adminpanel Button/Click Product Button','0',120),
 (28,'Click Cart  Button/Click Home Button/Click Product Button','0',121),
 (29,'Click Home Button','0',122),
 (30,'Click Home Button','0',123),
 (31,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',124),
 (32,'Click Home Button','0',125),
 (33,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',126),
 (34,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',127),
 (35,'Click Cart  Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Home Button','0',128),
 (36,'Click Home Button/Click Adminpanel Button','0',129),
 (37,'Click Home Button/Click Product Button','0',130),
 (38,'Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',131),
 (39,'Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',132),
 (40,'Click Home Button/Click Home Button','0',133),
 (41,'Click Home Button','0',134),
 (42,'Click Cart  Button/Click Home Button','0',135),
 (43,'Click Home Button/Click Product Button/Click Product Button/Click Product Button','0',136),
 (44,'Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',137),
 (45,'Click Home Button/Click Cart  Button','0',138),
 (46,'Click Cart  Button','0',139),
 (47,'Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Cart  Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product Button/Click Product Button/Click Product Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',140),
 (48,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',141),
 (49,'Click Home Button/Click Adminpanel Button/Click Cart  Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',142),
 (50,'Click Home Button/Click Product Button/Click Product Button','0',143),
 (51,'Click Home Button/Click Product Button/Click Product Button','0',144),
 (52,'Click Home Button/Click Home Button/Click Product Button','0',145),
 (53,'Click Home Button/Click Product Button','0',146),
 (54,'Click Home Button/Click Adminpanel Button','0',147),
 (55,'Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',148),
 (56,'Click Home Button/Click Product Button/Click Product Button','0',149),
 (57,'Click Home Button/Click Product Button/Click Product Button/Click Home Button/Click Home Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button/Click Product Button','0',150),
 (58,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',151),
 (59,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button','0',152),
 (60,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button','0',153),
 (61,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',154),
 (62,'Click Home Button/Click Home Button/Click Home Button','0',155),
 (63,'Click Home Button','0',156),
 (64,'Click Home Button/Click Home Button','0',157),
 (65,'Click Home Button/Click Home Button/Click Home Button','0',158),
 (66,'Click Home Button','0',159),
 (67,'Click Home Button','0',160),
 (68,'Click Home Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',161),
 (69,'Click Home Button','0',162),
 (70,'Click Cart  Button/Click Home Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',163),
 (71,'Click Home Button/Click Cart  Button/Click Home Button/Click Home Button','0',164),
 (72,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button','0',165),
 (73,'Click Home Button/Click Cart  Button','0',166),
 (74,'Click Cart  Button/Click Home Button','0',167),
 (75,'Click Home Button','0',168),
 (76,'Click Cart  Button','0',169),
 (77,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',170),
 (78,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',171),
 (79,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',172),
 (80,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',173),
 (81,'Click Cart  Button/Click Home Button/Click Cart  Button','0',174),
 (82,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',178),
 (83,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',179),
 (84,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',180),
 (85,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button','0',181),
 (86,'Click Home Button/Click Cart  Button/Click Home Button','0',182),
 (87,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',183),
 (88,'Click Cart  Button/Click Cart  Button/Click Home Button','0',187),
 (89,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',188),
 (90,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',189),
 (91,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',190),
 (92,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',191),
 (93,'Click Home Button/Click Cart  Button/Click Home Button','0',192),
 (94,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',193),
 (95,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Home Button','0',194),
 (96,'Click Home Button/Click Adminpanel Button','0',195),
 (97,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',196),
 (98,'Click Home Button/Click Adminpanel Button','0',197),
 (99,'Click Home Button/Click Cart  Button','0',198),
 (100,'Click Home Button/Click Cart  Button/Click Home Button','0',200),
 (101,'Click Home Button','0',202),
 (102,'Click Home Button/Click Home Button','0',203),
 (103,'Click Home Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button','0',204),
 (104,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',205),
 (105,'Click Home Button/Click Cart  Button','0',206),
 (106,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Cart  Button/Click Home Button','0',207),
 (107,'Click Home Button/Click Cart  Button/Click Home Button/Click Home Button/Click Cart  Button/Click Home Button','0',208),
 (108,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',209),
 (109,'Click Home Button','0',210),
 (110,'Click Cart  Button/Click Cart  Button','0',211),
 (111,'Click Home Button','0',212),
 (112,'Click Home Button','0',213),
 (113,'Click Home Button','0',214),
 (114,'Click Home Button/Click Cart  Button/Click Home Button','0',215),
 (115,'Click Home Button/Click Cart  Button/Click Home Button','0',216),
 (116,'Click Cart  Button/Click Cart  Button/Click Home Button','0',217),
 (117,'Click Home Button','0',218),
 (118,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',219),
 (119,'Click Home Button/Click Cart  Button','0',220),
 (120,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',221),
 (121,'Click Home Button/Click Cart  Button/Click Home Button','0',222),
 (122,'Click Home Button/Click Cart  Button','0',223),
 (123,'Click Home Button/Click Cart  Button/Click Home Button/Click Home Button/Click Cart  Button/Click Home Button','0',224),
 (124,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',225),
 (125,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button','0',226),
 (126,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',227),
 (127,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button/Click Cart  Button/Click Home Button','0',228),
 (128,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button','0',229),
 (129,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button','0',230),
 (130,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button','0',231),
 (131,'Click Home Button/Click Home Button','0',232),
 (132,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',233),
 (133,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',234),
 (134,'Click Home Button','0',235),
 (135,'Click Home Button/Click Adminpanel Button','0',236),
 (136,'Click Home Button','0',237),
 (137,'Click Home Button','0',238),
 (138,'Click Home Button','0',239),
 (139,'Click Home Button','0',240),
 (140,'Click Home Button','0',241),
 (141,'Click Home Button','0',242),
 (142,'Click Home Button','0',243),
 (143,'Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',244),
 (144,'Click Home Button','0',245),
 (145,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button','0',246),
 (146,'Click Home Button','0',247),
 (147,'Click Home Button','0',248),
 (148,'Click Home Button/Click Home Button','0',249),
 (149,'Click Home Button','0',250),
 (150,'Click Home Button/Click Home Button','0',251),
 (151,'Click Home Button/Click Home Button','0',252),
 (152,'Click Home Button','0',253),
 (153,'Click Home Button','0',254),
 (154,'Click Home Button','0',255),
 (155,'Click Home Button','0',256),
 (156,'Click Home Button','0',257),
 (157,'Click Home Button','0',258),
 (158,'Click Home Button','0',259),
 (159,'Click Home Button','0',260),
 (160,'Click Home Button/Click Home Button','0',261),
 (161,'Click Home Button/Click Cart  Button/Click Home Button','0',262),
 (162,'Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Home Button/Click Home Button','0',263),
 (163,'Click Home Button/Click Cart  Button/Click Home Button','0',264),
 (164,'Click Home Button','0',265),
 (165,'Click Home Button/Click Home Button','0',266),
 (166,'Click Home Button','0',267),
 (167,'Click Home Button','0',268),
 (168,'Click Home Button','0',269),
 (169,'Click Home Button','0',270),
 (170,'Click Home Button','0',271),
 (171,'Click Home Button/Click Adminpanel Button/Click Cart  Button/Click Home Button/Click Cart  Button','0',272),
 (172,'Click Home Button','0',273),
 (173,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Home Button/Click Cart  Button/Click Home Button','0',274),
 (174,'Click Home Button/Click Home Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Home Button','0',275),
 (175,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',276),
 (176,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click UserActivity Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/View UserActivity Button/Click Home Button/Click View User Button/Click Adminpanel Button/View UserActivity Button','0',277),
 (177,'Click Home Button/Click View User Button/Click View User Button','0',278),
 (178,'Click Home Button/Click View User Button/Click View User Button/Click View User Button','0',279),
 (179,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',280),
 (180,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',281),
 (181,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',282),
 (182,'Click Home Button/Click View User Button/Click View User Button','0',283),
 (183,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',284),
 (184,'Click Home Button/Click View User Button','0',285),
 (185,'Click Home Button/Click View User Button/Click View User Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click View User Button','0',286),
 (186,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Cart  Button/Click Cart  Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',287),
 (187,'Click Home Button/Click View User Button','0',288),
 (188,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',289),
 (189,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',290),
 (190,'Click Home Button/Click View User Button','0',291),
 (191,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',292),
 (192,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',293),
 (193,'Click Home Button/Click View User Button/Click View User Button','0',294),
 (194,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',295),
 (195,'Click Home Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button','0',296),
 (196,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',297),
 (197,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',298),
 (198,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click Home Button','0',299),
 (199,'Click Home Button/Click Adminpanel Button/Click Cart  Button/Click View User Button/Click Home Button','0',300),
 (200,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button','0',301),
 (201,'Click Home Button/Click View User Button','0',302),
 (202,'Click Cart  Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',303),
 (203,'Click Home Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button','0',304),
 (204,'Click Home Button/Click View User Button/Click Cart  Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',305),
 (205,'Click Home Button/Click View User Button/Click View User Button','0',306),
 (206,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',307),
 (207,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',308),
 (208,'Click Home Button/Click Adminpanel Button','0',309),
 (209,'Click Home Button/Click View User Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',310),
 (210,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Home Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',311),
 (211,'Click Home Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click Home Button','0',312),
 (212,'Click Home Button','0',313),
 (213,'Click Home Button/Click Home Button','0',314),
 (214,'Click Home Button','0',315),
 (215,'Click Home Button/Click View User Button/Click View User Button/Click Home Button','0',316),
 (216,'Click Cart  Button','0',317),
 (217,'Click Home Button/Click View User Button/Click View User Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Cart  Button/Click Cart  Button','0',318),
 (218,'Click Home Button/Click Product Button/Click Product Button/Click Product Button','0',319),
 (219,'Click Home Button/Click Product View Button/Click Adminpanel Button/View UserActivity Button/Click Product View Button/View UserActivity Button/Click Product View Button/Click Adminpanel Button','0',320),
 (220,'Click Home Button/Click Adminpanel Button/View UserActivity Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Adminpanel Button/View UserActivity Button/Click Product View Button/Click Cart  Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Home Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button','0',321),
 (221,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button','0',322),
 (222,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',323),
 (223,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',324),
 (224,'Click Home Button/Click Cart  Button/Click Cart  Button','0',325),
 (225,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',326),
 (226,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',327),
 (227,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',328),
 (228,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',329),
 (229,'Click Home Button/Click Cart  Button/Click Cart  Button','0',330),
 (230,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button','0',331),
 (231,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',332),
 (232,'Click Home Button/Click Cart  Button','0',333),
 (233,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Product View Button','0',334),
 (234,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',335),
 (235,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button','0',336),
 (236,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',337),
 (237,'Click Home Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click View User Button/Click View User Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button','0',338),
 (238,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',339),
 (239,'Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',340),
 (240,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',341),
 (241,'Click Home Button','0',342),
 (242,'Click Home Button/Click Checkout  Button/Click View User Button/Click View User Button/Click View User Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click View User Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',343),
 (243,'Click Home Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button','0',344),
 (244,'Click Home Button/Click Checkout  Button/Click Checkout  Button','0',345),
 (245,'Click Home Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button','0',346),
 (246,'Click Home Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button','0',347),
 (247,'Click Home Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button','0',348),
 (248,'Click Home Button/Click Checkout  Button','0',349),
 (249,'Click Home Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button/Click Checkout  Button','0',350),
 (250,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button','0',351),
 (251,'Click Home Button/Click Cart  Button/Click Checkout  Button','0',352),
 (252,'Click Home Button/Click Cart  Button/Click Checkout  Button','0',353),
 (253,'Click Home Button/Click Cart  Button/Click Checkout  Button/Click Cart  Button','0',354),
 (254,'Click Home Button/Click Cart  Button/Click Checkout  Button','0',355),
 (255,'Click Home Button/Click Cart  Button/Click Checkout  Button','0',356),
 (256,'Click Home Button/Click Cart  Button/Click Checkout  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button','0',357),
 (257,'Click Home Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button','0',358),
 (258,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id172/Click Home Button/Viewed Invoice id172/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id173/Click Home Button/Viewed Invoice id173/Click Home Button/Viewed Invoice id173','0',359),
 (259,'Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id174/Click View User Button/Click View User Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id175/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click Home Button/Viewed Invoice id176/Click View User Button/Click View User Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id177/Click View User Button','0',360),
 (260,'Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id178/Click Home Button/Viewed Invoice id178/Click Home Button/Viewed Invoice id178/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id179/Click Home Button/Viewed Invoice id179/Click Home Button/Viewed Invoice id179/Click Home Button/Viewed Invoice id179/Click Home Button/Viewed Invoice id179/Click View User Button/Click View User Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id180/Click Home Button/Viewed Invoice id180/Click Home Button/Viewed Invoice id180/Click Home Button/Viewed Invoice id180/Click Home Button/Viewed Invoice id180/Click Home Button/Viewed Invoice id180/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click View User Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click View User Button/Click View User Button/Click View User Button/Click Product View Button/Click View User Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button','0',361),
 (261,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',362),
 (262,'Click Home Button/Click Product View Button','0',363),
 (263,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id181','0',364),
 (264,'Click Home Button/Click Home Button','0',365),
 (265,'Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',366),
 (266,'Click Home Button','0',367),
 (268,'Click Home Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button','0',369),
 (269,'Click Home Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id182/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click View User Button/Click View User Button','0',370),
 (270,'Click Home Button/Click Product View Button/Click View User Button/Click Home Button/Click Home Button/Click Home Button','0',371),
 (271,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',372),
 (272,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',373),
 (273,'Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id183/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',374),
 (274,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click View User Button/Click Product View Button/Click View User Button/Click Home Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',375),
 (275,'Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id184/Click View User Button/Click Home Button/Click Product View Button/Click Home Button/Click Product View Button','0',376),
 (276,'Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id185/Click View User Button/Click View User Button','0',377),
 (277,'Click Home Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id186/Click Home Button/Viewed Invoice id186/Click Home Button/Viewed Invoice id186/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id187/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Product View Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id188/Click Home Button/Viewed Invoice id188/Click Home Button/Click View User Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id189','0',378),
 (278,'Click Home Button/Click View User Button/Click Home Button','0',379),
 (279,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',380),
 (280,'Click Home Button/Click View User Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id190/Click Product View Button/Click Product View Button/Click Product View Button/Click Home Button','0',381),
 (281,'Click Home Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click View User Button/Click Home Button','0',382),
 (282,'Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id191/Click Home Button/Viewed Invoice id191/Click Home Button/Viewed Invoice id191/Click Home Button/Viewed Invoice id191/Click Product View Button/Click Cart  Button/Click Cart  Button','0',383),
 (283,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Cart  Button/Click Cart  Button','0',384),
 (284,'Click Home Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id192/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Viewed Invoice id193/Click Home Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button','0',385),
 (285,'Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id194/Click Home Button/Viewed Invoice id194/Click View User Button/Click View User Button/Click View User Button/Click Home Button/Click View User Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Home Button/Click Home Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id195/Click View User Button','0',386),
 (286,'Click Cart  Button/Click Checkout  Button','0',387),
 (287,'Click Home Button/Click Product View Button/Click Product View Button/Click View User Button/Click View User Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Adminpanel Button/Click Product View Button/Click Home Button/Click Home Button/Click Product View Button/Click Adminpanel Button','0',388),
 (288,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',389),
 (289,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',390),
 (290,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',391),
 (291,'Click Home Button/Click Adminpanel Button','0',392),
 (292,'Click Home Button/Click Adminpanel Button/Click Product View Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',393),
 (293,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',394);
INSERT INTO `login_activity` (`idLogin_Activity`,`Description`,`status`,`LoginTimes_idLoginTimes`) VALUES 
 (294,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button','0',395),
 (295,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',396),
 (296,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',397),
 (297,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Checkout  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Home Button/Click Adminpanel Button/View UserActivity Button/View UserActivity Button/View UserActivity Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Home Button','0',398),
 (298,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',399),
 (299,'Click Home Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id198/Click View User Button/Click Product View Button/Click View User Button/Click View User Button/Click Product View Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id199/Click View User Button/Click Home Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id200/Click View User Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id201/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',400),
 (300,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',401),
 (301,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Home Button','0',402),
 (302,'Click Home Button/Click Cart  Button/Click Adminpanel Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Home Button','0',403),
 (303,'Click Cart  Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click View User Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id202/Click View User Button/Click Cart  Button/Click Product View Button/Click View User Button/Click Product View Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Adminpanel Button/View UserActivity Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click Home Button','0',404),
 (304,'Click Home Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button','0',405),
 (305,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',406),
 (306,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',407),
 (307,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',408),
 (308,'Click Home Button/Click Adminpanel Button','0',409),
 (309,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button','0',410),
 (310,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',411),
 (311,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Product View Button','0',412),
 (312,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',413),
 (313,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Adminpanel Button/Click Home Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',414),
 (314,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button','0',415),
 (315,'Click Home Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click View User Button','0',416),
 (316,'Click Home Button/Click Adminpanel Button/Click Home Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button','0',417),
 (317,'Click Home Button/Click Adminpanel Button','0',418),
 (318,'Click Home Button/Click Adminpanel Button','0',419),
 (319,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id203/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click View User Button','0',420),
 (320,'Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id204/Click View User Button/Click Product View Button/Click Product View Button/Click View User Button/Click Home Button/Click Adminpanel Button/Click Product View Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Home Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id205/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click Product View Button/Click View User Button/Click View User Button/Click Product View Button/Click Home Button/Click Home Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button','0',421),
 (321,'Click Home Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id206/Click View User Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',422),
 (322,'Click Home Button/Click Adminpanel Button','0',423),
 (323,'Click Home Button/Click Adminpanel Button','0',424),
 (324,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button','0',425),
 (325,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click View User Button/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',426),
 (326,'Click Home Button/Click Adminpanel Button/Click View User Button/Click View User Button/Click Home Button/Click Adminpanel Button','0',427),
 (327,'Click Home Button','0',428),
 (328,'Click Home Button/Click Home Button','0',429),
 (329,'Click Home Button/Click Adminpanel Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Product View Button','0',430),
 (330,'Click Home Button/Click Cart  Button/Click Product View Button/Click Cart  Button/Click Cart  Button/Click Cart  Button/Click Home Button','0',431),
 (331,'Click Cart  Button/Click View User Button','0',432),
 (332,'Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',433),
 (333,'Click Home Button/Click Home Button/Click Home Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id207/Click Cart  Button','0',434),
 (334,'Click Home Button','0',435),
 (335,'Click Home Button','0',436),
 (336,'Click Home Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',437),
 (337,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button','0',438),
 (338,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button','0',439),
 (339,'Click Home Button/Click Adminpanel Button','0',440),
 (340,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button','0',441),
 (341,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click View User Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button/Click Product View Button','0',442),
 (342,'Click Home Button/Click Adminpanel Button','0',443),
 (343,'Click Home Button/Click View User Button/Click View User Button/Click Product View Button/Click Product View Button/Click Adminpanel Button/View UserActivity Button/Click Adminpanel Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Cart  Button/Click Cart  Button/Click Home Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Product View Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Home Button/Click Product View Button/Click View User Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Home Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/Click Adminpanel Button/View UserActivity Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Product View Button/Click Home Button/Click View User Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Product View Button/Click View User Button/Click Home Button','0',444),
 (344,'Click Home Button/Click View User Button/Click Home Button/Click Home Button/Click Adminpanel Button','0',445),
 (345,'Click Home Button/Click Home Button','0',446),
 (346,'Click Home Button/Click Adminpanel Button/Click Adminpanel Button','0',447),
 (347,'Click Cart  Button/Click Cart  Button/Click Home Button','0',448),
 (348,'Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id208/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button','0',449),
 (349,'Click Home Button/Click Adminpanel Button','0',450),
 (350,'Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id209','0',451),
 (351,'Click Home Button/Click View User Button/Click Product View Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button/Click Home Button','0',452),
 (352,'Click Home Button/Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id210/Click Adminpanel Button','0',453),
 (353,'Click Home Button/Click Adminpanel Button','0',454),
 (354,'Click Cart  Button/Click Checkout  Button/Click Home Button/Viewed Invoice id211/Click View User Button/Click Adminpanel Button/Click Adminpanel Button/Click View User Button/Click Adminpanel Button','0',455),
 (355,'Click Home Button/Click Home Button','0',456);
/*!40000 ALTER TABLE `login_activity` ENABLE KEYS */;


--
-- Definition of table `logintimes`
--

DROP TABLE IF EXISTS `logintimes`;
CREATE TABLE `logintimes` (
  `idLoginTimes` int(11) NOT NULL AUTO_INCREMENT,
  `logdate` date DEFAULT NULL,
  `intime` time DEFAULT NULL,
  `outtime` time DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `Login_idLogin` int(11) NOT NULL,
  PRIMARY KEY (`idLoginTimes`),
  KEY `fk_LoginTimes_Login1` (`Login_idLogin`),
  CONSTRAINT `fk_LoginTimes_Login1` FOREIGN KEY (`Login_idLogin`) REFERENCES `login` (`idLogin`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logintimes`
--

/*!40000 ALTER TABLE `logintimes` DISABLE KEYS */;
INSERT INTO `logintimes` (`idLoginTimes`,`logdate`,`intime`,`outtime`,`status`,`Login_idLogin`) VALUES 
 (87,'2016-11-09','14:03:53','14:51:21','0',1),
 (88,'2016-11-09','14:51:21','20:42:55','0',1),
 (89,'2016-11-09','20:42:55','20:56:28','0',1),
 (90,'2016-11-09','20:56:28','21:05:50','0',1),
 (91,'2016-11-09','21:05:50','21:06:14','0',1),
 (92,'2016-11-09','21:53:01','22:43:50','0',1),
 (93,'2016-11-09','22:43:50','23:09:46','0',1),
 (94,'2016-11-09','23:09:46','23:27:34','0',1),
 (95,'2016-11-09','23:27:34','00:23:47','0',1),
 (96,'2016-11-10','00:23:47','00:24:17','0',1),
 (97,'2016-11-10','00:24:25','09:04:03','0',1),
 (98,'2016-11-10','09:04:03','11:18:31','0',1),
 (99,'2016-11-10','11:18:31','11:21:22','0',1),
 (100,'2016-11-10','11:21:22','21:03:13','0',1),
 (101,'2016-11-10','21:03:13','19:32:55','0',1),
 (102,'2016-11-11','19:32:55','19:33:47','0',1),
 (103,'2016-11-11','19:38:57','19:59:07','0',1),
 (104,'2016-11-11','20:01:18','20:08:47','0',1),
 (105,'2016-11-11','22:41:55','22:58:57','0',1),
 (106,'2016-11-11','23:09:48','23:25:43','0',1),
 (107,'2016-11-12','09:52:57','09:54:17','0',1),
 (108,'2016-11-12','09:58:50','10:01:15','0',1),
 (109,'2016-11-12','12:17:31','22:23:13','0',1),
 (110,'2016-11-12','22:23:13','09:47:10','0',1),
 (111,'2016-11-13','09:47:10','17:14:31','0',1),
 (112,'2016-11-13','17:14:31','11:11:56','0',1),
 (113,'2016-11-14','11:11:56','08:59:42','0',1),
 (114,'2016-11-15','08:59:42','11:43:09','0',1),
 (115,'2016-11-16','11:43:09','11:45:45','0',1),
 (116,'2016-11-16','11:47:26','11:51:02','0',1),
 (117,'2016-11-17','08:27:57','08:28:30','0',1),
 (118,'2016-11-17','08:30:11','08:32:13','0',1),
 (119,'2016-11-17','08:44:38','09:30:34','0',1),
 (120,'2016-11-17','09:30:44','09:31:00','0',1),
 (121,'2016-11-17','21:45:34','21:46:08','0',1),
 (122,'2016-11-17','21:49:20','21:52:23','0',1),
 (123,'2016-11-17','21:53:12','10:37:41','0',1),
 (124,'2016-11-18','10:37:41','10:41:51','0',1),
 (125,'2016-11-18','10:44:32','10:44:47','0',1),
 (126,'2016-11-18','10:50:04','11:00:39','0',1),
 (127,'2016-11-18','11:09:23','11:13:18','0',1),
 (128,'2016-11-18','13:22:16','13:34:36','0',1),
 (129,'2016-11-18','14:12:27','14:30:24','0',1),
 (130,'2016-11-18','14:30:24','14:39:31','0',1),
 (131,'2016-11-18','14:39:31','14:42:46','0',1),
 (132,'2016-11-18','14:43:10','14:44:28','0',1),
 (133,'2016-11-18','14:44:48','14:48:00','0',1),
 (134,'2016-11-18','14:48:08','14:50:14','0',1),
 (135,'2016-11-18','14:50:43','14:50:59','0',1),
 (136,'2016-11-18','14:51:57','14:52:19','0',3),
 (137,'2016-11-18','14:52:29','14:52:35','0',3),
 (138,'2016-11-18','14:52:45','17:03:44','0',1),
 (139,'2016-11-18','17:03:44','09:16:02','0',1),
 (140,'2016-11-19','09:16:02','12:20:31','0',1),
 (141,'2016-11-19','12:20:31','12:33:42','0',1),
 (142,'2016-11-21','12:33:42','12:55:59','0',1),
 (143,'2016-11-21','12:55:59','12:56:04','0',1),
 (144,'2016-11-21','13:14:11','13:16:52','0',1),
 (145,'2016-11-21','13:17:21','13:28:38','0',2),
 (146,'2016-11-21','13:29:04','13:29:20','0',1),
 (147,'2016-11-21','13:29:28','13:31:42','0',1),
 (148,'2016-11-21','13:34:34','23:29:14','0',2),
 (149,'2016-11-21','13:46:49','13:50:12','0',1),
 (150,'2016-11-21','13:50:12','13:57:07','0',1),
 (151,'2016-11-21','13:58:23','22:48:47','0',1),
 (152,'2016-11-21','22:48:47','22:52:42','0',1),
 (153,'2016-11-21','23:06:56','23:08:23','0',1),
 (154,'2016-11-21','23:17:43','23:20:38','0',1),
 (155,'2016-11-21','23:20:38','23:25:37','0',1),
 (156,'2016-11-21','23:29:14','23:29:25','0',2),
 (157,'2016-11-21','23:40:49','23:42:02','0',1),
 (158,'2016-11-21','23:42:11','23:45:43','0',2),
 (159,'2016-11-21','23:45:50','23:46:16','0',1),
 (160,'2016-11-22','13:22:50','08:21:26','0',1),
 (161,'2016-11-24','08:21:26','16:43:14','0',1),
 (162,'2016-11-24','16:43:14','16:43:28','0',1),
 (163,'2016-11-27','22:24:01','23:10:19','0',2),
 (164,'2016-11-27','22:55:43','23:14:05','0',1),
 (165,'2016-11-27','23:14:05','23:56:45','0',1),
 (166,'2016-11-27','23:56:45','09:20:57','0',1),
 (167,'2016-11-28','09:20:57','09:21:48','0',1),
 (168,'2016-11-28','09:22:10','10:17:47','0',1),
 (169,'2016-11-28','10:17:47','10:40:24','0',1),
 (170,'2016-11-28','10:40:24','10:50:40','0',1),
 (171,'2016-11-28','10:51:48','11:39:51','0',1),
 (172,'2016-11-28','11:39:51','11:50:13','0',1),
 (173,'2016-11-28','12:12:47','12:27:34','0',1),
 (174,'2016-11-28','12:27:34','12:32:06','0',1),
 (175,'2016-11-28','12:32:06','12:32:23','0',1),
 (176,'2016-11-28','12:32:23','12:37:16','0',1),
 (177,'2016-11-28','12:37:16','12:38:03','0',1),
 (178,'2016-11-28','12:38:03','12:41:12','0',1),
 (179,'2016-11-28','12:41:12','12:45:52','0',1),
 (180,'2016-11-28','12:49:38','12:56:19','0',1),
 (181,'2016-11-28','12:56:19','13:00:15','0',1),
 (182,'2016-11-28','13:00:15','13:35:13','0',1),
 (183,'2016-11-28','13:35:13','13:39:54','0',1),
 (184,'2016-11-28','13:39:54','13:40:22','0',1),
 (185,'2016-11-28','13:40:22','13:41:09','0',1),
 (186,'2016-11-28','13:41:09','22:37:43','0',1),
 (187,'2016-11-29','22:37:43','22:43:08','0',1),
 (188,'2016-11-29','22:43:08','22:59:12','0',1),
 (189,'2016-11-29','22:59:12','23:04:27','0',1),
 (190,'2016-11-29','23:05:45','23:39:15','0',1),
 (191,'2016-11-29','23:10:19','23:51:17','0',2),
 (192,'2016-11-29','23:39:15','00:11:59','0',1),
 (193,'2016-11-29','23:51:17','00:09:40','0',2),
 (194,'2016-11-30','00:09:40','11:16:33','0',2),
 (195,'2016-11-30','00:11:59','08:36:34','0',1),
 (196,'2016-11-30','08:36:34','08:47:15','0',1),
 (197,'2016-12-01','08:47:15','08:51:17','0',1),
 (198,'2016-12-01','08:51:17','08:52:13','0',1),
 (199,'2016-12-01','08:52:30','08:55:30','0',1),
 (200,'2016-12-01','08:55:30','09:05:29','0',1),
 (201,'2016-12-01','09:05:29','09:05:43','0',1),
 (202,'2016-12-01','09:05:43','09:28:08','0',1),
 (203,'2016-12-01','09:28:08','09:30:18','0',1),
 (204,'2016-12-01','09:30:18','09:36:38','0',1),
 (205,'2016-12-01','09:36:38','09:49:55','0',1),
 (206,'2016-12-01','09:49:55','09:52:20','0',1),
 (207,'2016-12-01','09:52:20','10:05:34','0',1),
 (208,'2016-12-01','10:05:34','10:13:11','0',1),
 (209,'2016-12-01','10:13:11','10:25:27','0',1),
 (210,'2016-12-01','10:25:27','10:31:02','0',1),
 (211,'2016-12-01','10:31:02','10:42:15','0',1),
 (212,'2016-12-01','10:42:15','10:47:32','0',1),
 (213,'2016-12-01','10:47:32','10:50:20','0',1),
 (214,'2016-12-01','10:50:20','10:56:56','0',1),
 (215,'2016-12-01','10:56:56','11:04:41','0',1),
 (216,'2016-12-01','11:04:41','11:13:16','0',1),
 (217,'2016-12-01','11:13:16','11:14:50','0',1),
 (218,'2016-12-01','11:14:59','11:16:23','0',1),
 (219,'2016-12-01','11:16:33','11:23:42','0',2),
 (220,'2016-12-01','11:23:42','11:39:06','0',2),
 (221,'2016-12-01','11:32:14','11:37:45','0',1),
 (222,'2016-12-01','11:37:45','11:38:57','0',1),
 (223,'2016-12-01','11:39:06','11:46:18','0',2),
 (224,'2016-12-01','11:46:18','11:47:15','0',2),
 (225,'2016-12-01','11:47:24','11:58:37','0',1),
 (226,'2016-12-01','11:58:37','12:12:53','0',1),
 (227,'2016-12-01','12:12:53','12:20:56','0',1),
 (228,'2016-12-01','12:20:56','12:34:39','0',1),
 (229,'2016-12-01','12:34:39','12:41:16','0',1),
 (230,'2016-12-01','12:41:24','12:44:06','0',2),
 (231,'2016-12-01','12:44:16','17:37:19','0',1),
 (232,'2016-12-02','17:37:19','17:39:17','0',1),
 (233,'2016-12-02','17:39:24','18:25:06','0',2),
 (234,'2016-12-02','17:54:25','18:21:44','0',1),
 (235,'2016-12-02','18:21:44','18:22:42','0',1),
 (236,'2016-12-02','18:22:54','18:24:57','0',1),
 (237,'2016-12-02','18:25:06','23:43:48','0',2),
 (238,'2016-12-02','19:04:07','20:37:28','0',1),
 (239,'2016-12-02','20:37:28','21:23:03','0',1),
 (240,'2016-12-02','21:23:03','21:43:33','0',1),
 (241,'2016-12-02','21:43:33','22:52:39','0',1),
 (242,'2016-12-02','22:52:39','09:34:59','0',1),
 (243,'2016-12-02','23:43:48','18:18:39','0',2),
 (244,'2016-12-03','18:18:39','02:21:06','0',2),
 (245,'2016-12-05','09:34:59','09:51:26','0',1),
 (246,'2016-12-05','09:51:26','13:11:38','0',1),
 (247,'2016-12-05','13:11:38','08:38:38','0',1),
 (248,'2016-12-06','08:38:38','09:19:21','0',1),
 (249,'2016-12-06','09:19:21','09:22:05','0',1),
 (250,'2016-12-06','09:22:15','09:26:53','0',1),
 (251,'2016-12-06','09:26:53','10:35:02','0',1),
 (252,'2016-12-06','10:35:02','10:39:12','0',1),
 (253,'2016-12-06','10:39:12','10:41:45','0',1),
 (254,'2016-12-06','10:42:20','13:01:44','0',1),
 (255,'2016-12-06','13:01:44','13:39:59','0',1),
 (256,'2016-12-06','13:39:59','13:41:43','0',1),
 (257,'2016-12-06','13:41:43','14:26:40','0',1),
 (258,'2016-12-06','14:26:40','14:34:06','0',1),
 (259,'2016-12-06','14:34:06','20:53:16','0',1),
 (260,'2016-12-06','20:53:16','21:10:59','0',1),
 (261,'2016-12-06','21:10:59','22:23:43','0',1),
 (262,'2016-12-06','22:23:43','23:02:05','0',1),
 (263,'2016-12-06','23:02:05','01:24:53','0',1),
 (264,'2016-12-07','01:25:03','01:34:36','0',1),
 (265,'2016-12-07','08:18:50','08:26:09','0',1),
 (266,'2016-12-07','08:26:09','08:26:33','0',1),
 (267,'2016-12-07','08:26:44','10:50:47','0',1),
 (268,'2016-12-07','10:50:47','11:26:29','0',1),
 (269,'2016-12-07','11:26:29','11:43:11','0',1),
 (270,'2016-12-07','11:43:11','12:40:04','0',1),
 (271,'2016-12-07','12:40:04','13:54:43','0',1),
 (272,'2016-12-07','22:00:10','09:28:34','0',1),
 (273,'2016-12-08','09:28:34','09:29:06','0',1),
 (274,'2016-12-08','09:29:06','11:25:01','0',1),
 (275,'2016-12-08','11:25:01','12:22:20','0',1),
 (276,'2016-12-08','12:22:20','13:18:50','0',1),
 (277,'2016-12-08','13:18:50','20:28:39','0',1),
 (278,'2016-12-08','20:28:39','21:44:56','0',1),
 (279,'2016-12-08','21:44:56','21:52:56','0',1),
 (280,'2016-12-08','21:52:56','23:41:37','0',1),
 (281,'2016-12-08','23:41:37','01:51:29','0',1),
 (282,'2016-12-09','01:51:29','01:57:14','0',1),
 (283,'2016-12-09','01:57:14','02:00:09','0',1),
 (284,'2016-12-09','02:00:09','02:18:58','0',1),
 (285,'2016-12-09','02:18:58','02:19:59','0',1),
 (286,'2016-12-09','02:21:06','16:55:13','0',2),
 (287,'2016-12-09','10:53:34','12:28:47','0',1),
 (288,'2016-12-09','12:28:47','12:30:48','0',1),
 (289,'2016-12-09','12:30:48','14:31:10','0',1),
 (290,'2016-12-09','14:31:10','16:55:09','0',1),
 (291,'2016-12-09','16:55:09','17:19:44','0',1),
 (292,'2016-12-09','17:19:44','18:02:21','0',1),
 (293,'2016-12-09','18:02:21','22:07:26','0',1),
 (294,'2016-12-09','22:07:26','22:15:35','0',1),
 (295,'2016-12-09','22:15:35','22:52:59','0',1),
 (296,'2016-12-10','09:13:45','11:17:46','0',1),
 (297,'2016-12-10','11:17:54','11:45:13','0',1),
 (298,'2016-12-10','11:45:13','12:12:56','0',1),
 (299,'2016-12-10','12:12:56','08:09:57','0',1),
 (300,'2016-12-17','08:09:57','15:16:36','0',1),
 (301,'2016-12-17','15:16:36','16:54:46','0',1),
 (302,'2016-12-17','16:55:13','16:56:02','0',2),
 (303,'2016-12-17','17:24:53','19:16:13','0',1),
 (304,'2016-12-18','19:16:13','20:50:41','0',1),
 (305,'2016-12-19','20:50:41','20:54:30','0',1),
 (306,'2016-12-19','20:55:29','20:57:10','0',4),
 (307,'2016-12-19','20:57:18',NULL,'1',4),
 (308,'2016-12-19','21:49:08','22:06:20','0',1),
 (309,'2016-12-19','22:06:20','15:39:09','0',1),
 (310,'2017-01-06','15:39:09','16:12:26','0',1),
 (311,'2017-01-06','16:12:26','22:02:18','0',1),
 (312,'2017-01-06','22:02:18','01:35:09','0',1),
 (313,'2017-01-07','14:14:37','14:18:50','0',1),
 (314,'2017-01-07','14:19:00','15:04:06','0',1),
 (315,'2017-01-07','15:04:06','13:48:59','0',1),
 (316,'2017-01-08','13:48:59','15:03:48','0',1),
 (317,'2017-01-08','15:03:48','20:39:33','0',1),
 (318,'2017-01-08','20:39:33','21:34:42','0',1),
 (319,'2017-01-08','21:34:42','08:58:21','0',1),
 (320,'2017-01-10','08:58:21','09:08:48','0',1),
 (321,'2017-01-10','09:08:48','11:25:58','0',1),
 (322,'2017-01-10','11:28:02','11:39:11','0',1),
 (323,'2017-01-10','11:41:38','12:02:23','0',1),
 (324,'2017-01-10','12:02:58','12:32:44','0',1),
 (325,'2017-01-10','12:32:57','12:34:33','0',1),
 (326,'2017-01-10','12:37:35','12:47:00','0',1),
 (327,'2017-01-10','12:51:53','13:00:55','0',1),
 (328,'2017-01-10','13:00:56','13:27:07','0',1),
 (329,'2017-01-10','13:34:43','13:45:54','0',1),
 (330,'2017-01-10','13:45:54','14:01:25','0',1),
 (331,'2017-01-10','14:01:25','22:21:59','0',1),
 (332,'2017-01-10','22:21:59','22:38:40','0',1),
 (333,'2017-01-10','22:38:40','22:42:57','0',1),
 (334,'2017-01-10','22:42:57','22:48:58','0',1),
 (335,'2017-01-10','22:48:58','23:00:28','0',1),
 (336,'2017-01-10','23:00:28','23:14:38','0',1),
 (337,'2017-01-10','23:14:38','23:24:56','0',1),
 (338,'2017-01-10','23:24:56','23:37:48','0',1),
 (339,'2017-01-10','23:37:48','23:46:39','0',1),
 (340,'2017-01-10','23:46:40','00:29:44','0',1),
 (341,'2017-01-11','00:29:44','00:41:00','0',1),
 (342,'2017-01-11','13:23:08','13:35:47','0',1),
 (343,'2017-01-11','13:35:47','16:07:02','0',1),
 (344,'2017-01-11','16:07:02','16:09:47','0',1),
 (345,'2017-01-11','16:09:47','16:21:46','0',1),
 (346,'2017-01-11','16:21:46','16:29:49','0',1),
 (347,'2017-01-11','16:29:49','17:08:06','0',1),
 (348,'2017-01-11','17:08:31','17:15:02','0',2),
 (349,'2017-01-11','17:15:08','21:59:14','0',1),
 (350,'2017-01-11','21:59:14','12:14:44','0',1),
 (351,'2017-01-12','12:14:44','12:17:57','0',1),
 (352,'2017-01-12','12:17:57','12:42:01','0',1),
 (353,'2017-01-12','12:42:01','12:49:04','0',1),
 (354,'2017-01-12','12:49:04','12:53:15','0',1),
 (355,'2017-01-12','12:53:38','12:57:59','0',1),
 (356,'2017-01-12','12:58:45','13:01:07','0',1),
 (357,'2017-01-12','13:01:17','13:06:28','0',1),
 (358,'2017-01-12','13:06:36','13:36:24','0',1),
 (359,'2017-01-12','13:36:24','14:16:05','0',1),
 (360,'2017-01-12','14:16:05','15:58:01','0',1),
 (361,'2017-01-12','15:58:01','17:18:40','0',1),
 (362,'2017-01-12','17:18:40','17:28:06','0',1),
 (363,'2017-01-12','17:28:06','17:31:43','0',1),
 (364,'2017-01-12','17:31:43','17:34:53','0',1),
 (365,'2017-01-12','17:34:53','18:00:55','0',1),
 (366,'2017-01-12','18:00:56','18:05:13','0',1),
 (367,'2017-01-12','18:05:13','18:06:37','0',1),
 (369,'2017-01-12','18:17:39','18:26:54','0',1),
 (370,'2017-01-12','18:28:26','18:35:48','0',1),
 (371,'2017-01-12','18:35:48','17:37:38','0',1),
 (372,'2017-01-14','17:37:38','08:33:40','0',1),
 (373,'2017-01-15','08:33:40','09:24:17','0',1),
 (374,'2017-01-15','09:24:17','13:44:32','0',1),
 (375,'2017-01-15','13:44:32','14:07:55','0',1),
 (376,'2017-01-15','14:07:55','15:23:17','0',1),
 (377,'2017-01-16','15:23:17','16:14:42','0',1),
 (378,'2017-01-16','16:14:42','17:28:13','0',1),
 (379,'2017-01-16','17:28:13','09:10:46','0',1),
 (380,'2017-01-18','09:10:46','11:12:26','0',1),
 (381,'2017-01-19','11:12:26','16:06:45','0',1),
 (382,'2017-01-20','16:06:45','19:57:53','0',1),
 (383,'2017-01-21','19:57:53','20:28:13','0',1),
 (384,'2017-01-21','21:22:32','22:17:38','0',1),
 (385,'2017-01-21','22:17:38','23:19:51','0',1),
 (386,'2017-01-21','23:19:51','14:46:18','0',1),
 (387,'2017-01-22','14:46:18','15:05:38','0',1),
 (388,'2017-01-22','15:05:38','12:05:50','0',1),
 (389,'2017-01-23','12:05:50','20:39:17','0',1),
 (390,'2017-01-23','20:39:17','23:19:14','0',1),
 (391,'2017-01-23','23:19:14','00:39:19','0',1),
 (392,'2017-01-24','00:39:28','00:39:33','0',1),
 (393,'2017-01-26','11:27:00','12:39:26','0',1),
 (394,'2017-01-26','12:39:27','20:16:47','0',1),
 (395,'2017-01-26','20:16:47','23:30:11','0',1),
 (396,'2017-01-26','23:30:11','10:35:49','0',1),
 (397,'2017-02-01','10:35:49','12:29:28','0',1),
 (398,'2017-02-01','12:29:29','11:20:37','0',1),
 (399,'2017-02-02','11:20:37','12:06:53','0',1),
 (400,'2017-02-02','12:06:53','17:09:52','0',1),
 (401,'2017-02-02','17:09:52','17:18:59','0',1),
 (402,'2017-02-02','17:18:59','21:13:57','0',1),
 (403,'2017-02-02','21:13:57','14:30:00','0',1),
 (404,'2017-02-03','14:30:00','14:44:21','0',1),
 (405,'2017-02-03','19:43:21','19:52:20','0',1),
 (406,'2017-02-03','19:52:20','21:18:49','0',1),
 (407,'2017-02-03','21:18:49','21:34:48','0',1),
 (408,'2017-02-03','21:34:48','16:44:51','0',1),
 (409,'2017-02-04','16:44:52','19:15:13','0',1),
 (410,'2017-02-04','19:15:13','21:34:39','0',1),
 (411,'2017-02-04','21:34:39','22:59:49','0',1),
 (412,'2017-02-04','22:59:49','01:45:39','0',1),
 (413,'2017-02-05','01:45:39','07:50:00','0',1),
 (414,'2017-02-05','07:50:00','11:01:46','0',1),
 (415,'2017-02-05','11:01:46','11:56:50','0',1),
 (416,'2017-02-05','11:56:50','13:25:30','0',1),
 (417,'2017-02-05','13:25:30','12:36:32','0',1),
 (418,'2017-02-06','12:36:32','21:27:12','0',1),
 (419,'2017-02-06','21:27:12','12:25:41','0',1),
 (420,'2017-02-08','12:25:41','12:54:14','0',1),
 (421,'2017-02-08','12:54:14','16:05:07','0',1),
 (422,'2017-02-08','16:05:07','16:25:01','0',1),
 (423,'2017-02-08','16:25:01','16:26:18','0',1),
 (424,'2017-02-08','16:26:18','16:28:14','0',1),
 (425,'2017-02-08','16:28:14','22:34:41','0',1),
 (426,'2017-02-08','22:34:42','11:52:26','0',1),
 (427,'2017-02-09','11:52:26','11:58:20','0',1),
 (428,'2017-02-09','11:59:13','11:59:48','0',5),
 (429,'2017-02-09','12:01:08',NULL,'1',5),
 (430,'2017-02-09','12:02:52','12:05:07','0',1),
 (431,'2017-02-09','12:05:07','12:14:13','0',1),
 (432,'2017-02-09','12:14:13','12:15:22','0',1),
 (433,'2017-02-09','12:18:05','12:31:37','0',1),
 (434,'2017-02-09','12:31:37','12:38:39','0',1),
 (435,'2017-02-09','12:38:39','12:39:00','0',1),
 (436,'2017-02-09','12:39:00','12:49:59','0',1),
 (437,'2017-02-09','12:49:59','13:08:11','0',1),
 (438,'2017-02-09','13:08:21','13:10:37','0',1),
 (439,'2017-02-09','13:10:37','13:13:05','0',1),
 (440,'2017-02-09','13:13:05','13:14:32','0',1),
 (441,'2017-02-09','13:28:23','13:29:06','0',1),
 (442,'2017-02-09','13:29:21','08:36:24','0',1),
 (443,'2017-03-03','08:36:25','08:37:37','0',1),
 (444,'2017-03-15','08:27:25','08:56:33','0',1),
 (445,'2017-03-16','08:56:33','08:59:34','0',1),
 (446,'2017-03-16','09:04:25','12:36:37','0',6),
 (447,'2017-03-16','09:41:13','09:46:36','0',1),
 (448,'2017-03-16','09:46:36','09:57:09','0',1),
 (449,'2017-03-16','09:57:09','10:01:00','0',1),
 (450,'2017-03-16','10:01:00','10:02:18','0',1),
 (451,'2017-03-16','10:02:18','10:09:15','0',1),
 (452,'2017-03-16','10:09:15','10:34:41','0',1),
 (453,'2017-03-16','10:34:41','12:25:02','0',1),
 (454,'2017-03-16','12:25:02','12:29:26','0',1),
 (455,'2017-03-16','12:29:26','12:36:26','0',1),
 (456,'2017-03-16','12:36:37',NULL,'1',6);
/*!40000 ALTER TABLE `logintimes` ENABLE KEYS */;


--
-- Definition of table `logintimes_has_page`
--

DROP TABLE IF EXISTS `logintimes_has_page`;
CREATE TABLE `logintimes_has_page` (
  `LoginTimes_idLoginTimes` int(11) NOT NULL,
  `Page_idPage` int(11) NOT NULL,
  `view_time` time DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `idLogintimehasPage` int(11) NOT NULL AUTO_INCREMENT,
  `acc_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`idLogintimehasPage`),
  KEY `fk_LoginTimes_has_Page_Page1` (`Page_idPage`),
  KEY `fk_LoginTimes_has_Page_LoginTimes1` (`LoginTimes_idLoginTimes`),
  CONSTRAINT `fk_LoginTimes_has_Page_LoginTimes1` FOREIGN KEY (`LoginTimes_idLoginTimes`) REFERENCES `logintimes` (`idLoginTimes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LoginTimes_has_Page_Page1` FOREIGN KEY (`Page_idPage`) REFERENCES `page` (`idPage`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=802 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logintimes_has_page`
--

/*!40000 ALTER TABLE `logintimes_has_page` DISABLE KEYS */;
INSERT INTO `logintimes_has_page` (`LoginTimes_idLoginTimes`,`Page_idPage`,`view_time`,`status`,`idLogintimehasPage`,`acc_count`) VALUES 
 (95,1,'23:27:36','1',4,2),
 (96,2,'00:23:48','1',5,1),
 (96,1,'00:23:51','1',6,1),
 (96,3,'00:23:55','1',7,1),
 (96,4,'00:24:09','1',8,1),
 (97,2,'00:24:25','1',9,1),
 (97,1,'00:24:26','1',10,1),
 (98,4,'09:04:03','1',11,1),
 (98,1,'09:04:06','1',12,1),
 (99,2,'11:18:31','1',13,1),
 (99,1,'11:18:49','1',14,6),
 (100,2,'11:21:22','1',15,1),
 (100,1,'11:21:23','1',16,1),
 (100,3,'13:06:25','1',17,1),
 (101,4,'21:03:13','1',18,1),
 (101,2,'21:03:20','1',19,1),
 (101,1,'21:03:22','1',20,1),
 (101,3,'22:05:40','1',21,1),
 (102,2,'19:32:55','1',22,1),
 (103,2,'19:38:57','1',23,11),
 (104,2,'20:01:18','1',24,7),
 (105,2,'22:41:55','1',25,8),
 (106,2,'23:09:48','1',26,10),
 (107,2,'09:52:57','1',27,1),
 (108,2,'09:58:50','1',28,1),
 (108,1,'09:58:59','1',29,1),
 (109,2,'12:17:31','1',30,1),
 (109,1,'12:17:39','1',31,49),
 (110,2,'22:23:13','1',32,1),
 (110,1,'22:23:17','1',33,20),
 (111,2,'09:47:11','1',34,1),
 (111,1,'09:47:15','1',35,51),
 (112,2,'17:14:31','1',36,1),
 (112,1,'17:14:33','1',37,1),
 (113,2,'11:11:57','1',38,3),
 (113,1,'11:12:03','1',39,21),
 (113,3,'12:07:47','1',40,12),
 (113,4,'12:10:33','1',41,5),
 (114,4,'08:59:42','1',42,1),
 (114,1,'08:59:47','1',43,3),
 (114,3,'09:04:49','1',44,14),
 (115,2,'11:43:09','1',45,2),
 (115,1,'11:43:26','1',46,2),
 (116,2,'11:47:26','1',47,2),
 (116,3,'11:50:25','1',48,7),
 (117,2,'08:27:58','1',49,1),
 (117,1,'08:28:01','1',50,1),
 (118,2,'08:30:11','1',51,2),
 (118,1,'08:30:14','1',52,1),
 (119,4,'08:44:38','1',53,2),
 (119,1,'08:46:23','1',54,6),
 (119,3,'09:27:24','1',55,13),
 (119,2,'09:30:09','1',56,1),
 (120,2,'09:30:44','1',57,1),
 (120,3,'09:30:49','1',58,6),
 (120,1,'09:30:56','1',59,1),
 (121,4,'21:45:35','1',60,1),
 (121,2,'21:45:44','1',61,1),
 (121,3,'21:46:06','1',62,1),
 (122,2,'21:49:20','1',63,1),
 (123,2,'21:53:12','1',64,1),
 (124,2,'10:37:41','1',65,6),
 (125,2,'10:44:32','1',66,1),
 (126,2,'10:50:04','1',67,6),
 (127,2,'11:09:23','1',68,7),
 (128,4,'13:22:17','1',69,1),
 (128,1,'13:22:31','1',70,8),
 (128,2,'13:33:12','1',71,3),
 (129,2,'14:12:27','1',72,1),
 (129,1,'14:12:34','1',73,1),
 (130,2,'14:30:24','1',74,1),
 (130,3,'14:30:30','1',75,1),
 (130,3,'14:32:36','1',76,1),
 (131,2,'14:39:32','1',77,4),
 (132,2,'14:43:10','1',78,4),
 (133,2,'14:44:48','1',79,2),
 (134,2,'14:48:08','1',80,1),
 (135,4,'14:50:43','1',81,1),
 (135,2,'14:50:52','1',82,1),
 (136,2,'14:51:58','1',83,1),
 (136,3,'14:52:10','1',84,3),
 (137,2,'14:52:29','1',85,1),
 (137,3,'14:52:31','1',86,5),
 (138,2,'14:52:45','1',87,1),
 (138,4,'14:53:12','1',88,1),
 (139,4,'17:03:44','1',89,1),
 (140,2,'09:16:02','1',90,2),
 (140,3,'09:16:13','1',91,33),
 (140,4,'09:16:45','1',92,26),
 (141,2,'12:20:31','1',93,1),
 (141,4,'12:20:39','1',94,10),
 (142,2,'12:33:42','1',95,1),
 (142,1,'12:33:45','1',96,1),
 (142,4,'12:39:04','1',97,1),
 (142,3,'12:39:51','1',98,25),
 (143,2,'12:55:59','1',99,1),
 (143,3,'12:56:00','1',100,2),
 (144,2,'13:14:11','1',101,1),
 (144,3,'13:14:14','1',102,2),
 (145,2,'13:17:21','1',103,2),
 (145,3,'13:27:12','1',104,1),
 (146,2,'13:29:04','1',105,1),
 (146,3,'13:29:15','1',106,1),
 (147,2,'13:29:28','1',107,1),
 (147,1,'13:29:29','1',108,1),
 (148,2,'13:34:34','1',109,1),
 (148,3,'13:34:35','1',110,10),
 (149,2,'13:46:50','1',111,1),
 (149,3,'13:46:51','1',112,2),
 (150,2,'13:50:12','1',113,3),
 (150,3,'13:50:14','1',114,12),
 (151,2,'13:58:23','1',115,1),
 (151,4,'14:00:43','1',116,4),
 (152,2,'22:48:48','1',117,1),
 (152,1,'22:48:53','1',118,2),
 (153,4,'23:06:56','1',119,3),
 (153,2,'23:07:22','1',120,1),
 (154,2,'23:17:43','1',121,5),
 (155,2,'23:20:38','1',122,3),
 (156,2,'23:29:14','1',123,1),
 (157,2,'23:40:49','1',124,2),
 (158,2,'23:42:11','1',125,3),
 (159,2,'23:45:50','1',126,1),
 (160,2,'13:22:50','1',127,1),
 (161,2,'08:21:26','1',128,28),
 (161,4,'08:21:51','1',129,1),
 (162,2,'16:43:15','1',130,1),
 (163,4,'22:24:01','1',131,6),
 (163,2,'22:24:18','1',132,8),
 (164,2,'22:55:43','1',133,3),
 (164,4,'22:55:57','1',134,1),
 (165,4,'23:14:05','1',135,3),
 (165,2,'23:15:59','1',136,5),
 (166,2,'23:56:45','1',137,1),
 (166,4,'23:57:53','1',138,1),
 (167,4,'09:20:57','1',139,1),
 (167,2,'09:21:08','1',140,1),
 (168,2,'09:22:10','1',141,1),
 (169,4,'10:17:47','1',142,1),
 (170,4,'10:40:24','1',143,6),
 (171,4,'10:51:48','1',144,9),
 (172,2,'11:39:51','1',145,1),
 (172,4,'11:39:57','1',146,5),
 (173,4,'12:12:47','1',147,4),
 (174,4,'12:27:34','1',148,2),
 (174,2,'12:28:24','1',149,1),
 (178,4,'12:38:03','1',150,10),
 (179,4,'12:41:13','1',151,3),
 (179,2,'12:42:08','1',152,2),
 (180,4,'12:49:38','1',153,6),
 (180,2,'12:50:34','1',154,1),
 (181,2,'12:56:19','1',155,2),
 (181,4,'12:56:50','1',156,2),
 (182,2,'13:00:15','1',157,2),
 (182,4,'13:10:45','1',158,1),
 (183,4,'13:35:13','1',159,5),
 (187,4,'22:37:43','1',160,2),
 (187,2,'22:41:11','1',161,1),
 (188,4,'22:43:08','1',162,4),
 (188,2,'22:43:14','1',163,1),
 (189,2,'22:59:12','1',164,2),
 (189,4,'23:00:13','1',165,3),
 (190,2,'23:05:45','1',166,2),
 (190,4,'23:06:16','1',167,3),
 (191,2,'23:10:19','1',168,10),
 (191,4,'23:28:45','1',169,5),
 (192,2,'23:39:15','1',170,2),
 (192,4,'23:39:32','1',171,1),
 (193,2,'23:51:17','1',172,1),
 (193,4,'23:51:29','1',173,5),
 (194,2,'00:09:40','1',174,4),
 (194,4,'00:09:59','1',175,2),
 (195,2,'00:11:59','1',176,1),
 (195,1,'00:12:17','1',177,1),
 (196,2,'08:36:34','1',178,1),
 (196,1,'08:36:54','1',179,10),
 (197,2,'08:47:16','1',180,1),
 (197,1,'08:47:23','1',181,1),
 (198,2,'08:51:17','1',182,1),
 (198,4,'08:51:36','1',183,1),
 (200,2,'08:55:30','1',184,2),
 (200,4,'08:55:59','1',185,1),
 (202,2,'09:05:43','1',186,1),
 (203,2,'09:28:09','1',187,2),
 (204,2,'09:30:18','1',188,3),
 (204,4,'09:32:00','1',189,2),
 (205,2,'09:36:39','1',190,2),
 (205,4,'09:37:43','1',191,2),
 (206,2,'09:49:55','1',192,1),
 (206,4,'09:50:43','1',193,1),
 (207,2,'09:52:20','1',194,5),
 (207,4,'09:55:11','1',195,1),
 (208,2,'10:05:34','1',196,4),
 (208,4,'10:06:10','1',197,2),
 (209,2,'10:13:11','1',198,2),
 (209,4,'10:17:58','1',199,2),
 (210,2,'10:25:27','1',200,1),
 (211,4,'10:31:04','1',201,2),
 (212,2,'10:42:15','1',202,1),
 (213,2,'10:47:32','1',203,1),
 (214,2,'10:50:20','1',204,1),
 (215,2,'10:56:56','1',205,2),
 (215,4,'10:57:47','1',206,1),
 (216,2,'11:04:41','1',207,2),
 (216,4,'11:05:04','1',208,1),
 (217,4,'11:13:16','1',209,2),
 (217,2,'11:14:40','1',210,1),
 (218,2,'11:14:59','1',211,1),
 (219,2,'11:16:33','1',212,2),
 (219,4,'11:17:03','1',213,7),
 (220,2,'11:23:42','1',214,1),
 (220,4,'11:24:26','1',215,1),
 (221,2,'11:32:14','1',216,1),
 (221,4,'11:32:51','1',217,7),
 (222,2,'11:37:45','1',218,2),
 (222,4,'11:38:01','1',219,1),
 (223,2,'11:39:06','1',220,1),
 (223,4,'11:39:55','1',221,1),
 (224,2,'11:46:18','1',222,4),
 (224,4,'11:46:30','1',223,2),
 (225,2,'11:47:24','1',224,7),
 (225,4,'11:48:30','1',225,22),
 (226,4,'11:58:38','1',226,6),
 (226,2,'11:58:52','1',227,4),
 (227,2,'12:12:54','1',228,2),
 (227,4,'12:13:13','1',229,5),
 (228,2,'12:20:56','1',230,10),
 (228,4,'12:21:26','1',231,12),
 (229,2,'12:34:40','1',232,11),
 (229,4,'12:34:43','1',233,14),
 (230,2,'12:41:24','1',234,5),
 (230,4,'12:41:38','1',235,5),
 (231,2,'12:44:16','1',236,4),
 (231,4,'12:44:25','1',237,5),
 (232,2,'17:37:19','1',238,2),
 (232,4,'17:38:05','1',239,2),
 (233,2,'17:39:24','1',240,3),
 (233,4,'17:39:26','1',241,3),
 (234,4,'17:54:25','1',242,3),
 (234,2,'17:54:34','1',243,2),
 (235,2,'18:21:44','1',244,1),
 (236,2,'18:22:54','1',245,1),
 (236,1,'18:24:52','1',246,1),
 (237,2,'18:25:06','1',247,1),
 (238,2,'19:04:07','1',248,1),
 (239,2,'20:37:28','1',249,1),
 (240,2,'21:23:04','1',250,1),
 (241,2,'21:43:33','1',251,1),
 (242,2,'22:52:39','1',252,1),
 (243,2,'23:43:48','1',253,1),
 (244,4,'18:18:39','1',254,3),
 (244,2,'18:18:44','1',255,2),
 (245,2,'09:34:59','1',256,1),
 (246,2,'09:51:26','1',257,1),
 (246,1,'10:05:29','1',258,2),
 (247,2,'13:11:38','1',259,1),
 (248,2,'08:38:38','1',260,1),
 (249,2,'09:19:21','1',261,2),
 (250,2,'09:22:15','1',262,1),
 (251,2,'09:26:53','1',263,2),
 (252,2,'10:35:02','1',264,2),
 (253,2,'10:39:12','1',265,1),
 (254,2,'10:42:20','1',266,1),
 (255,2,'13:01:44','1',267,1),
 (256,2,'13:39:59','1',268,1),
 (257,2,'13:41:43','1',269,1),
 (258,2,'14:26:40','1',270,1),
 (259,2,'14:34:06','1',271,1),
 (260,2,'20:53:16','1',272,1),
 (261,2,'21:10:59','1',273,2),
 (262,2,'22:23:43','1',274,2),
 (262,4,'22:23:55','1',275,1),
 (263,2,'23:02:05','1',276,6),
 (263,4,'00:51:10','1',277,5),
 (264,2,'01:25:03','1',278,2),
 (264,4,'01:28:33','1',279,1),
 (265,2,'08:18:50','1',280,1),
 (266,2,'08:26:09','1',281,2),
 (267,2,'08:26:45','1',282,1),
 (268,2,'10:50:48','1',283,1),
 (269,2,'11:26:29','1',284,1),
 (270,2,'11:43:11','1',285,1),
 (271,2,'12:40:04','1',286,1),
 (272,2,'22:00:10','1',287,2),
 (272,1,'22:00:44','1',288,1),
 (272,4,'22:03:01','1',289,2),
 (273,2,'09:28:34','1',290,1),
 (274,2,'09:29:06','1',291,8),
 (274,1,'09:30:46','1',292,1),
 (274,4,'09:31:24','1',293,1),
 (275,2,'11:25:01','1',294,5),
 (275,1,'11:38:02','1',295,1),
 (276,2,'12:22:20','1',296,1),
 (276,1,'12:22:27','1',297,16),
 (277,2,'13:18:50','1',298,2),
 (277,1,'13:18:53','1',299,8),
 (277,5,'13:29:16','1',300,3),
 (277,6,'13:55:59','1',301,1),
 (278,2,'20:28:39','1',302,1),
 (278,6,'20:28:43','1',303,2),
 (279,2,'21:44:56','1',304,1),
 (279,6,'21:45:50','1',305,3),
 (280,2,'21:52:56','1',306,1),
 (280,6,'21:53:01','1',307,25),
 (281,2,'23:41:37','1',308,1),
 (281,6,'23:41:39','1',309,19),
 (282,2,'01:51:29','1',310,1),
 (282,6,'01:51:33','1',311,6),
 (283,2,'01:57:14','1',312,1),
 (283,6,'01:57:17','1',313,2),
 (284,2,'02:00:09','1',314,1),
 (284,6,'02:00:11','1',315,9),
 (285,2,'02:18:58','1',316,1),
 (285,6,'02:19:01','1',317,1),
 (286,2,'02:21:06','1',318,2),
 (286,6,'02:21:15','1',319,3),
 (286,4,'02:22:06','1',320,2),
 (287,2,'10:53:34','1',321,2),
 (287,6,'10:53:40','1',322,31),
 (287,4,'11:57:57','1',323,2),
 (288,2,'12:28:47','1',324,1),
 (288,6,'12:28:50','1',325,1),
 (289,2,'12:30:48','1',326,1),
 (289,6,'12:30:53','1',327,25),
 (290,2,'14:31:11','1',328,1),
 (290,6,'14:31:14','1',329,8),
 (291,2,'16:55:10','1',330,1),
 (291,6,'16:55:13','1',331,1),
 (292,2,'17:19:44','1',332,1),
 (292,6,'17:20:01','1',333,6),
 (293,2,'18:02:22','1',334,1),
 (293,6,'18:02:26','1',335,5),
 (294,2,'22:07:26','1',336,1),
 (294,6,'22:07:30','1',337,2),
 (295,2,'22:15:35','1',338,1),
 (295,6,'22:15:39','1',339,8),
 (296,2,'09:13:45','1',340,1),
 (296,6,'09:13:48','1',341,2),
 (296,1,'09:15:12','1',342,2),
 (297,2,'11:17:54','1',343,1),
 (297,6,'11:17:59','1',344,14),
 (298,2,'11:45:13','1',345,1),
 (298,6,'11:45:18','1',346,11),
 (299,2,'12:12:56','1',347,2),
 (299,6,'12:12:59','1',348,3),
 (300,2,'08:09:57','1',349,2),
 (300,1,'08:10:04','1',350,1),
 (300,4,'08:18:40','1',351,1),
 (300,6,'08:18:45','1',352,1),
 (301,2,'15:16:37','1',353,1),
 (301,1,'15:18:15','1',354,12),
 (301,6,'16:54:31','1',355,1),
 (302,2,'16:55:13','1',356,1),
 (302,6,'16:55:15','1',357,1),
 (303,4,'17:24:54','1',358,1),
 (303,6,'17:26:11','1',359,1),
 (303,1,'17:26:45','1',360,6),
 (304,2,'19:16:14','1',361,1),
 (304,6,'19:16:24','1',362,1),
 (304,1,'19:17:41','1',363,2),
 (305,2,'20:50:41','1',364,2),
 (305,6,'20:50:44','1',365,5),
 (305,4,'20:51:35','1',366,1),
 (306,2,'20:55:29','1',367,1),
 (306,6,'20:55:37','1',368,2),
 (307,2,'20:57:18','1',369,1),
 (307,6,'20:57:20','1',370,4),
 (307,4,'21:06:19','1',371,1),
 (308,2,'21:49:08','1',372,1),
 (308,1,'21:49:20','1',373,7),
 (309,2,'22:06:20','1',374,1),
 (309,1,'22:06:22','1',375,1),
 (310,2,'15:39:09','1',376,5),
 (310,6,'15:39:14','1',377,1),
 (310,4,'15:42:41','1',378,1),
 (311,2,'16:12:27','1',379,4),
 (311,6,'16:12:34','1',380,8),
 (311,1,'16:28:59','1',381,26),
 (312,2,'22:02:19','1',382,2),
 (312,1,'22:02:28','1',383,1),
 (312,6,'22:02:50','1',384,2),
 (313,2,'14:14:37','1',385,1),
 (314,2,'14:19:00','1',386,2),
 (315,2,'15:04:06','1',387,1),
 (316,2,'13:49:00','1',388,2),
 (316,6,'13:52:08','1',389,2),
 (317,4,'15:03:49','1',390,1),
 (318,2,'20:39:33','1',391,2),
 (318,6,'20:39:41','1',392,2),
 (318,1,'20:41:05','1',393,2),
 (318,4,'20:45:22','1',394,2),
 (319,2,'21:34:42','1',395,1),
 (319,3,'21:34:43','1',396,3),
 (320,2,'08:58:21','1',397,1),
 (320,3,'08:58:24','1',398,3),
 (320,1,'08:58:42','1',399,2),
 (320,5,'08:58:52','1',400,2),
 (321,2,'09:08:48','1',401,5),
 (321,1,'09:09:05','1',402,2),
 (321,5,'09:09:15','1',403,2),
 (321,3,'09:11:00','1',404,73),
 (321,4,'09:27:58','1',405,25),
 (322,4,'11:28:02','1',406,6),
 (322,3,'11:38:49','1',407,1),
 (323,4,'11:41:38','1',408,7),
 (324,4,'12:02:58','1',409,22),
 (324,3,'12:10:48','1',410,5),
 (324,2,'12:11:50','1',411,3),
 (325,2,'12:32:58','1',412,1),
 (325,4,'12:33:00','1',413,2),
 (326,4,'12:37:35','1',414,12),
 (327,4,'12:51:53','1',415,9),
 (328,2,'13:00:56','1',416,1),
 (328,4,'13:01:02','1',417,6),
 (329,4,'13:34:43','1',418,7),
 (330,2,'13:45:54','1',419,1),
 (330,4,'13:45:58','1',420,2),
 (331,2,'14:01:25','1',421,1),
 (331,4,'14:01:28','1',422,3),
 (331,3,'14:01:35','1',423,1),
 (332,2,'22:21:59','1',424,1),
 (332,3,'22:22:07','1',425,1),
 (332,4,'22:22:10','1',426,3),
 (333,2,'22:38:41','1',427,1),
 (333,4,'22:38:46','1',428,1),
 (334,2,'22:42:57','1',429,1),
 (334,4,'22:43:39','1',430,6),
 (334,3,'22:45:11','1',431,1),
 (335,2,'22:48:58','1',432,1),
 (335,3,'22:49:03','1',433,3),
 (335,4,'22:49:10','1',434,14),
 (336,2,'23:00:29','1',435,1),
 (336,3,'23:00:31','1',436,5),
 (336,4,'23:00:37','1',437,17),
 (337,2,'23:14:38','1',438,1),
 (337,3,'23:14:40','1',439,7),
 (337,4,'23:14:50','1',440,51),
 (338,2,'23:24:56','1',441,1),
 (338,3,'23:24:58','1',442,9),
 (338,4,'23:25:04','1',443,32),
 (338,6,'23:30:41','1',444,2),
 (339,2,'23:37:48','1',445,1),
 (339,3,'23:37:55','1',446,3),
 (339,4,'23:38:01','1',447,26),
 (340,4,'23:46:40','1',448,5),
 (340,3,'23:46:52','1',449,1),
 (341,2,'00:29:44','1',450,1),
 (341,4,'00:29:47','1',451,20),
 (341,3,'00:35:27','1',452,1),
 (342,2,'13:23:09','1',453,1),
 (343,2,'13:35:47','1',454,1),
 (343,7,'13:35:52','1',455,24),
 (343,6,'13:36:43','1',456,4),
 (343,3,'14:37:03','1',457,1),
 (343,4,'14:37:10','1',458,3),
 (344,2,'16:07:03','1',459,1),
 (344,7,'16:07:11','1',460,9),
 (345,2,'16:09:48','1',461,1),
 (345,7,'16:09:57','1',462,2),
 (346,2,'16:21:47','1',463,1),
 (346,7,'16:21:49','1',464,5),
 (347,2,'16:29:49','1',465,1),
 (347,7,'16:30:22','1',466,28),
 (348,2,'17:08:31','1',467,1),
 (348,7,'17:08:34','1',468,6),
 (349,2,'17:15:09','1',469,1),
 (349,7,'17:15:14','1',470,1),
 (350,2,'21:59:15','1',471,1),
 (350,7,'22:03:09','1',472,10),
 (351,2,'12:14:44','1',473,1),
 (351,3,'12:14:49','1',474,1),
 (351,4,'12:14:54','1',475,2),
 (352,2,'12:17:58','1',476,1),
 (352,4,'12:18:07','1',477,1),
 (352,7,'12:18:49','1',478,1),
 (352,7,'12:18:55','1',479,1),
 (353,2,'12:42:01','1',480,1),
 (353,4,'12:42:04','1',481,1),
 (353,7,'12:42:05','1',482,1),
 (354,2,'12:49:04','1',483,1),
 (354,4,'12:49:15','1',484,2),
 (354,7,'12:49:37','1',485,1),
 (355,2,'12:53:38','1',486,1),
 (355,4,'12:53:40','1',487,1),
 (355,7,'12:54:09','1',488,1),
 (356,2,'12:58:45','1',489,1),
 (356,4,'12:58:47','1',490,1),
 (356,7,'12:58:49','1',491,1),
 (357,2,'13:01:17','1',492,1),
 (357,4,'13:01:19','1',493,6),
 (357,7,'13:01:21','1',494,2),
 (358,2,'13:06:37','1',495,6),
 (358,4,'13:06:38','1',496,12),
 (358,7,'13:06:40','1',497,3),
 (358,3,'13:11:26','1',498,5),
 (359,2,'13:36:24','1',499,14),
 (359,4,'13:36:40','1',500,20),
 (359,3,'13:37:12','1',501,6),
 (359,7,'13:37:29','1',502,3),
 (360,2,'14:16:05','1',503,52),
 (360,3,'14:16:07','1',504,6),
 (360,4,'14:16:13','1',505,4),
 (360,7,'14:16:16','1',506,4),
 (360,6,'14:16:38','1',507,5),
 (361,2,'15:58:01','1',508,28),
 (361,3,'15:58:03','1',509,15),
 (361,4,'15:58:07','1',510,5),
 (361,7,'15:58:09','1',511,3),
 (361,6,'16:20:35','1',512,13),
 (362,2,'17:18:40','1',513,4),
 (362,3,'17:18:58','1',514,9),
 (362,4,'17:19:03','1',515,15),
 (363,2,'17:28:06','1',516,1),
 (363,3,'17:28:08','1',517,1),
 (364,2,'17:31:43','1',518,3),
 (364,3,'17:31:59','1',519,1),
 (364,4,'17:32:08','1',520,2),
 (364,7,'17:32:25','1',521,1),
 (365,2,'17:34:53','1',522,2),
 (366,2,'18:00:56','1',523,1),
 (366,3,'18:01:00','1',524,4),
 (366,4,'18:01:08','1',525,9),
 (367,2,'18:05:14','1',526,1),
 (369,2,'18:17:39','1',531,1),
 (369,4,'18:17:49','1',532,8),
 (369,3,'18:17:55','1',533,3),
 (370,2,'18:28:26','1',535,3),
 (370,3,'18:28:28','1',536,5),
 (370,4,'18:30:31','1',537,5),
 (370,7,'18:31:58','1',538,1),
 (370,6,'18:32:37','1',539,1),
 (370,6,'18:33:41','1',540,1),
 (371,2,'18:35:49','1',541,4),
 (371,3,'18:35:57','1',542,1),
 (371,6,'18:36:32','1',543,1),
 (372,2,'17:37:38','1',544,8),
 (373,2,'08:33:40','1',545,6),
 (374,2,'09:24:17','1',546,3),
 (374,3,'09:24:20','1',547,1),
 (374,4,'09:24:26','1',548,1),
 (374,7,'09:24:31','1',549,1),
 (374,6,'09:24:48','1',550,5),
 (375,2,'13:44:32','1',551,7),
 (375,6,'13:50:17','1',552,10),
 (375,3,'13:53:53','1',553,1),
 (376,2,'14:07:55','1',554,5),
 (376,3,'14:08:02','1',555,3),
 (376,4,'14:08:07','1',556,1),
 (376,7,'14:08:31','1',557,1),
 (376,6,'14:09:08','1',558,1),
 (377,4,'15:23:17','1',559,1),
 (377,7,'15:23:24','1',560,1),
 (377,2,'15:23:34','1',561,2),
 (377,6,'15:23:42','1',562,2),
 (378,2,'16:14:42','1',563,18),
 (378,1,'16:14:45','1',564,1),
 (378,3,'16:19:06','1',565,3),
 (378,4,'16:19:12','1',566,4),
 (378,7,'16:19:38','1',567,4),
 (378,6,'16:30:33','1',568,4),
 (379,2,'17:28:13','1',569,2),
 (379,6,'17:28:18','1',570,1),
 (380,2,'09:10:46','1',571,1),
 (380,1,'09:10:50','1',572,31),
 (380,3,'09:33:54','1',573,1),
 (381,2,'11:12:26','1',574,4),
 (381,6,'11:12:31','1',575,1),
 (381,3,'11:12:56','1',576,2),
 (381,4,'11:25:43','1',577,1),
 (381,7,'11:25:53','1',578,1),
 (382,2,'16:06:45','1',579,2),
 (382,3,'16:06:47','1',580,4),
 (382,6,'16:07:30','1',581,1),
 (383,4,'19:57:53','1',582,3),
 (383,7,'19:57:55','1',583,1),
 (383,2,'19:58:01','1',584,8),
 (383,3,'20:25:20','1',585,1),
 (384,2,'21:22:32','1',586,29),
 (384,4,'22:08:38','1',587,1),
 (384,4,'22:13:29','1',588,1),
 (385,2,'22:17:38','1',589,43),
 (385,4,'22:17:40','1',590,6),
 (385,3,'22:17:43','1',591,5),
 (385,7,'22:18:01','1',592,2),
 (386,4,'23:19:52','1',593,2),
 (386,7,'23:19:54','1',594,2),
 (386,2,'23:19:59','1',595,11),
 (386,6,'23:24:00','1',596,12),
 (386,3,'23:45:50','1',597,4),
 (387,4,'14:46:18','1',598,1),
 (387,7,'14:46:54','1',599,1),
 (388,2,'15:05:39','1',600,3),
 (388,3,'15:05:41','1',601,50),
 (388,6,'15:06:00','1',602,2),
 (388,4,'15:07:07','1',603,2),
 (388,1,'15:53:55','1',604,2),
 (389,2,'12:05:51','1',605,1),
 (389,1,'12:06:06','1',606,53),
 (390,2,'20:39:17','1',607,1),
 (390,1,'20:39:18','1',608,13),
 (391,2,'23:19:14','1',609,1),
 (391,1,'23:19:16','1',610,7),
 (392,2,'00:39:28','1',611,1),
 (392,1,'00:39:30','1',612,1),
 (393,2,'11:27:00','1',613,1),
 (393,1,'11:27:17','1',614,125),
 (393,3,'11:29:22','1',615,3),
 (394,2,'12:39:27','1',616,1),
 (394,1,'12:39:33','1',617,10),
 (395,2,'20:16:47','1',618,1),
 (395,1,'20:16:49','1',619,19),
 (395,3,'23:18:22','1',620,1),
 (396,2,'23:30:11','1',621,1),
 (396,1,'23:30:14','1',622,17),
 (397,2,'10:35:49','1',623,1),
 (397,1,'10:35:53','1',624,12),
 (398,2,'12:29:29','1',625,3),
 (398,1,'12:29:31','1',626,17),
 (398,3,'13:28:54','1',627,9),
 (398,4,'13:29:15','1',628,5),
 (398,7,'13:29:21','1',629,2),
 (398,5,'13:33:34','1',630,3),
 (399,2,'11:20:37','1',631,1),
 (399,1,'11:20:48','1',632,3),
 (400,2,'12:06:53','1',633,10),
 (400,1,'12:06:59','1',634,38),
 (400,3,'12:21:06','1',635,9),
 (400,4,'12:21:11','1',636,4),
 (400,7,'12:21:14','1',637,6),
 (400,6,'12:37:53','1',638,6),
 (401,2,'17:09:52','1',639,1),
 (401,1,'17:09:55','1',640,6),
 (402,2,'17:18:59','1',641,2),
 (402,1,'17:19:01','1',642,6),
 (402,3,'17:25:11','1',643,6),
 (402,4,'17:30:30','1',644,3),
 (403,2,'21:13:57','1',645,2),
 (403,4,'21:14:02','1',646,3),
 (403,1,'21:14:22','1',647,1),
 (403,3,'21:15:17','1',648,9),
 (404,4,'14:30:00','1',649,4),
 (404,1,'14:30:15','1',650,5),
 (404,3,'14:30:57','1',651,4),
 (404,7,'14:31:54','1',652,2),
 (404,6,'14:32:06','1',653,6),
 (404,2,'14:32:22','1',654,7),
 (404,5,'14:39:17','1',655,1),
 (405,2,'19:43:21','1',656,1),
 (405,6,'19:43:27','1',657,2),
 (405,1,'19:44:44','1',658,1),
 (406,2,'19:52:20','1',660,1),
 (406,1,'19:52:21','1',661,26),
 (406,3,'20:11:14','1',662,2),
 (407,2,'21:18:49','1',663,1),
 (407,1,'21:20:22','1',664,2),
 (408,2,'21:34:48','1',666,1),
 (408,1,'21:34:50','1',667,17),
 (409,2,'16:44:52','1',668,1),
 (409,1,'16:44:56','1',669,1),
 (410,2,'19:15:13','1',670,1),
 (410,1,'19:15:16','1',671,2),
 (411,2,'21:34:39','1',672,1),
 (411,1,'21:34:41','1',673,9),
 (412,2,'22:59:49','1',674,1),
 (412,1,'23:02:04','1',675,13),
 (412,3,'23:58:37','1',676,2),
 (413,2,'01:45:40','1',677,1),
 (413,1,'01:45:43','1',678,4),
 (414,2,'07:50:00','1',679,3),
 (414,1,'07:50:04','1',680,35),
 (414,6,'08:20:13','1',681,3),
 (415,2,'11:01:47','1',682,1),
 (415,1,'11:01:48','1',683,5),
 (415,6,'11:20:47','1',684,1),
 (416,2,'11:56:50','1',685,1),
 (416,6,'11:56:53','1',686,5),
 (416,1,'12:02:06','1',687,10),
 (417,2,'13:25:30','1',688,3),
 (417,1,'13:25:32','1',689,5),
 (417,6,'13:26:23','1',690,3),
 (418,2,'12:36:32','1',691,1),
 (418,1,'12:36:36','1',692,1),
 (419,2,'21:27:12','1',693,1),
 (419,1,'21:27:16','1',694,1),
 (420,2,'12:25:41','1',695,3),
 (420,1,'12:25:48','1',696,8),
 (420,3,'12:33:31','1',697,1),
 (420,4,'12:33:36','1',698,1),
 (420,7,'12:33:38','1',699,1),
 (420,6,'12:48:12','1',700,2),
 (421,2,'12:54:14','1',702,13),
 (421,6,'12:54:18','1',703,26),
 (421,4,'13:48:26','1',704,2),
 (421,7,'13:48:39','1',705,2),
 (421,3,'13:49:04','1',706,6),
 (421,1,'13:55:20','1',707,18),
 (422,2,'16:05:07','1',708,3),
 (422,1,'16:05:11','1',709,6),
 (422,3,'16:05:40','1',710,1),
 (422,4,'16:05:49','1',711,1),
 (422,7,'16:05:52','1',712,1),
 (422,6,'16:06:42','1',713,2),
 (423,2,'16:25:01','1',714,1),
 (423,1,'16:25:02','1',715,1),
 (424,2,'16:26:18','1',716,1),
 (424,1,'16:26:21','1',717,1),
 (425,2,'16:28:14','1',718,1),
 (425,1,'16:28:17','1',719,2),
 (425,6,'16:55:06','1',720,7),
 (426,2,'22:34:42','1',721,1),
 (426,1,'22:34:46','1',722,13),
 (426,6,'22:50:37','1',723,6),
 (427,2,'11:52:26','1',724,2),
 (427,1,'11:52:31','1',725,2),
 (427,6,'11:52:36','1',726,2),
 (428,2,'11:59:13','1',727,1),
 (429,2,'12:01:08','1',728,2),
 (430,2,'12:02:52','1',729,1),
 (430,1,'12:03:05','1',730,1),
 (430,3,'12:03:45','1',731,2),
 (430,4,'12:03:58','1',732,3),
 (431,2,'12:05:07','1',733,2),
 (431,4,'12:05:11','1',734,4),
 (431,3,'12:05:19','1',735,1),
 (432,4,'12:14:14','1',736,1),
 (432,6,'12:14:21','1',737,1),
 (433,2,'12:18:05','1',738,16),
 (434,2,'12:31:37','1',739,5),
 (434,3,'12:34:26','1',740,1),
 (434,4,'12:34:34','1',741,2),
 (434,7,'12:34:44','1',742,1),
 (435,2,'12:38:39','1',743,1),
 (436,2,'12:39:00','1',744,1),
 (437,2,'12:49:59','1',745,3),
 (437,1,'12:50:27','1',746,8),
 (438,2,'13:08:21','1',747,1),
 (438,1,'13:08:22','1',748,2),
 (439,2,'13:10:37','1',749,1),
 (439,1,'13:10:39','1',750,3),
 (440,2,'13:13:05','1',751,1),
 (440,1,'13:13:21','1',752,1),
 (441,2,'13:28:23','1',753,1),
 (441,1,'13:28:28','1',754,2),
 (442,2,'13:29:21','1',755,1),
 (442,1,'13:29:23','1',756,4),
 (442,3,'13:36:18','1',757,2),
 (442,6,'13:54:44','1',758,2),
 (443,2,'08:36:25','1',759,1),
 (443,1,'08:37:05','1',760,1),
 (444,2,'08:27:25','1',761,23),
 (444,6,'08:27:31','1',762,5),
 (444,3,'08:27:57','1',763,17),
 (444,1,'08:28:46','1',764,84),
 (444,5,'08:31:52','1',765,2),
 (444,4,'09:48:27','1',766,2),
 (445,2,'08:56:33','1',767,3),
 (445,6,'08:56:38','1',768,1),
 (445,1,'08:59:21','1',769,1),
 (446,2,'09:04:25','1',770,2),
 (447,2,'09:41:13','1',771,1),
 (447,1,'09:41:16','1',772,2),
 (448,4,'09:46:36','1',773,2),
 (448,2,'09:46:40','1',774,1),
 (449,4,'09:57:09','1',775,1),
 (449,7,'09:57:12','1',776,1),
 (449,2,'09:57:21','1',777,2),
 (449,6,'09:57:28','1',778,2),
 (449,1,'09:57:34','1',779,3),
 (450,2,'10:01:00','1',780,1),
 (450,1,'10:01:08','1',781,1),
 (451,4,'10:02:18','1',782,1),
 (451,7,'10:02:24','1',783,1),
 (451,2,'10:02:29','1',784,2),
 (452,2,'10:09:15','1',785,88),
 (452,6,'10:09:19','1',786,1),
 (452,3,'10:09:59','1',787,1),
 (452,4,'10:10:04','1',788,1),
 (452,7,'10:10:07','1',789,1),
 (453,2,'10:34:41','1',790,3),
 (453,4,'10:34:43','1',791,1),
 (453,7,'10:34:46','1',792,1),
 (453,1,'10:35:02','1',793,1),
 (454,2,'12:25:02','1',794,1),
 (454,1,'12:25:06','1',795,1),
 (455,4,'12:29:26','1',796,1),
 (455,7,'12:30:06','1',797,1),
 (455,2,'12:30:15','1',798,2),
 (455,6,'12:30:32','1',799,2),
 (455,1,'12:31:28','1',800,3),
 (456,2,'12:36:37','1',801,2);
/*!40000 ALTER TABLE `logintimes_has_page` ENABLE KEYS */;


--
-- Definition of table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `idMessages` int(11) NOT NULL AUTO_INCREMENT,
  `Heding` varchar(100) DEFAULT NULL,
  `mbody` varchar(800) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `mdate` date DEFAULT NULL,
  `mtime` time DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  `reply` varchar(800) DEFAULT NULL,
  PRIMARY KEY (`idMessages`),
  KEY `fk_Messages_User1` (`User_idUser`),
  CONSTRAINT `fk_Messages_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`idMessages`,`Heding`,`mbody`,`status`,`mdate`,`mtime`,`User_idUser`,`reply`) VALUES 
 (1,'Order Confirmation','Your Order has been Dispatched','1','2016-12-01',NULL,1,NULL),
 (2,'Oder Confirmation','Your Order has been Dispatched.Oderid: 2invoice ID: 190','1','2017-02-05','13:19:20',1,NULL),
 (3,'Oder Confirmation','Your Order has been Dispatched.Oderid: 2invoice ID: 190','1','2017-02-05','13:19:36',1,NULL),
 (4,'Oder Confirmation','Your Order has been Dispatched.Oderid: 46invoice ID: 193','1','2017-02-05','13:20:00',1,NULL),
 (5,'Oder Confirmation','Your Order has been Dispatched.Oderid: 44invoice ID: 194','1','2017-02-05','13:25:43',1,NULL),
 (6,'Oder Confirmation','Your Order has been Dispatched.Oderid: 45invoice ID: 192','1','2017-02-05','13:28:07',1,NULL),
 (7,'Oder Confirmation','Your Order has been Dispatched.Oderid: 47invoice ID: 194','1','2017-02-08','12:26:29',1,NULL),
 (8,'Oder Confirmation','Your Order has been Dispatched.Oderid: 51invoice ID: 198','1','2017-02-08','12:31:33',1,NULL),
 (9,'Oder Confirmation','Your Order has been Dispatched.Oderid: 50invoice ID: 197','0','2017-02-08','12:31:50',1,NULL),
 (10,'Oder Confirmation','Your Order has been Dispatched.Oderid: 49invoice ID: 196','1','2017-02-08','12:32:38',1,NULL),
 (11,'Oder Confirmation','Your Order has been Dispatched.Oderid: 48invoice ID: 195','1','2017-02-08','12:32:52',1,NULL),
 (12,'Oder Confirmation','Your Order has been Dispatched.Oderid: 52invoice ID: 203','1','2017-02-08','12:34:00',1,NULL),
 (13,'Oder Confirmation','Your Order has been Dispatched.Oderid: 54invoice ID: 205','1','2017-02-08','14:01:48',1,NULL),
 (14,'Oder Confirmation','Your Order has been Dispatched.Oderid: 53invoice ID: 204','1','2017-02-08','14:01:53',1,NULL),
 (15,'Oder Confirmation','Your Order has been Dispatched.Oderid: 55invoice ID: 206','1','2017-02-08','16:07:47',1,NULL),
 (16,'Oder Confirmation','Your Order has been Dispatched.Oderid: 56invoice ID: 207','1','2017-02-09','13:55:32',1,NULL),
 (17,'Oder Confirmation','Your Order has been Dispatched.Oderid: 57invoice ID: 208','1','2017-03-16','09:57:50',1,NULL),
 (18,'Oder Confirmation','Your Order has been Dispatched.Oderid: 60invoice ID: 211','0','2017-03-16','12:32:14',1,NULL);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Definition of table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `idNews` int(11) NOT NULL,
  `newshedder` varchar(500) DEFAULT NULL,
  `newsbody` varchar(1000) DEFAULT NULL,
  `viewDate` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idNews`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news`
--

/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;


--
-- Definition of table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `idNotifications` int(11) NOT NULL AUTO_INCREMENT,
  `adddate` date DEFAULT NULL,
  `Title` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  PRIMARY KEY (`idNotifications`),
  KEY `fk_Notifications_User1` (`User_idUser`),
  CONSTRAINT `fk_Notifications_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`idNotifications`,`adddate`,`Title`,`status`,`User_idUser`) VALUES 
 (1,'2017-01-15','Order has been processed','0',1),
 (2,'2017-01-15','Add Product in your Wishlist','0',1),
 (3,'2017-01-15','Order has been processed','0',1),
 (4,'2017-01-16','Order has been processed','0',1),
 (5,'2017-01-16','Order has been processed','0',1),
 (6,'2017-01-16','Order has been processed','0',1),
 (7,'2017-01-16','Order has been processed','0',1),
 (8,'2017-01-16','Order has been processed','0',1),
 (9,'2017-01-16','Order has been processed','0',1),
 (10,'2017-01-16','Order has been processed','0',1),
 (11,'2017-01-16','Order has been processed','0',1),
 (12,'2017-01-19','Order has been processed','0',1),
 (13,'2017-01-21','Order has been processed','0',1),
 (14,'2017-01-21','Order has been processed','0',1),
 (15,'2017-01-21','Order has been processed','0',1),
 (16,'2017-01-21','Order has been processed','0',1),
 (17,'2017-01-21','Order has been processed','0',1),
 (18,'2017-01-21','Order has been processed','0',1),
 (19,'2017-01-21','Order has been processed','0',1),
 (20,'2017-01-21','Order has been processed','0',1),
 (21,'2017-02-02','Order has been processed','0',1),
 (22,'2017-02-02','Order has been processed','0',1),
 (23,'2017-02-02','Order has been processed','0',1),
 (24,'2017-02-02','Add Product in your Wishlist','0',1),
 (25,'2017-02-02','Order has been processed','0',1),
 (26,'2017-02-02','Order has been processed','0',1),
 (27,'2017-02-02','Order has been processed','0',1),
 (28,'2017-02-03','Order has been processed','0',1),
 (29,'2017-02-03','Order has been processed','0',1),
 (30,'2017-02-03','Add Product in your Wishlist','0',1),
 (31,'2017-02-05','Oder has been Dispatched','0',1),
 (32,'2017-02-05','Oder has been Dispatched','0',1),
 (33,'2017-02-05','Oder has been Dispatched','0',1),
 (34,'2017-02-05','Oder has been Dispatched','0',1),
 (35,'2017-02-05','Oder has been Dispatched','0',1),
 (36,'2017-02-08','Oder has been Dispatched','0',1),
 (37,'2017-02-08','Oder has been Dispatched','0',1),
 (38,'2017-02-08','Oder has been Dispatched','0',1),
 (39,'2017-02-08','Oder has been Dispatched','0',1),
 (40,'2017-02-08','Oder has been Dispatched','0',1),
 (41,'2017-02-08','Order has been processed','0',1),
 (42,'2017-02-08','Oder has been Dispatched','0',1),
 (43,'2017-02-08','Order has been processed','0',1),
 (44,'2017-02-08','Order has been processed','0',1),
 (45,'2017-02-08','Oder has been Dispatched','0',1),
 (46,'2017-02-08','Oder has been Dispatched','0',1),
 (47,'2017-02-08','Order has been processed','0',1),
 (48,'2017-02-08','Order has been processed','0',1),
 (49,'2017-02-08','Order has been processed','0',1),
 (50,'2017-02-08','Oder has been Dispatched','0',1),
 (51,'2017-02-09','Order has been processed','0',1),
 (52,'2017-02-09','Order has been processed','0',1),
 (53,'2017-02-09','Oder has been Dispatched','0',1),
 (54,'2017-03-15','Add Product in your Wishlist','0',1),
 (55,'2017-03-16','Order has been processed','0',1),
 (56,'2017-03-16','Order has been processed','0',1),
 (57,'2017-03-16','Order has been processed','0',1),
 (58,'2017-03-16','Oder has been Dispatched','0',1),
 (59,'2017-03-16','Order has been processed','0',1),
 (60,'2017-03-16','Order has been processed','0',1),
 (61,'2017-03-16','Order has been processed','0',1),
 (62,'2017-03-16','Oder has been Dispatched','0',1);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;


--
-- Definition of table `ordering`
--

DROP TABLE IF EXISTS `ordering`;
CREATE TABLE `ordering` (
  `idOrder` int(11) NOT NULL AUTO_INCREMENT,
  `Orderdate` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  `invoice_idInvoice` int(11) NOT NULL,
  `res_name` varchar(45) DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `street1` varchar(45) DEFAULT NULL,
  `street2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `pcode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idOrder`),
  KEY `fk_Order_User1` (`User_idUser`),
  KEY `fk_ordering_invoice1` (`invoice_idInvoice`),
  CONSTRAINT `fk_ordering_invoice1` FOREIGN KEY (`invoice_idInvoice`) REFERENCES `invoice` (`idInvoice`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ordering`
--

/*!40000 ALTER TABLE `ordering` DISABLE KEYS */;
INSERT INTO `ordering` (`idOrder`,`Orderdate`,`status`,`User_idUser`,`invoice_idInvoice`,`res_name`,`tel`,`street1`,`street2`,`city`,`pcode`) VALUES 
 (55,'2017-02-08','1',1,206,'Gihan Munasinghe','0716998694','22/b pitiyegedara','Bemmulla','Gampaha','11080'),
 (56,'2017-02-09','1',1,207,'Gihan Munasinghe','0716998694','22/b pitiyegedara','Bemmulla','Gampaha','11080'),
 (57,'2017-03-16','1',1,208,'Gihan Munasinghe','0716998694','22/b pitiyegedara','Bemmulla','Gampaha','11080'),
 (58,'2017-03-16','0',1,209,'Gihan Munasinghe','0716998694','22/b pitiyegedara','Bemmulla','Gampaha','11080'),
 (59,'2017-03-16','0',1,210,'Gihan Munasinghe','0716998694','22/b pitiyegedara','Bemmulla','Gampaha','11080'),
 (60,'2017-03-16','1',1,211,'Gihan Munasinghe','0716998694','22/b pitiyegedara','Bemmulla','Gampaha','11080');
/*!40000 ALTER TABLE `ordering` ENABLE KEYS */;


--
-- Definition of table `p_catergory`
--

DROP TABLE IF EXISTS `p_catergory`;
CREATE TABLE `p_catergory` (
  `idP_Catergory` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `Shipping_idShipping` int(11) NOT NULL,
  PRIMARY KEY (`idP_Catergory`),
  KEY `fk_P_Catergory_Shipping1` (`Shipping_idShipping`),
  CONSTRAINT `fk_P_Catergory_Shipping1` FOREIGN KEY (`Shipping_idShipping`) REFERENCES `shipping` (`idShipping`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `p_catergory`
--

/*!40000 ALTER TABLE `p_catergory` DISABLE KEYS */;
INSERT INTO `p_catergory` (`idP_Catergory`,`cat_name`,`status`,`Shipping_idShipping`) VALUES 
 (1,'Health','1',1),
 (2,'Beauty','1',2),
 (3,'Supplement','1',3),
 (6,'Vitamins','1',6),
 (7,'Nutrition','1',3),
 (9,'other','1',7);
/*!40000 ALTER TABLE `p_catergory` ENABLE KEYS */;


--
-- Definition of table `page`
--

DROP TABLE IF EXISTS `page`;
CREATE TABLE `page` (
  `idPage` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idPage`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `page`
--

/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page` (`idPage`,`name`,`url`) VALUES 
 (1,'AdminPage','AdminPanel.jsp'),
 (2,'HomePage','Home.jsp'),
 (3,'ViewProductPage','ViewProduct.jsp'),
 (4,'CartPage','Cart_test.jsp'),
 (5,'UsersActivity','UsersActivity.jsp'),
 (6,'UserView','UserView.jsp'),
 (7,'PaymentProcess','BillingProcess.jsp');
/*!40000 ALTER TABLE `page` ENABLE KEYS */;


--
-- Definition of table `productoffers`
--

DROP TABLE IF EXISTS `productoffers`;
CREATE TABLE `productoffers` (
  `idProductOffers` int(11) NOT NULL AUTO_INCREMENT,
  `presentage` int(11) DEFAULT NULL,
  `dateofview` date DEFAULT NULL,
  `offerstatus` varchar(45) DEFAULT NULL,
  `offerqty` int(11) DEFAULT NULL,
  `grn_has_products_IdGRNhasProduct` int(11) NOT NULL,
  `datestatus` varchar(45) DEFAULT NULL,
  `dateofadded` date DEFAULT NULL,
  PRIMARY KEY (`idProductOffers`),
  KEY `fk_productoffers_grn_has_products1` (`grn_has_products_IdGRNhasProduct`),
  CONSTRAINT `fk_productoffers_grn_has_products1` FOREIGN KEY (`grn_has_products_IdGRNhasProduct`) REFERENCES `grn_has_products` (`IdGRNhasProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productoffers`
--

/*!40000 ALTER TABLE `productoffers` DISABLE KEYS */;
INSERT INTO `productoffers` (`idProductOffers`,`presentage`,`dateofview`,`offerstatus`,`offerqty`,`grn_has_products_IdGRNhasProduct`,`datestatus`,`dateofadded`) VALUES 
 (9,20,'2017-01-22','1',4,1,'0','2017-01-19'),
 (11,8,'2017-01-22','1',2,2,'0','2017-01-19'),
 (12,10,'2017-01-22','1',10,3,'0','2017-01-19'),
 (13,12,'2017-02-02','1',21,4,'0','2017-01-19'),
 (14,15,'2017-01-22','1',5,5,'0','2017-01-19'),
 (15,18,'2017-01-22','1',7,6,'0','2017-01-19'),
 (16,11,'2017-01-22','1',3,7,'0','2017-01-19'),
 (17,16,'2017-01-22','1',1,12,'0','2017-01-19'),
 (19,10,'2017-02-02','1',0,16,'0','2017-02-02'),
 (20,10,'2017-02-03','1',1,9,'0','2017-02-03'),
 (21,5,'2017-02-04','1',0,6,'0','2017-02-04'),
 (22,5,'2017-02-05','1',0,9,'0','2017-02-05'),
 (23,4,'2017-02-08','1',0,16,'0','2017-02-08'),
 (24,6,'2017-02-08','1',2,6,'0','2017-02-08'),
 (25,5,'2017-02-09','1',0,12,'0','2017-02-09'),
 (29,4,'2017-03-15','1',0,45,'0','2017-03-15'),
 (30,6,'2017-03-15','1',0,8,'0','2017-03-15'),
 (31,3,'2017-03-15','1',0,7,'0','2017-03-15');
/*!40000 ALTER TABLE `productoffers` ENABLE KEYS */;


--
-- Definition of table `productreview`
--

DROP TABLE IF EXISTS `productreview`;
CREATE TABLE `productreview` (
  `idProductReview` int(11) NOT NULL AUTO_INCREMENT,
  `review` varchar(400) DEFAULT NULL,
  `ReviewDate` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `products_idProducts` int(11) NOT NULL,
  `user_idUser` int(11) NOT NULL,
  `dispatchorders_idDispatchOrders` int(11) NOT NULL,
  PRIMARY KEY (`idProductReview`),
  KEY `fk_ProductReview_products1` (`products_idProducts`),
  KEY `fk_ProductReview_user1` (`user_idUser`),
  KEY `fk_ProductReview_dispatchorders1` (`dispatchorders_idDispatchOrders`),
  CONSTRAINT `fk_ProductReview_dispatchorders1` FOREIGN KEY (`dispatchorders_idDispatchOrders`) REFERENCES `dispatchorders` (`idDispatchOrders`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductReview_products1` FOREIGN KEY (`products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductReview_user1` FOREIGN KEY (`user_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productreview`
--

/*!40000 ALTER TABLE `productreview` DISABLE KEYS */;
INSERT INTO `productreview` (`idProductReview`,`review`,`ReviewDate`,`status`,`products_idProducts`,`user_idUser`,`dispatchorders_idDispatchOrders`) VALUES 
 (1,'Superb Oil','2017-02-08','1',17,1,15),
 (2,'It helped to keep my health up','2017-02-08','1',14,1,15),
 (3,'This is well products','2017-02-09','1',19,1,15),
 (4,'Superb Product','2017-03-15','1',14,1,16),
 (5,'This Product  Very Helped ','2017-03-15','1',17,1,16);
/*!40000 ALTER TABLE `productreview` ENABLE KEYS */;


--
-- Definition of table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `idProducts` int(11) NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(45) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `img` varchar(500) DEFAULT NULL,
  `tol_qty` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `P_Catergory_idP_Catergory` int(11) NOT NULL,
  PRIMARY KEY (`idProducts`),
  KEY `fk_Products_P_Catergory1` (`P_Catergory_idP_Catergory`),
  CONSTRAINT `fk_Products_P_Catergory1` FOREIGN KEY (`P_Catergory_idP_Catergory`) REFERENCES `p_catergory` (`idP_Catergory`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`idProducts`,`ProductName`,`description`,`img`,`tol_qty`,`status`,`P_Catergory_idP_Catergory`) VALUES 
 (14,'Digestive Tonic','Good Healthy Product ','ProductImg/0.349294884821875229_Zandu-Pancharisht.png',386,1,1),
 (15,'Infee','Good For Children ','ProductImg/0.176816480361114334_Infee.png',377,1,1),
 (16,'Nityam','Makes Your Skin Beauty ','ProductImg/0.4420890020590202476_Zandu-Nityam-Tab.png',400,1,2),
 (17,'Fitness Oil','Before used workout begin','ProductImg/0.20877120166529341111.jpg',387,1,3),
 (18,'Pure Honey','Very Testy product ','ProductImg/0.28848030865613283925814249s.png',400,1,6),
 (19,'Saffron Cream  ','White Your Skin','ProductImg/0.62030467073882033182200332_cf7ec6c7c4.jpg',350,1,2),
 (20,'Hair Protecter','Good Vitamin for your hair and brings you healthy and long hair','ProductImg/0.5987982439136716ayurveda18.jpg',502,1,2),
 (21,'Foot Cream','Clean & Healthy Foot','ProductImg/0.17517869217226878Ayurveda-Bhaktiveda-products.jpg',399,1,2),
 (22,'G-Zyme','Good Syrup for cough  ','ProductImg/0.6285152872521844Ayurvedic-Medicine-for-Digestive-System.jpg',721,1,1),
 (23,'Skin Care','There are three products have of this skin care.Such Mangishta for Child ,Haridra for Teens and Neem for old Peoples ','ProductImg/0.17077050486486967Ayurvedic-Products-Can-Treat-Skin-Diseases.jpg',400,1,7),
 (24,'Herbal Remedies ','Goo for health','ProductImg/0.2843506949256126Greying_Hair_Supplement.jpg',387,1,2),
 (25,'Ovoutoline ','Good Syrup ','ProductImg/0.6243962807564707Ovoutoline.png',375,1,1),
 (26,'MouthWash','Given Good Mouth and teeth ','ProductImg/0.7685876282487676Pepsodent Mouthwash Herbal Fresh.jpg',399,1,1),
 (27,'Chyvanprash','Good for all pains','ProductImg/0.017220498191353406Zandu.png',129,1,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;


--
-- Definition of table `products_has_brands`
--

DROP TABLE IF EXISTS `products_has_brands`;
CREATE TABLE `products_has_brands` (
  `Products_idProducts` int(11) NOT NULL,
  `Brands_idBrands` int(11) NOT NULL,
  `idProductBrand` int(11) NOT NULL AUTO_INCREMENT,
  `rating` double DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idProductBrand`),
  KEY `fk_Products_has_Brands_Brands1` (`Brands_idBrands`),
  KEY `fk_Products_has_Brands_Products1` (`Products_idProducts`),
  CONSTRAINT `fk_Products_has_Brands_Brands1` FOREIGN KEY (`Brands_idBrands`) REFERENCES `brands` (`idBrands`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Brands_Products1` FOREIGN KEY (`Products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_has_brands`
--

/*!40000 ALTER TABLE `products_has_brands` DISABLE KEYS */;
INSERT INTO `products_has_brands` (`Products_idProducts`,`Brands_idBrands`,`idProductBrand`,`rating`,`status`) VALUES 
 (14,10,5,0,'1'),
 (15,11,6,0,'1'),
 (16,10,7,0,'1'),
 (17,11,8,0,'1'),
 (18,10,9,0,'1'),
 (19,13,10,0,'1'),
 (20,14,11,0,'1'),
 (21,15,12,0,'1'),
 (22,16,13,0,'1'),
 (23,17,14,0,'1'),
 (24,18,15,0,'1'),
 (25,10,16,0,'1'),
 (26,19,17,0,'1'),
 (27,10,18,0,'1');
/*!40000 ALTER TABLE `products_has_brands` ENABLE KEYS */;


--
-- Definition of table `products_has_supplier`
--

DROP TABLE IF EXISTS `products_has_supplier`;
CREATE TABLE `products_has_supplier` (
  `Products_idProducts` int(11) NOT NULL,
  `Supplier_idSupplier` int(11) NOT NULL,
  `idGrn` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idGrn`),
  KEY `fk_Products_has_Supplier_Supplier1` (`Supplier_idSupplier`),
  KEY `fk_Products_has_Supplier_Products1` (`Products_idProducts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products_has_supplier`
--

/*!40000 ALTER TABLE `products_has_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_has_supplier` ENABLE KEYS */;


--
-- Definition of table `productselling`
--

DROP TABLE IF EXISTS `productselling`;
CREATE TABLE `productselling` (
  `idProductSelling` int(11) NOT NULL AUTO_INCREMENT,
  `sell_qty` int(11) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `Products_idProducts` int(11) NOT NULL,
  PRIMARY KEY (`idProductSelling`),
  KEY `fk_ProductSelling_Products1` (`Products_idProducts`),
  CONSTRAINT `fk_ProductSelling_Products1` FOREIGN KEY (`Products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `productselling`
--

/*!40000 ALTER TABLE `productselling` DISABLE KEYS */;
INSERT INTO `productselling` (`idProductSelling`,`sell_qty`,`status`,`Products_idProducts`) VALUES 
 (1,133,'1',19),
 (2,117,'1',25),
 (3,59,'1',24),
 (4,29,'1',15),
 (5,5,'1',27),
 (6,4,'1',26),
 (7,15,'1',14),
 (8,5,'1',21),
 (9,1,'1',18),
 (10,3,'1',22),
 (11,14,'1',17),
 (12,5,'1',20);
/*!40000 ALTER TABLE `productselling` ENABLE KEYS */;


--
-- Definition of table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `idRatings` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  `rateDate` date DEFAULT NULL,
  `Products_idProducts` int(11) NOT NULL,
  `User_idUser` int(11) NOT NULL,
  `rate` double DEFAULT NULL,
  PRIMARY KEY (`idRatings`),
  KEY `fk_Ratings_Products1` (`Products_idProducts`),
  KEY `fk_Ratings_User1` (`User_idUser`),
  CONSTRAINT `fk_Ratings_Products1` FOREIGN KEY (`Products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ratings_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ratings`
--

/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` (`idRatings`,`status`,`rateDate`,`Products_idProducts`,`User_idUser`,`rate`) VALUES 
 (14,'1','2016-12-10',25,1,5),
 (15,'1','2016-12-10',24,1,3),
 (16,'1','2016-12-10',27,1,4),
 (17,'1','2016-12-10',15,1,3),
 (18,'1','2016-12-10',26,1,6),
 (19,'1','2016-12-10',14,1,3),
 (20,'1','2016-12-10',21,1,4),
 (21,'1','2016-12-10',17,1,3),
 (22,'1','2016-12-10',22,1,5),
 (25,'1','2017-02-08',19,1,5);
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;


--
-- Definition of table `returnorder`
--

DROP TABLE IF EXISTS `returnorder`;
CREATE TABLE `returnorder` (
  `idReturnOrder` int(11) NOT NULL AUTO_INCREMENT,
  `Reson` varchar(1000) DEFAULT NULL,
  `returndate` date DEFAULT NULL,
  `DispatchOrders_idDispatchOrders` int(11) NOT NULL,
  PRIMARY KEY (`idReturnOrder`),
  KEY `fk_ReturnOrder_DispatchOrders1` (`DispatchOrders_idDispatchOrders`),
  CONSTRAINT `fk_ReturnOrder_DispatchOrders1` FOREIGN KEY (`DispatchOrders_idDispatchOrders`) REFERENCES `dispatchorders` (`idDispatchOrders`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `returnorder`
--

/*!40000 ALTER TABLE `returnorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `returnorder` ENABLE KEYS */;


--
-- Definition of table `shipping`
--

DROP TABLE IF EXISTS `shipping`;
CREATE TABLE `shipping` (
  `idShipping` int(11) NOT NULL AUTO_INCREMENT,
  `mthod_name` varchar(45) DEFAULT NULL,
  `cost` varchar(45) DEFAULT NULL,
  `vehicle_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idShipping`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shipping`
--

/*!40000 ALTER TABLE `shipping` DISABLE KEYS */;
INSERT INTO `shipping` (`idShipping`,`mthod_name`,`cost`,`vehicle_type`) VALUES 
 (1,'Car','1200','Light Vehicle'),
 (2,'Lorry','2000','Hevy Vehecle'),
 (3,'bike','150','Light'),
 (6,'3-weel','400','Light'),
 (7,'foot','1000','Light');
/*!40000 ALTER TABLE `shipping` ENABLE KEYS */;


--
-- Definition of table `shippingorder`
--

DROP TABLE IF EXISTS `shippingorder`;
CREATE TABLE `shippingorder` (
  `idShippingOrder` int(11) NOT NULL AUTO_INCREMENT,
  `recieverName` varchar(145) DEFAULT NULL,
  `street1` varchar(200) DEFAULT NULL,
  `street2` varchar(200) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `postalcode` varchar(45) DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  PRIMARY KEY (`idShippingOrder`),
  KEY `fk_ShippingOrder_User1` (`User_idUser`),
  CONSTRAINT `fk_ShippingOrder_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shippingorder`
--

/*!40000 ALTER TABLE `shippingorder` DISABLE KEYS */;
INSERT INTO `shippingorder` (`idShippingOrder`,`recieverName`,`street1`,`street2`,`city`,`postalcode`,`User_idUser`) VALUES 
 (1,'dsdsfd','dsf','sfsfds','dsds','dsfdsf',2),
 (2,'Gihan Munasinghe','22/b pitiyegedara','Bemmulla','Gampaha','11080',1);
/*!40000 ALTER TABLE `shippingorder` ENABLE KEYS */;


--
-- Definition of table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `idSupplier` int(11) NOT NULL AUTO_INCREMENT,
  `fullName` varchar(500) DEFAULT NULL,
  `street1` varchar(45) DEFAULT NULL,
  `street2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `pcode` varchar(45) DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `webSite` varchar(45) DEFAULT NULL,
  `Company_idCompany` int(11) NOT NULL,
  `SupplierRequest_idSupplierRequest` int(11) NOT NULL,
  `ratings` double DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `joinDate` date DEFAULT NULL,
  PRIMARY KEY (`idSupplier`),
  KEY `fk_Supplier_Company1` (`Company_idCompany`),
  CONSTRAINT `fk_Supplier_Company1` FOREIGN KEY (`Company_idCompany`) REFERENCES `company` (`idCompany`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` (`idSupplier`,`fullName`,`street1`,`street2`,`city`,`pcode`,`tel`,`email`,`webSite`,`Company_idCompany`,`SupplierRequest_idSupplierRequest`,`ratings`,`status`,`joinDate`) VALUES 
 (1,'Chamara','22/b','hkjfhak','hkjh','44564','65465654','kjkjhk','jkhkjh',1,1,1,'1','2016-10-13'),
 (2,'madda','jklk','kljl','kljkl','46545','45644465','lkjklj','kljklj',2,2,2,'1','2016-11-16'),
 (5,'Gihan','22/b','pitiyegedara','Bemmulla','11040','0716998694','gihamunasinghe266@gmail.com','www.zenonIdeas.com',5,0,0,'1','2017-02-04');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `signDate` date DEFAULT NULL,
  `uimg` varchar(500) DEFAULT NULL,
  `UserType_idUserType` int(11) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  KEY `fk_User_UserType1` (`UserType_idUserType`),
  CONSTRAINT `fk_User_UserType1` FOREIGN KEY (`UserType_idUserType`) REFERENCES `usertype` (`idUserType`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`idUser`,`fname`,`lname`,`email`,`tel`,`signDate`,`uimg`,`UserType_idUserType`,`status`) VALUES 
 (1,'Gihan','Munasinghe','gihan@gmail.com','0716998694','2016-10-18','UserProfImg/0.15836578436536075myg.jpg',3,'1'),
 (2,'dfg','dfg','dsf','dfg','2016-10-13','UserProfImg/0.30246875095973014anu.jpg',2,'1'),
 (3,'Customer','Test','ascjakc@gmail.com','0716998694','2016-11-18',NULL,2,'1'),
 (4,'Chamal','Munasinghe','cham@gmail.com','0773983974','2016-12-19','UserProfImg/0.8852136769045871noimg.png',2,'1'),
 (5,'Chamara','Sasmith','cs@123.com','0714323338','2017-02-09',NULL,2,'1'),
 (6,'Tester','testing','tester@123.com','123123231232','2017-03-16',NULL,2,'1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


--
-- Definition of table `user_has_products_review`
--

DROP TABLE IF EXISTS `user_has_products_review`;
CREATE TABLE `user_has_products_review` (
  `User_idUser` int(11) NOT NULL,
  `Products_idProducts` int(11) NOT NULL,
  `idReview` int(11) NOT NULL AUTO_INCREMENT,
  `RDate` date DEFAULT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idReview`),
  KEY `fk_User_has_Products_Products1` (`Products_idProducts`),
  KEY `fk_User_has_Products_User1` (`User_idUser`),
  CONSTRAINT `fk_User_has_Products_Products1` FOREIGN KEY (`Products_idProducts`) REFERENCES `products` (`idProducts`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Products_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_has_products_review`
--

/*!40000 ALTER TABLE `user_has_products_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_has_products_review` ENABLE KEYS */;


--
-- Definition of table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype` (
  `idUserType` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUserType`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usertype`
--

/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` (`idUserType`,`type_name`,`status`) VALUES 
 (1,'Admin','1'),
 (2,'Customer','1'),
 (3,'SuperAdmin','1');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;


--
-- Definition of table `usertype_has_page`
--

DROP TABLE IF EXISTS `usertype_has_page`;
CREATE TABLE `usertype_has_page` (
  `idPhU` int(11) NOT NULL AUTO_INCREMENT,
  `UserType_idUserType` int(11) NOT NULL,
  `Page_idPage` int(11) NOT NULL,
  PRIMARY KEY (`idPhU`),
  KEY `fk_UserType_has_Page_Page1` (`Page_idPage`),
  KEY `fk_UserType_has_Page_UserType1` (`UserType_idUserType`),
  CONSTRAINT `fk_UserType_has_Page_Page1` FOREIGN KEY (`Page_idPage`) REFERENCES `page` (`idPage`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserType_has_Page_UserType1` FOREIGN KEY (`UserType_idUserType`) REFERENCES `usertype` (`idUserType`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usertype_has_page`
--

/*!40000 ALTER TABLE `usertype_has_page` DISABLE KEYS */;
INSERT INTO `usertype_has_page` (`idPhU`,`UserType_idUserType`,`Page_idPage`) VALUES 
 (1,1,1),
 (2,1,2),
 (3,1,3),
 (4,1,4),
 (5,2,2),
 (6,2,3),
 (7,2,4),
 (8,1,5),
 (9,2,6),
 (10,1,6),
 (11,1,7),
 (12,2,7),
 (13,3,1),
 (14,3,2),
 (15,3,3),
 (16,3,4),
 (17,3,5),
 (18,3,6),
 (19,3,7);
/*!40000 ALTER TABLE `usertype_has_page` ENABLE KEYS */;


--
-- Definition of table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist` (
  `idWishList` int(11) NOT NULL AUTO_INCREMENT,
  `itemCount` int(11) DEFAULT NULL,
  `User_idUser` int(11) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idWishList`),
  KEY `fk_WishList_User1` (`User_idUser`),
  CONSTRAINT `fk_WishList_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wishlist`
--

/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` (`idWishList`,`itemCount`,`User_idUser`,`status`) VALUES 
 (1,17,1,'1'),
 (2,2,4,'1');
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;


--
-- Definition of table `wishlist_has_grn_has_products`
--

DROP TABLE IF EXISTS `wishlist_has_grn_has_products`;
CREATE TABLE `wishlist_has_grn_has_products` (
  `wishlist_idWishList` int(11) NOT NULL,
  `grn_has_products_IdGRNhasProduct` int(11) NOT NULL,
  `WishAddDate` date DEFAULT NULL,
  `WishAddTime` time DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `IdwishlistHasGrnProducts` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IdwishlistHasGrnProducts`),
  KEY `fk_wishlist_has_grn_has_products_grn_has_products1` (`grn_has_products_IdGRNhasProduct`),
  KEY `fk_wishlist_has_grn_has_products_wishlist1` (`wishlist_idWishList`),
  CONSTRAINT `fk_wishlist_has_grn_has_products_grn_has_products1` FOREIGN KEY (`grn_has_products_IdGRNhasProduct`) REFERENCES `grn_has_products` (`IdGRNhasProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wishlist_has_grn_has_products_wishlist1` FOREIGN KEY (`wishlist_idWishList`) REFERENCES `wishlist` (`idWishList`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wishlist_has_grn_has_products`
--

/*!40000 ALTER TABLE `wishlist_has_grn_has_products` DISABLE KEYS */;
INSERT INTO `wishlist_has_grn_has_products` (`wishlist_idWishList`,`grn_has_products_IdGRNhasProduct`,`WishAddDate`,`WishAddTime`,`status`,`IdwishlistHasGrnProducts`) VALUES 
 (1,6,'2017-02-02','12:38:29','1',1),
 (1,1,'2017-02-03','14:33:49','1',2),
 (1,4,'2017-03-15','13:49:31','1',3);
/*!40000 ALTER TABLE `wishlist_has_grn_has_products` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
