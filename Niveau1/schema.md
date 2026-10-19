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
    id_categorie
)