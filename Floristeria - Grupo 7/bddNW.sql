-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema floristeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema floristeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `floristeria` DEFAULT CHARACTER SET latin1 ;
USE `floristeria` ;

-- -----------------------------------------------------
-- Table `floristeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`clientes` (
  `idregistro` INT NOT NULL AUTO_INCREMENT,
  `RTN` VARCHAR(16) CHARACTER SET 'utf8mb3' NULL DEFAULT '00000000000000',
  `Nombre` VARCHAR(30) CHARACTER SET 'utf8mb3' NOT NULL,
  `Direccion` TEXT CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Telefono` VARCHAR(30) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Correo` VARCHAR(250) CHARACTER SET 'utf8mb3' NULL DEFAULT NULL,
  `Imagen` LONGBLOB NULL DEFAULT NULL,
  `nombreImagen` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`idregistro`),
  INDEX `clientes_rtn_idx` (`RTN` ASC) VISIBLE,
  INDEX `clientes_nombre_idx` (`Nombre` ASC) VISIBLE,
  INDEX `clientes_telefono_idx` (`Telefono` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`usuario` (
  `usercod` BIGINT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NULL DEFAULT NULL,
  `useremail` VARCHAR(80) NULL DEFAULT NULL,
  `username` VARCHAR(80) NULL DEFAULT NULL,
  `userpswd` VARCHAR(128) NULL DEFAULT NULL,
  `userfching` DATETIME NULL DEFAULT NULL,
  `userpswdest` CHAR(3) NULL DEFAULT NULL,
  `userpswdexp` DATETIME NULL DEFAULT NULL,
  `userest` CHAR(3) NULL DEFAULT NULL,
  `useractcod` VARCHAR(128) NULL DEFAULT NULL,
  `userpswdchg` VARCHAR(128) NULL DEFAULT NULL,
  `usertipo` CHAR(3) NULL DEFAULT NULL COMMENT 'Tipo de Usuario, Normal, Consultor o Cliente',
  PRIMARY KEY (`usercod`),
  UNIQUE INDEX `useremail_UNIQUE` (`useremail` ASC) VISIBLE,
  INDEX `fk_usuario_clientes_clientes1_idx` (`idcliente` ASC) VISIBLE,
  INDEX `usertipo` (`usertipo` ASC, `useremail` ASC, `usercod` ASC, `userest` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_clientes_clientes1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `floristeria`.`clientes` (`idregistro`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`app_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`app_pedidos` (
  `id` VARCHAR(5) NOT NULL,
  `usuario_clientes_id` BIGINT NOT NULL,
  `fechahora` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `dispositivo` VARCHAR(250) NULL DEFAULT NULL,
  `activo` TINYINT(1) NULL DEFAULT '1',
  `modalidad` ENUM('ME', 'DO', 'LL') NOT NULL,
  `estado` ENUM('AAA', 'NNN', 'SNN', 'SSN', 'NNS', 'SNS', 'SSS', 'NSS', 'NSN') NULL DEFAULT NULL,
  `fechamodificacion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `usuariomodificacion` INT NULL DEFAULT NULL,
  `estacionmodificacion` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_app_pedidos_usuario_clientes1_idx` (`usuario_clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_app_pedidos_usuario_clientes1`
    FOREIGN KEY (`usuario_clientes_id`)
    REFERENCES `floristeria`.`usuario` (`usercod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`productos` (
  `invPrdId` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `foto` VARCHAR(200) NULL DEFAULT NULL,
  `invPrdDsc` VARCHAR(300) NULL DEFAULT NULL,
  `invPrdTip` VARCHAR(45) NULL DEFAULT NULL,
  `Estado` VARCHAR(45) NULL DEFAULT NULL,
  `stock` INT NULL DEFAULT NULL,
  `invPrdPrice` DECIMAL(5,0) NULL DEFAULT NULL,
  PRIMARY KEY (`invPrdId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`app_detalle_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`app_detalle_pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `app_pedidos_id` VARCHAR(5) NOT NULL,
  `productos_Codigo` VARCHAR(15) NOT NULL,
  `cantidad` DOUBLE NOT NULL,
  `anulado` TINYINT(1) NULL DEFAULT '0',
  `recibido` TINYINT(1) NULL DEFAULT '0',
  `entregado` TINYINT(1) NULL DEFAULT '0',
  `facturado` TINYINT(1) NULL DEFAULT '0',
  `nota` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_app_detalle_pedidos_app_pedidos1_idx` (`app_pedidos_id` ASC) VISIBLE,
  INDEX `fk_detalle_productro` (`productos_Codigo` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_pedido`
    FOREIGN KEY (`app_pedidos_id`)
    REFERENCES `floristeria`.`app_pedidos` (`id`),
  CONSTRAINT `fk_detalle_productro`
    FOREIGN KEY (`productos_Codigo`)
    REFERENCES `floristeria`.`productos` (`invPrdId`))
ENGINE = InnoDB
AUTO_INCREMENT = 219
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`clientes_direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`clientes_direcciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `direccion` TEXT NOT NULL,
  `creada` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `FK_clientes_direcciones_idcliente_idx` (`idcliente` ASC) VISIBLE,
  CONSTRAINT `FK_clientes_direcciones_idcliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `floristeria`.`clientes` (`idregistro`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`app_pedido_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`app_pedido_domicilio` (
  `app_pedidos_id` VARCHAR(5) NOT NULL,
  `clientes_direcciones_id` INT NOT NULL,
  PRIMARY KEY (`app_pedidos_id`),
  INDEX `fk_app_pedido_domicilio_app_pedidos1_idx` (`app_pedidos_id` ASC) VISIBLE,
  INDEX `fk_app_pedido_domicilio_clientes_direcciones1_idx` (`clientes_direcciones_id` ASC) VISIBLE,
  CONSTRAINT `fk_app_pedido_domicilio_clientes_direcciones1`
    FOREIGN KEY (`clientes_direcciones_id`)
    REFERENCES `floristeria`.`clientes_direcciones` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`app_pedidos_x_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`app_pedidos_x_ventas` (
  `ventas_idregistro` INT NOT NULL,
  `app_pedidos_id` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`ventas_idregistro`, `app_pedidos_id`),
  INDEX `fk_app_pedidos_x_ventas_ventas1_idx` (`ventas_idregistro` ASC) VISIBLE,
  INDEX `fk_app_pedidos_x_ventas_app_pedidos1_idx` (`app_pedidos_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`bitacora` (
  `bitacoracod` INT NOT NULL AUTO_INCREMENT,
  `bitacorafch` DATETIME NULL DEFAULT NULL,
  `bitprograma` VARCHAR(255) NULL DEFAULT NULL,
  `bitdescripcion` VARCHAR(255) NULL DEFAULT NULL,
  `bitobservacion` MEDIUMTEXT NULL DEFAULT NULL,
  `bitTipo` CHAR(3) NULL DEFAULT NULL,
  `bitusuario` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`bitacoracod`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `floristeria`.`carretilla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`carretilla` (
  `usercod` BIGINT NOT NULL,
  `invPrdId` VARCHAR(15) NOT NULL,
  `fchagregado` DATETIME NULL DEFAULT NULL,
  `cantidad` INT NOT NULL,
  `invPrdDsc` VARCHAR(300) NULL DEFAULT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `foto` VARCHAR(200) NULL DEFAULT NULL,
  `invPrdPrice` DECIMAL(5,0) NULL DEFAULT NULL,
  INDEX `usercod` (`usercod` ASC) VISIBLE,
  INDEX `carretill_fk_user_idx` (`invPrdId` ASC) VISIBLE,
  CONSTRAINT `carretill_fk_user`
    FOREIGN KEY (`invPrdId`)
    REFERENCES `floristeria`.`productos` (`invPrdId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `carretilla_ibfk_1`
    FOREIGN KEY (`usercod`)
    REFERENCES `floristeria`.`usuario` (`usercod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `floristeria`.`funciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`funciones` (
  `fncod` VARCHAR(255) NOT NULL,
  `fndsc` VARCHAR(45) NULL DEFAULT NULL,
  `fnest` CHAR(3) NULL DEFAULT NULL,
  `fntyp` CHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`fncod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `floristeria`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`roles` (
  `rolescod` VARCHAR(15) NOT NULL,
  `rolesdsc` VARCHAR(45) NULL DEFAULT NULL,
  `rolesest` CHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`rolescod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `floristeria`.`funciones_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`funciones_roles` (
  `rolescod` VARCHAR(15) NOT NULL,
  `fncod` VARCHAR(255) NOT NULL,
  `fnrolest` CHAR(3) NULL DEFAULT NULL,
  `fnexp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`rolescod`, `fncod`),
  INDEX `rol_funcion_key_idx` (`fncod` ASC) VISIBLE,
  CONSTRAINT `funcion_rol_key`
    FOREIGN KEY (`rolescod`)
    REFERENCES `floristeria`.`roles` (`rolescod`),
  CONSTRAINT `rol_funcion_key`
    FOREIGN KEY (`fncod`)
    REFERENCES `floristeria`.`funciones` (`fncod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `floristeria`.`roles_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `floristeria`.`roles_usuarios` (
  `usercod` BIGINT NOT NULL,
  `rolescod` VARCHAR(15) NOT NULL,
  `roleuserest` CHAR(3) NULL DEFAULT NULL,
  `roleuserfch` DATETIME NULL DEFAULT NULL,
  `roleuserexp` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`usercod`, `rolescod`),
  INDEX `rol_usuario_key_idx` (`rolescod` ASC) VISIBLE,
  CONSTRAINT `rol_usuario_key`
    FOREIGN KEY (`rolescod`)
    REFERENCES `floristeria`.`roles` (`rolescod`),
  CONSTRAINT `usuario_rol_key`
    FOREIGN KEY (`usercod`)
    REFERENCES `floristeria`.`usuario` (`usercod`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
