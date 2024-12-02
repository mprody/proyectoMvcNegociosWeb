<?php
namespace Dao\Security;

use Dao\Table;

class Users extends Table {
    public static function getAllUsers() {
        $sqlstr = "SELECT usercod, useremail, username, userest, 
                    CASE 
                        WHEN userest = 'ACT' THEN 'Activo'
                        WHEN userest = 'INA' THEN 'Inactivo'
                        WHEN userest = 'BLQ' THEN 'Bloqueado'
                        WHEN userest = 'SUS' THEN 'Suspendido'
                    END as userestdsc,
                    usertipo,
                    CASE 
                        WHEN usertipo = 'PBL' THEN 'Público'
                        WHEN usertipo = 'ADM' THEN 'Administrador'
                        WHEN usertipo = 'AUD' THEN 'Auditor'
                    END as usertipodsc
                  FROM usuario 
                  ORDER BY usercod;";
        $users = self::obtenerRegistros($sqlstr, array());
        return $users;
    }

    public static function getUserById($usercod) {
        $sqlstr = "SELECT usercod, useremail, username, userest, usertipo 
                  FROM usuario 
                  WHERE usercod=:usercod;";
        $params = array("usercod" => $usercod);
        $user = self::obtenerUnRegistro($sqlstr, $params);
        return $user;
    }

    public static function getUserByEmail($email) {
        $sqlstr = "SELECT usercod, useremail, username, userest, usertipo 
                  FROM usuario 
                  WHERE useremail = :useremail;";
        $params = array("useremail" => $email);
        return self::obtenerUnRegistro($sqlstr, $params);
    }

    public static function insertUser($username, $useremail, $userpswd, $userest, $usertipo) {
        // Verificar si el email ya existe
        if (self::getUserByEmail($useremail)) {
            throw new \Exception("El correo electrónico ya está registrado");
        }

        $sqlstr = "INSERT INTO usuario 
                  (username, useremail, userpswd, userfching, userpswdest, userpswdexp, 
                   userest, useractcod, userpswdchg, usertipo) 
                  VALUES 
                  (:username, :useremail, :userpswd, now(), 'ACT', 
                   DATE_ADD(now(), INTERVAL 90 DAY), :userest, 
                   :useractcod, now(), :usertipo);";

        $params = array(
            "username" => $username,
            "useremail" => $useremail,
            "userpswd" => self::_hashPassword($userpswd),
            "userest" => $userest,
            "useractcod" => md5(time() . $useremail),
            "usertipo" => $usertipo
        );

        return self::executeNonQuery($sqlstr, $params);
    }

    public static function updateUser($usercod, $username, $useremail, $userest, $usertipo) {
        // Verificar si el email ya existe para otro usuario
        $existingUser = self::getUserByEmail($useremail);
        if ($existingUser && $existingUser["usercod"] != $usercod) {
            throw new \Exception("El correo electrónico ya está registrado por otro usuario");
        }

        $sqlstr = "UPDATE usuario 
                  SET username = :username, 
                      useremail = :useremail,
                      userest = :userest,
                      usertipo = :usertipo 
                  WHERE usercod = :usercod;";

        $params = array(
            "usercod" => $usercod,
            "username" => $username,
            "useremail" => $useremail,
            "userest" => $userest,
            "usertipo" => $usertipo
        );

        return self::executeNonQuery($sqlstr, $params);
    }

    public static function deleteUser($usercod) {
        $sqlstr = "DELETE FROM usuario WHERE usercod = :usercod;";
        $params = array("usercod" => $usercod);
        return self::executeNonQuery($sqlstr, $params);
    }

    private static function _hashPassword($password) {
        return password_hash(
            hash_hmac(
                "sha256", 
                $password, 
                \Utilities\Context::getContextByKey("PWD_HASH")
            ),
            PASSWORD_BCRYPT // Cambiado a PASSWORD_BCRYPT
        );
    }

    public static function verifyPassword($raw_password, $hash_password) {
        return password_verify(
            hash_hmac(
                "sha256",
                $raw_password,
                \Utilities\Context::getContextByKey("PWD_HASH")
            ),
            $hash_password
        );
    }
}

?>
