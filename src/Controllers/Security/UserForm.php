<?php
namespace Controllers\Security;

use Controllers\PrivateController;
use Views\Renderer;
use Utilities\Site;
use Dao\Security\Users as DaoUsers;

class UserForm extends PrivateController {
    private $viewData = [];
    private $mode = 'INS';
    private $modeDsc = [
        "INS" => "Nuevo Usuario",
        "UPD" => "Editando Usuario %s",
        "DEL" => "Eliminando Usuario %s",
        "DSP" => "Detalle de Usuario %s"
    ];
    private $user = [
        "usercod" => "",
        "username" => "",
        "useremail" => "",
        "userpswd" => "",
        "userest" => "ACT",
        "usertipo" => "PBL"
    ];

    public function run(): void {
        try {
            $this->init();
            if ($this->isPostBack()) {
                $this->handlePost();
            }
            $this->prepareViewData();
            Renderer::render('security/userForm', $this->viewData);
        } catch (\Exception $ex) {
            Site::redirectToWithMsg(
                "index.php?page=Security_UsersList",
                $ex->getMessage()
            );
        }
    }

    private function init() {
        if (isset($_GET["mode"])) {
            $this->mode = $_GET["mode"];
            if (!isset($this->modeDsc[$this->mode])) {
                throw new \Exception("Modo no existe");
            }
            if ($this->mode !== "INS" && isset($_GET["usercod"])) {
                $this->user = DaoUsers::getUserById($_GET["usercod"]);
                if (!$this->user) {
                    throw new \Exception("Usuario no encontrado");
                }
            }
        } else {
            throw new \Exception("Modo no definido");
        }
    }

    private function handlePost() {
        try {
            // Validar datos básicos del formulario
            if (!isset($_POST["username"]) 
                || !isset($_POST["useremail"])
                || !isset($_POST["userest"])
                || !isset($_POST["usertipo"])) {
                throw new \Exception("Formulario incompleto");
            }

            // Validación de correo electrónico
            if (!filter_var($_POST["useremail"], FILTER_VALIDATE_EMAIL)) {
                throw new \Exception("Correo electrónico no válido");
            }
    
            // Capturar datos del formulario
            $this->user = [
                "username" => $_POST["username"],
                "useremail" => $_POST["useremail"],
                "userest" => $_POST["userest"],
                "usertipo" => $_POST["usertipo"]
            ];
    
            // Manejar el código de usuario según el modo
            if ($this->mode !== "INS") {
                $this->user["usercod"] = isset($_POST["usercod"]) ? $_POST["usercod"] : 
                                        (isset($_GET["usercod"]) ? $_GET["usercod"] : null);
                
                if (empty($this->user["usercod"])) {
                    throw new \Exception("Código de usuario no encontrado");
                }
            }
    
            // En modo insertar necesitamos la contraseña
            if ($this->mode === "INS") {
                if (!isset($_POST["userpswd"]) || empty(trim($_POST["userpswd"]))) {
                    throw new \Exception("Contraseña requerida");
                }
                $this->user["userpswd"] = password_hash($_POST["userpswd"], PASSWORD_BCRYPT);
            }
    
            // Procesar según el modo
            switch ($this->mode) {
                case 'INS':
                    $result = DaoUsers::insertUser(
                        $this->user["username"],
                        $this->user["useremail"],
                        $this->user["userpswd"],
                        $this->user["userest"],
                        $this->user["usertipo"]
                    );
                    if ($result) {
                        Site::redirectToWithMsg(
                            "index.php?page=Security_UsersList",
                            "Usuario creado exitosamente"
                        );
                    } else {
                        throw new \Exception("Error al crear el usuario");
                    }
                    break;
                
                case 'UPD':
                    $result = DaoUsers::updateUser(
                        $this->user["usercod"],
                        $this->user["username"],
                        $this->user["useremail"],
                        $this->user["userest"],
                        $this->user["usertipo"]
                    );
                    if ($result) {
                        Site::redirectToWithMsg(
                            "index.php?page=Security_UsersList",
                            "Usuario actualizado exitosamente"
                        );
                    } else {
                        throw new \Exception("Error al actualizar el usuario");
                    }
                    break;
    
                case 'DEL':
                    $result = DaoUsers::deleteUser($this->user["usercod"]);
                    if ($result) {
                        Site::redirectToWithMsg(
                            "index.php?page=Security_UsersList",
                            "Usuario eliminado exitosamente"
                        );
                    } else {
                        throw new \Exception("Error al eliminar el usuario");
                    }
                    break;
            }
        } catch (\Exception $ex) {
            throw new \Exception($ex->getMessage());
        }
    }

    private function prepareViewData(): void {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["modes_dsc"] = sprintf(
            $this->modeDsc[$this->mode],
            $this->mode === "INS" ? "" : $this->user["username"]
        );
        
        // Variables de control
        $this->viewData["showCommit"] = ($this->mode !== "DSP");
        $this->viewData["readonly"] = ($this->mode === "DSP" || $this->mode === "DEL") ? "readonly" : "";
        $this->viewData["showPassw"] = ($this->mode === "INS");
        
        // Marcar opción seleccionada en selects
        if(isset($this->user["userest"])) {
            $key = "userest_" . $this->user["userest"];
            $this->user[$key] = "selected";
        }
        if(isset($this->user["usertipo"])) {
            $key = "usertipo_" . $this->user["usertipo"];
            $this->user[$key] = "selected";
        }
        
        $this->viewData["user"] = $this->user;
    }
}
?>
