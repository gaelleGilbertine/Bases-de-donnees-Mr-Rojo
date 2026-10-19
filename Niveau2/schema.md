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