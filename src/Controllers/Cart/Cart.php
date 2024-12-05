<?php
/*
    Ubicación: src/Controllers/Cart/Cart.php
    Descripción: Controlador del carrito corregido con acciones 'add', 'remove' y 'clear'
*/

namespace Controllers\Cart;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Cart\CartSession;

class Cart extends PublicController
{
    private function jsonResponse($response)
    {
        header('Content-Type: application/json');
        echo json_encode($response);
        die();
    }

    public function run(): void
    {
        try {
            // Iniciar sesión si no está iniciada
            if (session_status() == PHP_SESSION_NONE) {
                session_start();
            }

            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $action = isset($_POST['action']) ? $_POST['action'] : '';

                // Registro de datos recibidos
                error_log("Acción recibida: " . $action);
                error_log("Datos POST: " . print_r($_POST, true));

                switch($action) {
                    case 'add':
                        if (!isset($_POST['productId'], $_POST['name'], $_POST['price'], $_POST['quantity'])) {
                            $this->jsonResponse([
                                'status' => 'ERROR',
                                'message' => 'Datos incompletos'
                            ]);
                            return;
                        }

                        // Limpiar y convertir datos
                        $productId = (int)$_POST['productId'];
                        $price = (float)str_replace(',', '', $_POST['price']);
                        $quantity = (int)$_POST['quantity'];

                        // Registro de validaciones
                        error_log("Datos después de validaciones: productId=" . $productId . ", price=" . $price . ", quantity=" . $quantity);

                        $response = CartSession::addToCart(
                            $productId,
                            strip_tags($_POST['name']),
                            $price,
                            $quantity
                        );

                        // Registro de la respuesta de addToCart
                        error_log("Respuesta de addToCart: " . print_r($response, true));

                        $this->jsonResponse($response);
                        break;

                    case 'remove':
                        if (!isset($_POST['productId'])) {
                            $this->jsonResponse([
                                'status' => 'ERROR',
                                'message' => 'ID de producto es requerido'
                            ]);
                            return;
                        }

                        $productId = (int)$_POST['productId'];

                        $response = CartSession::removeFromCart($productId);

                        // Registro de la respuesta de removeFromCart
                        error_log("Respuesta de removeFromCart: " . print_r($response, true));

                        $this->jsonResponse($response);
                        break;

                    case 'clear':
                        $response = CartSession::clearCart();

                        // Registro de la respuesta de clearCart
                        error_log("Respuesta de clearCart: " . print_r($response, true));

                        $this->jsonResponse($response);
                        break;

                    default:
                        $this->jsonResponse([
                            'status' => 'ERROR',
                            'message' => 'Acción no válida'
                        ]);
                        break;
                }
                return;
            }

            // Para GET - mostrar carrito
            $viewData = [
                'cart' => CartSession::getCart(),
                'cartTotal' => isset($_SESSION['cartTotal']) ? $_SESSION['cartTotal'] : 0
            ];

            Renderer::render('cart/cartview', $viewData);

        } catch (\Exception $e) {
            // Manejo de excepciones
            error_log("ERROR en Cart::run: " . $e->getMessage());
            error_log("TRACE: " . $e->getTraceAsString());

            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                $this->jsonResponse([
                    'status' => 'ERROR',
                    'message' => 'Error interno del servidor: ' . $e->getMessage()
                ]);
            } else {
                $viewData = [
                    'error' => 'Error al procesar el carrito: ' . $e->getMessage(),
                    'cart' => [],
                    'cartTotal' => 0
                ];
                Renderer::render('cart/cartview', $viewData);
            }
        }
    }
}
