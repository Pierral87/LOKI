CREATE DATABASE bibliotheque;
USE bibliotheque;

CREATE TABLE abonne (
  id_abonne INT(3) NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_abonne)
) ENGINE=InnoDB ;

INSERT INTO abonne (id_abonne, prenom) VALUES
(1, 'Guillaume'),
(2, 'Benoit'),
(3, 'Chloe'),
(4, 'Laura');


CREATE TABLE livre (
  id_livre INT(3) NOT NULL AUTO_INCREMENT,
  auteur VARCHAR(25) NOT NULL,
  titre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_livre)
) ENGINE=InnoDB ;

INSERT INTO livre (id_livre, auteur, titre) VALUES
(100, 'GUY DE MAUPASSANT', 'Une vie'),
(101, 'GUY DE MAUPASSANT', 'Bel-Ami '),
(102, 'HONORE DE BALZAC', 'Le pere Goriot'),
(103, 'ALPHONSE DAUDET', 'Le Petit chose'),
(104, 'ALEXANDRE DUMAS', 'La Reine Margot'),
(105, 'ALEXANDRE DUMAS', 'Les Trois Mousquetaires');

CREATE TABLE emprunt (
  id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
  id_livre INT(3) DEFAULT NULL,
  id_abonne INT(3) DEFAULT NULL,
  date_sortie DATE NOT NULL,
  date_rendu DATE DEFAULT NULL,
  PRIMARY KEY  (id_emprunt)
) ENGINE=InnoDB ;

INSERT INTO emprunt (id_emprunt, id_livre, id_abonne, date_sortie, date_rendu) VALUES
(1, 100, 1, '2016-12-07', '2016-12-11'),
(2, 101, 2, '2016-12-07', '2016-12-18'),
(3, 100, 3, '2016-12-11', '2016-12-19'),
(4, 103, 4, '2016-12-12', '2016-12-22'),
(5, 104, 1, '2016-12-15', '2016-12-30'),
(6, 105, 2, '2017-01-02', '2017-01-15'),
(7, 105, 3, '2017-02-15', NULL),
(8, 100, 2, '2017-02-20', NULL);

-- Quels sont les id_livre des livres qui n'ont pas été rendu à la bibliothèque ? 
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
-- Attention la valeur NULL se teste avec IS ou IS NOT
+----------+
| id_livre |
+----------+
|      105 |
|      100 |
+----------+

-- Pour avoir les titres des livres, ces informations sont sur une autre table... 
-- 2 possibilités :
    -- Requêtes imbriquées 
    -- Requêtes en jointure 

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
------------ REQUETES IMBRIQUEES (sur plusieurs tables) -----------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Quels sont les titres des livres qui n'ont pas été rendu à la bibliothèque ? 
-- SELECT titre FROM livre WHERE id_livre IN (105, 100);

-- Les requêtes imbriquées s'executent si on voulait l'imaginer de façon logique, par la fin
-- On a besoin du résultat de la "sous requête" pour mener à bien la première requête
SELECT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+

-- EXERCICE 1: Quels sont les prénoms des abonnés n'ayant pas rendu un livre à la bibliotheque.
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL);
-- EXERCICE 2 : Nous aimerions connaitre le(s) n° des livres empruntés par Chloé
SELECT id_livre FROM emprunt WHERE id_abonne IN 
    (SELECT id_abonne FROM abonne WHERE prenom = "Chloe");
-- EXERCICE 3: Affichez les prénoms des abonnés ayant emprunté un livre le 07/12/2016.
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE date_sortie = "2016-12-07");
-- EXERCICE 4: combien de livre Guillaume a emprunté à la bibliotheque ?
SELECT COUNT(*) FROM emprunt WHERE id_abonne IN 
    (SELECT id_abonne FROM abonne WHERE prenom = "Guillaume");
-- EXERCICE 5: Affichez la liste des abonnés ayant déjà emprunté un livre d'Alphonse Daudet
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE id_livre IN 
        (SELECT id_livre FROM livre WHERE auteur LIKE "%Daudet"));
-- EXERCICE 6: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque.
SELECT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne = 
        (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
-- EXERCICE 7: Nous aimerions connaitre les titres des livres que Chloe n'a pas emprunté à la bibliotheque.
SELECT titre FROM livre WHERE id_livre NOT IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne = 
        (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
-- EXERCICE 8: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque ET qui n'ont pas été rendu.
SELECT DISTINCT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne IN 
        (SELECT id_abonne FROM abonne WHERE prenom = "Chloe") AND date_rendu IS NULL);
-- EXERCICE 9 : Qui a emprunté le plus de livre à la bibliotheque ?
SELECT prenom FROM abonne WHERE id_abonne = 
    (SELECT id_abonne FROM emprunt GROUP BY id_abonne ORDER BY COUNT(*) DESC LIMIT 1);



-- La requête ci dessous si on veut afficher plusieurs abonnées si ils ont le même nombre d'emprunt (si le nombre le plus élevé d'emprunts est 3, et qu'ils sont plusieurs à avoir 3 emprunts, je peux en retourner plusieurs, contrairement à la requête ci dessus)
-- On passe ici par la création d'une table temporaire via un jeu de résultat, c'est pour ça que je fais un FROM sur une requête et non une table, et je dois donner un alias à cette table pour que cela fonctionne
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt GROUP BY id_abonne HAVING COUNT(*) = 
        (SELECT MAX(nbr_emprunt) FROM (SELECT COUNT(*) AS nbr_emprunt FROM emprunt GROUP BY id_abonne) AS compte));


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
------------ REQUETES EN JOINTURE (sur plusieurs tables) ----------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Une jointure c'est toujours possible ! 
-- Une imbriquée est possible uniquement si les champs que l'on souhaite afficher/récupérer proviennent d'une seule table 

-- Avec des requêtes imbriquées on parcourt les tables les unes après les autres (en passant toujours par le champ commun (PK/FK))
-- Avec des requêtes en jointure, on mélange les champs de sorties, les tables, les conditions sans que cela nous pose de problèmes

-- Nous aimerions connaître les dates de sorties et les dates de rendu pour l'abonné Guillaume tout en affichant le prénom Guillaume à côté de ces dates

    -- En imbriquée ce n'est pas possible ! Les infos des dates de rendus sont sur la table emprunt et l'info "Guillaume" sur la table abonne 

-- Em imbriquée je suis capable d'afficher uniquement les dates, éventuellement l'id de Guillaume, mais pas le prenom
    SELECT id_abonne, date_sortie, date_rendu FROM emprunt WHERE id_abonne = 
        (SELECT id_abonne FROM abonne WHERE prenom = "Guillaume");


-- En jointure, plusieurs syntaxes : 

SELECT abonne.prenom, emprunt.date_sortie, emprunt.date_rendu   -- Ce que je veux afficher, de plusieurs tables différentes 
FROM emprunt, abonne                                            -- Les tables que j'ai besoin de manipuler
WHERE prenom = "Guillaume"                                      -- Ma condition du prénom Guillaume
AND abonne.id_abonne = emprunt.id_abonne;                       -- La création de la jointure (on indique ici les champs que se correspondent entre nos deux tables)


-- Même requête avec des raccourcis d'écriture pour les prefixes des tables 
SELECT a.prenom, e.date_sortie, e.date_rendu   
FROM emprunt e, abonne a                                        
WHERE prenom = "Guillaume"                                      
AND a.id_abonne = e.id_abonne;   


-- Autre syntaxe pour les jointures 
-- En utilisant INNER JOIN ou JOIN 
-- Avec cette méthode on joint les tables une par une 
SELECT a.prenom, e.date_sortie, e.date_rendu   
FROM abonne a
INNER JOIN emprunt e USING (id_abonne) 
WHERE prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu   
FROM abonne a
JOIN emprunt e USING (id_abonne) -- Ici on utilise USING car par chance notre champ commun (PK/FK) a le même nom sur les deux tables
WHERE prenom = "Guillaume";


SELECT a.prenom, e.date_sortie, e.date_rendu   
FROM abonne a
INNER JOIN emprunt e ON a.id_abonne = e.id_abonne -- On pourrait utiliser ON si jamais le champ ne s'appelait de la même manière sur nos deux tables 
WHERE prenom = "Guillaume";

-- EXERCICE 1 : Nous aimerions connaitre les dates de sortie et les dates de rendu pour les livres écrit par Alphonse Daudet
SELECT e.date_sortie, e.date_rendu 
FROM emprunt e, livre l
WHERE auteur = "Alphonse Daudet"
AND e.id_livre = l.id_livre;
-- EXERCICE 2 : Qui a emprunté le livre "une vie" sur l'année 2016 
SELECT abonne.prenom 
FROM emprunt 
INNER JOIN livre ON emprunt.id_livre = livre.id_livre 
INNER JOIN abonne ON emprunt.id_abonne = abonne.id_abonne 
WHERE livre.titre = "Une vie"
AND YEAR(date_sortie) = 2016;
-- EXERCICE 3 : Nous aimerions connaitre le nombre de livre emprunté par chaque abonné 
SELECT COUNT(*) AS nombre_emprunts, a.prenom 
FROM emprunt e 
INNER JOIN abonne a ON e.id_abonne = a.id_abonne 
GROUP BY e.id_abonne;
-- EXERCICE 4 : Nous aimerions connaitre le nombre de livre emprunté à rendre par chaque abonné 
SELECT COUNT(*), a.prenom 
FROM emprunt e 
INNER JOIN abonne a ON e.id_abonne = a.id_abonne 
WHERE e.date_rendu IS NULL 
GROUP BY a.id_abonne;
-- EXERCICE 5 : Qui (prenom) a emprunté Quoi (titre) et Quand (date_sortie) ?
SELECT a.prenom, l.titre, e.date_sortie 
FROM abonne a 
INNER JOIN emprunt e USING (id_abonne)
INNER JOIN livre l USING (id_livre);
-- WHERE date_sortie IS NOT NULL 
-- GROUP BY a.prenom, l.titre, e.date_sortie;


-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
------------ JOINTURE EXTERNE (sans correspondance exigée) --------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Enregistrez vous dans la table abonne 
INSERT INTO abonne (prenom) VALUES ("Pierra");
SELECT * FROM abonne;

-- Affichez tous les prenoms des abonnées SANS EXCEPTION ainsi que les id_livre qu'ils ont emprunté si c'est le cas 
SELECT prenom, id_livre 
FROM abonne, emprunt 
WHERE abonne.id_abonne = emprunt.id_abonne;
+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Benoit    |      101 |
| Chloe     |      100 |
| Laura     |      103 |
| Guillaume |      104 |
| Benoit    |      105 |
| Chloe     |      105 |
| Benoit    |      100 |
| Chloe     |      100 |
+-----------+----------+
-- Nous n'apparaissons pas dans le résultat ! 
-- Ce que l'on fait depuis tout à l'heure ce sont des jointures "interne", elle ne sort du résultat que lorsque il y a une correspondance avec la table jointe
-- Ici Pierra n'a pas de correspondance dans la table emprunt, donc il n'apparait pas (voir schéma sur la page jointure de la doc : https://sql.sh/cours/jointures )

-- Pour récupérer l'intégralité d'une table et obtenir toutes les informations, on a besoin de faire une jointure EXTERNE 

-- Jointure externe : LEFT JOIN ou RIGHT JOIN
-- LEFT ou RIGHT permettent de donner la priorité à la table selon sa position dans le sens de lecture 
SELECT prenom, id_livre 
FROM abonne LEFT JOIN emprunt USING (id_abonne); -- Ici abonne est "le bout de chaine" de la jointure, on fait une jointure LEFT, donc c'est la table citée en premier qui sera "prioritaire" et de laquelle on récupèrera la totalité des informations 

SELECT prenom, id_livre 
FROM emprunt RIGHT JOIN abonne USING (id_abonne); -- Ici on a fait la même chose mais avec RIGHT, donc c'est la table citée en dernier qui sera prioritaire et récupèrera la totalité des enregistrements même sans correspondances
+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      104 |
| Guillaume |      100 |
| Benoit    |      100 |
| Benoit    |      105 |
| Benoit    |      101 |
| Chloe     |      100 |
| Chloe     |      105 |
| Chloe     |      100 |
| Laura     |      103 |
| Pierra    |     NULL |
+-----------+----------+

-- EXERCICE 1 : Affichez tous les livres sans exception puis les id_abonne ayant emprunté ces livres si c'est le cas
SELECT titre, id_abonne FROM livre LEFT JOIN emprunt USING (id_livre);
-- EXERCICE 2 : Affichez tous les prénoms des abonnés et s'ils ont fait des emprunts, affichez les id_livre, auteur et titre
SELECT prenom, id_livre, auteur, titre 
FROM abonne LEFT JOIN emprunt USING (id_abonne) LEFT JOIN livre USING (id_livre);
-- EXERCICE 3 : Affichez tous les prénoms des abonnés, tous les titres des livres et les informations des emprunts également 

SELECT a.prenom, l.titre, e.date_sortie, e.date_rendu
FROM abonne a
LEFT JOIN emprunt e  USING (id_abonne)
LEFT JOIN livre l USING (id_livre)
UNION
SELECT a.prenom, l.titre, e.date_sortie, e.date_rendu
FROM livre l
LEFT JOIN emprunt e USING (id_livre)
LEFT JOIN abonne a USING (id_abonne);


SELECT a.prenom, l.titre, e.date_sortie, e.date_rendu
FROM abonne a
LEFT JOIN emprunt e  USING (id_abonne)
RIGHT JOIN livre l USING (id_livre);