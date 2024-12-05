<?php

namespace Dao\Productos;

use Dao\Table;

class productosD extends Table
{
    public static function obtenerProductos()
    {
        try {
            $sqlstr = 'SELECT 
                          p.codProducto,
                          p.nombreProducto,
                          p.Stock,
                          p.precioVenta,
                          c.nombreCategoria
                      FROM productos p
                      LEFT JOIN categorias c ON p.CodCategoria = c.codCategoria
                      ORDER BY p.nombreProducto';

            // Eliminamos los echo y print_r de depuración
            $productos = self::obtenerRegistros($sqlstr, []);

            return $productos;

        } catch (\Exception $e) {
            // Utilizamos error_log para registrar errores sin afectar la salida
            error_log("ERROR en productosD::obtenerProductos: " . $e->getMessage());
            error_log("TRACE: " . $e->getTraceAsString());
            throw $e;
        }
    }

    public static function obtenerProductoPorId($productId)
    {
        try {
            $sqlstr = 'SELECT 
                          p.*,
                          c.nombreCategoria
                      FROM productos p
                      LEFT JOIN categorias c ON p.CodCategoria = c.codCategoria
                      WHERE p.codProducto = :productId';

            $params = ["productId" => $productId];
            $producto = self::obtenerUnRegistro($sqlstr, $params);

            return $producto;

        } catch (\Exception $e) {
            error_log("ERROR en productosD::obtenerProductoPorId: " . $e->getMessage());
            error_log("TRACE: " . $e->getTraceAsString());
            throw $e;
        }
    }
}
