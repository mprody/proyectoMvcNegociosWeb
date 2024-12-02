<?php 
namespace Controllers\productos;

use Controllers\PublicController;
use Views\Renderer;
use Dao\Productos\productosD;

class catalogo extends PublicController{
    public function run():void{
        $productosD=productosD::obtenerProductos();
        $viewProductos=[];

        foreach($productosD as $producto){
            $viewProducto[]=$producto;
        }
        $viewData=[
            "productos"=>$viewProducto
        ];
        Renderer::render('productos/catalogo',$viewData);
    }
}
?>