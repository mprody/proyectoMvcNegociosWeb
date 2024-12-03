<?php
session_start();
$mensaje = "";

if (isset($_POST["btnAccion"])) {

    switch ($_POST["btnAccion"]) {
        case "Agregar":
            if (is_numeric(openssl_decrypt($_POST["ID"], COD, KEY))) {
                $ID = openssl_decrypt($_POST["ID"], COD, KEY);
                $mensaje .= "Codigo Producto Correcto " . $ID . "<br/>";
            } else {
                $mensaje .= "Codigo Producto Incorrecto " . $ID . "<br/>";
                break;
            }
            if (is_string(openssl_decrypt($_POST["Nombre"], COD, KEY))) {
                $NOMBRE = openssl_decrypt($_POST["Nombre"], COD, KEY);
                $mensaje .= "Nombre Producto Correcto " . $NOMBRE . "<br/>";
            } else {
                $mensaje .= "Nombre Producto Incorrecto " . $NOMBRE . "<br/>";
                break;
            }
            if (is_numeric(openssl_decrypt($_POST["Cantidad"], COD, KEY))) {
                $CANTIDAD = openssl_decrypt($_POST["Cantidad"], COD, KEY);
                $mensaje .= "Cantidad Correcto " . $PRECIO . "<br/>";
            } else {
                $mensaje .= "Cantidad Incorrecto " . $PRECIO . "<br/>";
                break;
            }
            if (is_numeric(openssl_decrypt($_POST["Precio"], COD, KEY))) {
                $PRECIO = openssl_decrypt($_POST["Precio"], COD, KEY);
                $mensaje .= "Precio Venta Correcto " . $PRECIO . "<br/>";
            } else {
                $mensaje .= "Precio Venta Incorrecto " . $PRECIO . "<br/>";
                break;
            }


            if (!isset($_SESSION["CARRITO"])) {
                $producto = array(
                    "ID" => $ID,
                    "NOMBRE" => $NOMBRE,
                    "CANTIDAD" => $CANTIDAD,
                    "PRECIO" => $PRECIO
                );
                $_SESSION["CARRITO"][0] = $producto;
            } else {
                $NumeroProductos = count($_SESSION["CARRITO"]);
                $producto = array(
                    "ID" => $ID,
                    "NOMBRE" => $NOMBRE,
                    "CANTIDAD" => $CANTIDAD,
                    "PRECIO" => $PRECIO
                );
                $_SESSION["CARRITO"][$NumeroProductos] = $producto;
            }
            $mensaje = print_r($_SESSION, true);

            break;
            case "Eliminar":
                if (is_numeric(openssl_decrypt($_POST["ID"], COD, KEY))) {
                    $ID = openssl_decrypt($_POST["ID"], COD, KEY);
                    $mensaje .= "Codigo Producto Correcto " . $ID . "<br/>";
                    foreach($_SESSION["CARRITO"] as $indice=>$producto){
                        if($producto["ID"]==$ID){
                            unset($_SESSION["CARRITO"][$indice]);
                            echo "<script>alert('Elemento Borrado...');</script>";
                        }
                    }
                } else {
                    $mensaje .= "Codigo Producto Incorrecto " . $ID . "<br/>";
                break;
            }
            break;
    }
}
