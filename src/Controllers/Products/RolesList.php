<?php 
namespace Controllers\Products;

use Controllers\PrivateController;
use Dao\Products\RolesD;
use Views\Renderer;

class RolesList extends PrivateController{
    public function run(): void{
        $rolesD=RolesD::obtenerRoles();
        $viewRoles=[];
        

        foreach($rolesD as $rol){
            $viewrol[]=$rol;
        }
        $viewData=[
            "roles"=>$viewrol
        ];
        Renderer::render('products/rolesList',$viewData);
    }
}

?>