#!/bin/bash

# maintainer : menguerrand@dawan.fr
# Date : 21/11/2024
# Ce script montre comment se gère les variables

: "
echo $1
echo $2
echo $3
echo $4"

: "
valeur=5
chaine="bonjour comment ça va"
echo $valeur
"
: "
commande=$(cat ./log)
echo $commande123 # Le shell comprendra que la commande utilise la variable commande123 qui n'existe pas
echo ${commande}123 # Le shell sait délimiter où s'arrête le nom de la variable commande et pourra concaténer le contenu de la variable avec la chaîne "123""

case $1 in
    start)
        echo "Démarrage du service"
        ;;
    stop)
        echo "arrêt du service"
        ;;
    restart)
        echo "redémarrage du service"
        ;;
    *)
        echo "Usage : $0 {start|stop|restart}"
        ;;
esac