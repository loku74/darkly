# Cookie Manipulation - Admin Bypass

## Description
Cette vulnérabilité exploite la manipulation de cookies côté client pour contourner les vérifications d'autorisation et obtenir des privilèges administrateur.

## Exploitation

### Étape 1: Analyse du cookie existant
L'application utilise un cookie nommé `I_am_admin` pour déterminer si l'utilisateur a des privilèges administrateur.

**Cookie découvert :**
- **Nom**: `I_am_admin`
- **Valeur**: `68934a3e9455fa72420237eb05902327`
- **Type**: Hash MD5

### Étape 2: Déchiffrement du cookie
En déchiffrant la valeur MD5 du cookie :

```
68934a3e9455fa72420237eb05902327 → "false"
```

Le cookie contient donc la valeur "false" hashée en MD5, indiquant que l'utilisateur n'est pas administrateur.

### Étape 3: Génération du nouveau cookie
Par logique inverse, nous générons le hash MD5 de "true" :

```
"true" → b326b5062b2f0e69046810717534cb09
```

### Étape 4: Manipulation du cookie
1. Ouvrir les outils de développement du navigateur
3. Modifier la valeur du cookie `I_am_admin` :
   - **Ancienne valeur**: `68934a3e9455fa72420237eb05902327`
   - **Nouvelle valeur**: `b326b5062b2f0e69046810717534cb09`

### Étape 5: Exploitation finale
Une fois le cookie modifié, une simple requête GET vers la page nous donne le flag via une alerte JavaScript.

## Processus technique

```bash
# Déchiffrement de la valeur originale
echo "68934a3e9455fa72420237eb05902327" | # Correspond à MD5("false")

# Génération de la nouvelle valeur
echo -n "true" | md5sum
# Résultat: b326b5062b2f0e69046810717534cb09
```

## Impact
Cette vulnérabilité permet :
- **Élévation de privilèges** : Transformer un utilisateur standard en administrateur
- **Contournement des contrôles d'accès** : Accéder à des fonctionnalités réservées
- **Compromission de la logique métier** : Manipuler les décisions basées sur les cookies

## Prévention

### Solutions recommandées :
1. **Signatures cryptographiques** : Signer les cookies avec une clé secrète côté serveur
2. **Tokens JWT** : Utiliser des JSON Web Tokens signés
3. **Sessions côté serveur** : Stocker les informations sensibles sur le serveur
4. **Validation systématique** : Toujours vérifier les privilèges côté serveur
