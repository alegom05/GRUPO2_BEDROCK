-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema basededatos3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema basededatos3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `basededatos3` DEFAULT CHARACTER SET utf8 ;
USE `basededatos3` ;

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
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`evento` (
  `idEvento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fechaInicial` DATE NULL DEFAULT NULL,
  `fechaFinal` DATE NULL DEFAULT NULL,
  `foto` BLOB NOT NULL,
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
-- Table `basededatos3`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `dni` VARCHAR(8) NULL DEFAULT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `urbanizacion` VARCHAR(45) NULL DEFAULT NULL,
  `turnoSerenazgo` VARCHAR(45) NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `idRoles` VARCHAR(20) NOT NULL,
  `horaInicio` TIME NOT NULL,
  `horaFin` TIME NOT NULL,
  PRIMARY KEY (`idUsuario`, `idRoles`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  UNIQUE INDEX `dni_UNIQUE` (`dni` ASC) VISIBLE,
  INDEX `fk_usuario_roles1_idx` (`idRoles` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_roles1`
    FOREIGN KEY (`idRoles`)
    REFERENCES `basededatos3`.`roles` (`idRoles`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `basededatos3`.`evento_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`evento_has_usuario` (
  `idEvento` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `esCoordinadorDeporte` TINYINT NULL DEFAULT NULL,
  `esCoordinadorCultura` TINYINT NULL DEFAULT NULL,
  `esVecino` TINYINT NULL DEFAULT NULL,
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
  `fotosDeEventos` BLOB NULL DEFAULT NULL,
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
-- Table `basededatos3`.`incidencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `basededatos3`.`incidencia` (
  `idIncidenciaReportada` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `lugar` VARCHAR(200) NOT NULL,
  `referencia` VARCHAR(45) NOT NULL,
  `contacto` VARCHAR(45) NULL DEFAULT NULL,
  `requiereAmbulancia` TINYINT NOT NULL,
  `foto` BLOB NULL DEFAULT NULL,
  `idUsuario` INT NOT NULL,
  `esFalso` TINYINT NULL DEFAULT NULL,
  `criticidad` VARCHAR(45) NULL DEFAULT NULL,
  `tipoPersonal` VARCHAR(45) NULL DEFAULT NULL,
  `personalRefuerzo` VARCHAR(45) NULL DEFAULT NULL,
  `descripcionSolucion` VARCHAR(500) NULL DEFAULT NULL,
  `estadoPersonal` VARCHAR(45) NULL DEFAULT NULL,
  `idtipo` VARCHAR(6) NOT NULL,
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
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Datos de roles

INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('AD', 'Administrador');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('CO', 'Coordinadoras');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('SE', 'Serenazgo');
INSERT INTO `basededatos3`.`roles` (`idRoles`, `nombre`) VALUES ('VE', 'Vecino');


INSERT INTO usuario (nombre, apellido, correo, contraseña, direccion, urbanizacion, turnoSerenazgo, tipo, idRoles, horaInicio, horaFin) VALUES
('Ana', 'Pérez', 'aperez@gmail.com', '123456', 'Calle 123', 'Urbanización ABC', 'Turno Mañana', 'Residente', 'AD', '08:00:00', '16:00:00'),
('Beto', 'García', 'bgarcia@gmail.com', '123456', 'Av. Principal', 'Urbanización XYZ', 'Turno Noche', 'Residente', 'CO', '20:00:00', '04:00:00'),
('Carlos', 'Rodríguez', 'crodriguez@gmail.com', '123456', 'Calle 456', 'Urbanización DEF', 'Turno Mañana', 'Residente', 'CO', '08:00:00', '16:00:00'),
('Diana', 'Martínez', 'dmartinez@gmail.com', '123456', 'Av. Secundaria', 'Urbanización GHI', 'Turno Noche', 'Residente', 'CO', '20:00:00', '04:00:00'),
('Elena', 'Hernández', 'ehernandez@gmail.com', '123456', 'Calle 789', 'Urbanización JKL', 'Turno Mañana', 'Residente', 'CO', '08:00:00', '16:00:00'),
('Fernando', 'López', 'flopez@gmail.com', '123456', 'Av. Alternativa', 'Urbanización MNO', 'Turno Noche', 'Residente', 'SE', '20:00:00', '04:00:00'),
('Gabriela', 'Gómez', 'ggomez@gmail.com', '123456', 'Calle 111', 'Urbanización PQR', 'Turno Mañana', 'Residente', 'SE', '08:00:00', '16:00:00'),
('Hugo', 'Díaz', 'hdiaz@gmail.com', '123456', 'Av. Principal', 'Urbanización STU', 'Turno Noche', 'Residente', 'SE', '20:00:00', '04:00:00'),
('Isabel', 'Fernández', 'ifernandez@gmail.com', '123456', 'Calle 222', 'Urbanización VWX', 'Turno Mañana', 'usuario', 'SE', '08:00:00', '16:00:00'),
('Javier', 'Mendoza', 'jmendoza@gmail.com', '123456', 'Av. Secundaria', 'Urbanización YZA', 'Turno Noche', 'usuario', 'SE', '20:00:00', '04:00:00'),
('Karina', 'Pérez', 'kperez@gmail.com', '123456', 'Calle 333', 'Urbanización BCD', 'Turno Mañana', 'usuario', 'VE', '08:00:00', '16:00:00'),
('Luis', 'García', 'lgarcia@gmail.com', '123456', 'Av. Alternativa', 'Urbanización EFG', 'Turno Noche', 'Residente', 'VE', '20:00:00', '04:00:00'),
('María', 'Rodríguez', 'mrodriguez@gmail.com', '123456', 'Calle 444', 'Urbanización HIJ', 'Turno Mañana', 'Residente', 'VE', '08:00:00', '16:00:00'),
('Natalia', 'Martínez', 'nmartinez@gmail.com', '123456', 'Av. Principal', 'Urbanización KLM', 'Turno Noche', 'Residente', 'VE', '20:00:00', '04:00:00'),
('Oscar', 'Hernández', 'ohernandez@gmail.com', '123456', 'Calle 555', 'Urbanización NOP', 'Turno Mañana', 'Residente', 'VE', '08:00:00', '16:00:00'),
('Patricia', 'López', 'plopez@gmail.com', '123456', 'Av. Secundaria', 'Urbanización QRS', 'Turno Noche', 'Residente', 'VE', '20:00:00', '04:00:00'),
('Quirino', 'Gómez', 'qgomez@gmail.com', '123456', 'Calle 666', 'Urbanización TUV', 'Turno Mañana', 'Residente', 'VE', '08:00:00', '16:00:00');

-- Datos de profesores
INSERT INTO profesor (nombre, apellido, curso) VALUES
('Juan', 'Pérez', 'Yoga para adultos mayores, embarazadas y jóvenes'),
('Luisa', 'García', 'Yoga para adultos mayores, embarazadas y jóvenes'),
('Andrés', 'Rodríguez', 'Yoga para adultos mayores, embarazadas y jóvenes'),
('Marcela', 'Martínez', 'Competencia de fútbol'),
('Roberto', 'Hernández', 'Competencia de vóley'),
('Ana', 'López', 'Competencia de Atletismo'),
('Eduardo', 'Gómez', 'Carrera de tres pies'),
('Carolina', 'Díaz', 'Festival de juegos familiares'),
('Jorge', 'Fernández', 'Juegos deportivos para los niños'),
('Ana', 'Mendoza', 'Juegos deportivos para los niños');

-- Tipo
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('RE', 'Incidencia Reportada');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('FA', 'Incidencia Falsa Alarma');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('EN', 'Incidencia en proceso');

-- Incidencias
INSERT INTO incidencia (nombre, descripcion, lugar, referencia, contacto, requiereAmbulancia, idUsuario, esFalso, criticidad, tipoPersonal, personalRefuerzo, descripcionSolucion, estadoPersonal, idtipo)
VALUES
('Incidencia 3', 'Reporte de robo en la esquina de Calle 1 y Avenida Principal', 'Calle 1, San Miguel-Lima', 'Referencia 1, San Miguel-Lima', '912345678', 1, 1, 0, 'bajo', 'Bomberos', 'A pie', 'Se envió una patrulla al lugar', 'Bomberos en camino', 'EN'),
('Incidencia 4', 'Choque de vehículos en la intersección de Calle 2 y Avenida Secundaria', 'Calle 2, San Miguel-Lima', 'Referencia 2, San Miguel-Lima', '923456789', 1, 2, 0, 'medio', 'Comisaría', 'bicicleta', 'Se envió una ambulancia y se está desviando el tráfico', 'Ambulancia en camino', 'EN'),
('Incidencia 5', 'Incendio en un edificio de departamentos en la Calle 3', 'Calle 3, San Miguel-Lima', 'Referencia 3, San Miguel-Lima', '934567890', 1, 3, 0, 'alto', 'Ambulancia', 'canino', 'Se evacuaron los residentes y se está controlando el fuego', 'Policía en camino', 'EN'),
('Incidencia 6', 'Robo a mano armada en un supermercado en la Avenida Principal', 'Calle 4, San Miguel-Lima', 'Referencia 4, San Miguel-Lima', '945678901', 0, 4, 1, 'bajo', 'Bomberos', 'Vehiculo', 'Se arrestaron a los sospechosos y se recuperó la mercancía', 'Bomberos en camino', 'EN'),
('Incidencia 7', 'Altercado entre vecinos por ruido excesivo en la Calle 5', 'Calle 5, San Miguel-Lima', 'Referencia 5, San Miguel-Lima', '956789012', 0, 5, 1, 'medio', 'Comisaría', 'A pie', 'Se llegó a un acuerdo entre las partes involucradas', 'Ambulancia en camino', 'EN'),
('Incidencia 8', 'Sospecha de sustancias ilegales en una fiesta clandestina en Calle 6', 'Calle 6, San Miguel-Lima', 'Referencia 6, San Miguel-Lima', '967890123', 1, 6, 0, 'alto', 'Ambulancia', 'bicicleta', 'Se está realizando una redada policial', 'Policía en camino', 'EN'),
('Incidencia 9', 'Intrusión en una propiedad privada en la Calle 7', 'Calle 7, San Miguel-Lima', 'Referencia 7, San Miguel-Lima', '978901234', 1, 7, 0, 'bajo', 'Bomberos', 'canino', 'Se detuvo al intruso y se aseguró la zona', 'Bomberos en camino', 'EN'),
('Incidencia 10', 'Persona herida en un accidente de tránsito en la Calle 8', 'Calle 8, San Miguel-Lima', 'Referencia 8, San Miguel-Lima', '989012345', 1, 8, 0, 'medio', 'Comisaría', 'Vehiculo', 'Se llamó a una ambulancia y se está controlando el tráfico', 'Ambulancia en camino', 'EN'),
('Incidencia 11', 'Robo de vehículo estacionado en la Calle 9', 'Calle 9, San Miguel-Lima', 'Referencia 9, San Miguel-Lima', '990123456', 1, 9, 0, 'alto', 'Ambulancia', 'A pie', 'Se están rastreando las cámaras de seguridad en la zona', 'Policía en camino', 'EN'),
('Incidencia 12', 'Incidente con mascotas agresivas en la Calle 10', 'Calle 10, San Miguel-Lima', 'Referencia 10, San Miguel-Lima', '901234567', 0, 10, 1, 'bajo', 'Bomberos', 'bicicleta', 'Se capturaron a los animales y se notificó a los propietarios', 'Bomberos en camino', 'EN'),
('Incidencia 13', 'Riña callejera en la intersección de Calle 11 y Avenida Principal', 'Calle 11, San Miguel-Lima', 'Referencia 11, San Miguel-Lima', '912345678', 1, 11, 0, 'medio', 'Comisaría', 'canino', 'Se detuvieron a los involucrados y se está mediando el conflicto', 'Ambulancia en camino', 'EN'),
('Incidencia 14', 'Persona atrapada en un ascensor en la Calle 12', 'Calle 12, San Miguel-Lima', 'Referencia 12, San Miguel-Lima', '923456789', 0, 12, 1, 'alto', 'Ambulancia', 'Vehiculo', 'Se está enviando un equipo de rescate para liberar a la persona', 'Policía en camino', 'EN'),
('Incidencia 15', 'Denuncia de ruido excesivo en una fiesta en la Calle 13', 'Calle 13, San Miguel-Lima', 'Referencia 13, San Miguel-Lima', '934567890', 1, 13, 1, 'bajo', 'Bomberos', 'A pie', 'Se llegó a un acuerdo con los organizadores y se disolvió la fiesta', 'Bomberos en camino', 'EN');