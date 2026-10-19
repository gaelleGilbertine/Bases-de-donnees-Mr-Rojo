# schema relationnel mis a jour
## Etape 1: La carte
PLAT (nouveau)
(
    **id_plat**,
    nom,
    prix
)

## Etape 2:  Les catégories
CATEGORIE (nouveau)
(
    **id_categorie**,
    nom
)

PLAT (modifie)
(
     **id_plat**,
    nom,
    prix,
    #id_categorie
)

## Etape 3 : Les commandes
COMMANDE(nouveau)
(
    **id_commande**
)

LIGNE_COMMANDE (nouveau)
(
    #**id_commande**,
    #**id_plat**,
    date,
    quantite
)

## Etape 4 : Les habitués
CLIENT(nouveau)
(
    **id_client**,
    nom?
)

COMMANDE(modifie)
(
    **id_commande**
    #id_client
)