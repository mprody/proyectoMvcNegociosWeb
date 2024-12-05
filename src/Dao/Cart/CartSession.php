<?php

namespace Dao\Cart;

class CartSession {
    const SUCCESS = 'SUCCESS';
    const ERROR = 'ERROR';

    public static function addToCart($productId, $name, $price, $quantity = 1)
    {
        try {
            // Validaciones
            if (!is_int($productId) || $productId <= 0) {
                return [
                    'status' => self::ERROR,
                    'message' => 'ID de producto no válido'
                ];
            }

            // Limpiar el precio (quitar comas y convertir a float)
            $price = (float) str_replace(',', '', $price);

            if (!is_numeric($price) || $price <= 0) {
                return [
                    'status' => self::ERROR,
                    'message' => 'Precio no válido'
                ];
            }

            $quantity = (int) $quantity;
            if (!is_int($quantity) || $quantity <= 0) {
                return [
                    'status' => self::ERROR,
                    'message' => 'Cantidad no válida'
                ];
            }

            if (!isset($_SESSION['cart'])) {
                $_SESSION['cart'] = [];
            }

            // Usar el ID como string para evitar problemas con tipos
            $cartId = (string)$productId;

            if (isset($_SESSION['cart'][$cartId])) {
                $_SESSION['cart'][$cartId]['quantity'] += $quantity;
            } else {
                $_SESSION['cart'][$cartId] = [
                    'id' => $productId,
                    'name' => $name,
                    'price' => $price,
                    'quantity' => $quantity,
                    'total' => $price * $quantity
                ];
            }

            // Recalcular total
            $_SESSION['cart'][$cartId]['total'] =
                $_SESSION['cart'][$cartId]['price'] * $_SESSION['cart'][$cartId]['quantity'];

            self::updateCartTotal();

            return [
                'status' => self::SUCCESS,
                'message' => 'Producto agregado al carrito',
                'data' => $_SESSION['cart'][$cartId]
            ];

        } catch (\Exception $e) {
            return [
                'status' => self::ERROR,
                'message' => 'Error al agregar al carrito: ' . $e->getMessage()
            ];
        }
    }

    private static function updateCartTotal()
    {
        $total = 0;
        if (isset($_SESSION['cart']) && is_array($_SESSION['cart'])) {
            foreach ($_SESSION['cart'] as $item) {
                if (isset($item['total']) && is_numeric($item['total'])) {
                    $total += $item['total'];
                }
            }
        }
        $_SESSION['cartTotal'] = $total;
    }

    public static function getCart()
    {
        // Limpiar cualquier entrada inválida
        if (isset($_SESSION['cart'])) {
            foreach ($_SESSION['cart'] as $key => $item) {
                if ($key === 'null' || $key === '' || is_null($key)) {
                    unset($_SESSION['cart'][$key]);
                }
            }
        }
        return isset($_SESSION['cart']) ? $_SESSION['cart'] : [];
    }

    public static function removeFromCart($productId)
    {
        try {
            $cartId = (string)$productId;
            if (!isset($_SESSION['cart'][$cartId])) {
                return [
                    'status' => self::ERROR,
                    'message' => 'Producto no encontrado en el carrito'
                ];
            }

            unset($_SESSION['cart'][$cartId]);
            self::updateCartTotal();

            return [
                'status' => self::SUCCESS,
                'message' => 'Producto eliminado del carrito'
            ];
        } catch (\Exception $e) {
            return [
                'status' => self::ERROR,
                'message' => 'Error al eliminar del carrito: ' . $e->getMessage()
            ];
        }
    }

    // Método para limpiar el carrito
    public static function clearCart()
    {
        try {
            $_SESSION['cart'] = [];
            $_SESSION['cartTotal'] = 0;

            return [
                'status' => self::SUCCESS,
                'message' => 'Carrito limpiado exitosamente'
            ];
        } catch (\Exception $e) {
            return [
                'status' => self::ERROR,
                'message' => 'Error al limpiar el carrito: ' . $e->getMessage()
            ];
        }
    }
}
