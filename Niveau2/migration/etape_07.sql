UPDATE plat SET prix = 500 WHERE id = 1;
ALTER TABLE ligne_commande ADD COLUMN prix_unitaire INTEGER;

UPDATE ligne_commande SET prix_unitaire = 7000 WHERE id_plat = 1 ;
UPDATE ligne_commande SET prix_unitaire = 8000 WHERE id_plat = 2 ;
UPDATE ligne_commande SET prix_unitaire = 8500 WHERE id_plat = 3 ;
UPDATE ligne_commande SET prix_unitaire = 6000 WHERE id_plat = 4 ;
UPDATE ligne_commande SET prix_unitaire = 5000 WHERE id_plat = 5 ;
UPDATE ligne_commande SET prix_unitaire = 1000 WHERE id_plat = 6 ;
UPDATE ligne_commande SET prix_unitaire = 500 WHERE id_plat = 7 ;

CREATE TABLE historique_prix (
    id_prix SERIAL PRIMARY KEY,
    id_plat INTEGER REFERENCES plat(id),
    prix INTEGER,
    date_debut DATE,
    date_fin DATE
)
