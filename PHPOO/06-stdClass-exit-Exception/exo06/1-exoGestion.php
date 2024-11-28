<?php 

/*

Exercice 1 : Contrôle d'accès à une page admin avec exit / die

Objectif : Simuler un contrôle d’accès à une page d’administration en utilisant exit() ou die() pour stopper l’exécution du script si l’utilisateur n’a pas les droits nécessaires.

Énoncé :

    Créez un fichier gestion.php.
    Simulez un utilisateur connecté avec dans la session, un indice user auquel sont stockés des informations, notamment le rôle (valeurs possibles : 'admin', 'user').
    Si l'utilisateur n'a pas le rôle d'admin, utilisez die() ou exit() pour afficher un message d'erreur et interrompre l'exécution de la page. Sinon, affiche le contenu de la page d'administration.

*/