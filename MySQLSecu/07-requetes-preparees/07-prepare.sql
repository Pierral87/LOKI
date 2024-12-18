--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--------------------------- REQUETE PREPAREE -----------------------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


-- Cycle d'une requête préparée :  Analyse / Interprétation / Exécution 
-- Lors d'une requête "prepare" on écrit d'abord la requête, c'est une analyse de la requête qui va être lancée
-- Deuxieme chose : Et interprête cette requête en y ajoutant les valeurs nécessaires (on va coller des valeurs souvent contenues dans des variables, dans les marqueurs attendus)
-- Enfin, on exécute la requête 

USE entreprise;

PREPARE req FROM 'SELECT * FROM employes WHERE service = "commercial"';

EXECUTE req;

PREPARE req2 FROM 'SELECT * FROM employes WHERE prenom=?'; -- Je déclare ici une requête qui attends un param symbolisé par le ? 

SET @prenom = "Thomas"; -- Je défini une variable @prenom qui contient Thomas 

EXECUTE req2 USING @prenom; -- J'exécute la requête en transmettant la var @prenom, elle remplacera le ? 