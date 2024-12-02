<?php 
namespace Controllers\Security;

use Controllers\PrivateController;
use Dao\Security\Users as UsersDao;
use Views\Renderer;

class UsersList extends PrivateController {
    public function run(): void {
        $viewData = array();
        $users = UsersDao::getAllUsers();
        $viewData["users"] = array();
        
        foreach($users as $user) {
            $viewUser = array(
                "usercod" => $user["usercod"],
                "useremail" => $user["useremail"],
                "username" => $user["username"],
                "userest" => $user["userest"],
                "usertipo" => $user["usertipo"]
            );
            $viewData["users"][] = $viewUser;
        }

        Renderer::render('security/usersList', $viewData);
    }
}