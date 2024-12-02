<?php

namespace Controllers\Funciones;

use Controllers\PrivateController;
use Views\Renderer;
use Utilities\Site;
use Dao\Funciones\Funciones;
use Utilities\Validators;

class FuncionesForm extends PrivateController
{
    private $viewData = [];
    private $modeDscArr = [
        "INS" => "Crear nueva Función",
        "UPD" => "Editando %s (%s)",
        "DSP" => "Detalle de %s (%s)",
        "DEL" => "Eliminando %s (%s)",
    ];
    private $mode = '';

    private $errors = [];


    private function addError($error, $context = 'global')
    {
        if (isset($this->errors[$context])) {
            $this->errors[$context][] = $error;
        } else {
            $this->errors[$context] = [$error];
        }
    }

    //Estructura del Producto
    private $funcion = [
        "fncod" => '',
        "fndsc" => '',
        "fnest" => '',
        "fntyp" => '',      
    ];

    public function run(): void
    {
        // Ciclo de Vida del Formular
        // 1) Obtener variables del GET
        // 2) Si hay codigo de Carro y no es INS
        //      buscar el registor de carro por codigo
        // 3) Si existe POSTBACK
        //      capturar los datos del formulario
        //      validar los datos del formulario
        //      INS: insertar registro
        //      UPD: actualizar registro
        //      DEL: Eliminar registro
        //      Regresar a la lista actualizada
        // 4) Generar $viewData
        // 5) Renderezar formulario

        $this->inicializarForm();
        if ($this->isPostBack()) {
            $this->cargarDatosDelFormulario();
            if ($this->validarDatos()) {
                $this->procesarAccion();
            }
        }
        $this->generarViewData();
        Renderer::render('funciones/funciones_form', $this->viewData);
    }

    private function inicializarForm()
    {
        if (isset($_GET["mode"]) && isset($this->modeDscArr[$_GET["mode"]])) {
            $this->mode = $_GET["mode"];
        } else {
            Site::redirectToWithMsg("index.php?page=Funciones-FuncionesList", "Algo Sucedio Mal. Intente de Nuevo");
            die();
        }
        if ($this->mode !== 'INS' && isset($_GET["fncod"])) {
            $this->funcion["fncod"] = $_GET["fncod"];
            $this->cargarDatosFuncion();
        }
    }
    private function cargarDatosFuncion()
    {
        $tmpFuncion = Funciones::obtenerFuncionPorId($this->funcion["fncod"]);
        $this->funcion = $tmpFuncion;
    }
    private function cargarDatosDelFormulario()
    {
        $this->funcion["fncod"] = $_POST["fncod"];
        $this->funcion["fndsc"] = $_POST["fndsc"];
        $this->funcion["fnest"] = $_POST["fnest"];
        $this->funcion["fntyp"] = $_POST["fntyp"];       
    }

    private function validarDatos()
    {
        if (Validators::IsEmpty($this->funcion["fndsc"])) {
            $this->addError("fndsc no puede venir vacio!", "fndsc");
        }
        if (Validators::IsEmpty($this->funcion["fnest"])) {
            $this->addError("fnest no puede venir vacio!", "fnest");
        }        
        return count($this->errors) === 0;
    }

    private function procesarAccion()
    {
        switch ($this->mode) {
            case 'INS':
                $result = Funciones::agregarFuncion($this->funcion);
                if ($result) {
                    Site::redirectToWithMsg("index.php?page=Funciones-FuncionesList", "Funcion registrada satisfactoriamente");
                }
                break;
            case 'UPD':
                $result = Funciones::actualizarFuncion($this->funcion);
                if ($result) {
                    Site::redirectToWithMsg("index.php?page=Funciones-FuncionesList", "Funcion actualizada satisfactoriamente");
                }
                break;
            case 'DEL':
                $result = Funciones::eliminarFuncion($this->funcion['fncod']);
                if ($result) {
                    Site::redirectToWithMsg("index.php?page=Funciones-FuncionesList", "Funcion eliminada satisfactoriamente");
                }
                break;
        }
    }

    private function generarViewData()
    {
        $this->viewData["mode"] = $this->mode;

        $this->viewData["modes_dsc"] = sprintf(
            $this->modeDscArr[$this->mode],
            $this->funcion["fndsc"],
            $this->funcion["fncod"]
        );
        $this->viewData["funcion"] = $this->funcion;
        $this->viewData["readonly"] =
            ($this->viewData["mode"] === 'DEL'
                || $this->viewData["mode"] === 'DSP'
            ) ? 'readonly' : '';
        foreach ($this->errors as $context => $errores) {
            $this->viewData[$context . '_error'] = $errores;
            $this->viewData[$context . '_haserror'] = count($errores) > 0;
        }
        $this->viewData["showConfirm"] = ($this->viewData["mode"] != 'DSP');
    }
}