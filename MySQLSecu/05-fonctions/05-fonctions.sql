---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------- FONCTIONS PREDEFINIES ------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

-- Ici quelques exemples de fonctions prédéfinies 

USE bibliotheque;

SELECT DATABASE(); -- Fonction indiquant quelle est la bdd actuellement utilisée 

SELECT LAST_INSERT_ID(); -- Le dernier id inséré dans la BDD (auto incrémenté!)
    -- Attention, c'est sur la session en cours ! Une fois la session terminée, l'instruction n'est plus pas capable de vous renvoyer l'id 
    -- On le manipule souvent pour récupérer l'id d'un élément qu'on vient d'insérer en BDD 

SELECT CONCAT("a", "b", "c"); -- Permet de concaténer 
SELECT CONCAT_WS(" - ", "a", "b", "c");

-- Pratique pour réunir dans une même colonne plusieurs champs/colonnes différentes
-- comme nom/prénom, ou adresse/codepostal/ville 
SELECT CONCAT_WS(" - ", id_abonne, prenom) AS liste FROM abonne;

SELECT SUBSTRING("bonjour", 4); -- Couper une chaine

SELECT LOCATE("j", "aujourdhui"); -- Localiser la position d'une occurence dans une chaine

SELECT UPPER("hey"); -- Mettre en majuscule 

SELECT TRIM("   Pierra  ") AS login; -- Suppression des espaces en debut et fin de chaine de caractères 

SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 MONTH);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);


SELECT date_sortie, DATE_ADD(date_sortie, INTERVAL 1 MONTH) AS date_limite FROM emprunt;

SELECT CURDATE(); -- la date du jour
SELECT CURDATE() + 0; -- la date du jour sans tirets, par exemple pour nommer un fichier 

SELECT CURRENT_TIMESTAMP; -- Retourne la date et l'heure de l'instant T 
SELECT NOW(); -- Pareil, date et heure de l'instant T 
-- FROM_UNIXTIME() -- Transforme un timestamp en date/heure normale
SELECT UNIX_TIMESTAMP(CURDATE()); -- Transforme une date en timestamp 

SELECT DAYNAME(CURDATE());

SELECT prenom, DATE_FORMAT(date_sortie, "%d/%m/%Y") as date_fr FROM abonne, emprunt 
WHERE abonne.id_abonne = emprunt.id_abonne;
