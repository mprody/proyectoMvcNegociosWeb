<?php

namespace Controllers;

use Dao\Productos\ProductosD;

class Index extends PublicController
{
    /**
     *
     * @return void
     */
    public function run(): void
    {

        $productosData = ProductosD::obtenerProductos();


        usort($productosData, function ($a, $b) {
            return $a['codProducto'] - $b['codProducto'];
        });


        $processProducts = function ($products) {
            return array_map(function ($product) {
                $product['precioOriginal'] = $product['precioVenta'] + 100;
                return $product;
            }, $products);
        };


        $viewData = array(
            "productsHighlighted" => array_slice($productosData, 0, 4),
            "productsOnSale" => $processProducts(array_slice($productosData, 4, 4)),
            "productsNew" => array_slice($productosData, -4)
        );

        \Views\Renderer::render("index", $viewData);
    }
}
?>