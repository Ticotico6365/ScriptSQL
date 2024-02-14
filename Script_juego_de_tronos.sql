-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: gameofthrones
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
-- Table structure for table `alianza`
--

DROP TABLE IF EXISTS `alianza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alianza` (
  `id_casa` int(10) NOT NULL,
  `id_aliado` int(10) NOT NULL,
  KEY `alianza_casa_fk_1` (`id_casa`),
  KEY `alianza_casa_fk_2` (`id_aliado`),
  CONSTRAINT `alianza_casa_fk_1` FOREIGN KEY (`id_casa`) REFERENCES `casa` (`id`),
  CONSTRAINT `alianza_casa_fk_2` FOREIGN KEY (`id_aliado`) REFERENCES `casa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alianza`
--

LOCK TABLES `alianza` WRITE;
/*!40000 ALTER TABLE `alianza` DISABLE KEYS */;
/*!40000 ALTER TABLE `alianza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batalla`
--

DROP TABLE IF EXISTS `batalla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batalla` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `fecha` date NOT NULL,
  `lugar` varchar(150) NOT NULL,
  `id_castillo` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `batalla_castillo_fk` (`id_castillo`),
  CONSTRAINT `batalla_castillo_fk` FOREIGN KEY (`id_castillo`) REFERENCES `castillo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalla`
--

LOCK TABLES `batalla` WRITE;
/*!40000 ALTER TABLE `batalla` DISABLE KEYS */;
/*!40000 ALTER TABLE `batalla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batalla_casa`
--

DROP TABLE IF EXISTS `batalla_casa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batalla_casa` (
  `id_batalla` int(10) NOT NULL,
  `id_casa_1` int(10) NOT NULL,
  `id_casa_2` int(10) NOT NULL,
  KEY `batalla_casa_batalla_fk` (`id_batalla`),
  KEY `batalla_casa_casa_fk_1` (`id_casa_1`),
  KEY `batalla_casa_casa_fk_2` (`id_casa_2`),
  CONSTRAINT `batalla_casa_batalla_fk` FOREIGN KEY (`id_batalla`) REFERENCES `batalla` (`id`),
  CONSTRAINT `batalla_casa_casa_fk_1` FOREIGN KEY (`id_casa_1`) REFERENCES `casa` (`id`),
  CONSTRAINT `batalla_casa_casa_fk_2` FOREIGN KEY (`id_casa_2`) REFERENCES `casa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batalla_casa`
--

LOCK TABLES `batalla_casa` WRITE;
/*!40000 ALTER TABLE `batalla_casa` DISABLE KEYS */;
/*!40000 ALTER TABLE `batalla_casa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casa`
--

DROP TABLE IF EXISTS `casa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casa` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `apellido` varchar(100) NOT NULL,
  `blossom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casa`
--

LOCK TABLES `casa` WRITE;
/*!40000 ALTER TABLE `casa` DISABLE KEYS */;
INSERT INTO `casa` VALUES (1,'Stark','Lobo Huargo'),(2,'Lannister','León Dorado'),(3,'Tully','Trucha'),(4,'Arryn','Águila'),(5,'Martell','Sol Lanceado'),(6,'Baratheon','Ciervo '),(7,'Tyrell','Rosa amarilla'),(8,'Guardia de la Noche','Cuervo'),(9,'Targaryen','Dragón Tricéfalo'),(10,'Nieve','Bastardos'),(11,'Dothraki','Caballos'),(12,'Arena','Serpiente '),(13,'Karstark','Sol del Invierno'),(14,'Bolton','Hombre desollado'),(15,'Mormont','Oso de sable'),(16,'Glover','Puño de hierro'),(17,'Slate ','Borde blanco sobre grís claro'),(18,'Umber ','Gigante gruñendo'),(19,'Tully','Trucha'),(20,'Frey','Trucha'),(21,'Tully','Trucha');
/*!40000 ALTER TABLE `casa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `castillo`
--

DROP TABLE IF EXISTS `castillo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `castillo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `id_reino` int(10) NOT NULL,
  `id_casa` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `castillo_reino_fk` (`id_reino`),
  KEY `castillo_casa_fk` (`id_casa`),
  CONSTRAINT `castillo_casa_fk` FOREIGN KEY (`id_casa`) REFERENCES `casa` (`id`),
  CONSTRAINT `castillo_reino_fk` FOREIGN KEY (`id_reino`) REFERENCES `reino` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `castillo`
--

LOCK TABLES `castillo` WRITE;
/*!40000 ALTER TABLE `castillo` DISABLE KEYS */;
INSERT INTO `castillo` VALUES (1,'Invernalia ',1,1),(2,'Fuerte Terror ',1,14),(3,'Bastión Kar ',1,13),(4,'Pozanegra',1,17),(5,'Último Hogar ',1,18),(6,'Castillo Negro ',1,8),(7,'Colina Escarcha ',1,8),(8,'Guardiagrís',1,8),(9,'Guardaoriente del Mar',1,8),(10,'Torre Sombría',1,8),(11,'Foso Cailin',1,1),(12,'Bosquespeso',1,16);
/*!40000 ALTER TABLE `castillo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejercito`
--

DROP TABLE IF EXISTS `ejercito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ejercito` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `infanteria` int(10) NOT NULL,
  `caballeria` int(10) NOT NULL,
  `arqueros` int(10) NOT NULL,
  `id_casa` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ejercito_casa_fk` (`id_casa`),
  CONSTRAINT `ejercito_casa_fk` FOREIGN KEY (`id_casa`) REFERENCES `casa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejercito`
--

LOCK TABLES `ejercito` WRITE;
/*!40000 ALTER TABLE `ejercito` DISABLE KEYS */;
/*!40000 ALTER TABLE `ejercito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrimonio`
--

DROP TABLE IF EXISTS `matrimonio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrimonio` (
  `id_marido` int(10) NOT NULL,
  `id_mujer` int(10) NOT NULL,
  KEY `matrimonio_marido_fk` (`id_marido`),
  KEY `matrimonio_mujer_fk` (`id_mujer`),
  CONSTRAINT `matrimonio_marido_fk` FOREIGN KEY (`id_marido`) REFERENCES `personaje` (`id`),
  CONSTRAINT `matrimonio_mujer_fk` FOREIGN KEY (`id_mujer`) REFERENCES `personaje` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrimonio`
--

LOCK TABLES `matrimonio` WRITE;
/*!40000 ALTER TABLE `matrimonio` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrimonio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parentesco`
--

DROP TABLE IF EXISTS `parentesco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parentesco` (
  `id_personaje` int(10) NOT NULL,
  `id_pariente` int(10) NOT NULL,
  `madre_padre` int(1) NOT NULL,
  KEY `parentesco_personaje_fk` (`id_personaje`),
  KEY `parentesco_pariente_fk` (`id_pariente`),
  CONSTRAINT `parentesco_pariente_fk` FOREIGN KEY (`id_pariente`) REFERENCES `personaje` (`id`),
  CONSTRAINT `parentesco_personaje_fk` FOREIGN KEY (`id_personaje`) REFERENCES `personaje` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parentesco`
--

LOCK TABLES `parentesco` WRITE;
/*!40000 ALTER TABLE `parentesco` DISABLE KEYS */;
/*!40000 ALTER TABLE `parentesco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personaje`
--

DROP TABLE IF EXISTS `personaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personaje` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apodo` varchar(100) NOT NULL,
  `sexo` char(1) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `fuerza` int(2) NOT NULL DEFAULT 0,
  `destreza` int(2) NOT NULL DEFAULT 0,
  `inteligencia` int(2) NOT NULL DEFAULT 0,
  `influencia` int(2) NOT NULL DEFAULT 0,
  `id_casa` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personaje_casa_fk` (`id_casa`),
  CONSTRAINT `personaje_casa_fk` FOREIGN KEY (`id_casa`) REFERENCES `casa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personaje`
--

LOCK TABLES `personaje` WRITE;
/*!40000 ALTER TABLE `personaje` DISABLE KEYS */;
INSERT INTO `personaje` VALUES (1,'Eddard','Ned','M','1960-10-25',80,50,55,90,1),(2,'Catelyn','Cat','F','1963-11-12',10,15,90,85,1),(3,'Rob','El Joven Lobo','M','1990-04-10',90,70,60,70,1),(4,'Sansa','Palomita','F','1995-01-25',10,10,90,80,1),(5,'Arya','Mujer sin rostro','F','2000-02-25',50,90,65,20,1),(6,'Brand','El cuervo de tres ojos','M','1998-03-25',5,5,95,30,1),(7,'Rickon','','M','2005-04-25',10,10,10,10,1),(8,'Tywin','Abuelo León','M','1935-04-25',60,60,95,90,2),(9,'Jaime','Matareyes','M','1970-04-25',80,70,60,60,2),(10,'Tyrion','Gnomo, Mediohombre','M','1975-04-25',15,15,99,70,2),(11,'Cersei','Reina madre','F','1970-04-25',10,10,90,90,2),(12,'Myrcella','','F','1999-04-25',10,10,10,30,2),(13,'Tommen','El niño rey','M','2000-04-25',10,10,10,50,2),(14,'Joffrey','El joven ursurpador','M','1995-04-25',10,10,10,50,2),(15,'Daenerys','Madre de dragones','F','1995-04-25',10,10,10,50,9),(16,'Viserys','Joven Dragón','M','1990-04-25',10,10,10,50,9),(17,'Rhaegar','','M','1985-04-25',10,10,10,50,9),(18,'Khal Drogo','Jamás derrotado','M','1985-04-25',95,80,20,70,11),(19,'Jhon','Bastardo de Invernalia','M','1994-04-25',90,80,40,30,10),(20,'Olenna','Rosa espinada','F','1935-04-25',5,5,95,85,7),(21,'Mace','','M','1965-04-25',30,30,50,40,7),(22,'Margaery','Joven rosa','F','1995-04-25',10,10,85,40,7),(23,'Loras','El caballero de las flores','M','1994-04-25',70,90,40,40,7),(24,'Doran','','M','1950-04-25',10,20,50,80,7),(25,'Trystane','','M','1997-04-25',30,20,15,50,5),(26,'Oberyn','La Víbora Roja','M','1976-04-25',60,99,60,35,5),(27,'Ellaria','La Serpiente de Arena','F','1980-04-25',10,10,60,35,5),(28,'Obara','Serpiente de arena','F','1993-04-25',40,60,15,10,12),(29,'Nymera','Serpiente de arena','F','1996-04-25',35,60,15,10,12),(30,'Tyene','Serpiente de arena','F','1998-04-25',30,60,15,10,12),(31,'Robert','El Ursurpador','F','1960-04-25',90,60,40,90,6),(32,'Gendry','Serpiente de arena','F','1993-04-25',50,70,40,10,10),(33,'Stannis','Serpiente de arena','F','1965-04-25',80,70,40,70,6),(34,'Renly','Serpiente de arena','F','1980-04-25',40,40,40,60,6),(35,'Shireen','Serpiente de arena','F','2005-04-25',10,10,10,10,6);
/*!40000 ALTER TABLE `personaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reino`
--

DROP TABLE IF EXISTS `reino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reino` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `extension` double NOT NULL,
  `id_rey` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reino_personaje_rey_fk` (`id_rey`),
  CONSTRAINT `reino_personaje_rey_fk` FOREIGN KEY (`id_rey`) REFERENCES `personaje` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reino`
--

LOCK TABLES `reino` WRITE;
/*!40000 ALTER TABLE `reino` DISABLE KEYS */;
INSERT INTO `reino` VALUES (1,'El Norte ',200000,31),(2,'Islas del Hierro',3000,31),(3,'Al Norte del Muro',70000,31),(4,'Tierras de los ríos',40000,31),(5,'El Valle de Arryn',35000,31),(6,'Desembarco del Rey',13000,31),(7,'Alto Jardín',50000,31),(8,'Roca Casterly',30000,31),(9,'Tierras de la Tormenta',31000,31),(10,'Rocadragón',5000,31),(11,'Dorne',43000,31);
/*!40000 ALTER TABLE `reino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'gameofthrones'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
