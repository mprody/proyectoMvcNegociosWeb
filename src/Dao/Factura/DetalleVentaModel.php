<?php

namespace Dao\Factura;

use Dao\Table;

class DetalleVentaModel extends Table
{
    public static function obtenerDetallesPorFactura($codFactura)
    {
        $sqlstr = "SELECT CodigoProductos, Producto, precioVenta, Cantidad
                   FROM ventadetalle
                   WHERE CodFactura = :codFactura;";
        $detalle = self::obtenerRegistros($sqlstr, ["codFactura" => $codFactura]);
        return $detalle;
    }
}
