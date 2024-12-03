<?php
include "global/config.php";
include "global/conexion.php";
include "carrito.php";
include "templates/header.php";
?>

<br>
<?php if ($mensaje != "") { ?>
    <div class="alert alert-success">
        <?php echo $mensaje; ?>
        <a href="showCarrito.php" class="badge badge-success">Ver Carrito</a>
    </div>
<?php } ?>


<div class="row">
    <?php
    /*Aqui conectamos la BD*/
    $sentencia = $pdo->prepare("SELECT * FROM `productos`");
    $sentencia->execute();
    $listaProductos = $sentencia->fetchAll(PDO::FETCH_ASSOC);
    //print_r($listaProductos);
    ?>

    <?php
    /*Aqui seeccionamos que queremos la tabla productos*/
    //Desde el Col-3 se crea la tarjetita
    foreach ($listaProductos as $producto) { ?>
        <div class="col-3">
            <div class="card">
                <img
                    title="<?php echo $producto['nombreProducto']; ?>"
                    alt="<?php echo $producto['nombreProducto']; ?>"
                    class="card-img-top"
                    src="imagenes/<?php echo $producto['Imagen']; ?>"
                    height="317px">
                <div class="card-body">
                    <span><?php echo $producto['nombreProducto']; ?></span>
                    <h5 class="card-title">LPS <?php echo $producto['precioVenta']; ?></h5>

                    <form action="" method="post">
                        /*Aqui se mandan los datos al carrito mas se encriptan*/
                        <input type="text" name="ID" id="ID" value="<?php echo openssl_encrypt($producto['codProducto'], COD, KEY); ?>">
                        <input type="hidden" name="Nombre" id="Nombre" value="<?php echo openssl_encrypt($producto['nombreProducto'], COD, KEY); ?>">
                        <input type="hidden" name="Precio" id="Precio" value="<?php echo openssl_encrypt($producto['precioVenta'], COD, KEY); ?>">
                        <input type="hidden" name="Cantidad" id="Cantidad" value="<?php echo openssl_encrypt(1, COD, KEY); ?>">

                        <button class="btn btn-primary"
                            name="btnAccion"
                            value="Agregar"
                            type="submit">Agregar al carrito
                        </button>
                    </form>
                </div>
            </div>
        </div>
    <?php } ?>
</div>

<?php
include "templates/footer.php"
?>