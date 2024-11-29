<?php

namespace ProjetMVC\Controller;

use ProjetMVC\Model\UserModel;

class UserController
{

    protected $model;

    public function __construct()
    {
        echo "<hr>Initialisation de mon controller UserController WOW ! <hr>";
        $this->model = new UserModel;
    }

    public function handleRequest()
    {
        if (isset($_GET["op"])) {
            $op = $_GET["op"];
        } else {
            $op = null;
        }

        try {
            if ($op == "select") {
                $this->select();
            } elseif ($op == "update") {
                $this->update();
            } elseif ($op == "delete") {
                $this->delete();
            } else {
                $this->selectAll();
            }

        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }

    public function selectAll() 
    {
        $data = $this->model->modelSelectAll();
        var_dump($data);
    }
}
