<?php

namespace Dao\Funciones;

use Dao\Table;

class Funciones extends Table
{
    public static function obtenerFunciones()
    {
        $sqlstr = 'SELECT * FROM funciones;';
        $funciones = self::obtenerRegistros($sqlstr, []);
        return $funciones;
    }

    public static function obtenerFuncionPorId($id)
    {
        $sqlstr = 'SELECT * from funciones where fncod=:fncod;';
        $funcion = self::obtenerUnRegistro($sqlstr, ["fncod" => $id]);
        return $funcion;
    }

    public static function agregarFuncion($funcion)
    {        
        $sqlstr = 'insert into  funciones (
            fncod, fndsc, fnest, fntyp ) values
        (
            :fncod, :fndsc, :fnest, :fntyp            
        );';
        return self::executeNonQuery($sqlstr, $funcion);
    }

    public static function actualizarFuncion($funcion)
    {        
        $sqlstr = "update funciones set fndsc = :fndsc, fnest = :fnest, fntyp = :fntyp where fncod = :fncod;";

        return self::executeNonQuery($sqlstr, $funcion);
    }

    public static function eliminarfuncion($fncod)
    {
        $sqlstr = "delete from funciones where fncod = :fncod;";
        return self::executeNonQuery($sqlstr, ["fncod" => $fncod]);
    }
}