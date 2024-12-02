-- Create the database schema
CREATE DATABASE IF NOT EXISTS `ferreteria`
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;

-- Use the created database
USE `ferreteria`;

-- Create a user and grant privileges
CREATE USER IF NOT EXISTS 'ferreteria'@'%' IDENTIFIED BY 'ferreteria';
GRANT SELECT, INSERT, UPDATE, DELETE ON `ferreteria`.* TO 'ferreteria'@'%';

CREATE TABLE `usuario` (
    `usercod` BIGINT(10) NOT NULL AUTO_INCREMENT,
    `useremail` VARCHAR(80) DEFAULT NULL,
    `username` VARCHAR(80) DEFAULT NULL,
    `userpswd` VARCHAR(128) DEFAULT NULL,
    `userfching` DATETIME DEFAULT NULL,
    `userpswdest` CHAR(3) DEFAULT NULL,
    `userpswdexp` DATETIME DEFAULT NULL,
    `userest` CHAR(3) DEFAULT NULL,
    `useractcod` VARCHAR(128) DEFAULT NULL,
    `userpswdchg` VARCHAR(128) DEFAULT NULL,
    `usertipo` CHAR(3) DEFAULT NULL COMMENT 'Tipo de Usuario: Cliente, Administrador, Supervisor',
    PRIMARY KEY (`usercod`),
    UNIQUE KEY `useremail_UNIQUE` (`useremail`),
    KEY `usertipo` (`usertipo`, `useremail`, `usercod`, `userest`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE
    `roles` (
        `rolescod` varchar(128) NOT NULL,
        `rolesdsc` varchar(45) DEFAULT NULL,
        `rolesest` char(3) DEFAULT NULL,
        PRIMARY KEY (`rolescod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `roles_usuarios` (
        `usercod` bigint(10) NOT NULL,
        `rolescod` varchar(128) NOT NULL,
        `roleuserest` char(3) DEFAULT NULL,
        `roleuserfch` datetime DEFAULT NULL,
        `roleuserexp` datetime DEFAULT NULL,
        PRIMARY KEY (`usercod`, `rolescod`),
        KEY `rol_usuario_key_idx` (`rolescod`),
        CONSTRAINT `rol_usuario_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `usuario_rol_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `funciones` (
        `fncod` varchar(255) NOT NULL,
        `fndsc` varchar(255) DEFAULT NULL,
        `fnest` char(3) DEFAULT NULL,
        `fntyp` char(3) DEFAULT NULL,
        PRIMARY KEY (`fncod`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `funciones_roles` (
        `rolescod` varchar(128) NOT NULL,
        `fncod` varchar(255) NOT NULL,
        `fnrolest` char(3) DEFAULT NULL,
        `fnexp` datetime DEFAULT NULL,
        PRIMARY KEY (`rolescod`, `fncod`),
        KEY `rol_funcion_key_idx` (`fncod`),
        CONSTRAINT `funcion_rol_key` FOREIGN KEY (`rolescod`) REFERENCES `roles` (`rolescod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `rol_funcion_key` FOREIGN KEY (`fncod`) REFERENCES `funciones` (`fncod`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `bitacora` (
        `bitacoracod` int(11) NOT NULL AUTO_INCREMENT,
        `bitacorafch` datetime DEFAULT NULL,
        `bitprograma` varchar(255) DEFAULT NULL,
        `bitdescripcion` varchar(255) DEFAULT NULL,
        `bitobservacion` mediumtext,
        `bitTipo` char(3) DEFAULT NULL,
        `bitusuario` bigint(18) DEFAULT NULL,
        PRIMARY KEY (`bitacoracod`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8;

CREATE TABLE `categorias` (
  `codCategoria` int NOT NULL,
  `nombreCategoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `factura` (
    `codFactura` INT NOT NULL,
    `fechaFactura` DATE DEFAULT NULL,
    `dniFactura` INT DEFAULT NULL,
    `rtnFactura` INT DEFAULT NULL,
    `impuestoFactura` INT DEFAULT NULL,
    `subtotalFactura` INT DEFAULT NULL,
    `totalFactura` INT DEFAULT NULL,
    `usercod` BIGINT(10) NOT NULL, -- Clave foránea hacia `usuario`
    PRIMARY KEY (`codFactura`),
    CONSTRAINT `fk_factura_usuario` FOREIGN KEY (`usercod`) REFERENCES `usuario`(`usercod`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productos` (
  `codProducto` int NOT NULL,
  `CodCategoria` int DEFAULT NULL,
  `codProFactura` int DEFAULT NULL,
  `codProveedor` int DEFAULT NULL,
  `nombreProducto` varchar(50) DEFAULT NULL,
  `Stock` varchar(50) DEFAULT NULL,
  `precioVenta` int DEFAULT NULL,
  `precioCompra` int DEFAULT NULL,
  `fechaCompra` date DEFAULT NULL,
  PRIMARY KEY (`codProducto`),
  KEY `CodCategoria` (`CodCategoria`),
  KEY `codProFactura` (`codProFactura`),
  KEY `codProveedor` (`codProveedor`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`CodCategoria`) REFERENCES `categorias` (`codCategoria`),
  CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`codProFactura`) REFERENCES `factura` (`codFactura`),
  CONSTRAINT `productos_ibfk_3` FOREIGN KEY (`codProveedor`) REFERENCES `proveedores` (`codProveedores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `proveedores` (
  `codProveedores` int NOT NULL,
  `nombreProveedor` varchar(50) DEFAULT NULL,
  `contactoProveedor` int DEFAULT NULL,
  `emailProveedor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codProveedores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reportes` (
  `CodAdjudicacion` int NOT NULL,
  PRIMARY KEY (`CodAdjudicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ventadetalle` (
  `CodFactura` int NOT NULL,
  `CodAdjudicacion` int DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `CodigoProductos` int DEFAULT NULL,
  `Producto` varchar(50) DEFAULT NULL,
  `precioVenta` int DEFAULT NULL,
  `Cantidad` int DEFAULT NULL,
  KEY `CodFactura` (`CodFactura`),
  KEY `CodAdjudicacion` (`CodAdjudicacion`),
  CONSTRAINT `ventadetalle_ibfk_1` FOREIGN KEY (`CodFactura`) REFERENCES `factura` (`codFactura`),
  CONSTRAINT `ventadetalle_ibfk_2` FOREIGN KEY (`CodAdjudicacion`) REFERENCES `reportes` (`CodAdjudicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;