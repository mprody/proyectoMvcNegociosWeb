CREATE TABLE `ventadetalle` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `ClaveTrasaccion`VARCHAR(250),
    `PaypalDatos` TEXT,
    `PaypalFecha` DATETIME,
    `Correo` VARCHAR(200),
    `Total` DECIMAL(60,2),
    `Status` VARCHAR(200),
    `CodFactura` int DEFAULT NULL,
    `CodAdjudicacion` int DEFAULT NULL,
    `Fecha` date DEFAULT NULL,
    `CodigoProductos` int DEFAULT NULL,
    `Producto` varchar(50) DEFAULT NULL,
    `precioVenta` int DEFAULT NULL,
    `Cantidad` int DEFAULT NULL,
    PRIMARY KEY(`ID`)
)