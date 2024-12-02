<?php

namespace Dao\Products;

use Dao\Table;

class RolesD extends Table{

    public static function obtenerRoles(){
        $sqlstr ='SELECT * FROM roles';
        $roles=self::obtenerRegistros($sqlstr,[]);
        return $roles;
    }

    public static function obtenerRolesPorId($rolescod){
        $sqlstr='SELECT * FROM roles WHERE rolescod=:rolescod;';
        $roles=self::obtenerUnRegistro($sqlstr,["rolescod"=>$rolescod]);
        return $roles;
    }

    public static function agregarRoles($rol){
        
        //unset($rol['rolescod']);
        unset($rol['creado']);
        unset($rol['actualizado']);
        

        $sqlstr='insert into roles (
            rolescod,rolesdsc,rolesest) values
        (
            :rolescod,:rolesdsc,:rolesest
        );';
        
        return self::executeNonQuery($sqlstr,$rol);
    }

    //DataFirst
    public static function actualizarRoles($rol){
        unset($rol['creado']);
        unset($rol['actualizado']);
        $sqlstr=" update roles set rolescod = :rolescod, rolesdsc = :rolesdsc, rolesest = :rolesest where rolescod = :rolescod;";

            return self::executeNonQuery($sqlstr,$rol);
    }

    public static function eliminarRoles($rolescod){
        $sqlstr='delete from roles where rolescod= :rolescod;';
        return self::executeNonQuery($sqlstr,["rolescod"=>$rolescod]);
    }
}