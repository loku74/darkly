# Hidden Form Field - Email Manipulation

## Description
Cette vulnérabilité exploite un champ de formulaire caché côté client qui peut être modifié pour détourner l'envoi d'emails vers une adresse contrôlée par l'attaquant.

## Exploitation

### Étape 1: Analyse de la page
La page de récupération de mot de passe présente visuellement :
- Un simple bouton "Submit" pour envoyer le mot de passe
- Aucun champ d'email visible pour l'utilisateur

### Étape 2: Inspection du code source
En examinant le code source HTML de la page, nous découvrons la présence d'un champ email caché :

```html
<input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">
<input type="submit" name="Submit" value="Submit">
```
Le champ email est défini avec l'attribut `type="hidden"`, le rendant invisible dans l'interface utilisateur.

### Étape 3: Révélation du champ caché
Pour rendre le champ visible et modifiable, il suffit de changer `type="hidden"` en `type="text"` (ou `type="email"`) dans le code HTML.

### Étape 4: Modification de l'adresse email
Une fois le champ rendu visible :
1. Modifier la valeur du champ email avec votre propre adresse
2. Cliquer sur le bouton "Submit"

### Étape 5: Obtention du flag
Après la soumission du formulaire avec l'email modifié, le flag est révélé.

## Impact
Cette vulnérabilité permet :
- **Détournement d'emails** : Rediriger des informations sensibles vers un attaquant
- **Fuite d'informations** : Récupérer des mots de passe ou tokens de réinitialisation
- **Usurpation d'identité** : Se faire passer pour un utilisateur légitime
- **Compromission de comptes** : Accéder aux comptes d'autres utilisateurs

### Solutions immédiates :
1. **Validation côté serveur** : Ne jamais faire confiance aux données client
2. **Authentification préalable** : Demander une authentification avant la réinitialisation
3. **Confirmation par étapes multiples** : Processus en plusieurs étapes avec vérifications

### Recommandations de sécurité :
1. **Jamais de logique critique côté client** : Toujours valider côté serveur
4. **Rate limiting** : Limiter les tentatives de réinitialisation
