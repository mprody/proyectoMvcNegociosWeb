<?php 
namespace Dao\Productos;
use Dao\Table;

class productosD extends Table 
{
    public static function obtenerProductos()
    {
        $sqlstr = 'SELECT * FROM productos';
        return self::obtenerRegistros($sqlstr, []);
    }
}

?>