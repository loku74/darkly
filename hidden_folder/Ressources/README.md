# Information Disclosure - robots.txt & hidden folder

## Description
Cette vulnérabilité exploite la divulgation d'informations sensibles via le fichier `robots.txt` et la découverte d'un dossier `.hidden`.

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

Le repertoire .hidden contient des dossiers avec des noms aléatoires dans lesquels se trouvent d'autres dossiers similaires et des fichiers readme.

En regardant dans un readme au hasard, on trouve une phrase sans intérêt mais en récupérant le contenu de tous ces readme grâce à un script bash, on découvre que l'un d'entre eux contient un flag.

### Bonne pratique (sécurisée)
```
User-agent: *
Disallow: /
```
Ou simplement ne pas mentionner les répertoires sensibles
