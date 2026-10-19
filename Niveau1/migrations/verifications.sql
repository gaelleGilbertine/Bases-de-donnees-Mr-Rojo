-- ETAPE 1
--afficher les plats du plus cher au moins cher.
SELECT * FROM plat ORDER BY prix DESC;
-- Pour le prix j'ai choisi INTEGER comme type et j'ai choisi id_plat en cle primaire pour l'identifiant


-- ETAPE 2
--nombre de plats par catégorie, y compris les catégories sans plat
SELECT COUNT(plat.id), categorie.nom FROM categorie LEFT JOIN plat on plat.id_categorie = categorie.id_categorie GROUP BY categorie.nom ;
-- on ajoute pas juste categorie VARCHAR(50) dans la table des plats car ca pourrait entrainer des erreur de calcule. par exemple si dans categorie il y a une faute de frappe comme plat malagasy et l'autre plat malgache ca pourait fausser le resultat si je veux connaitre le nombre de plat dans la categorie plat malgache


-- ETAPE 3
--montant total de chaque commande
SELECT SUM(plat.prix * quantite), id_commande FROM ligne_commande JOIN plat on plat.id = ligne_commande.id_plat GROUP BY id_commande;
--je place la quantite dans ligne_commande


-- ETAPE 4
-- liste des commandes avec le nom du client, en affichant « client de passage » quand il n'y en a pas.
SELECT id_commande, COALESCE(clients.nom, 'client de passage') FROM commande LEFT JOIN clients on commande.id_client = clients.id_client ;
--oui ma cle etrangere est NOT NULL. pour ne perdre aucune commande il faut la jointure LEFT JOIN