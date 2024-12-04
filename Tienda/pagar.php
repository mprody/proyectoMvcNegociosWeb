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

<div class="jumbotron text-center">
    <h1 class="display-4">Este es el paso Final</h1>
    <hr class="my-4">
    <p class="lead"> Estas a Punto de Pagar con Paypal la Cantidad De:
    <h4>LPS <?php echo number_format($total, 2); ?></h4>
    </p>
    <p>Te daremos los productos cuando se procese el pago</br>
        <strong>(Para aclaraciones: TEL +504 XXXX-XXXX)</strong>
    </p>
</div>

<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Add meta tags for mobile and IE -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title> PayPal Checkout Integration | Horizontal Buttons </title>
</head>

<body>
    <!-- Set up a container element for the button -->
    <div id="paypal-button-container"></div>

    <!-- Include the PayPal JavaScript SDK -->
    <script src="https://www.paypal.com/sdk/js?client-id=test&currency=USD"></script>

    <script>
        // Render the PayPal button into #paypal-button-container
        paypal.Buttons({
            style: {
                layout: 'horizontal'
            },

            // Call your server to set up the transaction
            createOrder: function(data, actions) {
                return fetch('/demo/checkout/api/paypal/order/create/', {
                    method: 'post'
                }).then(function(res) {
                    return res.json();
                }).then(function(orderData) {
                    return orderData.id;
                });
            },

            // Call your server to finalize the transaction
            onApprove: function(data, actions) {
                return fetch('/demo/checkout/api/paypal/order/' + data.orderID + '/capture/', {
                    method: 'post'
                }).then(function(res) {
                    return res.json();
                }).then(function(orderData) {
                    // Three cases to handle:
                    //   (1) Recoverable INSTRUMENT_DECLINED -> call actions.restart()
                    //   (2) Other non-recoverable errors -> Show a failure message
                    //   (3) Successful transaction -> Show confirmation or thank you

                    // This example reads a v2/checkout/orders capture response, propagated from the server
                    // You could use a different API or structure for your 'orderData'
                    var errorDetail = Array.isArray(orderData.details) && orderData.details[0];

                    if (errorDetail && errorDetail.issue === 'INSTRUMENT_DECLINED') {
                        return actions.restart(); // Recoverable state, per:
                        // https://developer.paypal.com/docs/checkout/integration-features/funding-failure/
                    }

                    if (errorDetail) {
                        var msg = 'Sorry, your transaction could not be processed.';
                        if (errorDetail.description) msg += '\n\n' + errorDetail.description;
                        if (orderData.debug_id) msg += ' (' + orderData.debug_id + ')';
                        return alert(msg); // Show a failure message (try to avoid alerts in production environments)
                    }

                    // Successful capture! For demo purposes:
                    console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                    var transaction = orderData.purchase_units[0].payments.captures[0];
                    alert('Transaction ' + transaction.status + ': ' + transaction.id + '\n\nSee console for all available details');

                    // Replace the above to show a success message within this page, e.g.
                    // const element = document.getElementById('paypal-button-container');
                    // element.innerHTML = '';
                    // element.innerHTML = '<h3>Thank you for your payment!</h3>';
                    // Or go to another URL:  actions.redirect('thank_you.html');
                });
            }
        }).render('#paypal-button-container');
    </script>
</body>

</html>

<?php
include "templates/footer.php"
?>