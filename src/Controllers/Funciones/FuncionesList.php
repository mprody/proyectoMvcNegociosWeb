<?php

namespace Controllers\Funciones;

use Controllers\PrivateController;
use Dao\Funciones\Funciones;
use Views\Renderer;

class FuncionesList extends PrivateController
{
    public function run(): void
    {
        $funcionesDao = Funciones::obtenerFunciones();
        $viewFunciones = [];
        $estadosDscArr = [
            "ACT" => "Activo",
            "RSV" => "Reservado",
            "SLD" => "Vendido"
        ];
        foreach ($funcionesDao as $funcion) {
            $funcion["estadoDsc"] = $estadosDscArr[$funcion["fnest"]]; //OJO
            $viewFunciones[] = $funcion;
        }
        $viewData = [
            "funcion" => $viewFunciones
        ];

        Renderer::render('funciones/funciones_list', $viewData);
    }
}