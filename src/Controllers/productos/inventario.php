<?php 
namespace Controllers\productos;

use Controllers\PublicController;
use Dao\Productos\productosD;
use Views\Renderer;

class inventario extends PublicController{
    public function run():void{
        $productosD=productosD::obtenerProductos();
        $viewProductos=[];

        foreach($productosD as $producto){
            $viewProducto[]=$producto;
        }
        $viewData=[
            "productos"=>$viewProducto
        ];
        Renderer::render('productos/inventario',$viewData);
    }
}

?>