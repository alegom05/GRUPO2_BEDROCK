-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: basededatos3
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `credenciales`
--

-- Crear Base de datos u.u
CREATE DATABASE IF NOT EXISTS basededatos3;
USE basededatos3;

DROP TABLE IF EXISTS `credenciales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credenciales` (
  `idcredenciales` int NOT NULL,
  `idUsuario` int DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `claveHash` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcredenciales`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credenciales`
--

LOCK TABLES `credenciales` WRITE;
/*!40000 ALTER TABLE `credenciales` DISABLE KEYS */;
/*!40000 ALTER TABLE `credenciales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `idEvento` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `fechaInicial` date DEFAULT NULL,
  `fechaFinal` date DEFAULT NULL,
  `foto` mediumblob,
  `materiales` text NOT NULL,
  `lugar` varchar(45) NOT NULL,
  `hora` time NOT NULL,
  `frecuencia` varchar(45) NOT NULL,
  `vacantes` int NOT NULL,
  `descripcion` text NOT NULL,
  `tipo` varchar(10) DEFAULT NULL,
  `idProfesor` int NOT NULL,
  `estadoEvento` varchar(45) NOT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `fk_Evento_Profesor1_idx` (`idProfesor`),
  CONSTRAINT `fk_Evento_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`)
) ENGINE=InnoDB AUTO_INCREMENT=2021 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (2001,'Yoga','2024-06-01','2024-06-01',NULL,'Colchonetas, balones','Parque Kennedy, San Miguel, Lima','08:00:00','1',15,'Yoga para adultos mayores, embarazadas y jóvenes','Cultural',1,'Pronto'),(2002,'Fútbol','2024-06-02','2024-06-02',NULL,'Balones, redes','Complejo Deportivo San Miguel, Lima','16:00:00','2',18,'Competencia de fútbol','Deportivo',4,'Pronto'),(2003,'Voley','2024-06-03','2024-06-03',NULL,'Balones, redes','Parque de la Juventud, San Miguel, Lima','10:00:00','3',12,'Competencia de vóley','Deportivo',5,'Pronto'),(2004,'Maratón','2024-06-04','2024-06-04',NULL,'Cronómetros, banderines','Estadio Miguel Grau, San Miguel, Lima','09:00:00','4',14,'Ve y disfruta la entretenida marathon y apoya a tu distrito!','Deportivo',4,'Pronto'),(2005,'Tres pies','2024-06-05','2024-06-05',NULL,'Cuerdas, pañuelos','Parque El Olivar, San Miguel, Lima','15:00:00','5',16,'Carrera de tres pies','Deportivo',7,'Pronto'),(2006,'Familiar','2024-06-06','2024-06-06',NULL,'Juegos de mesa, pelotas','Municipalidad de San Miguel, Lima','10:30:00','1',20,'Festival de juegos familiares','Cultural',8,'Pronto'),(2007,'Niños','2024-06-07','2024-06-07',NULL,'Pelotas, conos','Parque Urubamba, San Miguel, Lima','14:00:00','2',15,'Juegos deportivos para los niños','Deportivo',9,'Pronto');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento_has_usuario`
--

DROP TABLE IF EXISTS `evento_has_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento_has_usuario` (
  `idEvento` int NOT NULL,
  `idUsuario` int NOT NULL,
  `asistio` tinyint DEFAULT NULL,
  `cometioFalta` tinyint DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`idEvento`,`idUsuario`),
  KEY `fk_Evento_has_Usuario_Usuario1_idx` (`idUsuario`),
  KEY `fk_Evento_has_Usuario_Evento1_idx` (`idEvento`),
  CONSTRAINT `fk_Evento_has_Usuario_Evento1` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `fk_Evento_has_Usuario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento_has_usuario`
--

LOCK TABLES `evento_has_usuario` WRITE;
/*!40000 ALTER TABLE `evento_has_usuario` DISABLE KEYS */;
INSERT INTO `evento_has_usuario` VALUES (2001,1,1,0,NULL),(2002,7,1,0,NULL),(2002,10,0,0,NULL),(2002,15,1,0,NULL),(2002,16,1,0,'Ataca a otros participantes durante el partido'),(2003,1,1,0,NULL),(2003,2,1,0,NULL),(2003,8,1,0,NULL);
/*!40000 ALTER TABLE `evento_has_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fotosdeeventos`
--

DROP TABLE IF EXISTS `fotosdeeventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fotosdeeventos` (
  `idfotosDeEventos` int NOT NULL AUTO_INCREMENT,
  `fotosDeEventos` mediumblob,
  `idEvento` int NOT NULL,
  PRIMARY KEY (`idfotosDeEventos`),
  KEY `fk_fotosDeEventos_Evento1_idx` (`idEvento`),
  CONSTRAINT `fk_fotosDeEventos_Evento1` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fotosdeeventos`
--

LOCK TABLES `fotosdeeventos` WRITE;
/*!40000 ALTER TABLE `fotosdeeventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `fotosdeeventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencia`
--

DROP TABLE IF EXISTS `incidencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidencia` (
  `idIncidenciaReportada` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `lugar` varchar(200) NOT NULL,
  `referencia` varchar(45) NOT NULL,
  `contacto` varchar(45) DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `requiereAmbulancia` tinyint DEFAULT NULL,
  `requierePolicia` tinyint DEFAULT NULL,
  `requiereBomberos` tinyint DEFAULT NULL,
  `idUsuario` int NOT NULL,
  `criticidad` varchar(45) DEFAULT NULL,
  `tipoPersonal` varchar(45) DEFAULT NULL,
  `personalRefuerzo` varchar(45) DEFAULT NULL,
  `descripcionSolucion` varchar(500) DEFAULT NULL,
  `descripcionEliminacion` varchar(500) DEFAULT NULL,
  `estadoPersonal` varchar(45) DEFAULT NULL,
  `estadoIncidencia` varchar(45) DEFAULT NULL,
  `idtipo` varchar(6) NOT NULL,
  `foto` mediumblob,
  `fechaFoto` time DEFAULT NULL,
  `isDeleted` tinyint NOT NULL,
  PRIMARY KEY (`idIncidenciaReportada`),
  KEY `fk_Incidencia_Usuario1_idx` (`idUsuario`),
  KEY `fk_incidencia_tipo1_idx` (`idtipo`),
  CONSTRAINT `fk_incidencia_tipo1` FOREIGN KEY (`idtipo`) REFERENCES `tipo` (`idtipo`),
  CONSTRAINT `fk_Incidencia_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=1039 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencia`
--

LOCK TABLES `incidencia` WRITE;
/*!40000 ALTER TABLE `incidencia` DISABLE KEYS */;
INSERT INTO `incidencia` VALUES (1001,'Personas atrapadas','Personas atrapadas en un ascensor en la Calle 12','Calle 12, San Miguel-Lima','Referencia 12, San Miguel-Lima','923456789','2024-06-19 10:20:25',0,NULL,0,12,'Alto','Ambulancia','Vehiculo','Se está enviando un equipo de rescate para liberar a la persona',NULL,'Policía en camino','En proceso','OT',_binary '99999999999999999999999999999999999999999999999999999999999999999',NULL,0),(1002,'Ruido de fiesta','Denuncia de ruido excesivo en una fiesta en la Calle 13','Calle 13, San Miguel-Lima','Referencia 13, San Miguel-Lima','934523890','2024-06-19 10:20:25',1,NULL,0,13,'Bajo','Bomberos','A pie','Se llegó a un acuerdo con los organizadores y se disolvió la fiesta',NULL,'Bomberos en camino','En proceso','AL',NULL,NULL,0),(1003,'Robo','Reporte de robo en la esquina de Calle 1 y Avenida Principal','Calle 1, San Miguel-Lima','Referencia 1, San Miguel-Lima','912115678','2024-06-19 10:20:25',1,NULL,0,1,'Bajo','Bomberos','A pie','Se envió una patrulla al lugar',NULL,'Bomberos en camino','En proceso','RO',NULL,NULL,0),(1004,'Choque de autos','Choque de vehículos en la intersección de Calle 2 y Avenida Secundaria','Calle 2, San Miguel-Lima','Referencia 2, San Miguel-Lima','923456789','2024-06-19 10:20:25',1,NULL,0,2,'Medio','Comisaría','bicicleta','Se envió una ambulancia y se está desviando el tráfico',NULL,'Ambulancia en camino','En proceso','AC',NULL,NULL,0),(1005,'Incendio en edificio','Incendio en un edificio de departamentos en la Calle 3','Calle 3, San Miguel-Lima','Referencia 3, San Miguel-Lima','934567890','2024-06-19 10:20:25',1,NULL,1,3,'Alto','Ambulancia','canino','Se evacuaron los residentes y se está controlando el fuego',NULL,'Policía en camino','En proceso','OT',NULL,NULL,0),(1006,'Robo con pistola','Robo a mano armada en un supermercado en la Avenida Principal','Calle 4, San Miguel-Lima','Referencia 4, San Miguel-Lima','945678901','2024-06-19 10:20:25',0,NULL,0,4,'Bajo','Bomberos','Vehiculo','Se arrestaron a los sospechosos y se recuperó la mercancía',NULL,'Bomberos en camino','En proceso','RO',NULL,NULL,0),(1007,'Ruido y altercado','Altercado entre vecinos por ruido excesivo en la Calle 5','Calle 5, San Miguel-Lima','Referencia 5, San Miguel-Lima','956789012','2024-06-19 10:20:25',0,NULL,0,5,'Medio','Comisaría','A pie','Se llegó a un acuerdo entre las partes involucradas',NULL,'Ambulancia en camino','En proceso','AL',NULL,NULL,0),(1008,'Drogas en fiesta','Sospecha de sustancias ilegales en una fiesta clandestina en Calle 6','Calle 6, San Miguel-Lima','Referencia 6, San Miguel-Lima','967890123','2024-06-19 10:20:25',1,NULL,0,6,'Alto','Ambulancia','bicicleta','Se está realizando una redada policial',NULL,'Policía en camino','En proceso','OT',NULL,NULL,0),(1009,'Intrusión','Intrusión en una propiedad privada en la Calle 7','Calle 7, San Miguel-Lima','Referencia 7, San Miguel-Lima','978901234','2024-06-19 10:20:25',1,NULL,0,7,'Bajo','Bomberos','canino','Se detuvo al intruso y se aseguró la zona',NULL,'Bomberos en camino','En proceso','OT',NULL,NULL,0),(1010,'Accidente de tránsito y persona herida','Persona herida en un accidente de tránsito en la Calle 8','Calle 8, San Miguel-Lima','Referencia 8, San Miguel-Lima','989012345','2024-06-19 10:20:25',1,NULL,0,8,'Medio','Comisaría','Vehiculo','Se llamó a una ambulancia y se está controlando el tráfico',NULL,'Ambulancia en camino','En proceso','AC',NULL,NULL,0),(1011,'Robo de vehículos','Robo de vehículo estacionado en la Calle 9','Calle 9, San Miguel-Lima','Referencia 9, San Miguel-Lima','990123456','2024-06-19 10:20:25',1,NULL,0,9,'Alto','Ambulancia','A pie','Se están rastreando las cámaras de seguridad en la zona',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1012,'Mascotas','Incidente con mascotas agresivas en la Calle 10','Calle 10, San Miguel-Lima','Referencia 10, San Miguel-Lima','901234567','2024-06-19 10:20:25',0,NULL,1,10,'Bajo','Bomberos','bicicleta','Se capturaron a los animales y se notificó a los propietarios',NULL,'Bomberos en camino','En proceso','OT',NULL,NULL,0),(1013,'Riña callejera','Riña callejera en la intersección de Calle 11 y Avenida Principal','Calle 11, San Miguel-Lima','Referencia 11, San Miguel-Lima','912345678','2024-06-19 10:20:25',1,NULL,0,11,'Medio','Comisaría','canino','Se detuvieron a los involucrados y se está mediando el conflicto',NULL,'Ambulancia en camino','En proceso','AL',NULL,NULL,0),(1014,'Robo','Robo reportado cerca del parque','Av. La Marina 123, San Miguel, Lima','Cerca del supermercado grande','987654321','2024-06-19 10:20:25',0,NULL,0,1,'Alto','Comisaría','Vehiculo','Sospechoso detenido',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1015,'Ruido','Queja por ruido de los vecinos','Calle Las Flores 456, San Miguel, Lima','Detrás de la gasolinera','912345678','2024-06-19 10:20:25',0,NULL,0,5,'Bajo','Comisaría','A pie','Advertencia emitida',NULL,'Policía en camino','En proceso','AL',NULL,NULL,0),(1016,'Incendio','Incendio en área residencial','Jr. San Martin 789, San Miguel, Lima','Frente a la escuela','923456789','2024-06-19 10:20:25',1,NULL,1,10,'Alto','Bomberos','Vehiculo','Incendio extinguido',NULL,'Bomberos en camino','En proceso','EM',NULL,NULL,0),(1017,'Emergencia Médica','Emergencia médica','Av. Universitaria 321, San Miguel, Lima','Junto al banco','934567890','2024-06-19 10:20:25',1,NULL,0,15,'Medio','Ambulancia','Vehiculo','Paciente estabilizado',NULL,'Ambulancia en camino','En proceso','EM',NULL,NULL,0),(1018,'Actividad sospechosa','Actividad sospechosa','Jr. Amazonas 654, San Miguel, Lima','Cerca del área de juegos','945678901','2024-06-19 10:20:25',0,NULL,0,16,'Medio','Comisaría','A pie','Área asegurada',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1019,'Problema doméstico','Disturbio doméstico','Av. Faucett 987, San Miguel, Lima','Cerca de la iglesia','956789012','2024-06-19 10:20:25',0,NULL,0,17,'Alto','Comisaría','Vehiculo','Conflicto resuelto',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1020,'Accidente','Accidente de tráfico','Calle Pizarro 159, San Miguel, Lima','En la rotonda','967890123','2024-06-19 10:20:25',1,NULL,0,15,'Medio','Ambulancia','Vehiculo','Herido transportado',NULL,'Ambulancia en camino','En proceso','EM',NULL,NULL,0),(1021,'Embriaguez','Embriaguez en público','Av. Libertad 753, San Miguel, Lima','Cerca del cine','978901234','2024-06-19 10:20:25',0,NULL,0,2,'Bajo','Comisaría','A pie','Individuo detenido',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1022,'Robo','Robo en progreso','Jr. Belgrano 852, San Miguel, Lima','Frente al centro comercial','989012345','2024-06-19 10:20:25',0,NULL,0,4,'Alto','Comisaría','Vehiculo','Sospechoso arrestado',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1023,'Vandalismo','Vandalismo','Av. Argentina 951, San Miguel, Lima','Junto al parque','990123456','2024-06-19 10:20:25',0,NULL,0,6,'Medio','Comisaría','Bicicleta','Reporte presentado',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1024,'Niño perdido','Niño perdido','Calle Independencia 159, San Miguel, Lima','En la parada de autobús','901234567','2024-06-19 10:20:25',0,NULL,0,8,'Alto','Comisaría','Canino','Niño encontrado',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1025,'Ebriedad','Conductor ebrio','Av. La Marina 357, San Miguel, Lima','Cerca de la escuela','912345678','2024-06-19 10:20:25',1,NULL,0,12,'Alto','Comisaría','Vehiculo','Conductor arrestado',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1026,'Pelea','Pelea reportada','Jr. Puno 456, San Miguel, Lima','Cerca del parque','923456789','2024-06-19 10:20:25',0,NULL,0,14,'Medio','Comisaría','A pie','Participantes separados',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1027,'Persona con arma','Persona con arma','Av. Brasil 789, San Miguel, Lima','Frente al mercado','934567890','2024-06-19 10:20:25',0,NULL,0,16,'Alto','Comisaría','Vehiculo','Arma confiscada',NULL,'Policía en camino','En proceso','RO',NULL,NULL,0),(1028,'Incendio','Incendio en edificio comercial','Calle Sucre 951, San Miguel, Lima','Cerca del banco','945678901','2024-06-19 10:20:25',1,NULL,1,15,'Alto','Bomberos','Vehiculo','Incendio bajo control',NULL,'Bomberos en camino','En proceso','AC',NULL,NULL,0),(1029,'Ascensor','Persona atrapada en un ascensor en la Calle 12','Calle 12, San Miguel-Lima','Referencia 12, San Miguel-Lima','923456789','2024-06-19 10:20:25',0,NULL,0,12,'Alto','Ambulancia','Vehiculo','Se está enviando un equipo de rescate para liberar a la persona',NULL,'Policía en camino','Nueva','OT',NULL,NULL,0),(1030,'Ruido','Denuncia de ruido excesivo en una fiesta en la Calle 13','Calle 13, San Miguel-Lima','Referencia 13, San Miguel-Lima','934523890','2024-06-19 10:20:25',1,NULL,0,13,'Bajo','Bomberos','A pie','Se llegó a un acuerdo con los organizadores y se disolvió la fiesta',NULL,'Bomberos en camino','Nueva','AL',NULL,NULL,0),(1031,'Robo','Reporte de robo en la esquina de Calle 1 y Avenida Principal','Calle 1, San Miguel-Lima','Referencia 1, San Miguel-Lima','912115678','2024-06-19 10:20:25',1,NULL,0,1,'Bajo','Bomberos','A pie','Se envió una patrulla al lugar',NULL,'Bomberos en camino','Nueva','RO',NULL,NULL,0),(1032,'Choque','Choque de vehículos en la intersección de Calle 2 y Avenida Secundaria','Calle 2, San Miguel-Lima','Referencia 2, San Miguel-Lima','923456789','2024-06-19 10:20:25',1,NULL,0,2,'Medio','Comisaría','bicicleta','Se envió una ambulancia y se está desviando el tráfico',NULL,'Ambulancia en camino','Nueva','AC',NULL,NULL,0),(1033,'Incendio','Incendio en un edificio de departamentos en la Calle 3','Calle 3, San Miguel-Lima','Referencia 3, San Miguel-Lima','934567890','2024-06-19 10:20:25',1,NULL,1,3,'Alto','Ambulancia','canino','Se evacuaron los residentes y se está controlando el fuego',NULL,'Policía en camino','Nueva','OT',NULL,NULL,0),(1034,'Incendio','Reporte de incendio en edificio','Av. La Marina 123, Lima','Referencia 34, San Miguel-Lima','987654321','2024-06-19 10:20:25',0,NULL,1,15,NULL,NULL,NULL,NULL,NULL,NULL,'Falsa alarma','OT',NULL,NULL,0),(1035,'Fuga de gas','Supuesta fuga de gas en cocina','Calle Las Flores 56, Miraflores','Referencia 56, Miraflores','912345678','2024-06-19 10:20:25',0,NULL,1,16,NULL,NULL,NULL,NULL,NULL,NULL,'Falsa alarma','OT',NULL,NULL,0),(1036,'Persona atrapada','Persona atrapada en un ascensor','Calle 10, Barranco','Referencia 78, Barranco','923456789','2024-06-19 10:20:25',0,NULL,0,17,NULL,NULL,NULL,NULL,NULL,NULL,'Falsa alarma','OT',NULL,NULL,0),(1037,'Accidente de tráfico','Accidente de tráfico sin heridos','Av. Brasil 789, Jesús María','Referencia 90, Jesús María','934567890','2024-06-19 10:20:25',0,NULL,0,18,NULL,NULL,NULL,NULL,NULL,NULL,'Falsa alarma','OT',NULL,NULL,0),(1038,'Alarma','Alarma de seguridad activada sin motivo','Jr. Puno 112, Cercado de Lima','Referencia 12, Cercado de Lima','945678901','2024-06-19 10:20:25',0,NULL,0,19,NULL,NULL,NULL,NULL,NULL,NULL,'Falsa alarma','OT',NULL,NULL,0);
/*!40000 ALTER TABLE `incidencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `idProfesor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `curso` varchar(60) NOT NULL,
  PRIMARY KEY (`idProfesor`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (1,'Juan','Pérez Fernández','Yoga para adultos mayores, embarazadas y jóvenes'),(2,'Luisa','García Fernández','Yoga para adultos mayores, embarazadas y jóvenes'),(3,'Andrés','Rodríguez Martínez','Yoga para adultos mayores, embarazadas y jóvenes'),(4,'Marcela','Martínez López','Competencia de fútbol'),(5,'Roberto','Hernández Gómez','Competencia de vóley'),(6,'Ana','López Fernández','Competencia de Atletismo'),(7,'Eduardo','Gómez Díaz','Carrera de tres pies'),(8,'Carolina','Díaz Fernández','Festival de juegos familiares'),(9,'Jorge','Fernández Martínez','Juegos deportivos para los niños'),(10,'Ana','Mendoza García','Juegos deportivos para los niños');
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `idRoles` varchar(20) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idRoles`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('AD','Administrador'),('CO','Coordinadoras'),('SE','Serenazgo'),('VE','Vecino');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo` (
  `idtipo` varchar(6) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES ('AC','Accidente'),('AL','Alteración del orden público'),('EM','Emergencia médica'),('OT','Otro'),('RO','Robo agravado');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `dni` varchar(8) DEFAULT NULL,
  `telefono` char(9) DEFAULT NULL,
  `correo` varchar(45) NOT NULL,
  `clave` varchar(45) NOT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `urbanizacion` varchar(45) DEFAULT NULL,
  `turnoSerenazgo` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `idRoles` varchar(20) NOT NULL,
  `horaInicio` time NOT NULL,
  `horaFin` time NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`idUsuario`,`idRoles`),
  UNIQUE KEY `correo_UNIQUE` (`correo`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  KEY `fk_usuario_roles1_idx` (`idRoles`),
  CONSTRAINT `fk_usuario_roles1` FOREIGN KEY (`idRoles`) REFERENCES `roles` (`idRoles`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Christopher','Terrones Peña','12345678','912345678','cterrones@gmail.com','123456','Calle 123','Urbanización ABC',NULL,NULL,'AD','08:00:00','16:00:00','1987-11-15'),(2,'Beto','García Fernández','23456789','923456789','bgarcia@gmail.com','123456','Av. Principal','Urbanización XYZ',NULL,'Cultura','CO','20:00:00','04:00:00','1990-02-22'),(3,'Nikol','Montes Esteban','34567890','934567890','nmontes@gmail.com','123456','Calle 456','Urbanización DEF',NULL,'Deporte','CO','08:00:00','16:00:00','1993-03-18'),(4,'Isaac','Huamaní Sulca','45678901','945678901','ihuamani@gmail.com','123456','Av. Secundaria','Urbanización GHI',NULL,'Deporte','CO','20:00:00','04:00:00','1991-05-09'),(5,'Elena','Hernández Gómez','56789012','956789012','ehernandez@gmail.com','123456','Calle 789','Urbanización JKL',NULL,'Cultura','CO','08:00:00','16:00:00','1992-07-22'),(6,'Dorian','Felix Naula','67890123','967890123','dfelix@gmail.com','123456','Av. Alternativa',NULL,'Noche','A pie','SE','20:00:00','04:00:00','1988-10-30'),(7,'Alejandro','Gómez Mostacero','78901234','978901234','agomez@gmail.com','123456','Calle 111',NULL,'Mañana','A pie','SE','08:00:00','16:00:00','1989-12-14'),(8,'Hugo','Díaz Fernández','89012345','989012345','hdiaz@gmail.com','123456','Av. Principal',NULL,'Noche','En bicicleta','SE','20:00:00','04:00:00','1995-06-19'),(9,'Isabel','Fernández Martínez','90123456','990123456','ifernandez@gmail.com','123456','Calle 222',NULL,'Mañana','Con canino','SE','08:00:00','16:00:00','1994-08-24'),(10,'Estefany','Fuentes Gutierrez','01234567','901234567','efuentes@gmail.com','123456','Av. Secundaria',NULL,'Noche','En bicicleta','SE','20:00:00','04:00:00','1993-01-17'),(11,'Fabricio','Estrada Castillo','23487405','923487405','festrada@gmail.com','123456','Calle 333','Urbanización BCD',NULL,NULL,'VE','08:00:00','16:00:00','1987-11-11'),(12,'Adrián','Tipo Leon','45786934','945786934','atipo@gmail.com','123456','Av. Alternativa','Urbanización EFG',NULL,NULL,'VE','20:00:00','04:00:00','1990-03-29'),(13,'María','Cruz Martínez','27845674','927845674','mcruz@gmail.com','123456','Calle 444','Urbanización HIJ',NULL,NULL,'VE','08:00:00','16:00:00','1988-05-06'),(14,'Natalia','Martínez López','36458976','936458976','nmartinez@gmail.com','123456','Av. Principal','Urbanización KLM',NULL,NULL,'VE','20:00:00','04:00:00','1991-04-25'),(15,'Oscar','Hernández Gómez','39084657','939084657','ohernandez@gmail.com','123456','Calle 555','Urbanización NOP',NULL,NULL,'VE','08:00:00','16:00:00','1992-08-14'),(16,'Patricia','López Fernández','67546834','967546834','plopez@gmail.com','123456','Av. Secundaria','Urbanización QRS',NULL,NULL,'VE','20:00:00','04:00:00','1994-06-07'),(17,'Quirino','Gómez Díaz','37895674','937895674','qgomez@gmail.com','123456','Calle 666','Urbanización TUV',NULL,NULL,'VE','08:00:00','16:00:00','1993-09-20'),(18,'Lucía','Pérez Sánchez','87654321','987654321','lperez@gmail.com','654321','Calle 123','Urbanización ABC',NULL,NULL,'VE','22:00:00','06:00:00','1989-12-27'),(19,'Luis','Martínez Ramírez','11223344','911223344','lmartinez@gmail.com','abcdef','Av. Principal 789','Urbanización DEF',NULL,NULL,'VE','14:00:00','22:00:00','1995-05-04'),(20,'Marta','García López','22334455','922334455','mgarcia@gmail.com','qwerty','Calle 456','Urbanización GHI',NULL,NULL,'VE','08:00:00','16:00:00','1988-07-30'),(21,'Pedro','Hernández Torres','33445566','933445566','phernandez@gmail.com','zxcvbn','Calle 789','Urbanización JKL',NULL,NULL,'VE','22:00:00','06:00:00','1994-01-12'),(22,'Lucía','Fernández Gómez','44556677','944556677','lfernandez@gmail.com','mnbvcx','Av. Secundaria 123','Urbanización MNO',NULL,NULL,'VE','14:00:00','22:00:00','1995-12-02'),(23,'Carlos','Sánchez Ruiz','55667788','955667788','csanchez@gmail.com','poiuyt','Calle 101',NULL,'Mañana','Con canino','SE','08:00:00','16:00:00','1989-05-15'),(24,'Elena','Díaz Fernández','66778899','966778899','ediaz@gmail.com','lkjhg','Calle 202','Urbanización STU',NULL,'Deporte','CO','22:00:00','06:00:00','1987-03-11'),(25,'Juan','Rodríguez Martínez','77889900','977889900','jrodriguez@gmail.com','asdfgh','Calle 303','Urbanización VWX',NULL,NULL,'VE','14:00:00','22:00:00','1992-10-17'),(26,'Luis','Gallego López','23416789','923416789','lgallego@gmail.com','abcdef','Avenida 456','Urbanización DEF',NULL,'Cultura','CO','16:00:00','00:00:00','1993-11-09'),(27,'María','Rodríguez Sánchez','34517890','934517890','mrodriguez@gmail.com','ghijkl','Pasaje 789',NULL,'Noche','A pie','SE','00:00:00','08:00:00','1988-12-21'),(28,'Carlos','Martínez Díaz','45608901','945608901','cmartinez@gmail.com','mnopqr','Jirón 101',NULL,'Mañana','Con canino','SE','08:00:00','16:00:00','1987-01-28'),(29,'Lucía','Gómez Ruiz','56780012','956780012','lgomez@gmail.com','stuvwx','Boulevard 202',NULL,'Tarde','En bicicleta','SE','16:00:00','00:00:00','1989-08-03'),(30,'José','Fernández Torres','61890123','961890123','jfernandez@gmail.com','yzabcd','Alameda 303','Urbanización PQR',NULL,'Cultura','CO','00:00:00','08:00:00','1991-09-12');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-23 23:23:25
