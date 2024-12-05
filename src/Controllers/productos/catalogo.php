<?php

namespace Controllers\productos;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Productos\productosD;

class catalogo extends PublicController {
    public function run(): void {
        try {
            // Iniciar sesión si no está iniciada
            if (session_status() == PHP_SESSION_NONE) {
                session_start();
            }

            // Obtener los productos
            $productosData = productosD::obtenerProductos();

            $viewProductos = [];

            // Procesar cada producto
            foreach ($productosData as $producto) {
                // Verificar que existan todas las claves necesarias
                if (!isset($producto["codProducto"]) ||
                    !isset($producto["nombreProducto"]) ||
                    !isset($producto["Stock"]) ||
                    !isset($producto["precioVenta"])) {
                    continue;
                }

                $hasStock = intval($producto["Stock"]) > 0;

                $viewProductos[] = array(
                    "codProducto" => $producto["codProducto"],
                    "nombreProducto" => $producto["nombreProducto"],
                    "precioVenta" => number_format(floatval($producto["precioVenta"]), 2),
                    "Stock" => intval($producto["Stock"]),
                    "hasStock" => $hasStock
                );
            }

            // Preparar datos para la vista
            $viewData = [
                "productos" => $viewProductos,
                "hasProducts" => !empty($viewProductos)
            ];

            // Renderizar vista
            Renderer::render('productos/catalogo', $viewData);

        } catch (\Exception $e) {
            // Manejo de excepciones
            error_log("ERROR en catalogo::run: " . $e->getMessage());
            error_log("TRACE: " . $e->getTraceAsString());

            $viewData = [
                "productos" => [],
                "hasProducts" => false,
                "error" => "Error al cargar los productos: " . $e->getMessage()
            ];

            Renderer::render('productos/catalogo', $viewData);
        }
    }
}
