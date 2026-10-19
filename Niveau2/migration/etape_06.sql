CREATE TABLE payement (
    id_payement SERIAL PRIMARY KEY,
    nom VARCHAR
);

CREATE TABLE ligne_payement (
    id_commande INTEGER REFERENCES commande(id_commande),
    id_payement INTEGER REFERENCES payement(id_payement),
    montant INTEGER ,
    PRIMARY KEY(id_commande, id_payement)
);

INSERT INTO payement(nom) VALUES 
('espèces'),
('MVola'),
('Orange Money');

INSERT INTO ligne_payement(id_commande, id_payement, montant) VALUES
(1, 1, 10000),
(1, 2, 5000),
(2, 3, 6000);
