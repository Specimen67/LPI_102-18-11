#!/bin/bash

# maintainer : menguerrand@dawan.fr
# Date : 21/11/2024
# Ce script montre comment utiliser les conditions

if [ condition ]; then
   # Commandes à exécuter si la condition est vraie
fi


if [ -f "fichier.txt" ]; then
   echo "le fichier existe"
fi


+ If-then-else


if [ condition ]; then
   # Commandes à exécuter si la condition est vraie
else
   # Commandes à exécuter si la condition est fausse
fi


if [ -f "fichier.txt" ]; then
   echo "le fichier existe"
else
   touch fichier.txt
fi


+ If-then-elif-else


if [ condition1 ]; then
   # Commandes à exécuter si la condition1 est vraie
elif [ condition2 ]; then
    # Commandes à exécuter si la condition2 est vraie
else
   # Commandes à exécuter si aucune condition n'est vraie
fi


if [ $1 -gt 10 ]; then
   echo "Le paramètre est supérieur à 10"
elif [ $1 -eq 10 ]; then
    echo "le paramètre est égal à 10"
else
   echo "Le paramètre est inférieur à 10."
fi


case $variable in
    valeur1)
        # Commandes si $variable == valeur1
        ;;
    valeur2)
        # Commandes si $variable == valeur2
        ;;
    *)
        # Commandes par défaut si aucune condition n'est remplie
        ;;
esac



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

