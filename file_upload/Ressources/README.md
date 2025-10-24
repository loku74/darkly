# File Upload Bypass - Content-Type Manipulation

## Description
Cette vulnérabilité exploite une faible vérification du type de fichier côté serveur, permettant l'upload de fichiers malveillants en manipulant les headers HTTP.

## Exploitation

### Étape 1: Analyse de la page d'upload et test
La page d'upload présente un formulaire permettant de télécharger des fichiers avec les restrictions suivantes :
- **Types acceptés** : Images JPEG uniquement
- **Validation** : Basée sur le Content-Type HTTP

Tentative d'upload d'un fichier PHP malveillant :

```php
<?php
// shell.php
system($_GET['cmd']);
?>
```

**Fichier testé** : `shell.php`
**Résultat** : Upload refusé

### Étape 2: Contournement par manipulation du Content-Type
Le serveur ne vérifiant que le header `Content-Type`, nous pouvons le manipuler pour faire accepter notre fichier malveillant.

### Étape 3: Exploitation réussie et obtention du flag
Avec le Content-Type modifié de `application/x-php` vers `image/jpeg`, le serveur accepte le fichier malveillant car il ne vérifie pas le contenu réel du fichier.

**Résultat** : Upload réussi ✅ → Flag obtenu !

Cette vulnérabilité permet :
- **Remote Code Execution (RCE)** : Contrôle total du serveur
- **Défiguration du site** : Modification du contenu web
- **Escalade de privilèges** : Accès aux fichiers système
