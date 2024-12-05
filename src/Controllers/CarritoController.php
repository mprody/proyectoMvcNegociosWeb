<?php
namespace Controllers;

use Views\Renderer;
use Controllers\PublicController;

class CarritoController extends PublicController
{
    public function run(): void
    {
        $action = $_GET['action'] ?? 'view';

        switch ($action) {
            case 'add':
                $this->agregarProducto(
                    $_POST['id'] ?? null,
                    $_POST['nombre'] ?? null,
                    $_POST['precio'] ?? null,
                    intval($_POST['cantidad'] ?? 1)
                );
                header("Location: index.php?page=CarritoController&action=view");
                exit;
            case 'view':
                $this->mostrarCarrito();
                break;
            case 'pagar':
                $this->pagar();
                header("Location: index.php?page=productos-catalogo");
                exit;
            default:
                header("Location: index.php?page=productos-catalogo");
                exit;
        }
    }

    private function agregarProducto($id, $nombre, $precio, $cantidad): void
    {
        if (!$id || !$nombre || !$precio || $cantidad <= 0) {
            return; // Validación básica para evitar datos inválidos
        }

        if (!isset($_SESSION['carrito'])) {
            $_SESSION['carrito'] = [];
        }

        $productoExiste = false;

        foreach ($_SESSION['carrito'] as &$producto) {
            if ($producto['id'] === $id) {
                // Si el producto ya existe, incrementar la cantidad
                $producto['cantidad'] += $cantidad;
                $productoExiste = true;
                break;
            }
        }

        if (!$productoExiste) {
            // Si el producto no existe, agregarlo como nuevo
            $_SESSION['carrito'][] = [
                'id' => $id,
                'nombre' => $nombre,
                'precio' => $precio,
                'cantidad' => $cantidad
            ];
        }
    }

    private function mostrarCarrito(): void
    {
        $carrito = $_SESSION['carrito'] ?? [];
        $total = array_reduce($carrito, function ($carry, $item) {
            return $carry + ($item['precio'] * $item['cantidad']);
        }, 0);

        Renderer::render('carrito', [
            'productos' => $carrito,
            'total' => $total
        ]);
    }

    private function pagar(): void
    {
        $_SESSION['carrito'] = []; // Vaciar el carrito después del pago
    }
}
