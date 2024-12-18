------------------------------------------------------------------------------------------------
------------------------------- TP Gestion utilisateurs ----------------------------------------
------------------------------------------------------------------------------------------------

-- TP sur la base entreprise 

/* 1. Créez les acteurs(les utilisateurs) suivants :
a)	« secretaire » qui a comme mot de passe : secretairepassword. Vous allez lui attribuer le privilège de la lecture (sélection) des champs suivants : id_employes, nom, prenom, sexe et service sur la table « employes » de notre base de données entreprise.
*/
CREATE USER 'secretaire'@'localhost' IDENTIFIED BY 'secretairepassword';
GRANT SELECT (id_employes, nom, prenom, sexe, service) ON entreprise.employes TO 'secretaire'@'localhost';

/*
b)	« directeur » qui a comme mot de passe « directeurpassword ». Vous allez lui attribuer les privilèges suivants : selection,modification,insertion,suppression sur la base de donnée entreprise plus le droit d’attribuer des droits aux autres utilisateurs.*/
CREATE USER 'directeur'@'localhost' IDENTIFIED BY 'directeurpassword';
GRANT SELECT, UPDATE, INSERT, DELETE, GRANT OPTION ON entreprise.employes TO 'directeur'@'localhost';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'secretaire'@'localhost';
/*2. Déconnectez-vous du compte root et connectez-vous en tant que secrétaire. Et suivez les instructions suivantes :

a)	Afficher la profession de l’employé 417.
*/
SELECT service FROM employes WHERE id_employes = 417;

-- b)	Afficher le nombre de commerciaux.
SELECT COUNT(*) FROM employes WHERE service = "commercial";
-- c)	Afficher le nombre de services (différents)
SELECT COUNT(DISTINCT service) FROM employes;
-- d)	Augmenter le salaire de chaque employé de 100euro. Qu’est-ce-que vous remarquez ?*/
UPDATE employes SET salaire = salaire +100;


/*
3. Déconnectez-vous du compte secrétaire et connectez-vous en tant que directeur. Et réalisez les requêtes suivantes :
a)	Afficher la date d'embauche de : Amandine.
*/
SELECT date_embauche FROM employes WHERE prenom = "Amandine";
-- b)	Afficher le salaire moyen par service.
SELECT AVG(salaire) AS salaire_moyen, service FROM employes GROUP BY service;z
-- c)	Afficher les informations de l'employé du service commercial gagnant le salaire le plus élevé
SELECT * FROM employes WHERE service = "commercial" ORDER BY salaire DESC LIMIT 1;



/*
4. Créer l’utilisateur « informaticien » avec son mot de passe « informaticienpassword » et donner à lui les droits suivants : sélection, insertion, modification, suppression sur la table employes avec les limites de ressources suivantes : il peut effectuer aux maximum 25 requêtes par heure et il peut se connecter jusqu’à 6 fois par heure.
*/
CREATE USER 'informaticien'@'localhost' IDENTIFIED BY 'informaticienpassword'
WITH MAX_QUERIES_PER_HOUR 25 MAX_CONNECTIONS_PER_HOUR 6;
GRANT SELECT, INSERT, UPDATE, DELETE ON entreprise.employes TO 'informaticien'@'localhost';
FLUSH PRIVILEGES;
