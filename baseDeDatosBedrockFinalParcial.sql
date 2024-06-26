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
  `telefono` char(9) DEFAULT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `urbanizacion` VARCHAR(45) NULL DEFAULT NULL,
  `turnoSerenazgo` VARCHAR(45) NULL DEFAULT NULL,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `idRoles` VARCHAR(20) NOT NULL,
  `horaInicio` TIME NOT NULL,
  `horaFin` TIME NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
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
  `estadoIncidencia` VARCHAR(45) NULL DEFAULT NULL,
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

-- Datos de usuario
INSERT INTO usuario (nombre, apellido, dni, telefono, correo, contraseña, direccion, urbanizacion, turnoSerenazgo, tipo, idRoles, horaInicio, horaFin, fecha_nacimiento) VALUES
('Ana', 'Pérez Fernández', '12345678', '912345678', 'aperez@gmail.com', '123456', 'Calle 123', 'Urbanización ABC', NULL, NULL, 'AD', '08:00:00', '16:00:00', '1987-11-15'),
('Beto', 'García Fernández', '23456789', '923456789', 'bgarcia@gmail.com', '123456', 'Av. Principal', 'Urbanización XYZ', NULL, 'Cultura', 'CO', '20:00:00', '04:00:00', '1990-02-22'),
('Carlos', 'Rodríguez Martínez', '34567890', '934567890', 'crodriguez@gmail.com', '123456', 'Calle 456', 'Urbanización DEF', NULL, 'Deporte', 'CO', '08:00:00', '16:00:00', '1993-03-18'),
('Diana', 'Martínez López', '45678901', '945678901', 'dmartinez@gmail.com', '123456', 'Av. Secundaria', 'Urbanización GHI', NULL, 'Deporte', 'CO', '20:00:00', '04:00:00', '1991-05-09'),
('Elena', 'Hernández Gómez', '56789012', '956789012', 'ehernandez@gmail.com', '123456', 'Calle 789', 'Urbanización JKL', NULL, 'Cultura', 'CO', '08:00:00', '16:00:00', '1992-07-22'),
('Fernando', 'López Fernández', '67890123', '967890123', 'flopez@gmail.com', '123456', 'Av. Alternativa', NULL, 'Noche', 'A pie', 'SE', '20:00:00', '04:00:00', '1988-10-30'),
('Gabriela', 'Gómez Díaz', '78901234', '978901234', 'ggomez@gmail.com', '123456', 'Calle 111', NULL, 'Mañana', 'A pie', 'SE', '08:00:00', '16:00:00', '1989-12-14'),
('Hugo', 'Díaz Fernández', '89012345', '989012345', 'hdiaz@gmail.com', '123456', 'Av. Principal', NULL, 'Noche', 'En bicicleta', 'SE', '20:00:00', '04:00:00', '1995-06-19'),
('Isabel', 'Fernández Martínez', '90123456', '990123456', 'ifernandez@gmail.com', '123456', 'Calle 222', NULL, 'Mañana', 'Con canino', 'SE', '08:00:00', '16:00:00', '1994-08-24'),
('Javier', 'Mendoza García', '01234567', '901234567', 'jmendoza@gmail.com', '123456', 'Av. Secundaria', NULL, 'Noche', 'En bicicleta', 'SE', '20:00:00', '04:00:00', '1993-01-17'),
('Karina', 'Pérez Díaz', '23487405', '923487405', 'kperez@gmail.com', '123456', 'Calle 333', 'Urbanización BCD', NULL, NULL, 'VE', '08:00:00', '16:00:00', '1987-11-11'),
('Luis', 'García Fernández', '45786934', '945786934', 'lgarcia@gmail.com', '123456', 'Av. Alternativa', 'Urbanización EFG', NULL, NULL, 'VE', '20:00:00', '04:00:00', '1990-03-29'),
('María', 'Cruz Martínez', '27845674', '927845674', 'mcruz@gmail.com', '123456', 'Calle 444', 'Urbanización HIJ', NULL, NULL, 'VE', '08:00:00', '16:00:00', '1988-05-06'),
('Natalia', 'Martínez López', '36458976', '936458976', 'nmartinez@gmail.com', '123456', 'Av. Principal', 'Urbanización KLM', NULL, NULL, 'VE', '20:00:00', '04:00:00', '1991-04-25'),
('Oscar', 'Hernández Gómez', '39084657', '939084657', 'ohernandez@gmail.com', '123456', 'Calle 555', 'Urbanización NOP', NULL, NULL, 'VE', '08:00:00', '16:00:00', '1992-08-14'),
('Patricia', 'López Fernández', '67546834', '967546834', 'plopez@gmail.com', '123456', 'Av. Secundaria', 'Urbanización QRS', NULL, NULL, 'VE', '20:00:00', '04:00:00', '1994-06-07'),
('Quirino', 'Gómez Díaz', '37895674', '937895674', 'qgomez@gmail.com', '123456', 'Calle 666', 'Urbanización TUV', NULL, NULL, 'VE', '08:00:00', '16:00:00', '1993-09-20'),
('Lucía', 'Pérez Sánchez', '87654321', '987654321', 'lperez@gmail.com', '654321', 'Calle 123', 'Urbanización ABC', NULL, NULL, 'VE', '22:00:00', '06:00:00', '1989-12-27'),
('Luis', 'Martínez Ramírez', '11223344', '911223344', 'lmartinez@gmail.com', 'abcdef', 'Av. Principal 789', 'Urbanización DEF', NULL, NULL, 'VE', '14:00:00', '22:00:00', '1995-05-04'),
('Marta', 'García López', '22334455', '922334455', 'mgarcia@gmail.com', 'qwerty', 'Calle 456', 'Urbanización GHI', NULL, NULL, 'VE', '08:00:00', '16:00:00', '1988-07-30'),
('Pedro', 'Hernández Torres', '33445566', '933445566', 'phernandez@gmail.com', 'zxcvbn', 'Calle 789', 'Urbanización JKL', NULL, NULL, 'VE', '22:00:00', '06:00:00', '1994-01-12'),
('Lucía', 'Fernández Gómez', '44556677', '944556677', 'lfernandez@gmail.com', 'mnbvcx', 'Av. Secundaria 123', 'Urbanización MNO', NULL, NULL, 'VE', '14:00:00', '22:00:00', '1995-12-02'),
('Carlos', 'Sánchez Ruiz', '55667788', '955667788', 'csanchez@gmail.com', 'poiuyt', 'Calle 101', NULL, 'Mañana', 'Con canino', 'SE', '08:00:00', '16:00:00', '1989-05-15'),
('Elena', 'Díaz Fernández', '66778899', '966778899', 'ediaz@gmail.com', 'lkjhg', 'Calle 202', 'Urbanización STU', NULL, 'Deporte', 'CO', '22:00:00', '06:00:00', '1987-03-11'),
('Juan', 'Rodríguez Martínez', '77889900', '977889900', 'jrodriguez@gmail.com', 'asdfgh', 'Calle 303', 'Urbanización VWX', NULL, NULL, 'VE', '14:00:00', '22:00:00', '1992-10-17'),
('Luis', 'Gallego López', '23416789', '923416789', 'lgallego@gmail.com', 'abcdef', 'Avenida 456', 'Urbanización DEF', NULL, 'Cultura', 'CO', '16:00:00', '00:00:00', '1993-11-09'),
('María', 'Rodríguez Sánchez', '34517890', '934517890', 'mrodriguez@gmail.com', 'ghijkl', 'Pasaje 789', NULL, 'Noche', 'A pie', 'SE', '00:00:00', '08:00:00', '1988-12-21'),
('Carlos', 'Martínez Díaz', '45608901', '945608901', 'cmartinez@gmail.com', 'mnopqr', 'Jirón 101', NULL, 'Mañana', 'Con canino', 'SE', '08:00:00', '16:00:00', '1987-01-28'),
('Lucía', 'Gómez Ruiz', '56780012', '956780012', 'lgomez@gmail.com', 'stuvwx', 'Boulevard 202', NULL, 'Tarde', 'En bicicleta', 'SE', '16:00:00', '00:00:00', '1989-08-03'),
('José', 'Fernández Torres', '61890123', '961890123', 'jfernandez@gmail.com', 'yzabcd', 'Alameda 303', 'Urbanización PQR', NULL, 'Cultura', 'CO', '00:00:00', '08:00:00', '1991-09-12');

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
('Ana', 'Mendoza García', 'Juegos deportivos para los niños');

-- Tipo
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('RO', 'Robo agravado');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('EM', 'Emergencia médica');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('AL', 'Alteración del orden público');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('AC', 'Accidente');
INSERT INTO `basededatos3`.`tipo` (`idtipo`, `nombre`) VALUES ('OT', 'Otro');

-- Incidencias
ALTER TABLE incidencia AUTO_INCREMENT = 1001;
INSERT INTO `basededatos3`.`incidencia` 
(`nombre`, `descripcion`, `lugar`, `referencia`, `contacto`, `requiereAmbulancia`, `idUsuario`, `esFalso`, `criticidad`, `tipoPersonal`, `personalRefuerzo`, `descripcionSolucion`, `estadoPersonal`, `estadoIncidencia`, `idtipo`, `foto`)
VALUES
('Ascensor', 'Persona atrapada en un ascensor en la Calle 12', 'Calle 12, San Miguel-Lima', 'Referencia 12, San Miguel-Lima', '923456789', 0, 12, 1, 'Alto', 'Ambulancia', 'Vehiculo', 'Se está enviando un equipo de rescate para liberar a la persona', 'Policía en camino', 'En proceso', 'OT', NULL),
('Ruido', 'Denuncia de ruido excesivo en una fiesta en la Calle 13', 'Calle 13, San Miguel-Lima', 'Referencia 13, San Miguel-Lima', '934523890', 1, 13, 1, 'Bajo', 'Bomberos', 'A pie', 'Se llegó a un acuerdo con los organizadores y se disolvió la fiesta', 'Bomberos en camino', 'En proceso', 'AL', NULL),
('Robo', 'Reporte de robo en la esquina de Calle 1 y Avenida Principal', 'Calle 1, San Miguel-Lima', 'Referencia 1, San Miguel-Lima', '912115678', 1, 1, 0, 'Bajo', 'Bomberos', 'A pie', 'Se envió una patrulla al lugar', 'Bomberos en camino', 'En proceso', 'RO', NULL),
('Choque', 'Choque de vehículos en la intersección de Calle 2 y Avenida Secundaria', 'Calle 2, San Miguel-Lima', 'Referencia 2, San Miguel-Lima', '923456789', 1, 2, 0, 'Medio', 'Comisaría', 'bicicleta', 'Se envió una ambulancia y se está desviando el tráfico', 'Ambulancia en camino', 'En proceso', 'AC', NULL),
('Incendio', 'Incendio en un edificio de departamentos en la Calle 3', 'Calle 3, San Miguel-Lima', 'Referencia 3, San Miguel-Lima', '934567890', 1, 3, 0, 'Alto', 'Ambulancia', 'canino', 'Se evacuaron los residentes y se está controlando el fuego', 'Policía en camino', 'En proceso', 'OT', NULL),
('Robo', 'Robo a mano armada en un supermercado en la Avenida Principal', 'Calle 4, San Miguel-Lima', 'Referencia 4, San Miguel-Lima', '945678901', 0, 4, 1, 'Bajo', 'Bomberos', 'Vehiculo', 'Se arrestaron a los sospechosos y se recuperó la mercancía', 'Bomberos en camino', 'En proceso', 'RO', NULL),
('Ruido', 'Altercado entre vecinos por ruido excesivo en la Calle 5', 'Calle 5, San Miguel-Lima', 'Referencia 5, San Miguel-Lima', '956789012', 0, 5, 1, 'Medio', 'Comisaría', 'A pie', 'Se llegó a un acuerdo entre las partes involucradas', 'Ambulancia en camino', 'En proceso', 'AL', NULL),
('Drogas', 'Sospecha de sustancias ilegales en una fiesta clandestina en Calle 6', 'Calle 6, San Miguel-Lima', 'Referencia 6, San Miguel-Lima', '967890123', 1, 6, 0, 'Alto', 'Ambulancia', 'bicicleta', 'Se está realizando una redada policial', 'Policía en camino', 'En proceso', 'OT', NULL),
('Intrusión', 'Intrusión en una propiedad privada en la Calle 7', 'Calle 7, San Miguel-Lima', 'Referencia 7, San Miguel-Lima', '978901234', 1, 7, 0, 'Bajo', 'Bomberos', 'canino', 'Se detuvo al intruso y se aseguró la zona', 'Bomberos en camino', 'En proceso', 'OT', NULL),
('Accidente de tránsito', 'Persona herida en un accidente de tránsito en la Calle 8', 'Calle 8, San Miguel-Lima', 'Referencia 8, San Miguel-Lima', '989012345', 1, 8, 0, 'Medio', 'Comisaría', 'Vehiculo', 'Se llamó a una ambulancia y se está controlando el tráfico', 'Ambulancia en camino', 'En proceso', 'AC', NULL),
('Robo', 'Robo de vehículo estacionado en la Calle 9', 'Calle 9, San Miguel-Lima', 'Referencia 9, San Miguel-Lima', '990123456', 1, 9, 0, 'Alto', 'Ambulancia', 'A pie', 'Se están rastreando las cámaras de seguridad en la zona', 'Policía en camino', 'En proceso', 'RO', NULL),
('Mascotas', 'Incidente con mascotas agresivas en la Calle 10', 'Calle 10, San Miguel-Lima', 'Referencia 10, San Miguel-Lima', '901234567', 0, 10, 1, 'Bajo', 'Bomberos', 'bicicleta', 'Se capturaron a los animales y se notificó a los propietarios', 'Bomberos en camino', 'En proceso', 'OT', NULL),
('Riña callejera', 'Riña callejera en la intersección de Calle 11 y Avenida Principal', 'Calle 11, San Miguel-Lima', 'Referencia 11, San Miguel-Lima', '912345678', 1, 11, 0, 'Medio', 'Comisaría', 'canino', 'Se detuvieron a los involucrados y se está mediando el conflicto', 'Ambulancia en camino', 'En proceso', 'AL', NULL),
('Robo', 'Robo reportado cerca del parque', 'Av. La Marina 123, San Miguel, Lima', 'Cerca del supermercado grande', '987654321', 0, 1, 0, 'Alto', 'Comisaría', 'Vehiculo', 'Sospechoso detenido', 'Policía en camino', 'En proceso', 'RO', NULL),
('Ruido', 'Queja por ruido de los vecinos', 'Calle Las Flores 456, San Miguel, Lima', 'Detrás de la gasolinera', '912345678', 0, 5, 1, 'Bajo', 'Comisaría', 'A pie', 'Advertencia emitida', 'Policía en camino', 'En proceso', 'AL', NULL),
('Incendio', 'Incendio en área residencial', 'Jr. San Martin 789, San Miguel, Lima', 'Frente a la escuela', '923456789', 1, 10, 0, 'Alto', 'Bomberos', 'Vehiculo', 'Incendio extinguido', 'Bomberos en camino', 'En proceso', 'EM', NULL),
('Emergencia Médica', 'Emergencia médica', 'Av. Universitaria 321, San Miguel, Lima', 'Junto al banco', '934567890', 1, 15, 0, 'Medio', 'Ambulancia', 'Vehiculo', 'Paciente estabilizado', 'Ambulancia en camino', 'En proceso', 'EM', NULL),
('Actividad sospechosa', 'Actividad sospechosa', 'Jr. Amazonas 654, San Miguel, Lima', 'Cerca del área de juegos', '945678901', 0, 16, 1, 'Medio', 'Comisaría', 'A pie', 'Área asegurada', 'Policía en camino', 'En proceso', 'RO', NULL),
('Problema doméstico', 'Disturbio doméstico', 'Av. Faucett 987, San Miguel, Lima', 'Cerca de la iglesia', '956789012', 0, 17, 0, 'Alto', 'Comisaría', 'Vehiculo', 'Conflicto resuelto', 'Policía en camino', 'En proceso', 'RO', NULL),
('Accidente', 'Accidente de tráfico', 'Calle Pizarro 159, San Miguel, Lima', 'En la rotonda', '967890123', 1, 15, 0, 'Medio', 'Ambulancia', 'Vehiculo', 'Herido transportado', 'Ambulancia en camino', 'En proceso', 'EM', NULL),
('Embriaguez', 'Embriaguez en público', 'Av. Libertad 753, San Miguel, Lima', 'Cerca del cine', '978901234', 0, 2, 1, 'Bajo', 'Comisaría', 'A pie', 'Individuo detenido', 'Policía en camino', 'En proceso', 'RO', NULL),
('Robo', 'Robo en progreso', 'Jr. Belgrano 852, San Miguel, Lima', 'Frente al centro comercial', '989012345', 0, 4, 0, 'Alto', 'Comisaría', 'Vehiculo', 'Sospechoso arrestado', 'Policía en camino', 'En proceso', 'RO', NULL),
('Vandalismo', 'Vandalismo', 'Av. Argentina 951, San Miguel, Lima', 'Junto al parque', '990123456', 0, 6, 1, 'Medio', 'Comisaría', 'Bicicleta', 'Reporte presentado', 'Policía en camino', 'En proceso', 'RO', NULL),
('Niño perdido', 'Niño perdido', 'Calle Independencia 159, San Miguel, Lima', 'En la parada de autobús', '901234567', 0, 8, 0, 'Alto', 'Comisaría', 'Canino', 'Niño encontrado', 'Policía en camino', 'En proceso', 'RO', NULL),
('Ebriedad', 'Conductor ebrio', 'Av. La Marina 357, San Miguel, Lima', 'Cerca de la escuela', '912345678', 1, 12, 0, 'Alto', 'Comisaría', 'Vehiculo', 'Conductor arrestado', 'Policía en camino', 'En proceso', 'RO', NULL),
('Pelea', 'Pelea reportada', 'Jr. Puno 456, San Miguel, Lima', 'Cerca del parque', '923456789', 0, 14, 1, 'Medio', 'Comisaría', 'A pie', 'Participantes separados', 'Policía en camino', 'En proceso', 'RO', NULL),
('Persona con arma', 'Persona con arma', 'Av. Brasil 789, San Miguel, Lima', 'Frente al mercado', '934567890', 0, 16, 0, 'Alto', 'Comisaría', 'Vehiculo', 'Arma confiscada', 'Policía en camino', 'En proceso', 'RO', NULL),
('Incendio', 'Incendio en edificio comercial', 'Calle Sucre 951, San Miguel, Lima', 'Cerca del banco', '945678901', 1, 15, 0, 'Alto', 'Bomberos', 'Vehiculo', 'Incendio bajo control', 'Bomberos en camino', 'En proceso', 'AC', NULL),
('Emergencia médica', 'Emergencia médica en área pública', 'Jr. Tacna 123, San Miguel, Lima', 'Junto al hospital', NULL, 1, 14, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'EM', NULL),
('Ruido', 'Queja por ruido', 'Av. Bolivar 357, San Miguel, Lima', 'Detrás de la tienda', NULL, 0, 14, 1, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'AL', NULL),
('Embriaguez', 'Embriaguez en público', 'Av. Libertad 753, San Miguel, Lima', 'Cerca del cine', NULL, 0, 2, 1, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'AL', NULL),
('Robo', 'Robo en progreso', 'Jr. Belgrano 852, San Miguel, Lima', 'Frente al centro comercial', NULL, 0, 4, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'RO', NULL),
('Vandalismo', 'Vandalismo', 'Av. Argentina 951, San Miguel, Lima', 'Junto al parque', NULL, 0, 6, 1, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'OT', NULL),
('Pérdida', 'Niño perdido', 'Calle Independencia 159, San Miguel, Lima', 'En la parada de autobús', NULL, 0, 8, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'OT', NULL),
('Ebriedad', 'Conductor ebrio', 'Av. La Marina 357, San Miguel, Lima', 'Cerca de la escuela', NULL, 1, 12, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'AL', NULL),
('Pelea', 'Pelea reportada', 'Jr. Puno 456, San Miguel, Lima', 'Cerca del parque', NULL, 0, 14, 1, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'AL', NULL),
('Grafiti', 'Grafiti en una iglesia', 'Av. Brasil 789, San Miguel, Lima', 'Frente al mercado', NULL, 0, 16, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'OT', NULL),
('Incendio', 'Incendio en edificio comercial', 'Calle Sucre 951, San Miguel, Lima', 'Cerca del banco', NULL, 1, 15, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'AC', NULL),
('Emergencia médica', 'Emergencia médica en área pública', 'Jr. Tacna 123, San Miguel, Lima', 'Junto al hospital', NULL, 1, 14, 0, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'EM', NULL),
('Ruido', 'Queja por ruido', 'Av. Bolivar 357, San Miguel, Lima', 'Detrás de la tienda', NULL, 0, 14, 1, NULL, NULL, NULL, NULL, NULL, 'Nueva', 'AL', NULL),
('Persona sospechosa', 'Persona sospechosa merodeando', 'Av. San Martin 123, San Miguel, Lima', 'Frente a la tienda', NULL, 0, 3, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL),
('Llamada', 'Llamada de emergencia falsa', 'Calle Libertad 456, San Miguel, Lima', 'Cerca del parque', NULL, 0, 5, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'OT', NULL),
('Incendio', 'Incendio reportado, pero inexistente', 'Jr. Arequipa 789, San Miguel, Lima', 'Detrás del colegio', NULL, 1, 7, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'AC', NULL),
('Accidente', 'Accidente de tráfico', 'Av. Grau 321, San Miguel, Lima', 'Frente al hospital', NULL, 1, 9, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'AC', NULL),
('Disturbio', 'Disturbio en vecindario, falso reporte', 'Calle Pizarro 654, San Miguel, Lima', 'Cerca del mercado', NULL, 0, 11, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'AL', NULL),
('Persona herida', 'Persona herida por caer de su segundo piso', 'Av. Los Incas 987, San Miguel, Lima', 'En la plaza central', NULL, 1, 13, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'EM', NULL),
('Robo', 'Robo en progreso', 'Calle Bolognesi 159, San Miguel, Lima', 'Frente al banco', NULL, 0, 15, 1, NULL, NULL, NULL, NULL, NULL, 'Falsa alarma', 'RO', NULL);

-- Eventos
ALTER TABLE evento AUTO_INCREMENT = 2001;
INSERT INTO evento (nombre, fechaInicial, fechaFinal, foto, materiales, lugar, hora, frecuencia, vacantes, descripcion, tipo, idProfesor, estadoEvento) VALUES
('Yoga', '2024-06-01', '2024-06-01', X'', 'Colchonetas, balones', 'Parque Kennedy, San Miguel, Lima', '08:00:00', '1', '15', 'Yoga para adultos mayores, embarazadas y jóvenes', 'Cultural', '1', 'Pronto'),
('Fútbol', '2024-06-02', '2024-06-02', X'', 'Balones, redes', 'Complejo Deportivo San Miguel, Lima', '16:00:00', '2', '18', 'Competencia de fútbol', 'Deportivo', '4', 'Pronto'),
('Voley', '2024-06-03', '2024-06-03', X'', 'Balones, redes', 'Parque de la Juventud, San Miguel, Lima', '10:00:00', '3', '12', 'Competencia de vóley', 'Deportivo', '5', 'Pronto'),
('Atletismo', '2024-06-04', '2024-06-04', X'', 'Cronómetros, banderines', 'Estadio Miguel Grau, San Miguel, Lima', '09:00:00', '4', '14', 'Competencia de atletismo', 'Deportivo', '4', 'Pronto'),
('Tres pies', '2024-06-05', '2024-06-05', X'', 'Cuerdas, pañuelos', 'Parque El Olivar, San Miguel, Lima', '15:00:00', '5', '16', 'Carrera de tres pies', 'Deportivo', '7', 'Pronto'),
('Familiar', '2024-06-06', '2024-06-06', X'', 'Juegos de mesa, pelotas', 'Municipalidad de San Miguel, Lima', '10:30:00', '1', '20', 'Festival de juegos familiares', 'Cultural', '8', 'Pronto'),
('Niños', '2024-06-07', '2024-06-07', X'', 'Pelotas, conos', 'Complejo Deportivo San Miguel, Lima', '14:00:00', '2', '15', 'Juegos deportivos para los niños', 'Deportivo', '9', 'Pronto'),
('Yoga', '2024-06-08', '2024-06-08', X'', 'Esterillas, pelotas', 'Parque de la Juventud, San Miguel, Lima', '17:00:00', '3', '17', 'Yoga para adultos mayores, embarazadas y jóvenes', 'Cultural', '2', 'Pronto'),
('Fútbol', '2024-06-09', '2024-06-09', X'', 'Balones, redes', 'Estadio Miguel Grau, San Miguel, Lima', '11:30:00', '4', '19', 'Competencia de fútbol', 'Deportivo', '4', 'Pronto'),
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
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2001', '1', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2002', '5', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2002', '7', '0', '0', '0', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2003', '8', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2002', '10', '0', '0', '1', '0', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2002', '15', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2003', '2', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2003', '1', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2004', '2', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2004', '15', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2004', '17', '0', '0', '1', '0', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`) VALUES ('2004', '3', '0', '0', '1', '1', '0');
INSERT INTO `basededatos3`.`evento_has_usuario` (`idEvento`, `idUsuario`, `esCoordinadorDeporte`, `esCoordinadorCultura`, `esVecino`, `asistio`, `cometioFalta`, `descripcion`) VALUES ('2004', '5', '0', '0', '1', '1', '1', 'Falta deportiva contra un compañero');


