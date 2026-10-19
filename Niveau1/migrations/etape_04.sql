CREATE TABLE clients(
    id_client SERIAL PRIMARY KEY,
    nom VARCHAR(255)
)

ALTER TABLE commande ADD COLUMN id_client INTEGER ;
INSERT INTO clients(nom) VALUES
('Gaelle'),
('user'),
('client'),
('Sarobidy'),
(NULL);

UPDATE clients SET nom = '' WHERE id_client = 6;

UPDATE commande SET id_client = 1 WHERE id_commande = 1;
UPDATE commande SET id_client = 2 WHERE id_commande = 2;
UPDATE commande SET id_client = 3 WHERE id_commande = 3;
UPDATE commande SET id_client = 4 WHERE id_commande = 4;
UPDATE commande SET id_client = 5 WHERE id_commande = 5;
UPDATE commande SET id_client = 5 WHERE id_commande = 6;
UPDATE commande SET id_client = 4 WHERE id_commande = 7;


ALTER TABLE commande ALTER COLUMN id_client SET NOT NULL;
ALTER TABLE commande ADD FOREIGN KEY (id_client) REFERENCES clients(id_client);
