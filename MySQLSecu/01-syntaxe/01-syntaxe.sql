-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------- SYNTAXE MYSQL --------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------



-- Ceci est un commentaire jusqu'à la fin de la ligne 
# Ceci est un commentaire aussi sur une seule ligne 
/*
    Commentaire
    sur 
    plusieurs lignes
*/

-- Les requêtes ne sont pas sensibles à la casse, cependant, une convention d'écriture veut que nous écrivions les mots clés en MAJUSCULE 
-- SELECT prenom FROM liste_abonnes;

-- Chaque instruction doit se terminer par un ; 

-- Pour se connecter à la console MySQL :
    -- dans XAMPP 
            -- Bouton "shell" 
            -- on écrit ensuite dans le terminal : mysql -u root -p     (il demande ensuite un password, pas de password, j'appuie sur entrée)
    -- dans MAMP 
            -- /Applications/MAMP/Library/bin/mysql -u root -p   (sur MAMP le password c'est "root") 
    -- dans WAMP 
            -- On lance simplement la console MySQL via le menu de Wamp 

-- Création de BDD 
CREATE DATABASE ma_bdd;
CREATE DATABASE entreprise;

SHOW DATABASES; -- Pour voir la liste des BDD du serveur
SHOW TABLES; -- Pour voir les tables de la base sélectionnée 
SHOW WARNINGS; -- Pour voir le détail des warnings de la dernière requête 

USE entreprise; -- Pour se positionner sur une BDD afin de pouvoir travailler dessus 
SELECT DATABASE(); -- Cette instruction me retourne quelle est la base actuellement sélectionnée 

DROP DATABASE ma_bdd; -- Pour supprimer une BDD 
DROP TABLE nom_de_table; -- Pour supprimer une table 

TRUNCATE nom_de_table; -- Permet de vider une table en gardant la structure (attention c'est une requête de type structure)

DESC nom_de_table; -- Pour avoir un affichage de la structure de la table 

USE entreprise;

-- Création d'une table 

CREATE TABLE IF NOT EXISTS employes (
  id_employes int NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

-- Insertion d'un jeu de données 

INSERT INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES
(350, 'Jean-pierre', 'Laborde', 'm', 'direction', '2010-12-09', 5000),
(388, 'Clement', 'Gallet', 'm', 'commercial', '2010-12-15', 2300),
(415, 'Thomas', 'Winter', 'm', 'commercial', '2011-05-03', 3550),
(417, 'Chloe', 'Dubar', 'f', 'production', '2011-09-05', 1900),
(491, 'Elodie', 'Fellier', 'f', 'secretariat', '2011-11-22', 1600),
(509, 'Fabrice', 'Grand', 'm', 'comptabilite', '2011-12-30', 2900),
(547, 'Melanie', 'Collier', 'f', 'commercial', '2012-01-08', 3100),
(592, 'Laura', 'Blanchet', 'f', 'direction', '2012-05-09', 4500),
(627, 'Guillaume', 'Miller', 'm', 'commercial', '2012-07-02', 1900),
(655, 'Celine', 'Perrin', 'f', 'commercial', '2012-09-10', 2700),
(699, 'Julien', 'Cottet', 'm', 'secretariat', '2013-01-05', 1390),
(701, 'Mathieu', 'Vignal', 'm', 'informatique', '2013-04-03', 2500),
(739, 'Thierry', 'Desprez', 'm', 'secretariat', '2013-07-17', 1500),
(780, 'Amandine', 'Thoyer', 'f', 'communication', '2014-01-23', 2100),
(802, 'Damien', 'Durand', 'm', 'informatique', '2014-07-05', 2250),
(854, 'Daniel', 'Chevel', 'm', 'informatique', '2015-09-28', 3100),
(876, 'Nathalie', 'Martin', 'f', 'juridique', '2016-01-12', 3550),
(900, 'Benoit', 'Lagarde', 'm', 'production', '2016-06-03', 2550),
(933, 'Emilie', 'Sennard', 'f', 'commercial', '2017-01-11', 1800),
(990, 'Stephanie', 'Lafaye', 'f', 'assistant', '2017-03-01', 1775);

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
---- REQUETES DE SELECTION (On questionne la bdd) ---------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Affichage complet des données de la table employes 
SELECT * FROM employes;

-- Selection de simplement quelques champs de la table (dans l'ordre demandé)
SELECT nom, prenom, service FROM employes;

-- Question : Affichez la liste des différents services de la table employes...
SELECT service FROM employes;
-- Pour éviter les doublons, on utilise DISTINCT 
SELECT DISTINCT service FROM employes;

-- CONDITION WHERE 
-- Affichage des employés du service informatique 
SELECT * FROM employes WHERE service = "informatique";
SELECT * FROM employes WHERE service = 'informatique';
+-------------+---------+--------+------+--------------+---------------+---------+
| id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
+-------------+---------+--------+------+--------------+---------------+---------+
|         701 | Mathieu | Vignal | m    | informatique | 2013-04-03    |    2500 |
|         802 | Damien  | Durand | m    | informatique | 2014-07-05    |    2250 |
|         854 | Daniel  | Chevel | m    | informatique | 2015-09-28    |    3100 |
+-------------+---------+--------+------+--------------+---------------+---------+

-- BETWEEN 
-- Affichage des employés ayant été embauchés entre 2015 et aujourd'hui 
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND "2024-12-16";
+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         854 | Daniel    | Chevel  | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie  | Martin  | f    | juridique    | 2016-01-12    |    3550 |
|         900 | Benoit    | Lagarde | m    | production   | 2016-06-03    |    2550 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
|         990 | Stephanie | Lafaye  | f    | assistant    | 2017-03-01    |    1775 |
+-------------+-----------+---------+------+--------------+---------------+---------+

SELECT NOW(); -- Nous renvoie la date et l'heure de l'instant T
SELECT CURDATE(); -- Nous renvoie uniquement la date du jour 

SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND CURDATE();

-- LIKE la valeur approchante 
-- Like nous permet de rechercher une information sans l'écrire totalement, on cherche des valeurs ressemblantes à la saisie
-- Affichage des prenoms commen_ant par la lettre "s" 
SELECT prenom FROM employes WHERE prenom LIKE "s%";
-- % : signifie "peu importe ce qui se trouve à cet endroit"
+-----------+
| prenom    |
+-----------+
| Stephanie |
+-----------+

-- Affichage des prénoms finissant par les lettres "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie";
+-----------+
| prenom    |
+-----------+
| Elodie    |
| Melanie   |
| Nathalie  |
| Emilie    |
| Stephanie |
+-----------+

-- Affichage des prénoms contenant les lettres "ie" (début, fin, milieu)
SELECT prenom FROM employes WHERE prenom LIKE "%ie%";


-- EXCLUSION 
-- Tous les employés sauf ceux d'un service particulier, par exemple, sauf le service commercial 
SELECT * FROM employes WHERE service != "commercial";
-- SELECT * FROM employes WHERE service NOT IN("commercial");

-- Les opérateurs de comparaison : 
    -- =   est égal à  
    -- !=  est différent de 
    -- > strictement supérieur 
    -- >= supérieur ou égal 
    -- < strictement inférieur
    -- < inférieur ou égal 

-- Les employés ayant un salaire supérieur à 3000 
SELECT * FROM employes WHERE salaire > 3000;
+-------------+-------------+----------+------+--------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service      | date_embauche | salaire |
+-------------+-------------+----------+------+--------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction    | 2010-12-09    |    5000 |
|         415 | Thomas      | Winter   | m    | commercial   | 2011-05-03    |    3550 |
|         547 | Melanie     | Collier  | f    | commercial   | 2012-01-08    |    3100 |
|         592 | Laura       | Blanchet | f    | direction    | 2012-05-09    |    4500 |
|         854 | Daniel      | Chevel   | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique    | 2016-01-12    |    3550 |
+-------------+-------------+----------+------+--------------+---------------+---------+

-- ORDER BY pour ordonner des résultats 
-- Affichage des employes dans l'ordre alphabétique 
SELECT * FROM employes ORDER BY nom;
SELECT * FROM employes ORDER BY nom ASC; -- ASC pour ascendant (cas par défaut si non précisé)
-- Ordre inversé : DESC pour descendant 
SELECT * FROM employes ORDER BY nom DESC;

-- Il est possible d'ordonner sur plusieurs champs 
-- On classe par service 
SELECT service, nom, prenom FROM employes ORDER BY service;
SELECT service, nom, prenom FROM employes ORDER BY service, nom;

-- LIMIT pour limiter le nombre de résultat (pagination par exemple)
-- Affichage des employes 3 par 3 
SELECT * FROM employes LIMIT 0, 3; -- LIMIT position_de_depart, nb_de_ligne
+-------------+-------------+---------+------+------------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service    | date_embauche | salaire |
+-------------+-------------+---------+------+------------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction  | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter  | m    | commercial | 2011-05-03    |    3550 |
+-------------+-------------+---------+------+------------+---------------+---------+
SELECT * FROM employes LIMIT 3, 3;
+-------------+---------+---------+------+--------------+---------------+---------+
| id_employes | prenom  | nom     | sexe | service      | date_embauche | salaire |
+-------------+---------+---------+------+--------------+---------------+---------+
|         417 | Chloe   | Dubar   | f    | production   | 2011-09-05    |    1900 |
|         491 | Elodie  | Fellier | f    | secretariat  | 2011-11-22    |    1600 |
|         509 | Fabrice | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
+-------------+---------+---------+------+--------------+---------------+---------+
SELECT * FROM employes LIMIT 6, 3;
+-------------+-----------+----------+------+------------+---------------+---------+
| id_employes | prenom    | nom      | sexe | service    | date_embauche | salaire |
+-------------+-----------+----------+------+------------+---------------+---------+
|         547 | Melanie   | Collier  | f    | commercial | 2012-01-08    |    3100 |
|         592 | Laura     | Blanchet | f    | direction  | 2012-05-09    |    4500 |
|         627 | Guillaume | Miller   | m    | commercial | 2012-07-02    |    1900 |
+-------------+-----------+----------+------+------------+---------------+---------+

-- Il est possible d'écrire LIMIT de façon raccourci, sans spécifier l'offset, donc en commençant par le premier enregistrement 
SELECT * FROM employes LIMIT 3; 
+-------------+-------------+---------+------+------------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service    | date_embauche | salaire |
+-------------+-------------+---------+------+------------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction  | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter  | m    | commercial | 2011-05-03    |    3550 |
+-------------+-------------+---------+------+------------+---------------+---------+

-- Affichage des employés avec leur salaire annuel 
SELECT nom, prenom, service, salaire * 12 FROM employes;
-- La même avec un alias (surnom) sur la colonne du calcul (cela nous facilitera la récupération dans notre langage back)
SELECT nom, prenom, service, salaire, salaire * 12 AS salaire_annuel FROM employes;
+----------+-------------+---------------+----------------+
| nom      | prenom      | service       | salaire_annuel |
+----------+-------------+---------------+----------------+
| Laborde  | Jean-pierre | direction     |          60000 |
| Gallet   | Clement     | commercial    |          27600 |
| Winter   | Thomas      | commercial    |          42600 |
| Dubar    | Chloe       | production    |          22800 |
| Fellier  | Elodie      | secretariat   |          19200 |
| Grand    | Fabrice     | comptabilite  |          34800 |
| Collier  | Melanie     | commercial    |          37200 |
| Blanchet | Laura       | direction     |          54000 |
| Miller   | Guillaume   | commercial    |          22800 |
| Perrin   | Celine      | commercial    |          32400 |
| Cottet   | Julien      | secretariat   |          16680 |
| Vignal   | Mathieu     | informatique  |          30000 |
| Desprez  | Thierry     | secretariat   |          18000 |
| Thoyer   | Amandine    | communication |          25200 |
| Durand   | Damien      | informatique  |          27000 |
| Chevel   | Daniel      | informatique  |          37200 |
| Martin   | Nathalie    | juridique     |          42600 |
| Lagarde  | Benoit      | production    |          30600 |
| Sennard  | Emilie      | commercial    |          21600 |
| Lafaye   | Stephanie   | assistant     |          21300 |
+----------+-------------+---------------+----------------+

-- Fonctions d'agrégation 
-- SUM()  pour avoir la somme 
-- La masse salariale annuelle de l'entreprise
SELECT SUM(salaire *12) AS masse_salariale FROM employes;
+-----------------+
| masse_salariale |
+-----------------+
|          623580 |
+-----------------+

-- AVG() la moyenne 
-- Affichage du salaire moyen de l'entreprise 
SELECT AVG(salaire) AS salaire_moyen FROM employes;
+---------------+
| salaire_moyen |
+---------------+
|       2598.25 |
+---------------+

-- ROUND() pour arrondir
-- ROUND(valeur) => arrondi à l'entier
-- ROUND(valeur, 1) => arrondi avec une décimale 
SELECT ROUND(AVG(salaire)) AS salaire_moyen_arrondi FROM employes;
SELECT ROUND(AVG(salaire), 1) AS salaire_moyen_arrondi FROM employes;

--COUNT() permet de compter le nombre de ligne d'une requête 
-- Le nombre d'employés dans l'entreprise : 
SELECT COUNT(*) AS nombre_employes FROM employes; -- COUNT() va faire +1 pour chaque ligne qu'il rencontre et nous renvoie le total
+-----------------+
| nombre_employes |
+-----------------+
|              20 |
+-----------------+
SELECT COUNT(*) AS nombre_commerciaux FROM employes WHERE service = "commercial"; 
-- Mettez toujours * dans le COUNT (et non pas le nom d'un champ), sinon, en cas d'un champ NULL, la ligne ne sera pas comptée
+--------------------+
| nombre_commerciaux |
+--------------------+
|                  6 |
+--------------------+

-- MIN() & MAX()
-- salaire minimum
SELECT MIN(salaire) FROM employes;
+--------------+
| MIN(salaire) |
+--------------+
|         1390 |
+--------------+
-- salaire maximum
SELECT MAX(salaire) FROM employes;
+--------------+
| MAX(salaire) |
+--------------+
|         5000 |
+--------------+

-- EXERCICE : Affichez le salaire minimum ainsi que le prenom de l'employé ayant ce salaire (Julien Cottet)
SELECT prenom, MIN(salaire) FROM employes; -- Pas d'erreur mais le résultat est incohérent, il nous sort Jean-Pierre !
+-------------+--------------+
| prenom      | MIN(salaire) |
+-------------+--------------+
| Jean-pierre |         1390 |
+-------------+--------------+
-- MIN() c'est une fonction d'agrégation elle ne peut retourner qu'un seul résultat !!! 
-- Et la requête me sort ensuite le premier prénom qu'elle trouve dans la table soit : Jean-Pierre 

-- 2 solutions 

-- 1 - Requête imbriquée 
-- SELECT prenom, salaire FROM employes WHERE salaire = 1390;
SELECT prenom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes);
+--------+---------+
| prenom | salaire |
+--------+---------+
| Julien |    1390 |
+--------+---------+

-- 2 - ORDER BY et LIMIT
SELECT prenom, salaire FROM employes ORDER BY salaire ASC LIMIT 1;
+--------+---------+
| prenom | salaire |
+--------+---------+
| Julien |    1390 |
+--------+---------+


-- IN & NOT IN pour tester plusieurs valeurs 
-- Affichage des employés des services commercial et comptabilite 
SELECT * FROM employes WHERE service = "commercial" OR service = "comptabilite";
SELECT * FROM employes WHERE service IN ("commercial", "comptabilite");
+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         388 | Clement   | Gallet  | m    | commercial   | 2010-12-15    |    2300 |
|         415 | Thomas    | Winter  | m    | commercial   | 2011-05-03    |    3550 |
|         509 | Fabrice   | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
|         547 | Melanie   | Collier | f    | commercial   | 2012-01-08    |    3100 |
|         627 | Guillaume | Miller  | m    | commercial   | 2012-07-02    |    1900 |
|         655 | Celine    | Perrin  | f    | commercial   | 2012-09-10    |    2700 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
+-------------+-----------+---------+------+--------------+---------------+---------+

-- Tous les employés sauf ceux des services commercial et comptabilite 
SELECT * FROM employes WHERE service NOT IN ("commercial", "comptabilite");

-- Plusieurs conditions : AND 
-- On veut les employes du service commercial ayant un salaire inférieur ou égal à 2000 
SELECT * FROM employes WHERE service = "commercial" AND salaire <= 2000;

-- Vous pouvez sauter des lignes si vous le souhaitez, cela ne dérangera pas l'exécution de la requête en console
SELECT * 
FROM employes 
WHERE service = "commercial" 
AND salaire <= 2000;

-- L'une ou l'autre d'un ensemble de conditions : OR 
-- EXERCICE : Employes du service production ayant un salaire égal à 1900 ou 2300...  
SELECT * FROM employes WHERE service = "production" AND salaire = 1900 OR salaire = 2300; -- Résultat incorrent, on a aussi Clement du service commercial ??? 

SELECT * FROM employes WHERE (service = "production" AND salaire = 1900) OR (salaire = 2300); -- le système le comprend comme ceci (on a rajouté les parenthèses pour visualiser)


SELECT * FROM employes WHERE service = "production" AND salaire = 1900 OR  service = "production" AND salaire = 2300; 
SELECT * FROM employes WHERE service = "production" AND (salaire = 1900 OR salaire = 2300); 
SELECT * FROM employes WHERE service = "production" AND salaire IN (1900,2300); 

-- GROUP BY pour regrouper selon un ou plusieurs champs (généralement utilisé avec des fonctions d'agrégation)
-- Nombre d'employes par service 
SELECT COUNT(*), service FROM employes; -- Résultat incorrect ! COUNT() étant une fonction d'agrégation, elle ne peut renvoyer qu'une ligne, le service demandé n'a pas de rapport avec l'appel de cette fonction d'agrégation
+----------+-----------+
| COUNT(*) | service   |
+----------+-----------+
|       20 | direction |
+----------+-----------+

SELECT * FROM employes ORDER BY service; -- Visualition ici de chaque bloc par service (grace au group by)

-- Avec GROUP BY il est possible de demander de nous renvoyer le COUNT() en regroupant par service
-- En quelques sortes, chaque "bloc" de service est "extrait" du résultat de base et la fonction d'agrégation s'applique à chaque bloc séparément
SELECT COUNT(*) as nombre_employes, service FROM employes GROUP BY service;
+-----------------+---------------+
| nombre_employes | service       |
+-----------------+---------------+
|               2 | direction     |
|               6 | commercial    |
|               2 | production    |
|               3 | secretariat   |
|               1 | comptabilite  |
|               3 | informatique  |
|               1 | communication |
|               1 | juridique     |
|               1 | assistant     |
+-----------------+---------------+
-- Il est possible de mettre une condition sur un GROUP BY : HAVING (ayant) 
-- Nombre d'employés par service, pour les services ayant plus de 2 employés
SELECT COUNT(*) as nombre_employes, service FROM employes GROUP BY service HAVING COUNT(*) > 2;
+-----------------+--------------+
| nombre_employes | service      |
+-----------------+--------------+
|               6 | commercial   |
|               3 | secretariat  |
|               3 | informatique |
+-----------------+--------------+


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
---- REQUETES D'INSERTION (Action : enregistrement) -------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Ici je spécifie NULL pour la clé primaire (id_employes) pour la laisser s'auto incrémenter
INSERT INTO employes (id_employes, prenom, nom, salaire, sexe, service, date_embauche) VALUES (NULL, "Pierra", "Lacaze", 20000, "m", "formation", CURDATE());

-- Je peux ne pas citer la clé dans les champs dans lesquels insérer, de toute façon elle va s'auto incrémenter
INSERT INTO employes (prenom, nom, salaire, sexe, service, date_embauche) VALUES ("Pierro", "Lacaze", 20000, "m", "formation", CURDATE());

-- Je peux aussi omettre de citer la première paranthèse des champs dans lesquels j'insère, mais il faudra citer TOUS les champs dans leur ordre de la structure de la table 
INSERT INTO employes VALUES (NULL, "Pierru", "Lacaze", "m", "formation", CURDATE(), 20000  );


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
---- REQUETES DE MODIFICATION (Action : modification) -----------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- On modifie le salaire d'un employe 
UPDATE employes SET salaire = 2000 WHERE id_employes = 991;
-- On peut aussi faire plusieurs modifications à la fois 
UPDATE employes SET salaire = 2200, service = "informatique" WHERE id_employes = 992;

-- REPLACE 
-- Dans le cas d'une nouvelle valeur, le REPLACE va se comporter comme un INSERT INTO
-- Si la valeur est trouvée, elle sera "modifiée"
REPLACE INTO employes VALUES (994, "Polo", "Lolo", "m", "Web", CURDATE(), 3000);

REPLACE INTO employes VALUES (994, "Polo", "Lolo", "m", "Web", CURDATE(), 30000);

-- ATTENTION : NE JAMAIS UTILISER REPLACE 
    -- En fait, REPLACE INTO ne modifie pas un enregistrement, il le supprime pour le réinsérer ! 
        -- TRES GRAVE sur une base possedant des relations en CASCADE entre ses tables (CASCADE = réaction en chaine, pourrait supprimer des centaines/milliers d'autres enregistrement alors que l'on a souhaité simplement faire une modification !... :(   ))


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
---- REQUETES DE SUPPRESSION (Action : Supprimer) ---------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------    
DELETE FROM employes;  -- Cette requête supprime toutes les données de la table (équivaut à TRUNCATE, mais c'est une requête de type CRUD et non pas structure (attention au niveau des transactions))
DELETE FROM employes WHERE id_employes = 990;
-- On supprime généralement par rapport à une ou plusieurs conditions 
DELETE FROM employes WHERE id_employes > 800;

DELETE FROM employes WHERE service = "commercial" AND id_employes != 415;




-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
---- EXERCICES : ------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------   

-- 1 -- Afficher la profession de l'employé 547.
SELECT service FROM employes WHERE id_employes = 547;
+------------+
| service    |
+------------+
| commercial |
+------------+
-- 2 -- Afficher la date d'embauche d'Amandine.	
SELECT date_embauche FROM employes WHERE prenom = "Amandine";
+---------------+
| date_embauche |
+---------------+
| 2014-01-23    |
+---------------+
-- 3 -- Afficher le nom de famille de Guillaume	
SELECT nom FROM employes WHERE prenom = "Guillaume";
+--------+
| nom    |
+--------+
| Miller |
+--------+
-- 4 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.	
SELECT COUNT(*) FROM employes WHERE id_employes LIKE "5%";
+----------+
| COUNT(*) |
+----------+
|        3 |
+----------+
-- 5 -- Afficher le nombre de commerciaux.
SELECT COUNT(*) FROM employes WHERE service = "commercial";
+----------+
| COUNT(*) |
+----------+
|        6 |
+----------+
-- 6 -- Afficher le salaire moyen des informaticiens 
SELECT ROUND(AVG(salaire)) FROM employes WHERE service = "informatique";
+---------------------+
| ROUND(AVG(salaire)) |
+---------------------+
|                2617 |
+---------------------+
-- 7 -- Afficher les 5 premiers employés après avoir classé leur nom de famille par ordre alphabétique. 
SELECT * FROM employes ORDER BY nom LIMIT 5;
+-------------+---------+----------+------+--------------+---------------+---------+
| id_employes | prenom  | nom      | sexe | service      | date_embauche | salaire |
+-------------+---------+----------+------+--------------+---------------+---------+
|         592 | Laura   | Blanchet | f    | direction    | 2012-05-09    |    4500 |
|         854 | Daniel  | Chevel   | m    | informatique | 2015-09-28    |    3100 |
|         547 | Melanie | Collier  | f    | commercial   | 2012-01-08    |    3100 |
|         699 | Julien  | Cottet   | m    | secretariat  | 2013-01-05    |    1390 |
|         739 | Thierry | Desprez  | m    | secretariat  | 2013-07-17    |    1500 |
+-------------+---------+----------+------+--------------+---------------+---------+
-- 8 -- Afficher le coût des commerciaux sur 1 année.		
SELECT SUM(salaire*12) AS cout_annuel FROM employes WHERE service = "commercial";
+-------------+
| cout_annuel |
+-------------+
|      184200 |
+-------------+
-- 9 -- Afficher le salaire moyen par service. 
SELECT service, ROUND(AVG(salaire)) FROM employes GROUP BY service;
+---------------+---------------------+
| service       | ROUND(AVG(salaire)) |
+---------------+---------------------+
| direction     |                4750 |
| commercial    |                2558 |
| production    |                2225 |
| secretariat   |                1497 |
| comptabilite  |                2900 |
| informatique  |                2617 |
| communication |                2100 |
| juridique     |                3550 |
| assistant     |                1775 |
+---------------+---------------------+
-- 10 -- Afficher le nombre de recrutement sur l'année 2010 
SELECT COUNT(*) FROM employes WHERE date_embauche BETWEEN "2010-01-01" AND "2010-12-31";
SELECT COUNT(*) AS embauche_2010 FROM employes WHERE YEAR(date_embauche) = 2010;
+---------------+
| embauche_2010 |
+---------------+
|             2 |
+---------------+
-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2015 a 2017
SELECT AVG(salaire) FROM employes WHERE YEAR(date_embauche) BETWEEN 2015 AND 2017;
+--------------+
| AVG(salaire) |
+--------------+
|         2555 |
+--------------+
-- 12 -- Afficher le nombre de service différent 
SELECT COUNT(DISTINCT service) FROM employes;
+-------------------------+
| COUNT(DISTINCT service) |
+-------------------------+
|                       9 |
+-------------------------+
-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT * FROM employes WHERE service NOT IN ("production", "secretariat");
-- 14 -- Afficher conjointement le nombre d'homme et de femme dans l'entreprise
SELECT COUNT(*), sexe FROM employes GROUP BY sexe;
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2012 de sexe masculin et gagnant un salaire supérieur a 2500 €
SELECT * FROM employes WHERE service = "commercial" AND sexe = "m" AND date_embauche < "2012-01-01" AND salaire > 2500;
-- 16 -- Qui a été embauché en dernier 
SELECT * FROM employes ORDER BY date_embauche DESC LIMIT 1;
-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT * FROM employes WHERE service = "commercial" ORDER BY salaire DESC LIMIT 1;
-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire 
SELECT prenom FROM employes WHERE service = "comptabilite" ORDER BY salaire DESC LIMIT 1;
-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier 
SELECT prenom FROM employes WHERE service = "informatique" ORDER BY date_embauche ASC LIMIT 1;
-- 20 -- Augmenter chaque employé de 100 €
UPDATE employes SET salaire = salaire + 100;
-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes WHERE service = "secretariat";
