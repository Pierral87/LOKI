------------------------------------------------------------------------------------------------
------------------------------- TP Gestion utilisateurs ----------------------------------------
------------------------------------------------------------------------------------------------

-- TP sur la base entreprise 

/* 1. Créez les acteurs(les utilisateurs) suivants :
a)	« secretaire » qui a comme mot de passe : secretairepassword. Vous allez lui attribuer le privilège de la lecture (sélection) des champs suivants : id_employes, nom, prenom, sexe et service sur la table « employes » de notre base de données entreprise.
b)	« directeur » qui a comme mot de passe « directeurpassword ». Vous allez lui attribuer les privilèges suivants : selection,modification,insertion,suppression sur la base de donnée entreprise plus le droit d’attribuer des droits aux autres utilisateurs.*/

/*2. Déconnectez-vous du compte root et connectez-vous en tant que secrétaire. Et suivez les instructions suivantes :

a)	Afficher la profession de l’employé 417.
b)	Afficher le nombre de commerciaux.
c)	Afficher le nombre de services (différents)
d)	Augmenter le salaire de chaque employé de 100euro. Qu’est-ce-que vous remarquez ?*/


/*
3. Déconnectez-vous du compte secrétaire et connectez-vous en tant qu’administrateur. Et réalisez les requêtes suivantes :
a)	Afficher la date d'embauche de : Amandine.
b)	Afficher le salaire moyen par service.
c)	Afficher les informations de l'employé du service commercial gagnant le salaire le plus élevé
*/


/*
4. Créer l’utilisateur « informaticien » avec son mot de passe « informaticienpassword » et donner à lui les droits suivants : sélection, insertion, modification, suppression sur la table employes avec les limites de ressources suivantes : il peut effectuer aux maximum 25 requêtes par heure et il peut se connecter jusqu’à 6 fois par heure.
*/