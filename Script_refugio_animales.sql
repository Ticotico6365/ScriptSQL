-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: refugio_animales
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.4-MariaDB

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
-- Table structure for table `adopcion`
--

DROP TABLE IF EXISTS `adopcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adopcion` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `id_cliente` int(10) NOT NULL,
  `id_refugio` int(10) NOT NULL,
  `id_mascota` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `adopcionfk1` (`id_mascota`),
  KEY `adopcionfk2` (`id_refugio`),
  KEY `adopcionfk3` (`id_cliente`),
  CONSTRAINT `adopcionfk1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id`),
  CONSTRAINT `adopcionfk2` FOREIGN KEY (`id_refugio`) REFERENCES `refugio` (`id`),
  CONSTRAINT `adopcionfk3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adopcion`
--

LOCK TABLES `adopcion` WRITE;
/*!40000 ALTER TABLE `adopcion` DISABLE KEYS */;
INSERT INTO `adopcion` VALUES (1,'ADP1_0001',1,1,1),(2,'ADP1_0002',6,1,4),(3,'ADP1_0003',3,1,5),(4,'ADP1_0004',1,1,19),(5,'ADP1_0005',3,1,22),(6,'ADP2_0001',9,2,24),(7,'ADP2_0002',3,2,25),(8,'ADP3_0001',6,3,15),(9,'ADP3_0002',7,3,28),(10,'ADP3_0003',9,3,30);
/*!40000 ALTER TABLE `adopcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `animal` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `especie` varchar(150) NOT NULL,
  `raza` varchar(50) NOT NULL,
  `es_salvaje` tinyint(1) DEFAULT NULL,
  `es_domestico` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (1,'Perro','Labrador',0,1),(2,'Perro','Pastor Alemán',0,1),(3,'Perro','Caniche',0,1),(4,'Perro','Bulldog',0,1),(5,'Perro','Chihuahua',0,1),(6,'Perro','Beagle',0,1),(7,'Perro','Chow Chow',0,1),(8,'Perro','Salchicha',0,1),(9,'Perro','Dálmata',0,1),(10,'Perro','Boxer',0,1),(11,'Gato','Persa',0,1),(12,'Gato','Oriental',0,1),(13,'Gato','Exótico',0,1),(14,'Gato','Bengala',0,1),(15,'Gato','Siberiano',0,1),(16,'Serpiente','Víbora',1,0),(17,'Serpiente','Cobra',1,0),(18,'Serpiente','Pitón',1,0),(19,'Serpiente','Reticular',1,0),(20,'Serpiente','Anaconda',1,0),(21,'Conejo','Dutch',0,1),(22,'Conejo','Belgian Hare',0,1),(23,'Conejo','Florida White',0,1),(24,'Conejo','Holland Lop',0,1),(25,'Hamster','Dorado',0,1),(26,'Hamster','Ruso',0,1),(27,'Hamster','Chino',0,1),(28,'Pájaro','Loro',0,1),(29,'Pájaro','Canario',0,1),(30,'Pájaro','Golondrina',0,1);
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `dni` varchar(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Fernando ','Ramos Castro','12345678A'),(2,'Augusto ','García Fuentes','87654321L'),(3,'Nerea','López Calvijo','11225548P'),(4,'Andrea ','Duarte Fernández','57241548Z'),(5,'Diego','Mayorga Galán','65225874F'),(6,'Jaime ','Guijarro Sans','11878795K'),(7,'Sara','Conejero Nuñez','36225481Y'),(8,'Cristina','Fernández Carmona','14887477R'),(9,'Antonio','Mateo Guisado','25336587Q'),(10,'Leonor ','Martin Lebrón','23666525S');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota`
--

DROP TABLE IF EXISTS `mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mascota` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `peso` double NOT NULL,
  `id_refugio` int(10) NOT NULL,
  `id_animal` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mascotafk1` (`id_refugio`),
  KEY `mascotafk2` (`id_animal`),
  CONSTRAINT `mascotafk1` FOREIGN KEY (`id_refugio`) REFERENCES `refugio` (`id`),
  CONSTRAINT `mascotafk2` FOREIGN KEY (`id_animal`) REFERENCES `animal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota`
--

LOCK TABLES `mascota` WRITE;
/*!40000 ALTER TABLE `mascota` DISABLE KEYS */;
INSERT INTO `mascota` VALUES (1,'Coco',15.5,1,2),(2,'Thor',6.23,1,5),(3,'Max',7.1,1,9),(4,'Leo',2.32,1,21),(5,'Rocky',5.7,1,16),(6,'Simba',0.23,2,28),(7,'Bruno',0.15,2,30),(8,'Sultán',0.78,2,29),(9,'Ricitos',6,2,12),(10,'Kira',3.5,3,24),(11,'Tyrion',18.4,3,11),(12,'Kailo',20.6,3,3),(13,'Maguira',17.62,2,16),(14,'Condesa',26.12,2,17),(15,'Seviper',9.8,3,18),(16,'Arbok',4.23,3,19),(17,'Lina',18.45,1,20),(18,'Luna',2.3,1,1),(19,'Lola',6.24,1,3),(20,'Mia',7.15,1,2),(21,'Camila',3.545,1,16),(22,'Mila',6.58,1,5),(23,'Max',7.89,1,23),(24,'Toby',13.25,2,7),(25,'Jack',13.65,2,14),(26,'Lucas',18.9,2,26),(27,'Lucky',7.5,3,17),(28,'Jazz',25.64,3,16),(29,'Conor',3.24,3,11),(30,'Bella',7.54,3,17);
/*!40000 ALTER TABLE `mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refugio`
--

DROP TABLE IF EXISTS `refugio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refugio` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `capacidad` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refugio`
--

LOCK TABLES `refugio` WRITE;
/*!40000 ALTER TABLE `refugio` DISABLE KEYS */;
INSERT INTO `refugio` VALUES (1,'La Gran Acogida','Calle Puerta del Sol S/N',50),(2,'Arboleda Natural','Calle Fresas 5',10),(3,'Bosque Susurrante','Calle Sierpes 21',30);
/*!40000 ALTER TABLE `refugio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacuna`
--

DROP TABLE IF EXISTS `vacuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacuna` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `num_dosis` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacuna`
--

LOCK TABLES `vacuna` WRITE;
/*!40000 ALTER TABLE `vacuna` DISABLE KEYS */;
INSERT INTO `vacuna` VALUES (1,' Vacuna canina 1 ',2),(2,' Vacuna canina 2 ',1),(3,' Vacuna felina',3),(4,' Vacuna aviar',1);
/*!40000 ALTER TABLE `vacuna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacuna_animal`
--

DROP TABLE IF EXISTS `vacuna_animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacuna_animal` (
  `id_vacuna` int(10) NOT NULL,
  `id_animal` int(10) NOT NULL,
  KEY `vacuna_animalfk1` (`id_vacuna`),
  KEY `vacuna_animalfk2` (`id_animal`),
  CONSTRAINT `vacuna_animalfk1` FOREIGN KEY (`id_vacuna`) REFERENCES `vacuna` (`id`),
  CONSTRAINT `vacuna_animalfk2` FOREIGN KEY (`id_animal`) REFERENCES `animal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacuna_animal`
--

LOCK TABLES `vacuna_animal` WRITE;
/*!40000 ALTER TABLE `vacuna_animal` DISABLE KEYS */;
INSERT INTO `vacuna_animal` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(2,1),(2,3),(2,5),(2,9),(3,11),(3,13),(3,14),(3,15),(4,28),(4,29),(4,30);
/*!40000 ALTER TABLE `vacuna_animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vacunacion_mascota`
--

DROP TABLE IF EXISTS `vacunacion_mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacunacion_mascota` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `fecha_vacunacion` date NOT NULL,
  `id_mascota` int(10) NOT NULL,
  `id_vacuna` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vacunacion_mascotafk1` (`id_mascota`),
  KEY `vacunacion_mascotafk2` (`id_vacuna`),
  CONSTRAINT `vacunacion_mascotafk1` FOREIGN KEY (`id_mascota`) REFERENCES `mascota` (`id`),
  CONSTRAINT `vacunacion_mascotafk2` FOREIGN KEY (`id_vacuna`) REFERENCES `vacuna` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vacunacion_mascota`
--

LOCK TABLES `vacunacion_mascota` WRITE;
/*!40000 ALTER TABLE `vacunacion_mascota` DISABLE KEYS */;
INSERT INTO `vacunacion_mascota` VALUES (1,'2019-05-03',1,1),(2,'2019-05-15',1,1),(3,'2019-06-12',5,1),(4,'2019-12-15',9,1),(5,'2019-05-15',12,3),(6,'2019-05-15',29,4),(7,'2019-05-15',30,4),(8,'2019-05-15',2,1);
/*!40000 ALTER TABLE `vacunacion_mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'refugio_animales'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
