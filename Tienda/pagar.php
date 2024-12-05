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
    $idVenta = $pdo->lastInsertId();

    foreach ($_SESSION["CARRITO"] as $indice => $producto) {

        $sentencia = $pdo->prepare("INSERT INTO
    `detalleventasegundaparte`(`ID`, `IdVenta`, `IdProducto`, `PrecioUnitario`, `Cantidad`)
    VALUES (NULL, :IdVenta, :IdProducto, :PrecioUnitario, :Cantidad);");

        $sentencia->bindParam(":IdVenta", $idVenta);
        $sentencia->bindParam(":IdProducto", $producto['ID']);
        $sentencia->bindParam(":PrecioUnitario", $producto['PRECIO']);
        $sentencia->bindParam(":Cantidad", $producto['CANTIDAD']);
        $sentencia->execute();
    }
}
?>

<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<style>
    /* Media query for mobile viewport */
    @media screen and (max-width: 400px) {
        #paypal-button-container {
            width: 100%;
        }
    }

    /* Media query for desktop viewport */
    @media screen and (min-width: 400px) {
        #paypal-button-container {
            width: 250px;
            display: inline-block;
        }
    }
</style>

<div class="jumbotron text-center">
    <h1 class="display-4">Este es el paso Final</h1>
    <hr class="my-4">
    <p class="lead"> Estas a Punto de Pagar con Paypal la Cantidad De:
    <h4>LPS <?php echo number_format($total, 2); ?></h4>
    <div id="paypal-button-container"></div>
    </p>
    <p>Te daremos los productos cuando se procese el pago</br>
        <strong>(Para aclaraciones: TEL +504 XXXX-XXXX)</strong>
    </p>
</div>


<script>
    paypal.Button.render({
        env: 'sandbox', // sandbox | production
        style: {
            label: 'checkout', // checkout | credit | pay | buynow | generic
            size: 'responsive', // small | medium | large | responsive
            shape: 'pill', // pill | rect
            color: 'gold' // gold | blue | silver | black
        },

        // PayPal Client IDs - replace with your own
        // Create a PayPal app: https://developer.paypal.com/developer/applications/create

        client: {
            sandbox: 'AXLQBD6JjgWuaGX4Izd5K3VqCeoE_dMPG4AFjNQyawgOx-406eMc1syHxQ1U0qNmDBPUgUgamhkmOPz_',
            production: ''
        },

        // Wait for the PayPal button to be clicked

        payment: function(data, actions) {
            return actions.payment.create({
                payment: {
                    transactions: [{
                        amount: {
                            total: '<?php echo $total; ?>',
                            currency: 'LPS'
                        },
                    }]
                }
            });
        },

        // Wait for the payment to be authorized by the customer

        onAuthorize: function(data, actions) {
            return actions.payment.execute().then(function() {
                window.alert('Pago Completado');
            });
        }

    }, '#paypal-button-container');
</script>

<?php
include "templates/footer.php"
?>