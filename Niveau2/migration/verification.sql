-- ETAPE 6
-- Liste des commandes non soldées avec le montant dû, le montant payé et le reste à payer.
SELECT commande.id_commande, 
        montant_du,
        COALESCE(montant_payer, 0),
        montant_du - COALESCE(montant_payer, 0) AS reste_payer
FROM commande
LEFT JOIN (
    SELECT id_commande, SUM(plat.prix * ligne_commande.quantite) AS montant_du
    FROM ligne_commande JOIN plat ON ligne_commande.id_plat = plat.id
    GROUP BY id_commande
) AS montant_commande ON commande.id_commande = montant_commande.id_commande
LEFT JOIN (SELECT id_commande , SUM(ligne_payement.montant) AS montant_payer FROM ligne_payement GROUP BY id_commande)
AS payement ON commande.id_commande = payement.id_commande;
--Montant dû = somme des prix des plats * quantités.
--Montant payé = somme des paiements enregistrés.
--Reste à payer = montant dû − montant payé.
--une colonne montant_paye dans la table des commandes ne suffit pas car le client peut payer en deux fois avec differents mode de payements
-- pour CHECK pour ajouter un nouveau mode de paiement, il faut modifier la contrainte. pour la table de reference facile d'ajouter, de supprimer ou de gérer les modes de paiement sans modifier la structure de la table des paiements. donc il vaux mieux utiliser la table de reference


