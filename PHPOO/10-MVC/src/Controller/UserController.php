<?php

namespace ProjetMVC\Controller;

use ProjetMVC\Model\UserModel;

class UserController
{

    // Cette prop va contenir un objet de type Model, notre élément qui nous sert à piocher nos données en BDD
    protected $model;

    public function __construct()
    {
        // echo "<hr>Initialisation de mon controller UserController WOW ! <hr>";
        // J'initialise ici un objet de type UserModel, c'est mon Model qui me sert à me retourner mes données sur les utilisateurs 
        $this->model = new UserModel;
    }

    // La méthode render me permet de gérer l'affichage de mes vues 
    public function render($layout, $vue, $parameters = array())
    {

        // extract() : fonction prédéfinie qui permet de transformer les clés d'un array en variable, qui auront la valeur la clé en question du array
        // par exemple "title" => "List User"
        // deviendra
        // $title = "List User";
        extract($parameters);

        ob_start(); // On démarre une mise en tampon, pour faire en sorte de ne pas exécuter directement le code au client, mais le mets de côté pour pouvoir le manipuler avant de relacher l'affichage 

        require_once "src/View/$vue";

        $content = ob_get_clean(); // Ici on clean la mémoire tampon en "insérant" dans $content tous les éléments chargé depuis le ob_start, à savoir le require de notre vue

        ob_start(); 
        require_once "src/View/$layout"; // Appel de la structure de ma page, à ce niveau grâce au ob_get_clean on a bien la var $content qui est définie, j'aurai donc ma page entièrement modélisée 

        return ob_end_flush(); // A cette étape, la mise en tampon est terminée et je libère l'affichage pour l'utilisateur
    }

    // Ici la méthode qui me permet de comprendre les requêtes de l'utilisateur
    public function handleRequest()
    {
        if (isset($_GET["op"])) {
            $op = $_GET["op"];
        } else {
            $op = null;
        }

        if (isset($_GET["id"])) {
            $id = $_GET["id"];
        } else {
            $id = null;
        }

        try {
            // S'il a demandé à voir un utilisateur
            if ($op == "select") {
                $this->select($id);
            } 
            // S'il a demandé à ajouter un user
            elseif ($op == "add") {
                $this->add();
            }
            // S'il a demandé à modifier un user 
            elseif ($op == "update") {
                var_dump($_GET);
                $this->update();
            } 
            // S'il a demandé à supprimer un utilisateur
            elseif ($op == "delete") {
                $this->delete();
            // Sinon, on affiche tout
            } else {
                $this->selectAll();
            }

        } catch (\Exception $e) {
            echo $e->getMessage();
        }
    }

    // Ci-dessous la méthode me permettant de gérer la demande d'affichage de tous les utilisateurs 
    public function selectAll() 
    {
        // J'appelle mon model pour lui demander de me retourner tous les utilisateurs de ma base (mon array)
        $data = $this->model->modelSelectAll();
        // var_dump($data);
        // require("templateListUser.php");
        // $title = "Liste des utilisateurs";
        // $content = require("src/View/ListUser.php");
        // require("src/View/layout.php");

        // J'appelle la méthode render qui me permet de gérer l'affichage de mon contenu
        // Je transmet : 
            // le layout, c'est la structure de la page 
            // la vue, c'est le contenu de la page qui sera inséré dans le layout 
            // les params, ce sont les différentes données dont j'ai besoin pour mener à bien l'affichage de ma vue et mon layout 
                // Ici je transmet le titre de la page (changeant à chaque scénario) ainsi que les data reçus du Model 
        $this->render("layout.php", "ListUser.php", 
        [
            "title" => "Liste des utilisateur",
            "data" => $data
        ]);
    }

    public function select($id) 
    {
        // Je dois lancer la méthode selectOneModel($id)
    }
}
