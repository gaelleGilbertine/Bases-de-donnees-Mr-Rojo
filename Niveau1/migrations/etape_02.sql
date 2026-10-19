CREATE TABLE categorie (
    id_categorie SERIAL PRIMARY KEY,
    nom VARCHAR(255) NULL NULL
);

ALTER TABLE plat ADD COLUMN id_categorie INTEGER ;

INSERT INTO categorie(nom) VALUES 
('Plat malagasy'),
('Plat chinois'),
('Soupe'),
('Dessert et goûter'),
('Boisson');

INSERT INTO categorie(nom) VALUES ('Plat coreen');
UPDATE plat SET id_categorie = 1 WHERE id = 1;
UPDATE plat SET id_categorie = 1 WHERE id = 2;
UPDATE plat SET id_categorie = 1 WHERE id = 3;
UPDATE plat SET id_categorie = 2 WHERE id = 4;
UPDATE plat SET id_categorie = 3 WHERE id = 5;
UPDATE plat SET id_categorie = 4 WHERE id = 6;
UPDATE plat SET id_categorie = 5 WHERE id = 7;
ALTER COLUMN id_categorie SET NOT NULL;
ALTER TABLE plat ADD FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie);