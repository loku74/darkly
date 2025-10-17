# HTML Injection - Feedback Form Exploitation

## Description
Cette vulnérabilité exploite une injection HTML dans un formulaire de feedback qui ne valide pas correctement les entrées utilisateur, permettant l'injection de code HTML arbitraire.

## Exploitation

### Étape 1: Analyse du formulaire de feedback
La page contient un formulaire permettant d'envoyer des commentaires avec deux champs :
- **Name** : Champ texte avec limitation apparente
- **Message** : Zone de texte pour le feedback

### Étape 2: Inspection du champ "Name"
Le champ nom présente les caractéristiques suivantes :

```html
<input name="txtName" type="text" size="30" maxlength="10">
```

**Limitations identifiées :**
- `maxlength="10"` : Limite théorique de 10 caractères
- Validation uniquement côté client (front-end)

### Étape 3: Test d'injection HTML
Une fois la limite contournée, nous pouvons injecter du code HTML dans le champ nom :

#### **Exemples d'injections possibles :**

**Injection d'un bouton :**
```html
<button onclick="alert('XSS')">Click me</button>
```

**Injection d'un titre :**
```html
<h1>Titre injecté</h1>
```

**Injection d'un lien malveillant :**
```html
<a href="https://malicious-site.com">Cliquez ici</a>
```

**Injection d'une image :**
```html
<img src="x" onerror="alert('XSS')">
```

### Étape 4: Déclenchement du flag
La simple injection du caractère `<` dans le champ nom suffit à déclencher la détection :

```html
<
```

Après envoi du formulaire avec ce caractère, le flag est ajouté à la liste des feedbacks.

## Impact

Cette vulnérabilité permet :
- **Injection de contenu malveillant** : Modification de l'affichage de la page
- **Cross-Site Scripting (XSS)** : Exécution de JavaScript arbitraire
- **Phishing** : Injection de liens malveillants
