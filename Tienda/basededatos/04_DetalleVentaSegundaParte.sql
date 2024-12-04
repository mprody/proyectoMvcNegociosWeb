CREATE TABLE `DetalleVentaSegundaParte` (
    `ID` INT(11) NOT NULL AUTO_INCREMENT,
    `IdVenta` INT(11),
    `IdProducto` INT(11),
    `PrecioUnitario` DECIMAL(20,2),
    `Cantidad` INT(11),
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`IdVenta`) REFERENCES `ventadetalle`(`ID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (`IdProducto`) REFERENCES `productos`(`codProducto`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);