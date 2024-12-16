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
-- salaire maximum
SELECT MAX(salaire) FROM employes;
