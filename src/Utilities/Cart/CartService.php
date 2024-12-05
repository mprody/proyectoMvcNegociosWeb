<?php
namespace Utilities\Cart;

use Dao\productos\productosD;

class CartService
{
    public static function getProductDetails($productId)
    {
        // Obtener detalles del producto desde la base de datos
        return productosD::obtenerProductoPorId($productId);
    }

    public static function calculateTotal($items)
    {
        $total = 0;
        foreach ($items as $item) {
            $total += $item['subtotal'];
        }
        return $total;
    }

    public static function validateStock($productId, $cantidad)
    {
        $producto = self::getProductDetails($productId);
        if ($producto && isset($producto['Stock'])) {
            return $producto['Stock'] >= $cantidad;
        }
        return false;
    }
}