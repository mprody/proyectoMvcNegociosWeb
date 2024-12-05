<?php

namespace Dao\Factura;

use Dao\Table;

class FacturaModel extends Table
{
    public static function obtenerFacturaPorCodigo($codFactura)
    {
        $sqlstr = "SELECT codFactura, fechaFactura, dniFactura, rtnFactura, impuestoFactura, subtotalFactura, totalFactura  FROM factura WHERE codFactura = :codFactura;";
        $factura = self::obtenerUnRegistro($sqlstr, ["codFactura" => $codFactura]);
        return $factura;
    }

    public static function obtenerNombreCliente($codFactura)
    {
        $sqlstr = "SELECT u.username FROM usuario AS u INNER JOIN factura AS f ON u.usercod = f.usercod WHERE codFactura = :codFactura;";
        $nombreCliente = self::obtenerUnRegistro($sqlstr, ["codFactura" => $codFactura]);
        return $nombreCliente;
    }
}
