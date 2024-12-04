CREATE TABLE `productos` (
    `codProducto` int(11) NOT NULL AUTO_INCREMENT,
    `nombreProducto` varchar(200) DEFAULT NULL,
    `Descripcion` varchar(225) DEFAULT NULL,
    `CodCategoria` int(11) DEFAULT NULL,
    `codProveedor` int(11) DEFAULT NULL,
    `Stock` varchar(50) DEFAULT NULL,
    `precioVenta` decimal(20, 2) DEFAULT NULL,
    `precioCompra` decimal(20, 2) DEFAULT NULL,
    `fechaCompra` date DEFAULT NULL,
    `Imagen` varchar(200) DEFAULT NULL,
    PRIMARY KEY (`codProducto`)
)