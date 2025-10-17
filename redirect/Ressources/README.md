# Open Redirect - Social Media Links Manipulation

## Description
Cette vulnérabilité exploite un système de redirection non sécurisé qui permet de rediriger les utilisateurs vers des sites arbitraires en manipulant un paramètre URL non sécurisé.

## Exploitation

### Étape 1: Analyse des liens de réseaux sociaux et compréhension des paramètres URL
En bas de la page principale, nous trouvons des liens vers les réseaux sociaux :


Chaque lien contient deux paramètres importants :
- **`page=redirect`** : Indique que nous utilisons la fonctionnalité de redirection
- **`site=<plateforme>`** : Spécifie vers quelle plateforme rediriger

### Étape 2: Test des redirections légitimes
Les redirections normales fonctionnent pour les trois plateformes autorisées :

```
http://localhost:8080/index.php?page=redirect&site=facebook
http://localhost:8080/index.php?page=redirect&site=twitter
http://localhost:8080/index.php?page=redirect&site=instagram
```

Ces URLs nous emmènent vers une page intermédiaire affichant les réseaux sociaux, puis nous redirige vers la plateforme choisie.

### Étape 3: Découverte de la vulnérabilité et obtention du flag
En modifiant le paramètre `site` avec une valeur non autorisée :

```
http://localhost:8080/index.php?page=redirect&site=scrouch
```

On peut facilement rediriger un utilisateur vers un autre site, tout en préservant l'URL de base du site sur lequel on se trouve.

Lorsque nous utilisons une valeur non prévue pour le paramètre `site`, l'application nous affiche la page redirect qui contient le flag.

Cette vulnérabilité permet :
- **Reputation Damage** : Utilisation du domaine légitime pour des redirections malveillantes
