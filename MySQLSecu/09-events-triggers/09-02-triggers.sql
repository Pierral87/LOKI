----------------------------------------------------------------------------
----------------------------------------------------------------------------
--------------- TRIGGERS ---------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

-- Un Trigger nous permet de faire un traitement comme une fonction ou une procédure MAIS, on ne peut pas l'exécuter directement 
-- Par contre, on peut spécifier l'action qui déclenchera ce trigger.

-- Les triggers se déclenchent afin d'automatiser des taches à la suite de certaines actions 

CREATE TABLE IF NOT EXISTS employes_informations (
  id_employes_informations int(3) NOT NULL AUTO_INCREMENT,
  nombre int NOT NULL,
  derniere_date_embauche date NOT NULL,
  PRIMARY KEY (id_employes_informations)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

-- Ici cette table me sert à conserver le nombre d'employés actuellement dans l'entreprise ainsi que la dernière date d'embauche 

-- On va mettre en place un trigger qui aura pour but de mettre à jour ces informations après chaque insertion de nouvel employé ! 


DELIMITER $
CREATE TRIGGER maj_info_employes AFTER INSERT ON employes 
FOR EACH ROW 
BEGIN 
    UPDATE employes_informations SET nombre = nombre + 1, derniere_date_embauche = NEW.date_embauche;
END $ 

-- AFTER INSERT ON  indique que le trigger se lance après chaque insertion, ici sur la table employes
-- FOR EACH ROW pour dire qu'il se lance à chaque fois / à chaque insert 
-- nombre = nombre + 1   pour gérer l'incrémentation du nombre d'employés 
-- La notion des valeurs NEW et OLD 
    -- NEW. permet d'accèder à la valeur entrante (une valeur venant de mon insertion (uniquement dans le cas d'un UPDATE ou INSERT))
    -- OLD. permet d'accèder à la valeur sortante (la valeur qui sera remplacée ou supprimée (uniquement dans le cas d'un UPDATE ou DELETE))

----------------------------------- EXERCICES -------------------------------------------------
--# Exercice 1/ création de la table de "employes_sauvegarde" : Exactement la méme table que la table employes avec les mémes champs mais vide !
CREATE TABLE IF NOT EXISTS employes_sauvegarde (
  id_employes int(4) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB; DEFAULT CHARSET=utf8mb4;
--# exercice : Faite en sorte d'inscrire des données dans "employes_sauvegarde" pour toute nouvelle insertion dans la table employes (en plus de la maj sur la table employes_informations)


--# Exercice 2/ Création d'une table "employes_supprime" : Exactement la méme table que la table employes avec les mémes champs mais vide !
CREATE TABLE IF NOT EXISTS employes_supprime (
  id_employes int(4) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB $DEFAULT CHARSET=utf8mb4;
--# exercice : Faite en sorte d'enregistrer tous les employes supprimés de la table employes, dans cette table. Cela nous servira de corbeille.

--# Exercice 3/ Création de la table "employes_salaire"
CREATE TABLE IF NOT EXISTS employes_salaire (
  id_employes_salaire int(11) NOT NULL AUTO_INCREMENT,
  id_employes int(11) NOT NULL,
  champ varchar(15) NOT NULL DEFAULT 'salaire',
  ancien int(11) NOT NULL,
  nouveau int(11) NOT NULL,
  difference int(11) NOT NULL,
  date_modification datetime NOT NULL,
  PRIMARY KEY (id_employes_salaire)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;
--# exercice : Dés que le salaire d'un employes est changé (et uniquement dans ce cas), nous voulons conserver l'historique des changement de salaire dans une table "employes_salaire"


--# Exercice 5/ Création dune table "employes_action"
CREATE TABLE IF NOT EXISTS employes_action (
  id_action int(11) NOT NULL AUTO_INCREMENT,
  id_employes int(11) NOT NULL,
  requete enum('update','delete','insert') NOT NULL,
  date_action datetime NOT NULL,
  PRIMARY KEY (id_action)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--# Le but de l'exercice est de repertorier les actions passées sur la table employes (INSERT, UPDATE, DELETE)  - 3 triggers 

