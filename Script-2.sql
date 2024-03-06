-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: panaderiacurrodb
-- ------------------------------------------------------
-- Server version	11.4.0-MariaDB

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int(10) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `apellidos` varchar(250) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Ana','Sánchez','111222333','1988-09-18'),(2,'Pedro','Gómez','444555666','1995-02-28'),(3,'Laura','Hernández','777888999','1980-06-10'),(4,'Francisco','Rodríguez','123987456','1989-08-14'),(5,'Elena','Fernández','456789123','1994-03-25'),(6,'Pablo','Gutiérrez','789123456','1983-06-18'),(7,'Carmen','Vargas','987654321','1991-01-12'),(8,'Antonio','Ortega','654321987','1986-09-30'),(9,'Silvia','Núñez','321654987','1997-04-03'),(10,'Roberto','Díaz','876543210','1984-11-22');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `id` int(10) NOT NULL,
  `codigo` varchar(250) NOT NULL,
  `fecha_compra` datetime NOT NULL,
  `id_panaderia` int(10) NOT NULL,
  `id_cliente` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `compra_cliente_fk` (`id_cliente`),
  KEY `compra_panaderia_fk` (`id_panaderia`),
  CONSTRAINT `compra_cliente_fk` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  CONSTRAINT `compra_panaderia_fk` FOREIGN KEY (`id_panaderia`) REFERENCES `panaderia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES (1,'C12345','2024-03-05 10:30:00',1,1),(2,'C12345','2024-03-03 10:30:00',1,1),(3,'C12345','2024-03-04 10:30:00',1,1),(4,'D67890','2024-03-05 12:45:00',2,2),(5,'D67890','2024-03-05 12:45:00',2,2),(6,'D67890','2024-03-05 12:45:00',1,2),(7,'D67890','2024-03-05 12:45:00',3,2),(8,'D67890','2024-03-05 12:45:00',2,2),(9,'F54321','2024-02-05 15:00:00',3,3),(10,'F54321','2024-03-05 15:00:00',3,3),(11,'F54321','2024-03-08 15:00:00',4,3),(12,'G34567','2024-03-06 11:15:00',4,4),(13,'H78901','2024-03-06 14:30:00',5,5),(14,'I23456','2024-03-07 09:45:00',5,6),(15,'J56789','2024-03-07 13:00:00',5,7),(16,'K01234','2024-03-08 16:15:00',5,8),(17,'L56789','2024-03-08 18:30:00',5,9),(18,'M12345','2024-03-09 12:45:00',5,10);
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linea_compra`
--

DROP TABLE IF EXISTS `linea_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linea_compra` (
  `id_compra` int(10) NOT NULL,
  `id_tipo_pan` int(10) NOT NULL,
  `unidades` int(10) NOT NULL,
  KEY `linea_compra_compra_fk` (`id_compra`),
  KEY `linea_compra_tipo_pan_fk` (`id_tipo_pan`),
  CONSTRAINT `linea_compra_compra_fk` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id`),
  CONSTRAINT `linea_compra_tipo_pan_fk` FOREIGN KEY (`id_tipo_pan`) REFERENCES `tipo_pan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linea_compra`
--

LOCK TABLES `linea_compra` WRITE;
/*!40000 ALTER TABLE `linea_compra` DISABLE KEYS */;
INSERT INTO `linea_compra` VALUES (1,1,2),(2,2,1),(3,3,3),(4,4,2),(5,5,3),(6,6,1),(7,7,4),(8,8,2),(9,9,3),(10,10,2);
/*!40000 ALTER TABLE `linea_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `panaderia`
--

DROP TABLE IF EXISTS `panaderia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `panaderia` (
  `id` int(10) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `direccion` varchar(250) NOT NULL,
  `fecha_fundacion` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `panaderia`
--

LOCK TABLES `panaderia` WRITE;
/*!40000 ALTER TABLE `panaderia` DISABLE KEYS */;
INSERT INTO `panaderia` VALUES (1,'Panadería El Sabor','Calle Principal 123','2020-01-01'),(2,'Pan y Dulces','Avenida Central 456','2018-05-15'),(3,'La Hogaza Feliz','Plaza del Pueblo 789','2015-09-30'),(4,'Pan Delicioso','Calle de la Alegría 567','2017-11-20'),(5,'El Rincón del Pan','Avenida de los Sabores 890','2016-04-08');
/*!40000 ALTER TABLE `panaderia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pan`
--

DROP TABLE IF EXISTS `tipo_pan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pan` (
  `id` int(10) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `precio_unidad` double NOT NULL,
  `precio_oferta` double NOT NULL,
  `unidades_oferta` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pan`
--

LOCK TABLES `tipo_pan` WRITE;
/*!40000 ALTER TABLE `tipo_pan` DISABLE KEYS */;
INSERT INTO `tipo_pan` VALUES (1,'Pan Integral',2.5,1.8,3),(2,'Bollería Variada',3,2.5,4),(3,'Pan de Centeno',2.8,2,5),(4,'Pan de Molde',2.2,1.5,2),(5,'Croissants',3.5,2.8,4),(6,'Barra de Cereales',2,1.6,3),(7,'Pan Multigrano',2.7,2.2,5),(8,'Magdalenas',2.8,2,6),(9,'Rosquillas',2.3,1.9,4),(10,'Baguettes',3,2.5,5);
/*!40000 ALTER TABLE `tipo_pan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pan_panaderia`
--

DROP TABLE IF EXISTS `tipo_pan_panaderia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pan_panaderia` (
  `id_tipo_pan` int(10) NOT NULL,
  `id_panaderia` int(10) NOT NULL,
  KEY `tipo_pan_panaderia_tipo_pan_fk` (`id_tipo_pan`),
  KEY `tipo_pan_panaderia_panaderia_fk` (`id_panaderia`),
  CONSTRAINT `tipo_pan_panaderia_panaderia_fk` FOREIGN KEY (`id_panaderia`) REFERENCES `panaderia` (`id`),
  CONSTRAINT `tipo_pan_panaderia_tipo_pan_fk` FOREIGN KEY (`id_tipo_pan`) REFERENCES `tipo_pan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pan_panaderia`
--

LOCK TABLES `tipo_pan_panaderia` WRITE;
/*!40000 ALTER TABLE `tipo_pan_panaderia` DISABLE KEYS */;
INSERT INTO `tipo_pan_panaderia` VALUES (1,1),(2,1),(3,1),(4,1),(6,1),(8,1),(10,1),(2,2),(3,2),(4,2),(5,2),(6,2),(3,3),(10,3),(1,4),(5,4),(7,4),(8,4),(9,4),(5,5),(6,5),(7,5);
/*!40000 ALTER TABLE `tipo_pan_panaderia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trabajador`
--

DROP TABLE IF EXISTS `trabajador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trabajador` (
  `id` int(10) NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `apellidos` varchar(250) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `id_panaderia` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trabajador_panaderia_fk` (`id_panaderia`),
  CONSTRAINT `trabajador_panaderia_fk` FOREIGN KEY (`id_panaderia`) REFERENCES `panaderia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trabajador`
--

LOCK TABLES `trabajador` WRITE;
/*!40000 ALTER TABLE `trabajador` DISABLE KEYS */;
INSERT INTO `trabajador` VALUES (1,'Juan','López','123456789','1990-03-12',1),(2,'María','García','987654321','1985-07-24',2),(3,'Carlos','Martínez','555666777','1993-12-05',3),(4,'Laura','Pérez','333444555','1992-07-08',1),(5,'Javier','Ruiz','666777888','1987-04-15',1),(6,'Marta','Jiménez','999000111','1996-11-22',4),(7,'David','González','111222333','1990-01-30',4),(8,'Isabel','López','444555666','1985-09-18',2),(9,'Sergio','Sánchez','777888999','1993-05-12',2),(10,'Ana María','Martínez','888999000','1980-12-03',5);
/*!40000 ALTER TABLE `trabajador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'panaderiacurrodb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

