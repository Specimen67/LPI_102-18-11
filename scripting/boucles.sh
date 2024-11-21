#!/bin/bash

# maintainer : menguerrand@dawan.fr
# Date : 21/11/2024
# Le script montre comment utiliser les boucles

#for var in liste; do
    # Commandes à exécuter pour chaque élément
#done

# Lister tous les fichiers qui terminent en .txt dans le dossier.
for fichier in *.txt; do
    echo "Fichier: $fichier"
done


for fichier in *.txt; do
    echo "Fichier: $fichier"
done

### Quelques variantes:



for i in 1 2 3 4 5; do
  echo "Valeur : $i"
done




for i in {1..5}; do
  echo "Iteration : $i"
done

compteur=0
while [ $compteur -lt 10 ]; do
   echo "compteur: $compteur"
   compteur=$((compteur + 1 ))
done

compteur=0
until  [ $compteur -ge 10 ]; do
   echo "compteur: $compteur"
   compteur=$((compteur + 1 ))
done
