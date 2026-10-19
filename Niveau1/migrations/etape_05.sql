CREATE TABLE serveur (
    id_serveur SERIAL PRIMARY KEY ,
    nom VARCHAR(255)
);

CREATE TABLE tabless (
    id_table SERIAL PRIMARY KEY,
    numero INTEGER
);

ALTER TABLE commande ADD COLUMN id_serveur INTEGER;
ALTER TABLE commande ADD COLUMN id_table INTEGER;

INSERT INTO serveur(nom) VALUES 
('Njaka Rakoto'),
('Lalao Rasoa');

INSERT INTO tabless(numero) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

UPDATE commande SET id_serveur = 1 where id_commande = 1;
UPDATE commande SET id_serveur = 2 where id_commande = 2;
UPDATE commande SET id_serveur = 1 where id_commande = 3;
UPDATE commande SET id_serveur = 2 where id_commande = 4;
UPDATE commande SET id_serveur = 1 where id_commande = 5;
UPDATE commande SET id_serveur = 1 where id_commande = 6;
UPDATE commande SET id_serveur = 2 where id_commande = 7;


UPDATE commande SET id_table = 1 where id_commande = 1;
UPDATE commande SET id_table = 2 where id_commande = 2;
UPDATE commande SET id_table = 3 where id_commande = 3;
UPDATE commande SET id_table = 4 where id_commande = 4;
UPDATE commande SET id_table = NULL where id_commande = 5;
UPDATE commande SET id_table = NULL where id_commande = 6;
UPDATE commande SET id_table = 2 where id_commande = 7;



ALTER TABLE commande ALTER COLUMN id_serveur SET NOT NULL;
