---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------- LES EVENEMENTS -------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

-- Un évènement permet de programmer des actions sur notre bdd, par rapport à une notion de temps 
-- Gérer une insertion à une date spécifique
-- Gérer des copies de tables chaque jour à une heure spécifique
-- Gérer des insertions automatiques chaque minute 

-- Il se peut que sur votre serveur les évènements soient désactivés
SHOW GLOBAL VARIABLES LIKE 'event_scheduler'; -- On peut voir ici si les évènements sont sur ON ou OFF
SET GLOBAL event_scheduler = 1; -- Permet de passer sur ON nos évènements 


USE entreprise;
-- Syntaxe de création d'un évènement 
CREATE EVENT insert_employes 
ON SCHEDULE EVERY 1 MINUTE 
DO INSERT INTO employes (prenom) VALUES ("Pierra");
-- Cet évent au dessus gère une insertion dans la table employes, chaque minute 


-- Cet évènement est de type "one time", c'est une seule insertion unique à l'heure de maintenant + 2 minutes 
CREATE EVENT insert2 
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 2 MINUTE 
DO INSERT INTO employes (prenom) VALUES ("Boby");

-- Via les évènements on peut aussi lancer des procédures stockées 


-- On peut aussi faire des évènements recurring (qui se répète) en spécifiant une date de départ (pas forcément tout de suite)
CREATE EVENT insert_employes3 
ON SCHEDULE EVERY 1 MINUTE STARTS "2024-12-18 15:27:00"
DO INSERT INTO employes (prenom) VALUES ("Polo");

-- On peut aussi définir une date de fin d'un évènement recurring 

CREATE EVENT insert_employes4
ON SCHEDULE EVERY 1 MINUTE
ENDS CURRENT_TIMESTAMP + INTERVAL 5 MINUTE
DO INSERT INTO employes (prenom) VALUES ("Willy");


CREATE TABLE IF NOT EXISTS journal (
  id_journal int(10) NOT NULL AUTO_INCREMENT,
  titre varchar(20) NOT NULL,
  texte text NOT NULL,
  PRIMARY KEY (id_journal)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

INSERT INTO journal (titre, texte) VALUES ("Bientot Noel", "Les enfants vont recevoir plein de cadeaux ! ");

CREATE TABLE IF NOT EXISTS journal_copie (
  id_journal int(10) NOT NULL AUTO_INCREMENT,
  titre varchar(20) NOT NULL,
  texte text NOT NULL,
  PRIMARY KEY (id_journal)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DELIMITER $
CREATE EVENT backup_journal
    ON SCHEDULE EVERY 1 MINUTE 
        DO 
            BEGIN 
            DELETE FROM journal_copie;

            INSERT INTO journal_copie SELECT * FROM journal; 
            END 
        $


 ----- EXERCICES --------------------

-- 	 Exercice 1 : Notification pour les emprunts en retard

-- Créez un événement qui :

--     Exécute tous les jours à minuit.
--     Inscrit dans une table emprunts_en_retard (à créer) les abonnés qui ont des emprunts dont la date_rendu est NULL et dont la date_sortie dépasse 30 jours.
	CREATE TABLE emprunts_en_retard (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_abonne INT NOT NULL,
  id_livre INT NOT NULL,
  date_sortie DATE NOT NULL
) ENGINE=InnoDB;

-- Exercice 2 : Archivage des emprunts terminés

--     Créez une table historique_emprunts pour stocker les emprunts dont la date_rendu est renseignée.
--     Créez un événement qui exécute tous les mois pour déplacer les emprunts terminés dans cette table.
CREATE TABLE historique_emprunts (
  id_emprunt INT NOT NULL,
  id_livre INT NOT NULL,
  id_abonne INT NOT NULL,
  date_sortie DATE NOT NULL,
  date_rendu DATE NOT NULL,
  PRIMARY KEY (id_emprunt)
) ENGINE=InnoDB;

-- Exercice 3 : Comptage des emprunts mensuels

--     Créez une table stats_emprunts pour stocker les statistiques mensuelles (mois, année, nombre d’emprunts).
--     Créez un événement qui s’exécute chaque début de mois pour calculer le nombre d’emprunts effectués le mois précédent.
CREATE TABLE stats_emprunts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  mois INT NOT NULL,
  annee INT NOT NULL,
  total_emprunts INT NOT NULL
) ENGINE=InnoDB;

-- Exercice 4 : Notification d’emprunts par auteur

--     Créez un événement qui exécute tous les jours pour insérer dans une table statistiques_auteurs les statistiques des emprunts par auteur pour les livres empruntés la veille.
CREATE TABLE statistiques_auteurs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  auteur VARCHAR(25),
  total_emprunts INT,
  date_stat DATE
) ENGINE=InnoDB;