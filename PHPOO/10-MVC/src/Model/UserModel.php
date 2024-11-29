<?php 
namespace ProjetMVC\Model;

class UserModel 
{
    // Ici la props contient la totalité de mon array (normalement on stocke ici l'objet représentant la bdd)
    protected $users;

    public function __construct()
    {
        // echo "<hr>Initialisation du Model UserModel !!!!!! <hr>";

        // J'initialise ici normalement la création de l'objet BDD, dans notre cas, on récupère les valeurs venant de la session 
        $this->users = $_SESSION["users"];
    }

    public function modelSelectAll()
    {
        // Je fais un return de la totalité des données 
        return $this->users;
    }

    public function selectOneModel($id)
    {

        // return du seul user ayant cet id 
    }

}