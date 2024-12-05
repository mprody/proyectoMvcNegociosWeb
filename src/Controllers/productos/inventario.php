<?php 

namespace Controllers\productos;

use Controllers\PublicController;
use Dao\Productos\productosD;
use Views\Renderer;

class inventario extends PublicController
{
    public function run():void
    {
        try {
            // Obtener productos
            $productos = productosD::obtenerProductos();
            
            // Preparar datos para la vista
            $viewData = [
                "productos" => $productos, // No necesitamos el foreach, pasamos directamente el array
                "hasProductos" => count($productos) > 0
            ];

            // Renderizar vista
            Renderer::render('productos/inventario', $viewData);
            
        } catch (\Exception $e) {
            error_log("Error en inventario: " . $e->getMessage());
            $viewData = [
                "productos" => [],
                "hasProductos" => false,
                "error" => "Error al cargar los productos"
            ];
            Renderer::render('productos/inventario', $viewData);
        }
    }
}

?>