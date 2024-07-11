-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema basededatos3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `basededatos3` DEFAULT CHARACTER SET utf8 ;
USE `basededatos3` ;

-- -----------------------------------------------------
-- Table `basededatos3`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `dni` VARCHAR(8) NULL DEFAULT NULL,
  `telefono` CHAR(9) NULL DEFAULT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `urbanizacion` VARCHAR(45) NULL DEFAULT NULL,
  `turnoSerenazgo` VARCHAR(45) NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `idRoles` VARCHAR(20) NULL DEFAULT NULL,
  `horaInicio` TIME NOT NULL,
  `horaFin` TIME NOT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `rolSolicitado` VARCHAR(45) NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  INDEX `fk_usuario_roles1_idx` (`idRoles` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_roles1`
    FOREIGN KEY (`idRoles`)
    REFERENCES `basededatos3`.`roles` (`idRoles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `basededatos3`.`solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`solicitudes` (
  `idsolicitudes` INT NOT NULL AUTO_INCREMENT,
  `estadosolicitud` TINYINT NULL DEFAULT NULL,
  `fechasolicitud` DATE NULL DEFAULT NULL,
  `usuario_idUsuario` INT NOT NULL,
  `roles_idRoles` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idsolicitudes`),
  INDEX `fk_solicitudes_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  INDEX `fk_solicitudes_roles1_idx` (`roles_idRoles` ASC) VISIBLE,
  CONSTRAINT `fk_solicitudes_roles1`
    FOREIGN KEY (`roles_idRoles`)
    REFERENCES `basededatos3`.`roles` (`idRoles`),
  CONSTRAINT `fk_solicitudes_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `basededatos3`.`usuario` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `basededatos3`.`solicitudes`
MODIFY `roles_idRoles` VARCHAR(20) NULL DEFAULT NULL;

-- -----------------------------------------------------
-- Table basededatos3.credenciales
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS basededatos3.credenciales (
  idcredenciales INT NOT NULL,
  correo VARCHAR(45) NULL DEFAULT NULL,
  claveHash VARCHAR(64) NULL DEFAULT NULL,
  idUsuario INT NOT NULL,
  PRIMARY KEY (idcredenciales),
  INDEX fk_credenciales_usuario1_idx (idUsuario ASC) VISIBLE,
  CONSTRAINT fk_credenciales_usuario1
    FOREIGN KEY (idUsuario)
    REFERENCES basededatos3.usuario (idUsuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `basededatos3`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`profesor` (
  `idProfesor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `curso` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idProfesor`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`evento` (
  `idEvento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fechaInicial` DATE NULL DEFAULT NULL,
  `fechaFinal` DATE NULL DEFAULT NULL,
  `foto` MEDIUMBLOB NOT NULL,
  `materiales` TEXT NOT NULL,
  `lugar` VARCHAR(45) NOT NULL,
  `hora` TIME NOT NULL,
  `frecuencia` VARCHAR(45) NOT NULL,
  `vacantes` INT NOT NULL,
  `descripcion` TEXT NOT NULL,
  `tipo` VARCHAR(10) NULL DEFAULT NULL,
  `idProfesor` INT NOT NULL,
  `estadoEvento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEvento`),
  INDEX `fk_Evento_Profesor1_idx` (`idProfesor` ASC) VISIBLE,
  CONSTRAINT `fk_Evento_Profesor1`
    FOREIGN KEY (`idProfesor`)
    REFERENCES `basededatos3`.`profesor` (`idProfesor`))
ENGINE = InnoDB
AUTO_INCREMENT = 2021
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`roles` (
  `idRoles` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRoles`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`evento_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`evento_has_usuario` (
  `idEvento` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `asistio` TINYINT NULL DEFAULT NULL,
  `cometioFalta` TINYINT NULL DEFAULT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idEvento`, `idUsuario`),
  INDEX `fk_Evento_has_Usuario_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_Evento_has_Usuario_Evento1_idx` (`idEvento` ASC) VISIBLE,
  CONSTRAINT `fk_Evento_has_Usuario_Evento1`
    FOREIGN KEY (`idEvento`)
    REFERENCES `basededatos3`.`evento` (`idEvento`),
  CONSTRAINT `fk_Evento_has_Usuario_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `basededatos3`.`usuario` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`fotosdeeventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`fotosdeeventos` (
  `idfotosDeEventos` INT NOT NULL AUTO_INCREMENT,
  `fotosDeEventos` MEDIUMBLOB NULL DEFAULT NULL,
  `idEvento` INT NOT NULL,
  PRIMARY KEY (`idfotosDeEventos`),
  INDEX `fk_fotosDeEventos_Evento1_idx` (`idEvento` ASC) VISIBLE,
  CONSTRAINT `fk_fotosDeEventos_Evento1`
    FOREIGN KEY (`idEvento`)
    REFERENCES `basededatos3`.`evento` (`idEvento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`tipo` (
  `idtipo` VARCHAR(6) NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `basededatos3`.`Aconpanantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`Aconpanantes` (
  `idAconpanantes` INT NOT NULL AUTO_INCREMENT,
  `NombreAconpanantes` VARCHAR(45) NOT NULL,
  `ApellidoAconpanantes` VARCHAR(45) NOT NULL,
  `DniAconpanantes` VARCHAR(8) NOT NULL,
  `evento_has_usuario_idEvento` INT NOT NULL,
  `evento_has_usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idAconpanantes`, `evento_has_usuario_idEvento`, `evento_has_usuario_idUsuario`),
  INDEX `fk_Aconpanantes_evento_has_usuario1_idx` (`evento_has_usuario_idEvento` ASC, `evento_has_usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Aconpanantes_evento_has_usuario1`
    FOREIGN KEY (`evento_has_usuario_idEvento` , `evento_has_usuario_idUsuario`)
    REFERENCES `basededatos3`.`evento_has_usuario` (`idEvento` , `idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `basededatos3`.`incidencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`incidencia` (
  `idIncidenciaReportada` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `lugar` VARCHAR(200) NOT NULL,
  `referencia` VARCHAR(45) NOT NULL,
  `contacto` VARCHAR(45) NULL DEFAULT NULL,
  `fecha` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `requiereAmbulancia` TINYINT NULL DEFAULT NULL,
  `requierePolicia` TINYINT NULL DEFAULT NULL,
  `requiereBomberos` TINYINT NULL DEFAULT NULL,
  `idUsuario` INT NOT NULL,
  `criticidad` VARCHAR(45) NULL DEFAULT NULL,
  `tipoPersonal` VARCHAR(45) NULL DEFAULT NULL,
  `personalRefuerzo` VARCHAR(45) NULL DEFAULT NULL,
  `descripcionSolucion` VARCHAR(500) NULL DEFAULT NULL,
  `descripcionEliminacion` VARCHAR(500) NULL DEFAULT NULL,
  `estadoPersonal` VARCHAR(45) NULL DEFAULT NULL,
  `estadoIncidencia` VARCHAR(45) NULL DEFAULT NULL,
  `idtipo` VARCHAR(6) NOT NULL,
  `foto` MEDIUMBLOB NULL DEFAULT NULL,
  `fechaFoto` TIME NULL DEFAULT NULL,
  `isDeleted` TINYINT NOT NULL,
  PRIMARY KEY (`idIncidenciaReportada`),
  INDEX `fk_Incidencia_Usuario1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_incidencia_tipo1_idx` (`idtipo` ASC) VISIBLE,
  CONSTRAINT `fk_incidencia_tipo1`
    FOREIGN KEY (`idtipo`)
    REFERENCES `basededatos3`.`tipo` (`idtipo`),
  CONSTRAINT `fk_Incidencia_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `basededatos3`.`usuario` (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1039
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Datos de roles
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('AD', 'Administrador');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('CO', 'Coordinadoras');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('SE', 'Serenazgo');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('VE', 'Vecino');
/*INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('C0', 'PreCoordinadora');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('V0', 'PreVecino');*/

-- Datos de usuario
INSERT INTO usuario (nombre, apellido, dni, telefono, correo, clave, direccion, urbanizacion, turnoSerenazgo, tipo, idRoles, horaInicio, horaFin, fecha_nacimiento) VALUES
('Christopher','Terrones Peña','32364579','912345678','cterrones@gmail.com','123456','Calle 123','Urbanización ABC',NULL,NULL,'AD','08:00:00','16:00:00','1987-11-15'),
('Beto','García Fernández','64856789','923456789','bgarcia@gmail.com','123456','Av. Principal','Urbanización XYZ',NULL,'Cultura','CO','20:00:00','04:00:00','1990-02-22'),
('Nikol','Montes Esteban','34567890','934567890','nmontes@gmail.com','123456','Calle 456','Urbanización DEF',NULL,'Deporte','CO','08:00:00','16:00:00','1993-03-18'),
('Isaac','Huamaní Sulca','49078901','945678901','ihuamani@gmail.com','123456','Av. Secundaria','Urbanización GHI',NULL,'Deporte','CO','20:00:00','04:00:00','1991-05-09'),
('Elena','Hernández Gómez','50789012','956789012','ehernandez@gmail.com','123456','Calle 789','Urbanización JKL',NULL,'Cultura','CO','08:00:00','16:00:00','1992-07-22'),
('Dorian','Felix Naula','33890123','967890123','dfelix@gmail.com','123456','Av. Alternativa',NULL,'Noche','A pie','SE','20:00:00','04:00:00','1988-10-30'),
('Alejandro','Gómez Mostacero','78901234','978901234','carlosjn.gmos@gmail.com','123456','Calle 403',NULL,'Mañana','A pie','SE','08:00:00','16:00:00','1989-12-14'),
('Hugo','Díaz Fernández','89012345','989012345','hdiaz@gmail.com','123456','Av. Principal',NULL,'Noche','En bicicleta','SE','20:00:00','04:00:00','1995-06-19'),
('Isabel','Fernández Martínez','90123456','990123456','ifernandez@gmail.com','123456','Calle 222',NULL,'Mañana','Con canino','SE','08:00:00','16:00:00','1994-08-24'),
('Estefany','Fuentes Gutierrez','01234567','901234567','efuentes@gmail.com','123456','Av. Secundaria',NULL,'Noche','En bicicleta','SE','20:00:00','04:00:00','1993-01-17'),
('Fabricio','Estrada Castillo','23487405','923487405','festrada@gmail.com','123456','Calle 333','Urbanización BCD',NULL,NULL,'VE','08:00:00','16:00:00','1987-11-11'),
('Adrián','Tipo Leon','45786934','945786934','atipo@gmail.com','123456','Av. Alternativa','Urbanización EFG',NULL,NULL,'VE','20:00:00','04:00:00','1990-03-29'),
('María','Cruz Martínez','27845674','927845674','mcruz@gmail.com','123456','Calle 444','Urbanización HIJ',NULL,NULL,'VE','08:00:00','16:00:00','1988-05-06'),
('Natalia','Martínez López','36458976','936458976','nmartinez@gmail.com','123456','Av. Principal','Urbanización KLM',NULL,NULL,'VE','20:00:00','04:00:00','1991-04-25'),
('Oscar','Hernández Gómez','39084657','939084657','ohernandez@gmail.com','123456','Calle 555','Urbanización NOP',NULL,NULL,'VE','08:00:00','16:00:00','1992-08-14'),
('Patricia','López Fernández','67546834','967546834','plopez@gmail.com','123456','Av. Secundaria','Urbanización QRS',NULL,NULL,'VE','20:00:00','04:00:00','1994-06-07'),
('Quirino','Gómez Díaz','37895674','937895674','qgomez@gmail.com','123456','Calle 666','Urbanización TUV',NULL,NULL,'VE','08:00:00','16:00:00','1993-09-20'),
('Lucía','Pérez Sánchez','87654321','987654321','lperez@gmail.com','654321','Calle 123','Urbanización ABC',NULL,NULL,'VE','22:00:00','06:00:00','1989-12-27'),
('Luis','Martínez Ramírez','10293344','911223344','lmartinez@gmail.com','abcdef','Av. Principal 789','Urbanización DEF',NULL,NULL,'VE','14:00:00','22:00:00','1995-05-04'),
('Marta','García López','28234455','922334455','mgarcia@gmail.com','qwerty','Calle 456','Urbanización GHI',NULL,NULL,'VE','08:00:00','16:00:00','1988-07-30'),
('Pedro','Hernández Torres','33445096','933445566','phernandez@gmail.com','zxcvbn','Calle 789','Urbanización JKL',NULL,NULL,'VE','22:00:00','06:00:00','1994-01-12'),
('Lucía','Fernández Gómez','34556987','944556677','lfernandez@gmail.com','mnbvcx','Av. Secundaria 123','Urbanización MNO',NULL,NULL,'VE','14:00:00','22:00:00','1995-12-02'),
('Carlos','Sánchez Ruiz','59067028','955667788','csanchez@gmail.com','poiuyt','Calle 101',NULL,'Mañana','Con canino','SE','08:00:00','16:00:00','1989-05-15'),
('Elena','Díaz Fernández','12378599','966778899','ediaz@gmail.com','lkjhg','Calle 202','Urbanización STU',NULL,'Deporte','CO','22:00:00','06:00:00','1987-03-11'),
('Juan','Rodríguez Martínez','73789120','977889900','jrodriguez@gmail.com','asdfgh','Calle 303','Urbanización VWX',NULL,NULL,'VE','14:00:00','22:00:00','1992-10-17'),
('Luis','Gallego López','17216789','923416789','lgallego@gmail.com','abcdef','Avenida 456','Urbanización DEF',NULL,'Cultura','CO','16:00:00','00:00:00','1993-11-09'),
('María','Rodríguez Sánchez','34517890','934517890','mrodriguez@gmail.com','ghijkl','Pasaje 789',NULL,'Noche','A pie','SE','00:00:00','08:00:00','1988-12-21'),
('Carlos','Martínez Díaz','45608901','945608901','cmartinez@gmail.com','mnopqr','Jirón 101',NULL,'Mañana','Con canino','SE','08:00:00','16:00:00','1987-01-28'),
('Lucía','Gómez Ruiz','56780012','956780012','lgomez@gmail.com','stuvwx','Boulevard 202',NULL,'Tarde','En bicicleta','SE','16:00:00','00:00:00','1989-08-03'),
('José','Fernández Torres','61890123','961890123','jfernandez@gmail.com','yzabcd','Alameda 303','Urbanización PQR',NULL,'Cultura','CO','00:00:00','08:00:00','1991-09-12');


-- Datos de profesores
INSERT INTO profesor (nombre, apellido, curso) VALUES
('Juan', 'Pérez Fernández', 'Yoga para adultos mayores, embarazadas y jóvenes'),
('Luisa', 'García Fernández', 'Yoga para adultos mayores, embarazadas y jóvenes'),
('Andrés', 'Rodríguez Martínez', 'Yoga para adultos mayores, embarazadas y jóvenes'),
('Marcela', 'Martínez López', 'Competencia de fútbol'),
('Roberto', 'Hernández Gómez', 'Competencia de vóley'),
('Ana', 'López Fernández', 'Competencia de Atletismo'),
('Eduardo', 'Gómez Díaz', 'Carrera de tres pies'),
('Carolina', 'Díaz Fernández', 'Festival de juegos familiares'),
('Jorge', 'Fernández Martínez', 'Juegos deportivos para los niños'),
('Catalina', 'Mendoza García', 'Juegos deportivos para los niños');

-- Tipo
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('RO', 'Robo agravado');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('EM', 'Emergencia médica');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('AL', 'Alteración del orden público');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('AC', 'Accidente');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('OT', 'Otro');

-- Incidencias
ALTER TABLE incidencia AUTO_INCREMENT = 1001;
INSERT INTO `basededatos3`.`incidencia` 
(`nombre`, `descripcion`, `lugar`, `referencia`, `contacto`, `requiereAmbulancia`, `requiereBomberos`, `idUsuario`, `criticidad`, `tipoPersonal`, `personalRefuerzo`, `descripcionSolucion`, `descripcionEliminacion`, `estadoPersonal`, `estadoIncidencia`, `idtipo`, `foto`, `isDeleted`) VALUES
('Personas atrapadas', 'Personas atrapadas en un ascensor en la Calle 12', 'Calle 12, San Miguel-Lima', 'Referencia 12, San Miguel-Lima', '923456789', 0, 0, 12, 'Alto', 'Ambulancia', 'Vehiculo', 'Se está enviando un equipo de rescate para liberar a la persona', NULL, 'Policía en camino', 'En proceso', 'OT', 0010000000111111111111111111111111111111001000000011111111111111111111111111111100000000001110111111111111100001111111100000000000110000001110000000000111111110000000000011000111111111111111111111110000000000001110011111111101111100111111000000000000101000011111111000000011100000000000000000000001111111000000001100000000000000001000001111101100000000110000000000000000110000111101000000000000000000000000000001000110000000000011000000000000000000000100000000000000001100000000000000000000001001111110000000110000000000000000000000011111001000000011000000000000000000000000001111000000001100000000000000000000000011111100000000110000000000000000000000001101100000000111000000000000000000000000001100000000011100000000000000000000000000000000000001110000000000000000000000000000000000000111000000000000000000000000000000000000011100000000000000000000000000000000000000100000000000,0),
('Ruido de fiesta', 'Denuncia de ruido excesivo en una fiesta en la Calle 13', 'Calle 13, San Miguel-Lima', 'Referencia 13, San Miguel-Lima', '934523890', 1, 0, 13, 'Bajo', 'Bomberos', 'A pie', 'Se llegó a un acuerdo con los organizadores y se disolvió la fiesta', NULL, 'Bomberos en camino', 'En proceso', 'AL', NULL, 0),
('Robo', 'Reporte de robo en la esquina de Calle 1 y Avenida Principal', 'Calle 1, San Miguel-Lima', 'Referencia 1, San Miguel-Lima', '912115678', 1, 0, 1, 'Bajo', 'Bomberos', 'A pie', 'Se envió una patrulla al lugar', NULL, 'Bomberos en camino', 'En proceso', 'RO', NULL, 0),
('Choque de autos', 'Choque de vehículos en la intersección de Calle 2 y Avenida Secundaria', 'Calle 2, San Miguel-Lima', 'Referencia 2, San Miguel-Lima', '923456789', 1, 0, 2, 'Medio', 'Comisaría', 'bicicleta', 'Se envió una ambulancia y se está desviando el tráfico', NULL, 'Ambulancia en camino', 'En proceso', 'AC', NULL, 0),
('Incendio en edificio', 'Incendio en un edificio de departamentos en la Calle 3', 'Calle 3, San Miguel-Lima', 'Referencia 3, San Miguel-Lima', '934567890', 1, 1, 3, 'Alto', 'Ambulancia', 'canino', 'Se evacuaron los residentes y se está controlando el fuego', NULL, 'Policía en camino', 'En proceso', 'OT', 0010000000111111111111111111111111111111001000000011111111111111111111111111111100000000001110111111111111100001111111100000000000110000001110000000000111111110000000000011000111111111111111111111110000000000001110011111111101111100111111000000000000101000011111111000000011100000000000000000000001111111000000001100000000000000001000001111101100000000110000000000000000110000111101000000000000000000000000000001000110000000000011000000000000000000000100000000000000001100000000000000000000001001111110000000110000000000000000000000011111001000000011000000000000000000000000001111000000001100000000000000000000000011111100000000110000000000000000000000001101100000000111000000000000000000000000001100000000011100000000000000000000000000000000000001110000000000000000000000000000000000000111000000000000000000000000000000000000011100000000000000000000000000000000000000100000000000, 0),
('Robo con pistola', 'Robo a mano armada en un supermercado en la Avenida Principal', 'Calle 4, San Miguel-Lima', 'Referencia 4, San Miguel-Lima', '945678901', 0, 0, 4, 'Bajo', 'Bomberos', 'Vehiculo', 'Se arrestaron a los sospechosos y se recuperó la mercancía', NULL, 'Bomberos en camino', 'En proceso', 'RO', NULL, 0),
('Ruido y altercado', 'Altercado entre vecinos por ruido excesivo en la Calle 5', 'Calle 5, San Miguel-Lima', 'Referencia 5, San Miguel-Lima', '956789012', 0, 0, 5, 'Medio', 'Comisaría', 'A pie', 'Se llegó a un acuerdo entre las partes involucradas', NULL, 'Ambulancia en camino', 'En proceso', 'AL', NULL, 0),
('Drogas en fiesta', 'Sospecha de sustancias ilegales en una fiesta clandestina en Calle 6', 'Calle 6, San Miguel-Lima', 'Referencia 6, San Miguel-Lima', '967890123', 1, 0, 6, 'Alto', 'Ambulancia', 'bicicleta', 'Se está realizando una redada policial', NULL, 'Policía en camino', 'En proceso', 'OT', NULL, 0),
('Intrusión', 'Intrusión en una propiedad privada en la Calle 7', 'Calle 7, San Miguel-Lima', 'Referencia 7, San Miguel-Lima', '978901234', 1, 0, 7, 'Bajo', 'Bomberos', 'canino', 'Se detuvo al intruso y se aseguró la zona', NULL, 'Bomberos en camino', 'En proceso', 'OT', NULL, 0),
('Accidente de tránsito y persona herida', 'Persona herida en un accidente de tránsito en la Calle 8', 'Calle 8, San Miguel-Lima', 'Referencia 8, San Miguel-Lima', '989012345', 1, 0, 8, 'Medio', 'Comisaría', 'Vehiculo', 'Se llamó a una ambulancia y se está controlando el tráfico', NULL, 'Ambulancia en camino', 'En proceso', 'AC', NULL, 0),
('Robo de vehículos', 'Robo de vehículo estacionado en la Calle 9', 'Calle 9, San Miguel-Lima', 'Referencia 9, San Miguel-Lima', '990123456', 1, 0, 9, 'Alto', 'Ambulancia', 'A pie', 'Se están rastreando las cámaras de seguridad en la zona', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Mascotas', 'Incidente con mascotas agresivas en la Calle 10', 'Calle 10, San Miguel-Lima', 'Referencia 10, San Miguel-Lima', '901234567', 0, 1, 10, 'Bajo', 'Bomberos', 'bicicleta', 'Se capturaron a los animales y se notificó a los propietarios', NULL, 'Bomberos en camino', 'En proceso', 'OT', NULL, 0),
('Riña callejera', 'Riña callejera en la intersección de Calle 11 y Avenida Principal', 'Calle 11, San Miguel-Lima', 'Referencia 11, San Miguel-Lima', '912345678', 1, 0, 11, 'Medio', 'Comisaría', 'canino', 'Se detuvieron a los involucrados y se está mediando el conflicto', NULL, 'Ambulancia en camino', 'En proceso', 'AL', NULL, 0),
('Robo', 'Robo reportado cerca del parque', 'Av. La Marina 123, San Miguel, Lima', 'Cerca del supermercado grande', '987654321', 0, 0, 1, 'Alto', 'Comisaría', 'Vehiculo', 'Sospechoso detenido', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Ruido', 'Queja por ruido de los vecinos', 'Calle Las Flores 456, San Miguel, Lima', 'Detrás de la gasolinera', '912345678', 0, 0, 5, 'Bajo', 'Comisaría', 'A pie', 'Advertencia emitida', NULL, 'Policía en camino', 'En proceso', 'AL', NULL, 0),
('Incendio', 'Incendio en área residencial', 'Jr. San Martin 789, San Miguel, Lima', 'Frente a la escuela', '923456789', 1, 1, 10, 'Alto', 'Bomberos', 'Vehiculo', 'Incendio extinguido', NULL, 'Bomberos en camino', 'En proceso', 'EM', NULL, 0),
('Emergencia Médica', 'Emergencia médica', 'Av. Universitaria 321, San Miguel, Lima', 'Junto al banco', '934567890', 1, 0, 15, 'Medio', 'Ambulancia', 'Vehiculo', 'Paciente estabilizado', NULL, 'Ambulancia en camino', 'En proceso', 'EM', NULL, 0),
('Actividad sospechosa', 'Actividad sospechosa', 'Jr. Amazonas 654, San Miguel, Lima', 'Cerca del área de juegos', '945678901', 0, 0, 16, 'Medio', 'Comisaría', 'A pie', 'Área asegurada', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Problema doméstico', 'Disturbio doméstico', 'Av. Faucett 987, San Miguel, Lima', 'Cerca de la iglesia', '956789012', 0, 0, 17, 'Alto', 'Comisaría', 'Vehiculo', 'Conflicto resuelto', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Accidente', 'Accidente de tráfico', 'Calle Pizarro 159, San Miguel, Lima', 'En la rotonda', '967890123', 1, 0, 15, 'Medio', 'Ambulancia', 'Vehiculo', 'Herido transportado', NULL, 'Ambulancia en camino', 'En proceso', 'EM', NULL, 0),
('Embriaguez', 'Embriaguez en público', 'Av. Libertad 753, San Miguel, Lima', 'Cerca del cine', '978901234', 0, 0, 2, 'Bajo', 'Comisaría', 'A pie', 'Individuo detenido', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Robo', 'Robo en progreso', 'Jr. Belgrano 852, San Miguel, Lima', 'Frente al centro comercial', '989012345', 0, 0, 4, 'Alto', 'Comisaría', 'Vehiculo', 'Sospechoso arrestado', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Vandalismo', 'Vandalismo', 'Av. Argentina 951, San Miguel, Lima', 'Junto al parque', '990123456', 0, 0, 6, 'Medio', 'Comisaría', 'Bicicleta', 'Reporte presentado', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Niño perdido', 'Niño perdido', 'Calle Independencia 159, San Miguel, Lima', 'En la parada de autobús', '901234567', 0, 0, 8, 'Alto', 'Comisaría', 'Canino', 'Niño encontrado', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Ebriedad', 'Conductor ebrio', 'Av. La Marina 357, San Miguel, Lima', 'Cerca de la escuela', '912345678', 1, 0, 12, 'Alto', 'Comisaría', 'Vehiculo', 'Conductor arrestado', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Pelea', 'Pelea reportada', 'Jr. Puno 456, San Miguel, Lima', 'Cerca del parque', '923456789', 0, 0, 14, 'Medio', 'Comisaría', 'A pie', 'Participantes separados', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Persona con arma', 'Persona con arma', 'Av. Brasil 789, San Miguel, Lima', 'Frente al mercado', '934567890', 0, 0, 16, 'Alto', 'Comisaría', 'Vehiculo', 'Arma confiscada', NULL, 'Policía en camino', 'En proceso', 'RO', NULL, 0),
('Incendio', 'Incendio en edificio comercial', 'Calle Sucre 951, San Miguel, Lima', 'Cerca del banco', '945678901', 1, 1, 15, 'Alto', 'Bomberos', 'Vehiculo', 'Incendio bajo control', NULL, 'Bomberos en camino', 'En proceso', 'AC', NULL, 0),
('Ascensor', 'Persona atrapada en un ascensor en la Calle 12', 'Calle 12, San Miguel-Lima', 'Referencia 12, San Miguel-Lima', '923456789', 0, 0, 12, 'Alto', 'Ambulancia', 'Vehiculo', 'Se está enviando un equipo de rescate para liberar a la persona', NULL, 'Policía en camino', 'Nueva', 'OT', NULL, 0),
('Ruido', 'Denuncia de ruido excesivo en una fiesta en la Calle 13', 'Calle 13, San Miguel-Lima', 'Referencia 13, San Miguel-Lima', '934523890', 1, 0, 13, 'Bajo', 'Bomberos', 'A pie', 'Se llegó a un acuerdo con los organizadores y se disolvió la fiesta', NULL, 'Bomberos en camino', 'Nueva', 'AL', NULL, 0),
('Robo', 'Reporte de robo en la esquina de Calle 1 y Avenida Principal', 'Calle 1, San Miguel-Lima', 'Referencia 1, San Miguel-Lima', '912115678', 1, 0, 1, 'Bajo', 'Bomberos', 'A pie', 'Se envió una patrulla al lugar', NULL, 'Bomberos en camino', 'Nueva', 'RO', NULL, 0),
('Choque', 'Choque de vehículos en la intersección de Calle 2 y Avenida Secundaria', 'Calle 2, San Miguel-Lima', 'Referencia 2, San Miguel-Lima', '923456789', 1, 0, 2, 'Medio', 'Comisaría', 'bicicleta', 'Se envió una ambulancia y se está desviando el tráfico', NULL, 'Ambulancia en camino', 'Nueva', 'AC', NULL, 0),
('Incendio', 'Incendio en un edificio de departamentos en la Calle 3', 'Calle 3, San Miguel-Lima', 'Referencia 3, San Miguel-Lima', '934567890', 1, 1, 3, 'Alto', 'Ambulancia', 'canino', 'Se evacuaron los residentes y se está controlando el fuego', NULL, 'Policía en camino', 'Nueva', 'OT', NULL, 0),
('Incendio', 'Reporte de incendio en edificio', 'Av. La Marina 123, Lima', 'Referencia 34, San Miguel-Lima', '987654321', 0, 1, 15, NULL, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL, 0),
('Fuga de gas', 'Supuesta fuga de gas en cocina', 'Calle Las Flores 56, Miraflores', 'Referencia 56, Miraflores', '912345678', 0, 1, 16, NULL, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL, 0),
('Persona atrapada', 'Persona atrapada en un ascensor', 'Calle 10, Barranco', 'Referencia 78, Barranco', '923456789', 0, 0, 17, NULL, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL, 0),
('Accidente de tráfico', 'Accidente de tráfico sin heridos', 'Av. Brasil 789, Jesús María', 'Referencia 90, Jesús María', '934567890', 0, 0, 18, NULL, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL, 0),
('Alarma', 'Alarma de seguridad activada sin motivo', 'Jr. Puno 112, Cercado de Lima', 'Referencia 12, Cercado de Lima', '945678901', 0, 0, 19, NULL, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL, 0);

-- Eventos
ALTER TABLE evento AUTO_INCREMENT = 2001;
INSERT INTO evento (nombre, fechaInicial, fechaFinal, foto, materiales, lugar, hora, frecuencia, vacantes, descripcion, tipo, idProfesor, estadoEvento) VALUES
('Yoga', '2024-06-01', '2024-06-01', X'' , 'Colchonetas, balones', 'Parque Kennedy, San Miguel, Lima', '08:00:00', '1', '15', 'Yoga para adultos mayores, embarazadas y jóvenes', 'Cultural', '1', 'Pronto'),
('Fútbol', '2024-06-02', '2024-06-02', X'', 'Balones, redes', 'Complejo Deportivo San Miguel, Lima', '16:00:00', '2', '18', 'Competencia de fútbol', 'Deportivo', '4', 'Pronto'),
('Voley', '2024-06-03', '2024-06-03', X'', 'Balones, redes', 'Parque de la Juventud, San Miguel, Lima', '10:00:00', '3', '12', 'Competencia de vóley', 'Deportivo', '5', 'Pronto'),
('Atletismo', '2024-06-04', '2024-06-04', X'', 'Cronómetros, banderines', 'Estadio Miguel Grau, San Miguel, Lima', '09:00:00', '4', '14', 'Competencia de atletismo', 'Deportivo', '4', 'Pronto'),
('Tres pies', '2024-06-05', '2024-06-05', X'', 'Cuerdas, pañuelos', 'Parque El Olivar, San Miguel, Lima', '15:00:00', '5', '16', 'Carrera de tres pies', 'Deportivo', '7', 'Pronto'),
('Familiar', '2024-06-06', '2024-06-06', X'', 'Juegos de mesa, pelotas', 'Municipalidad de San Miguel, Lima', '10:30:00', '1', '20', 'Festival de juegos familiares', 'Cultural', '8', 'Pronto'),
('Niños', '2024-06-07', '2024-06-07', X'', 'Pelotas, conos', 'Parque Urubamba, San Miguel, Lima', '14:00:00', '2', '15', 'Juegos deportivos para los niños', 'Deportivo', '9', 'Pronto'),
('Yoga', '2024-06-08', '2024-06-08', X'', 'Esterillas, pelotas', 'Parque Helio, San Miguel, Lima', '17:00:00', '3', '17', 'Yoga para adultos mayores, embarazadas y jóvenes', 'Cultural', '2', 'Pronto'),
('Fútbol', '2024-06-09', '2024-06-09', X'', 'Balones, redes', 'Parque Los Rosales, San Miguel, Lima', '11:30:00', '4', '19', 'Competencia de fútbol', 'Deportivo', '4', 'Pronto'),
('Voley', '2024-06-10', '2024-06-10', X'', 'Balones, redes', 'Parque Kennedy, San Miguel, Lima', '13:00:00', '5', '20', 'Competencia de vóley', 'Deportivo', '5', 'Pronto'),
('Atletismo', '2024-06-11', '2024-06-11', X'', 'Cronómetros, banderines', 'Estadio Miguel Grau, San Miguel, Lima', '08:00:00', '1', '15', 'Competencia de atletismo', 'Deportivo', '6', 'Pronto'),
('Tres pies', '2024-06-12', '2024-06-12', X'', 'Cuerdas, pañuelos', 'Parque El Olivar, San Miguel, Lima', '16:00:00', '2', '18', 'Carrera de tres pies', 'Deportivo', '7', 'Pronto'),
('Familiar', '2024-06-13', '2024-06-13', X'', 'Juegos de mesa, pelotas', 'Municipalidad de San Miguel, Lima', '10:30:00', '3', '12', 'Festival de juegos familiares', 'Cultural', '8', 'Pronto'),
('Niños', '2024-06-14', '2024-06-14', X'', 'Pelotas, conos', 'Complejo Deportivo San Miguel, Lima', '14:00:00', '4', '14', 'Juegos deportivos para los niños', 'Deportivo', '10', 'Pronto'),
('Yoga', '2024-06-15', '2024-06-15', X'', 'Esterillas, pelotas', 'Parque de la Juventud, San Miguel, Lima', '17:00:00', '5', '16', 'Yoga para adultos mayores, embarazadas y jóvenes', 'Cultural', '3', 'Pronto'),
('Fútbol', '2024-06-16', '2024-06-16', X'', 'Balones, redes', 'Estadio Miguel Grau, San Miguel, Lima', '11:30:00', '1', '19', 'Competencia de fútbol', 'Deportivo', '4', 'Pronto'),
('Voley', '2024-06-17', '2024-06-17', X'', 'Balones, redes', 'Parque Kennedy, San Miguel, Lima', '13:00:00', '2', '20', 'Competencia de vóley', 'Deportivo', '7', 'Pronto'),
('Atletismo', '2024-06-18', '2024-06-18', X'', 'Cronómetros, banderines', 'Estadio Miguel Grau, San Miguel, Lima', '08:00:00', '3', '15', 'Competencia de atletismo', 'Deportivo', '8', 'Pronto'),
('Tres pies', '2024-06-19', '2024-06-19', X'', 'Cuerdas, pañuelos', 'Parque El Olivar, San Miguel, Lima', '16:00:00', '4', '18', 'Carrera de tres pies', 'Deportivo', '9', 'Pronto'),
('Familiar', '2024-06-20', '2024-06-20', X'', 'Juegos de mesa, pelotas', 'Municipalidad de San Miguel, Lima', '10:30:00', '5', '12', 'Festival de juegos familiares', 'Cultural', '10', 'Pronto');

-- evento_has_usuario
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`, `descripcion`) VALUES ('2001', '12', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`, `descripcion`) VALUES ('2002', '16', '1', '0','Ataca a otros participantes durante el partido');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2002', '7', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`, `descripcion`) VALUES ('2003', '8', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2002', '10', '0', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2002', '12', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2003', '2', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2003', '11', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2004', '2', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2004', '15', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2004', '11', '0', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2004', '3', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`,  `asistio`, `cometioFalta`, `descripcion`) VALUES ('2004', '5', '1', '0',NULL);
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `asistio`, `cometioFalta`,`descripcion`) VALUES ('2004', '13', '1', '1','Fomenta a la destruccion de la propiedad publica y genera altercados');

-- credenciales

-- Insertar datos en credenciales
INSERT INTO credenciales (idCredenciales, correo, claveHash, idUsuario)
SELECT 
    idUsuario as idCredenciales,
    correo,
    SHA2(clave, 256) as claveHash,
    idUsuario
FROM usuario;

INSERT INTO `basededatos3`.`solicitudes` (`estadosolicitud`, `fechasolicitud`, `usuario_idUsuario`, `roles_idRoles`)
VALUES 
(0, '2024-06-01', 1, NULL),
(0, '2024-06-02', 2, NULL),
(0, '2024-06-03', 3, NULL),
(0, '2024-06-04', 4, NULL),
(0, '2024-06-05', 5, NULL),
(0, '2024-06-06', 6, NULL),
(0, '2024-06-07', 7, NULL),
(0, '2024-06-08', 8, NULL),
(0, '2024-06-09', 9, NULL),
(0, '2024-06-10', 10, NULL);