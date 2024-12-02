create database Ferreteria;
use Ferreteria;
DROP TABLE IF EXISTS `categorias`;

CREATE TABLE `categorias` (
  `codCategoria` int AUTO_INCREMENT NOT NULL,
  `nombreCategoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codCategoria`)
) ;

LOCK TABLES `categorias` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `codFactura` int AUTO_INCREMENT NOT NULL,
  `fechaFactura` date DEFAULT NULL,
  `dniFactura` int DEFAULT NULL,
  `rtnFactura` int DEFAULT NULL,
  `impuestoFactura` int DEFAULT NULL,
  `subtotalFactura` int DEFAULT NULL,
  `totalFactura` int DEFAULT NULL,
  PRIMARY KEY (`codFactura`)
);

LOCK TABLES `factura` WRITE;

UNLOCK TABLES;


DROP TABLE IF EXISTS `funciones`;
CREATE TABLE `funciones` (
  `fnCod` int AUTO_INCREMENT NOT NULL,
  `fnDsc` varchar(40) DEFAULT NULL,
  `fnEst` varchar(20) DEFAULT NULL,
  `fnTyp` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`fnCod`),
  CONSTRAINT `fnCod` FOREIGN KEY (`fnCod`) REFERENCES `rolesfunciones` (`fnCod`)
);


LOCK TABLES `funciones` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `codProducto` int AUTO_INCREMENT NOT NULL,
  `CodCategoria` int DEFAULT NULL,
  `codProveedor` int DEFAULT NULL,
  `nombreProducto` varchar(50) DEFAULT NULL,
  `Stock` varchar(50) DEFAULT NULL,
  `precioVenta` int DEFAULT NULL,
  `precioCompra` int DEFAULT NULL,
  `fechaCompra` date DEFAULT NULL,
  PRIMARY KEY (`codProducto`),
  KEY `CodCategoria` (`CodCategoria`),
  KEY `codProveedor` (`codProveedor`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`CodCategoria`) REFERENCES `categorias` (`codCategoria`),
  CONSTRAINT `productos_ibfk_3` FOREIGN KEY (`codProveedor`) REFERENCES `proveedores` (`codProveedores`)
);


LOCK TABLES `productos` WRITE;

UNLOCK TABLES;


DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores` (
  `codProveedores` int AUTO_INCREMENT NOT NULL,
  `nombreProveedor` varchar(50) DEFAULT NULL,
  `contactoProveedor` int DEFAULT NULL,
  `emailProveedor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codProveedores`)
);


LOCK TABLES `proveedores` WRITE;

UNLOCK TABLES;




DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `rolesCod` int AUTO_INCREMENT NOT NULL,
  `rolesDsc` varchar(20) DEFAULT NULL,
  `rolesEst` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rolesCod`)
);

LOCK TABLES `roles` WRITE;

UNLOCK TABLES;


DROP TABLE IF EXISTS `rolesfunciones`;

CREATE TABLE `rolesfunciones` (
  `rolesCod_rf` int AUTO_INCREMENT NOT NULL,
  `fnCod` int NOT NULL,
  `fnRolEst` varchar(20) DEFAULT NULL,
  `fnExp` date DEFAULT NULL,
  PRIMARY KEY (`fnCod`,`rolesCod_rf`),
  KEY `rolesCod_rf_idx` (`rolesCod_rf`),
  CONSTRAINT `rolesCod_rf` FOREIGN KEY (`rolesCod_rf`) REFERENCES `roles` (`rolesCod`)
);


LOCK TABLES `rolesfunciones` WRITE;

UNLOCK TABLES;



DROP TABLE IF EXISTS `rolesusuarios`;
CREATE TABLE `rolesusuarios` (
  `userCod` int AUTO_INCREMENT NOT NULL,
  `rolesCod` int NOT NULL,
  `roleUserEst` varchar(40) DEFAULT NULL,
  `roleUserFch` date DEFAULT NULL,
  `roleUserExp` date DEFAULT NULL,
  PRIMARY KEY (`userCod`,`rolesCod`),
  KEY `rolesCod_idx` (`rolesCod`),
  CONSTRAINT `rolesCod` FOREIGN KEY (`rolesCod`) REFERENCES `roles` (`rolesCod`),
  CONSTRAINT `userCod` FOREIGN KEY (`userCod`) REFERENCES `usuario` (`userCod`)
);

LOCK TABLES `rolesusuarios` WRITE;

UNLOCK TABLES;

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `userCod` int AUTO_INCREMENT NOT NULL,
  `userEmail` varchar(40) DEFAULT NULL,
  `userName` varchar(40) DEFAULT NULL,
  `userApellido` varchar(40) DEFAULT NULL,
  `userPswd` varchar(20) DEFAULT NULL,
  `userFching` varchar(20) DEFAULT NULL,
  `userPswdexp` varchar(20) DEFAULT NULL,
  `userEst` varchar(20) DEFAULT NULL,
  `userActCod` int DEFAULT NULL,
  `userPswdchg` varchar(20) DEFAULT NULL,
  `userTipo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userCod`)
) ;

LOCK TABLES `usuario` WRITE;

UNLOCK TABLES;


DROP TABLE IF EXISTS `ventadetalle`;

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
  CONSTRAINT `ventadetalle_ibfk_1` FOREIGN KEY (`CodFactura`) REFERENCES `factura` (`codFactura`)
);

LOCK TABLES `ventadetalle` WRITE;

UNLOCK TABLES;
CREATE USER 'ferreteria'@'localhost' IDENTIFIED BY 'ferreteria11';
GRANT SELECT, INSERT, UPDATE, DELETE ON ferreteria.* TO 'ferreteria'@'localhost';

