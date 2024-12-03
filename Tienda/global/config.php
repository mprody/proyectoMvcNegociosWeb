<?php
//Aqui encriptamos
define("KEY", "ElMasDuro");
define("COD", "AES-128-ECB");
//Aqui le decimos como conextar la BD
define("SERVIDOR","localHost");
define("USUARIO","root");
define("PASSWORD","");
define("BD","seguridad");

/*ESta es otra forma de conectarse a la BD

$connection = New Mysql("localHost","root","contraseña","seguridad")

*/
?>