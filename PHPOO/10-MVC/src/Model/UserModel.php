<?php 
namespace ProjetMVC\Model;

class UserModel 
{
    protected $users;

    public function __construct()
    {
        echo "<hr>Initialisation du Model UserModel !!!!!! <hr>";
        $this->users = $_SESSION["users"];
    }

    public function modelSelectAll()
    {
        return $this->users;
    }

}