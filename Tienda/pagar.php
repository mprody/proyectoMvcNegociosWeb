<?php
include "global/config.php";
include "global/conexion.php";
include "carrito.php";
include "templates/header.php";
?>

<?php
if ($_POST) {
    $total = 0;
    $SID = session_id();
    $Correo = $_POST['email'];
    foreach ($_SESSION["CARRITO"] as $indice => $producto) {
        $total = $total + ($producto['PRECIO'] * $producto['CANTIDAD']);
    }
    $sentencia = $pdo->prepare("INSERT INTO `ventadetalle` 
    (`ID`, `ClaveTrasaccion`, `PaypalDatos`, `PaypalFecha`, `Correo`, `Total`, `Status`, `CodFactura`, `CodAdjudicacion`, `Fecha`, `CodigoProductos`, `Producto`, `precioVenta`, `Cantidad`)
    VALUES (NULL, :ClaveTrasaccion, '', NOW(), :Correo, :Total, 'Pendiente', '', '', '', '', '', '', '');");

    $sentencia->bindParam(":ClaveTrasaccion", $SID);
    $sentencia->bindParam(":Correo", $Correo);
    $sentencia->bindParam(":Total", $total);
    $sentencia->execute();
    $idVenta=$pdo->lastInsertId();

    echo "<h3>" . $total . "</h3>";
}
?>















<?php
include "templates/footer.php"
?>