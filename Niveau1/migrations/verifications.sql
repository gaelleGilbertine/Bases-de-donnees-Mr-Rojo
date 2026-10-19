-- ETAPE 1
--afficher les plats du plus cher au moins cher.
SELECT * FROM plat ORDER BY prix DESC;
-- Pour le prix j'ai choisi INTEGER comme type et j'ai choisi id_plat en cle primaire pour l'identifiant


-- ETAPE 2
--nombre de plats par catégorie, y compris les catégories sans plat
SELECT COUNT(plat.id), categorie.nom FROM categorie LEFT JOIN plat on plat.id_categorie = categorie.id_categorie GROUP BY categorie.nom ;
-- on ajoute pas juste categorie VARCHAR(50) dans la table des plats car ca pourrait entrainer des erreur de calcule. par exemple si dans categorie il y a une faute de frappe comme plat malagasy et l'autre plat malgache ca pourait fausser le resultat si je veux connaitre le nombre de plat dans la categorie plat malgache