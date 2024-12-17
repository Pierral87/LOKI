-- UNION permet de fusionner plusiuers résultats en un seul (voir dernier exercice des jointures externes)

-- ATTENTION le nombre de champs attendus doit être le même dans les requêtes concernées 

-- UNION applique un DISTINCT par défaut pour ne pas avoir de doublons 

SELECT prenom AS liste_personnes FROM abonne 
UNION
SELECT auteur FROM livre;
+-------------------+
| liste_personnes   |
+-------------------+
| Guillaume         |
| Benoit            |
| Chloe             |
| Laura             |
| Pierra            |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
+-------------------+

-- Pour avoir les doublons : 
-- UNION ALL 

SELECT prenom AS liste_personnes FROM abonne 
UNION ALL 
SELECT auteur FROM livre;
+-------------------+
| liste_personnes   |
+-------------------+
| Guillaume         |
| Benoit            |
| Chloe             |
| Laura             |
| Pierra            |
| GUY DE MAUPASSANT |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
| ALEXANDRE DUMAS   |
+-------------------+