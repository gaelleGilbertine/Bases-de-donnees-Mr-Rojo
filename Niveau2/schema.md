# schema relationnel mis a jour (niveau 2)
## Etape 6 :  Les paiements
PAYEMENT(nouveau)
(
    **id-payement**,
    nom
)

LIGNE_PAYEMENT(nouveau)
(
    #**id_payement**,
    #**id_commande**,
    montant,

)

## Etape 7 :  Les prix changent
LIGNE_COMMANDE (modifier)
(
    #**id_commande**,
    #**id_plat**,
    date,
    quantite,
    prix_unitaire
)

HISTORIQUE_PRIX (nouveau)
(
    **id_prix**,
    #id_plat,
    prix,
    date_debut,
    date_fin

)