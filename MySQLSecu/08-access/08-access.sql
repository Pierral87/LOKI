----------------------------------------------------------------------------
----------------------------------------------------------------------------
------------- Gestion de la sécurité par les accès utilisateurs ------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------


/* 

Nos BDD nous permettent de stocker des données 
    Ces BDDs vont fonctionner en liaison avec notre site web (pages html avec du PHP ou autre)
Donc finalement, n'importe quel utilisateur de notre app peut se "connecter" à notre BDD 

Il est donc absolument nécessaire de veiller à ce que les utilisateurs ne possèdent pas plus de droits que nécessaire 

On évitera ABSOLUMENT d'utiliser root (super admin de la bdd) sur notre site web 

Pour cela on va donc créer des comptes utilisateurs sur notre BDD

*/

-- Création d'un nouvel utilisateur : 

-- Syntaxe 
CREATE USER "login"@"host" IDENTIFIED BY "password";

-- Suppression d'un utilisateur 
DROP USER "login"@"host";


-- Je crée ici un utilisateur pierral  pour l'instant il n'a aucuns droits !
CREATE USER "pierral"@"localhost" IDENTIFIED BY "azerty";

-- Je peux utiliser la commande GRANT (si j'en ai les droits ! root a tous les droits) pour donner des droits à un utilisateur 
-- Ici je donne les droits SELECT, INSERT à pierral, mais aussi UPDATE uniquement sur le champ service 
GRANT SELECT, INSERT, UPDATE(service) 
ON entreprise.employes 
TO "pierral"@"localhost";


-- GRANT ALL qui donne tous les droits sur une base.table  


-- FLUSH PRIVILEGES pour valider la modification des droits utilisateurs 
FLUSH PRIVILEGES;


-- Limitation des ressources 

-- MAX_QUERIES_PER_HOUR : le nombre de requêtes qu'il peut exécuter par heure 
-- MAX_UPDATES_PER_HOUR : Le nombre de modif qu'il peut exécuter par heure 
-- MAX_CONNECTIONS_PER_HOUR : Le nombre de fois qu'il peut se connecter à notre serveur 

-- Important de mettre ça en place pour se protéger d'attaques de type ddos/force brute afin d'éviter que votre serveur n'encaisse des millions de requêtes en quelques secondes 
-- On veillera à mettre une limite suffisamment élevée pour ne pas qu'un utilisateur classique soit limité dans sa navigation 

CREATE USER "pierro"@"localhost" IDENTIFIED BY "azerty"
WITH MAX_QUERIES_PER_HOUR 5
MAX_UPDATES_PER_HOUR 5
MAX_CONNECTIONS_PER_HOUR 3
;

GRANT SELECT, INSERT, UPDATE(service) 
ON entreprise.employes 
TO "pierro"@"localhost";

FLUSH PRIVILEGES;

