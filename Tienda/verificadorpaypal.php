<?php
print_r($_GET);

$ClientID = "AXLQBD6JjgWuaGX4Izd5K3VqCeoE_dMPG4AFjNQyawgOx-406eMc1syHxQ1U0qNmDBPUgUgamhkmOPz_";
$Secret = "ELU41NPT5QDdzW9q-ymR9ob8bGV43Og7yWt0uy24nh-lqzg25jcIwdSFdC_oWGN9tsZ3IeSTdlp9AGBJ";

$Login = curl_init("https://api-m.sandbox.paypal.com/v1/oauth2/token");
curl_setopt($Login, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($Login, CURLOPT_USERPWD, $ClientID . ":" . $Secret);
curl_setopt($Login, CURLOPT_POSTFIELDS, "grant_type=client_credentials");
$Respuesta = curl_exec($Login);
$objRespuesta = json_decode($Respuesta);
$AccessToken = $objRespuesta->access_token;

print_r($AccessToken);

$venta = curl_init("https://api-m.sandbox.paypal.com/v1/payments/payment/" . $_GET['paymentID']);

curl_setopt($venta, CURLOPT_HTTPHEADER, array("Content-Type: application/json", "Authorization: Bearer" . $AccessToken));

$RespuestaVenta = curl_exec($venta);

print_r($RespuestaVenta);
?>