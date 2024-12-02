<?php 
namespace Dao\Productos;
use Dao\Table;

class productosD extends Table{
    
    public static function obtenerProductos(){
        $sqlstr='select * from productos';
        $productos=self::obtenerRegistros($sqlstr,[]);
        return $productos;
    }
}

?>