CREATE TABLE ligne_commande(
    id_commande INTEGER REFERENCES commande(id_commande),
    id_plat INTEGER REFERENCES plat(id),
    dates DATE,
    quantite INTEGER,
    PRIMARY KEY (id_commande, id_plat)
);

CREATE TABLE commande(
    id_commande SERIAL PRIMARY KEY
);

INSERT INTO commande(id_commande) VALUES 
(1),
(2),
(3),
(4),
(5),
(6),
(7);

INSERT INTO ligne_commande(id_commande, id_plat, dates, quantite) VALUES 
(1, 1, '2026-10-15', 2),
(1, 2, '2026-10-15', 5),
(2, 3, '2026-10-14', 3),
(3, 5, '2026-10-14', 2),
(4, 2, '2026-10-15', 1),
(5, 3, '2026-10-15', 2),
(6, 1, '2026-10-15', 3),
(7, 2, '2026-10-15', 2);
