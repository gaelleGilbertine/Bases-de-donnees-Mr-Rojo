# Fiche de révision — Commandes fondamentales de PostgreSQL

Cette fiche regroupe les commandes PostgreSQL jusqu'à la section 15 : connexion, commandes `psql`, bases de données, tables, opérations CRUD, recherches, calculs, jointures, sous-requêtes, contraintes, transactions, vues, index, permissions et analyse des requêtes.

> **Attention :** les commandes de suppression (`DROP`, `DELETE`, `TRUNCATE`) peuvent détruire des données. Vérifie toujours la table et la condition `WHERE` avant de les exécuter.

## 1. Se connecter à PostgreSQL

Ces commandes s'exécutent dans le terminal Linux.

| Commande | Rôle |
|---|---|
| `psql -U postgres` | Se connecter avec l'utilisateur `postgres` |
| `psql -U postgres -d restaurant` | Se connecter à la base `restaurant` |
| `psql -h localhost -p 5432 -U postgres -d restaurant` | Préciser l'hôte, le port, l'utilisateur et la base |
| `\\q` | Quitter `psql` |

Si PostgreSQL utilise un autre port, par exemple `5433`, remplace `5432` par le port configuré.

## 2. Les commandes `psql` indispensables

Ces commandes se tapent **à l'intérieur de `psql`**, pas dans le terminal Linux ordinaire.

| Commande | Utilité |
|---|---|
| `\\l` | Lister les bases de données |
| `\\c restaurant` | Se connecter à la base `restaurant` |
| `\\dt` | Afficher les tables de la base courante |
| `\\d plat` | Afficher la structure de la table `plat` |
| `\\d+ plat` | Afficher la structure détaillée de la table |
| `\\du` | Afficher les utilisateurs et rôles |
| `\\dn` | Afficher les schémas |
| `\\conninfo` | Afficher les informations de connexion |
| `\\?` | Aide sur les commandes `psql` |
| `\\h` | Aide sur les commandes SQL |
| `\\h SELECT` | Aide sur la syntaxe de `SELECT` |
| `\\timing` | Activer ou désactiver l'affichage du temps d'exécution |

**À retenir :** les commandes `psql` commencent généralement par `\\` et ne nécessitent pas de point-virgule.

## 3. Créer, modifier et supprimer une base de données

### Créer une base

```sql
CREATE DATABASE restaurant;
```

### Supprimer une base

```sql
DROP DATABASE restaurant;
```

Cette opération est destructive.

### Renommer une base

```sql
ALTER DATABASE restaurant
RENAME TO restaurant_test;
```

### Créer un utilisateur

```sql
CREATE USER etudiant WITH PASSWORD 'motdepasse';
```

### Accorder le droit de connexion

```sql
GRANT CONNECT ON DATABASE restaurant TO etudiant;
```

Cela autorise la connexion à la base, mais ne donne pas automatiquement tous les droits sur ses tables.

## 4. Créer et modifier les tables

### `CREATE TABLE` — créer une table

```sql
CREATE TABLE plat (
    id_plat INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom_plat VARCHAR(100) NOT NULL,
    prix NUMERIC(10,2) NOT NULL CHECK (prix >= 0)
);
```

### `ALTER TABLE` — modifier une table

Ajouter une colonne :

```sql
ALTER TABLE plat
ADD COLUMN description TEXT;
```

Modifier le type d'une colonne :

```sql
ALTER TABLE plat
ALTER COLUMN nom_plat TYPE VARCHAR(150);
```

Supprimer une colonne :

```sql
ALTER TABLE plat
DROP COLUMN description;
```

Ajouter une contrainte :

```sql
ALTER TABLE plat
ADD CONSTRAINT prix_positif CHECK (prix >= 0);
```

> Si la table possède déjà une contrainte équivalente, ne l'ajoute pas une deuxième fois.

Renommer une colonne :

```sql
ALTER TABLE plat
RENAME COLUMN nom_plat TO libelle;
```

Renommer une table :

```sql
ALTER TABLE plat
RENAME TO plats;
```

### `DROP TABLE` — supprimer une table

```sql
DROP TABLE plat;
```

Supprime la table et ses données.

### `TRUNCATE` — vider une table

```sql
TRUNCATE TABLE plat;
```

Supprime toutes les lignes, mais conserve la structure.

Pour réinitialiser aussi le compteur des identifiants `IDENTITY` :

```sql
TRUNCATE TABLE plat RESTART IDENTITY;
```

## 5. Insérer, lire, modifier et supprimer des données (CRUD)

Les quatre opérations fondamentales sont appelées CRUD.

### C — Create : `INSERT`

```sql
INSERT INTO plat (nom_plat, prix)
VALUES ('Pizza', 15000);
```

Insérer plusieurs lignes :

```sql
INSERT INTO plat (nom_plat, prix)
VALUES
    ('Pizza', 15000),
    ('Burger', 10000),
    ('Salade', 8000);
```

Afficher la ligne insérée, y compris son identifiant :

```sql
INSERT INTO plat (nom_plat, prix)
VALUES ('Pâtes', 12000)
RETURNING *;
```

### R — Read : `SELECT`

```sql
SELECT * FROM plat;
```

### U — Update : `UPDATE`

```sql
UPDATE plat
SET prix = 18000
WHERE id_plat = 1;
```

### D — Delete : `DELETE`

```sql
DELETE FROM plat
WHERE id_plat = 1;
```

**Attention :** sans `WHERE`, `UPDATE` peut modifier toutes les lignes et `DELETE` peut supprimer toutes les lignes de la table.

## 6. Les recherches avec `SELECT`

### Sélectionner certaines colonnes

```sql
SELECT nom_plat, prix
FROM plat;
```

### Filtrer avec `WHERE`

```sql
SELECT *
FROM plat
WHERE prix > 10000;
```

Opérateurs de comparaison :

| Opérateur | Signification |
|---|---|
| `=` | Égal à |
| `<>` ou `!=` | Différent de |
| `>` | Supérieur à |
| `<` | Inférieur à |
| `>=` | Supérieur ou égal |
| `<=` | Inférieur ou égal |

### Combiner des conditions

```sql
SELECT *
FROM plat
WHERE prix >= 10000
  AND prix <= 20000;
```

- `AND` : les deux conditions doivent être vraies.
- `OR` : au moins une condition doit être vraie.
- `NOT` : inverse une condition.

### Rechercher dans une liste

```sql
SELECT *
FROM plat
WHERE prix IN (8000, 10000, 15000);
```

### Rechercher dans un intervalle

```sql
SELECT *
FROM plat
WHERE prix BETWEEN 10000 AND 20000;
```

`BETWEEN` inclut les deux bornes.

### Rechercher du texte avec `LIKE` et `ILIKE`

```sql
SELECT *
FROM plat
WHERE nom_plat LIKE 'P%';
```

`LIKE 'P%'` recherche les noms qui commencent par `P`.

- `%` : zéro ou plusieurs caractères.
- `_` : exactement un caractère.
- `ILIKE` : comme `LIKE`, mais sans distinguer majuscules et minuscules dans PostgreSQL.

Exemple :

```sql
SELECT *
FROM plat
WHERE nom_plat ILIKE '%pizza%';
```

### Tester une valeur absente

```sql
SELECT *
FROM plat
WHERE prix IS NULL;
```

Pour les valeurs présentes :

```sql
SELECT *
FROM plat
WHERE prix IS NOT NULL;
```

**Important :** pour tester `NULL`, utilise `IS NULL` ou `IS NOT NULL`, pas `= NULL`.

### Trier les résultats

```sql
SELECT *
FROM plat
ORDER BY prix ASC;
```

- `ASC` : ordre croissant.
- `DESC` : ordre décroissant.

### Limiter les résultats

```sql
SELECT *
FROM plat
LIMIT 5;
```

Pour un résultat reproductible, ajoute généralement un `ORDER BY`.

### Éliminer les doublons dans le résultat

```sql
SELECT DISTINCT prix
FROM plat;
```

Cela n'efface aucune donnée dans la table.

### Compter les lignes

```sql
SELECT COUNT(*)
FROM plat;
```

Compter les plats dont le prix dépasse 10 000 :

```sql
SELECT COUNT(*)
FROM plat
WHERE prix > 10000;
```

### Pagination

```sql
SELECT *
FROM plat
ORDER BY id_plat
LIMIT 10 OFFSET 20;
```

Affiche jusqu'à 10 lignes après avoir ignoré les 20 premières.

## 7. Fonctions de calcul et regroupements

| Fonction | Rôle |
|---|---|
| `COUNT(*)` | Compter les lignes |
| `SUM(colonne)` | Calculer une somme |
| `AVG(colonne)` | Calculer une moyenne |
| `MIN(colonne)` | Trouver la valeur minimale |
| `MAX(colonne)` | Trouver la valeur maximale |

Exemples :

```sql
SELECT SUM(prix) FROM plat;
```

Calcule la somme des prix enregistrés ; ce n'est pas nécessairement le chiffre d'affaires.

```sql
SELECT AVG(prix) FROM plat;
```

Calcule le prix moyen des plats.

### `GROUP BY` — regrouper les données

Compter les commandes par client :

```sql
SELECT id_client, COUNT(*) AS nombre_commandes
FROM commande
GROUP BY id_client;
```

### `HAVING` — filtrer les groupes

Afficher uniquement les clients ayant passé au moins trois commandes :

```sql
SELECT id_client, COUNT(*) AS nombre_commandes
FROM commande
GROUP BY id_client
HAVING COUNT(*) >= 3;
```

- `WHERE` filtre les lignes avant le regroupement.
- `HAVING` filtre les groupes après le regroupement.

## 8. Les jointures : `JOIN`

Les jointures permettent de récupérer des informations de plusieurs tables.

Exemple de tables :

**client**

| id_client | nom |
|---:|---|
| 1 | Marie |
| 2 | Jean |

**commande**

| id_commande | id_client |
|---:|---:|
| 101 | 1 |
| 102 | 1 |
| 103 | 2 |

### `INNER JOIN`

Affiche uniquement les lignes qui correspondent dans les deux tables.

```sql
SELECT client.nom, commande.id_commande
FROM client
INNER JOIN commande
    ON client.id_client = commande.id_client;
```

### `LEFT JOIN`

Affiche tous les clients, même ceux qui n'ont aucune commande.

```sql
SELECT client.nom, commande.id_commande
FROM client
LEFT JOIN commande
    ON client.id_client = commande.id_client;
```

Pour un client sans commande, les colonnes venant de `commande` valent `NULL`.

### `RIGHT JOIN`

Conserve toutes les lignes de la table de droite, même sans correspondance à gauche.

```sql
SELECT client.nom, commande.id_commande
FROM client
RIGHT JOIN commande
    ON client.id_client = commande.id_client;
```

### `FULL OUTER JOIN`

Conserve toutes les lignes des deux tables, avec ou sans correspondance.

```sql
SELECT client.nom, commande.id_commande
FROM client
FULL OUTER JOIN commande
    ON client.id_client = commande.id_client;
```

### `CROSS JOIN`

Produit toutes les combinaisons possibles entre les lignes des deux tables.

```sql
SELECT *
FROM client
CROSS JOIN plat;
```

### `USING` — raccourci de jointure

Si les deux tables possèdent une colonne appelée `id_client` :

```sql
SELECT *
FROM client
JOIN commande USING (id_client);
```

Équivalent dans ce cas à :

```sql
SELECT *
FROM client
JOIN commande
    ON client.id_client = commande.id_client;
```

`USING` évite de répéter le nom de la colonne commune dans la condition.

## 9. Les sous-requêtes

Une sous-requête est une requête placée dans une autre requête.

### Avec `IN`

Trouver les clients ayant passé au moins une commande :

```sql
SELECT *
FROM client
WHERE id_client IN (
    SELECT id_client
    FROM commande
);
```

### Avec `EXISTS`

```sql
SELECT *
FROM client c
WHERE EXISTS (
    SELECT 1
    FROM commande co
    WHERE co.id_client = c.id_client
);
```

### Avec `NOT EXISTS`

Trouver les clients sans commande :

```sql
SELECT *
FROM client c
WHERE NOT EXISTS (
    SELECT 1
    FROM commande co
    WHERE co.id_client = c.id_client
);
```

### Avec `WITH` — requête intermédiaire nommée

```sql
WITH total_commandes AS (
    SELECT id_client, COUNT(*) AS nombre
    FROM commande
    GROUP BY id_client
)
SELECT *
FROM total_commandes
WHERE nombre >= 3;
```

`WITH` aide à structurer une requête complexe en étapes plus lisibles.

## 10. Clés et contraintes

| Mot-clé | Signification |
|---|---|
| `PRIMARY KEY` | Identifie chaque ligne de façon unique et non nulle |
| `FOREIGN KEY` | Relie une colonne à une clé d'une autre table ou de la même table |
| `NOT NULL` | Interdit les valeurs nulles |
| `UNIQUE` | Empêche les doublons selon la contrainte |
| `CHECK` | Vérifie une condition |
| `DEFAULT` | Définit une valeur par défaut |

### Définir une clé étrangère

```sql
CREATE TABLE commande (
    id_commande INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_client INTEGER NOT NULL,
    FOREIGN KEY (id_client) REFERENCES client(id_client)
);
```

Cette règle interdit d'associer une commande à un identifiant de client inexistant.

### Ajouter une clé étrangère après la création

```sql
ALTER TABLE commande
ADD CONSTRAINT fk_commande_client
FOREIGN KEY (id_client)
REFERENCES client(id_client);
```

### Supprimer une contrainte

```sql
ALTER TABLE commande
DROP CONSTRAINT fk_commande_client;
```

### Ajouter une valeur par défaut

```sql
ALTER TABLE commande
ALTER COLUMN statut SET DEFAULT 'en_attente';
```

Supprimer la valeur par défaut :

```sql
ALTER TABLE commande
ALTER COLUMN statut DROP DEFAULT;
```

### Ajouter une contrainte d'unicité

```sql
ALTER TABLE client
ADD CONSTRAINT uq_client_email UNIQUE (email);
```

### Définir une relation plusieurs-à-plusieurs

```sql
CREATE TABLE ligne_commande (
    id_commande INTEGER REFERENCES commande(id_commande),
    id_plat INTEGER REFERENCES plat(id_plat),
    quantite INTEGER NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_commande, id_plat)
);
```

La clé primaire composée interdit deux lignes ayant le même couple commande-plat. Si plusieurs lignes distinctes sont nécessaires pour le même plat dans une commande, il faut choisir une autre clé.

## 11. Transactions

Une transaction permet de regrouper plusieurs opérations et de décider de les valider ou de les annuler.

| Commande | Rôle |
|---|---|
| `BEGIN` | Commencer une transaction |
| `COMMIT` | Valider les modifications |
| `ROLLBACK` | Annuler les modifications non validées |
| `SAVEPOINT` | Créer un point de retour intermédiaire |
| `ROLLBACK TO` | Revenir à un point de sauvegarde |

Exemple :

```sql
BEGIN;

UPDATE plat
SET prix = 18000
WHERE id_plat = 1;

COMMIT;
```

Pour annuler les modifications avant validation, utilise `ROLLBACK` à la place de `COMMIT`.

Exemple avec un point de sauvegarde :

```sql
BEGIN;

UPDATE plat
SET prix = 18000
WHERE id_plat = 1;

SAVEPOINT etape1;

UPDATE plat
SET prix = 20000
WHERE id_plat = 2;

ROLLBACK TO etape1;

COMMIT;
```

La modification du plat 1 est conservée, mais celle du plat 2 est annulée.

## 12. Les vues : `VIEW`

Une vue est une requête enregistrée que l'on peut interroger comme une table.

Créer une vue :

```sql
CREATE VIEW plats_chers AS
SELECT *
FROM plat
WHERE prix > 10000;
```

Consulter la vue :

```sql
SELECT * FROM plats_chers;
```

Supprimer la vue :

```sql
DROP VIEW plats_chers;
```

Une vue classique repose sur sa requête et ne stocke pas séparément le résultat des données.

## 13. Les index : `INDEX`

Un index peut accélérer certaines recherches, au prix d'espace supplémentaire et d'un coût lors des modifications.

Créer un index :

```sql
CREATE INDEX idx_plat_nom
ON plat(nom_plat);
```

Supprimer un index :

```sql
DROP INDEX idx_plat_nom;
```

PostgreSQL crée automatiquement un index pour une clé primaire et pour une contrainte `UNIQUE`.

## 14. Rôles et permissions

### Créer un rôle autorisé à se connecter

```sql
CREATE ROLE lecteur LOGIN PASSWORD 'motdepasse';
```

### Autoriser la lecture d'une table

```sql
GRANT SELECT ON TABLE plat TO lecteur;
```

### Autoriser l'insertion et la modification

```sql
GRANT INSERT, UPDATE ON TABLE plat TO lecteur;
```

### Retirer le droit de modification

```sql
REVOKE UPDATE ON TABLE plat FROM lecteur;
```

Les permissions sur les tables, les schémas et les séquences peuvent être distinctes.

## 15. Examiner et analyser une requête

### `EXPLAIN`

Affiche le plan d'exécution prévu par PostgreSQL, sans exécuter normalement la requête :

```sql
EXPLAIN
SELECT *
FROM plat
WHERE prix > 10000;
```

### `EXPLAIN ANALYZE`

Exécute réellement la requête et affiche les mesures d'exécution :

```sql
EXPLAIN ANALYZE
SELECT *
FROM plat
WHERE prix > 10000;
```

À utiliser prudemment avec les requêtes qui modifient des données, car elles sont réellement exécutées.

### `ANALYZE`

Actualise les statistiques utilisées par l'optimiseur :

```sql
ANALYZE plat;
```

### `COMMENT ON`

Ajouter une description à une table :

```sql
COMMENT ON TABLE plat IS 'Liste des plats du restaurant';
```


