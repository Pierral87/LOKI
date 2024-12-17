-- Les transactions sont possibles avec le moteur de bdd (engine) innoDB 
-- Les transactions nous permettent de créer un environnement de travail temporaire pour exécuter des requêtes pour ensuite soit : - les valider, soit - les annuler ! 

USE entreprise;

START TRANSACTION; -- démarre une transaction

SELECT * FROM employes; -- On vérifie les données 

UPDATE employes SET salaire = +100; -- Je me suis trompé dans ma requête... J'ai mis le salaire de tout le monde à 100€ plutôt que de l'augmenter de 100€

SELECT * FROM employes; -- Je vérifie mon résultat (aïe)

ROLLBACK; -- ROLLBACK me permet d'annuler toutes les modifications depuis le début de ma transaction
COMMIT; -- COMMIT me permet de valider toutes les modifications depuis le début de la transaction
-- Si je ferme la console, cela fait un ROLLBACK
-- ATTENTION un COMMIT, un ROLLBACK, une fermeture de console TERMINE la transaction 


-- TRANSACTION AVANCEE & SAVEPOINT 

START TRANSACTION; 

SELECT * FROM employes; 

SAVEPOINT point1; -- On crée ici un point de sauvegarde que l'on nomme point1 

UPDATE employes SET salaire = 5000; -- Modification des salaire de tout le monde 

SELECT * FROM employes; 

SAVEPOINT point2; -- Point de sauvegarde point2

UPDATE employes SET salaire = 2000; -- Modification du salaire de tout le monde 

SELECT * FROM employes; 

SAVEPOINT point3; -- Point de sauvegarde point 3


ROLLBACK TO point2; -- Retour au point 2 
ROLLBACK TO point1; -- Retour au point 1 
ROLLBACK TO point3; -- Retour au point 3  -- ERREUR ce point n'existe plus 

-- Avec un ROLLBACK TO, la transaction reste en cours 
-- Pour terminer définitivement la transaction, il faudra faire un vrai commit ou un vrai rollback 

-- /!\ ATTENTION, à l'intérieur d'une transaction on peut tester et rollback uniquement des requêtes de manipulation de données, (select, insert, update, delete), mais certaines autres instructions passeront outre la transaction et seront bel et bien appliquées ! Par exemple un DELETE from employes; va supprimer tous les employés, je peux le ROLLBACK. Mais, un TRUNCATE employes, va vider la table de tous ses enregistrements, lui, je ne pourrais pas le ROLLBACK !


-- On manipulera les transactions via notre langage back ! 
-- En PHP on va apprendre à manipuler les BDD avec la classe prédéfinie : PDO 
-- PDO possède des méthodes pour lancer, commit, rollback des transactions
-- On les manipule généralement dans un try catch 

-- Ci dessous un exemple de code PHP manipulant les transactions 
/*
<?php
try {
    // Connexion à la base de données
    $pdo = new PDO('mysql:host=localhost;dbname=ma_base', 'mon_utilisateur', 'mon_mot_de_passe');

    // Démarrage d'une transaction
    $pdo->beginTransaction();

    // Requête pour débiter le compte source
    $stmt = $pdo->prepare("UPDATE comptes SET solde = solde - :montant WHERE id = :compte_source");
    $stmt->execute([':montant' => 100, ':compte_source' => 1]);

    // Requête pour créditer le compte destinataire
    $stmt = $pdo->prepare("UPDATE comptes SET solde = solde + :montant WHERE id = :compte_destinataire");
    $stmt->execute([':montant' => 100, ':compte_destinataire' => 2]);

    // Validation de la transaction
    $pdo->commit();
    echo "Transaction réussie !";
} catch (PDOException $e) {
    // Annulation de la transaction en cas d'erreur
    $pdo->rollBack();
    echo "Erreur lors de la transaction : " . $e->getMessage();
}
*/



