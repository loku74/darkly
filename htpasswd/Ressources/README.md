# Information Disclosure - robots.txt & htpasswd

## Description
Cette vulnérabilité exploite la divulgation d'informations sensibles via le fichier `robots.txt` et la découverte d'un fichier `.htpasswd` contenant des identifiants d'administrateur.

## Exploitation

### Étape 1: Découverte du fichier robots.txt
Le fichier `robots.txt` est un standard web qui indique aux robots d'exploration (crawlers) les URL auxquelles ils peuvent accéder sur un site. Il est généralement accessible publiquement.

**URL d'accès :**
```
http://<domain>/robots.txt
```

### Étape 2: Analyse du contenu robots.txt
En accédant au fichier robots.txt, nous découvrons :

```
User-agent: *
Disallow: /whatever
Disallow: /.hidden
```

Ce fichier révèle deux répertoires que les robots ne doivent pas explorer :
- `/whatever`
- `/.hidden`

### Étape 3: Exploration du répertoire `/whatever`
Les répertoires mentionnés dans `robots.txt` sont souvent des cibles intéressantes car ils contiennent potentiellement des informations sensibles.

```
http://<domain>/whatever/
```

Dans le répertoire `/whatever`, nous trouvons un fichier `.htpasswd` qui contient des identifiants d'authentification.

**Contenu du fichier htpasswd :**
```
root:437394baff5aa33daa618be47b75cb49
```

Structure :
- **Username**: `root`
- **Password hash**: `437394baff5aa33daa618be47b75cb49`
- **Format**: MD5

### Étape 4: Déchiffrement du mot de passe
Le hash MD5 peut être déchiffré pour révéler le mot de passe en clair :

```bash
# Hash à déchiffrer
437394baff5aa33daa618be47b75cb49

# Résultat après déchiffrement
qwerty123@
```

### Étape 5: Exploitation finale
Avec les identifiants découverts, nous accédons à la zone d'administration :

1. Naviguer vers `http://<domain>/admin`
2. Utiliser les identifiants :
   - **Username**: `root`
   - **Password**: `qwerty123@`
3. Obtenir le flag après authentification réussie

## Impact
Cette vulnérabilité permet :
- **Accès administrateur non autorisé** : Compromission complète du système
- **Divulgation d'informations sensibles** : Révélation de la structure du site

### Bonne pratique (sécurisée)
```
User-agent: *
Disallow: /
```
Ou simplement ne pas mentionner les répertoires sensibles
