Cette faille exploite la faible verification du type de fichier uploader sur le serveur.

Etape 1:
- Sur la page d'upload, selectionner un fichier image (ex: image.jpg)
Ensuite on test avec un fichier php malveillant en .php qui ne va pas pouvoir etre uploader.

Etape 2:
- On sait que le fichier envoyé doit etre une image jpeg.
On relance l'upload du fichier php soit depuis la ligne de commande avec curl ou avec burp suite en modifiant l'extension la valeur du champ Content-Type en de application/x-php en image/jpeg.

Le site va accepter le fichier car il ne verifie pas le contenu reel du fichier.

Pour corriger cette faille, il faut verifier l'extension du fichier ainsi que son type MIME et idealement analyser le contenu du fichier pour s'assurer qu'il correspond bien a une image.
