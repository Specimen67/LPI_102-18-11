#!/bin/bash

# ============================================
# Script unique pour l'exécution des exercices
# ============================================

# Répertoire de travail (répertoire courant du script)
base_dir=$(pwd)

# Liste des dossiers d'exercices
dossiers=("Exercice_1" "Exercice_2")

echo "Création de l'environnement de travail..."

# Création des dossiers pour les exercices
for dossier in "${dossiers[@]}"; do
    if [ ! -d "$base_dir/$dossier" ]; then
        mkdir "$base_dir/$dossier"
        echo "Dossier créé : $dossier"
    else
        echo "Dossier déjà existant : $dossier"
    fi
done

echo "Environnement de travail prêt dans $base_dir."
echo "Début des exercices..."

# ========================
# Exercice 1 : Gestion du fichier test.txt
# ========================
echo "Exercice 1 : Gestion du fichier test.txt"
exercice1_dir="$base_dir/Exercice_1"
fichier1="$exercice1_dir/test.txt"

if [ -e "$fichier1" ]; then
    echo "Le fichier test.txt existe déjà dans Exercice_1."
else
    touch "$fichier1"
    echo "Fichier test.txt créé dans Exercice_1."
fi

# ========================
# Exercice 2 : Manipulation du fichier animaux.txt
# ========================
echo "Exercice 2 : Manipulation du fichier animaux.txt"
exercice2_dir="$base_dir/Exercice_2"
fichier2="$exercice2_dir/animaux.txt"

contenu="Le chat est un ami du chien.
Un chien n'aime pas toujours un chat."

# Créer le fichier animaux.txt avec le contenu initial si nécessaire
if [ ! -e "$fichier2" ]; then
    echo "$contenu" > "$fichier2"
    echo "Fichier animaux.txt créé dans Exercice_2 avec le contenu initial."
fi

# Échanger les mots "chat" et "chien" dans le fichier
sed -i -e 's/chat/TEMP_PLACEHOLDER/g' \
       -e 's/chien/chat/g' \
       -e 's/TEMP_PLACEHOLDER/chien/g' "$fichier2"

echo "Les mots 'chat' et 'chien' ont été échangés dans animaux.txt."

# ========================
# Exercice 3 : Manipuler les variables
# ========================
echo "Exercice 3 : Manipulation des variables"
variable=$1
if [ -z "$variable" ]; then
    echo "Aucune variable passée en argument. Essayez : ./script.sh 'VotreVariable'"
else
    echo "La variable passée en argument est : $variable"
fi

# ========================
# Exercice 4 : Créer une calculatrice
# ========================
echo "Exercice 4 : Calculatrice interactive"

# Demander le premier nombre
read -p "Entrez le premier nombre : " nombre1

# Demander le deuxième nombre
read -p "Entrez le deuxième nombre : " nombre2

# Demander l'opération
echo "Choisissez l'opération à effectuer :"
echo "1) Addition"
echo "2) Soustraction"
echo "3) Division"
read -p "Votre choix (1/2/3) : " choix

# Effectuer l'opération
case $choix in
    1)
        resultat=$((nombre1 + nombre2))
        echo "La somme est : $resultat"
        ;;
    2)
        resultat=$((nombre1 - nombre2))
        echo "La différence est : $resultat"
        ;;
    3)
        if [ "$nombre2" -eq 0 ]; then
            echo "Erreur : Division par zéro impossible."
        else
            resultat=$((nombre1 / nombre2))
            echo "Le quotient est : $resultat"
        fi
        ;;
    *)
        echo "Choix invalide. Veuillez sélectionner 1, 2 ou 3."
        ;;
esac

# ========================
# Exercice 5 : Afficher les nombres de 1 à 10
# ========================
echo "Exercice 5 : Affichage des nombres de 1 à 10"
for i in {1..10}; do
    echo "$i"
done

# ========================
# Exercice 6 : Afficher les fichiers avec une extension spécifique
# ========================
echo "Exercice 6 : Affichage des fichiers d'une extension spécifique"
read -p "Entrez l'extension (par exemple, .txt) : " extension
echo "Fichiers avec l'extension $extension dans le répertoire courant :"
ls *"$extension" 2>/dev/null || echo "Aucun fichier trouvé avec l'extension $extension."

# ========================
# Exercice 7 : Installer Nginx et changer le port par défaut
# ========================
echo "Exercice 7 : Installation de Nginx et changement du port"
sudo apt update && sudo apt install -y nginx
sudo sed -i 's/listen 80;/listen 8080;/' /etc/nginx/sites-available/default
sudo systemctl restart nginx
echo "Nginx installé et configuré pour écouter sur le port 8080."

# ========================
# Exercice 8 : Créer un environnement LAMP ou LEMP
# ========================
echo "Exercice 8 : Installation LAMP ou LEMP"

# Demander le choix de l'utilisateur
read -p "Voulez-vous installer un environnement LAMP ou LEMP ? (tapez lamp/lemp) : " choix_env

if [ "$EUID" -ne 0 ]; then
    echo "Veuillez exécuter ce script en tant qu'utilisateur root (sudo)."
    exit 1
fi

if [ "$choix_env" == "lemp" ]; then
    echo "Installation du serveur LEMP en cours..."

    # --- Mise à jour des paquets ---
    echo "Mise à jour des paquets..."
    apt update && apt upgrade -y

    # --- Installation de Nginx ---
    echo "Installation de Nginx..."
    apt install -y nginx
    echo "Activation et démarrage du service Nginx..."
    systemctl enable nginx
    systemctl start nginx
    echo "Nginx installé avec succès."

    # --- Installation de MySQL ---
    echo "Installation de MySQL..."
    apt install -y mysql-server
    echo "Activation et démarrage du service MySQL..."
    systemctl enable mysql
    systemctl start mysql
    echo "MySQL installé avec succès."

    # --- Sécurisation de MySQL ---
    echo "Lancement de la sécurisation de MySQL..."
    mysql_secure_installation

    # --- Installation de PHP ---
    echo "Installation de PHP et modules associés..."
    apt install -y php-fpm php-mysql
    echo "PHP installé avec succès."

    # --- Configuration de Nginx pour PHP ---
    echo "Configuration de Nginx pour utiliser PHP..."
    cat > /etc/nginx/sites-available/default <<EOL
server {
    listen 80;
    server_name localhost;

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;')-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOL

    echo "Redémarrage de Nginx pour appliquer la configuration..."
    systemctl restart nginx

    # --- Test de configuration ---
    echo "Création d'une page de test PHP..."
    echo "<?php phpinfo(); ?>" > /var/www/html/info.php
    echo "Accédez à http://votre_ip/info.php pour vérifier l'installation de PHP."

    echo "Installation LEMP terminée avec succès !"
    echo "Services installés :"
    echo "- Nginx (port 80)"
    echo "- MySQL (port 3306)"
    echo "- PHP (testez via /info.php)"

elif [ "$choix_env" == "lamp" ]; then
    echo "Installation du serveur LAMP en cours..."

    # --- Mise à jour des paquets ---
    echo "Mise à jour des paquets..."
    apt update && apt upgrade -y

    # --- Installation d'Apache ---
    echo "Installation d'Apache..."
    apt install -y apache2
    echo "Activation et démarrage du service Apache..."
    systemctl enable apache2
    systemctl start apache2
    echo "Apache installé avec succès."

    # --- Installation de MySQL ---
    echo "Installation de MySQL..."
    apt install -y mysql-server
    echo "Activation et démarrage du service MySQL..."
    systemctl enable mysql
    systemctl start mysql
    echo "MySQL installé avec succès."

    # --- Sécurisation de MySQL ---
    echo "Lancement de la sécurisation de MySQL..."
    mysql_secure_installation

    # --- Installation de PHP ---
    echo "Installation de PHP et modules associés..."
    apt install -y php libapache2-mod-php php-mysql
    echo "PHP installé avec succès."

    # --- Test de configuration ---
    echo "Création d'une page de test PHP..."
    echo "<?php phpinfo(); ?>" > /var/www/html/info.php
    echo "Accédez à http://votre_ip/info.php pour vérifier l'installation de PHP."

    echo "Installation LAMP terminée avec succès !"
    echo "Services installés :"
    echo "- Apache (port 80)"
    echo "- MySQL (port 3306)"
    echo "- PHP (testez via /info.php)"

else
    echo "Choix invalide. Veuillez taper 'lamp' ou 'lemp'."
fi

# ========================
# Exercice 9 : Vérification des paramètres du script
# ========================
echo "Exercice 9 : Vérification des paramètres"

# Vérification du nombre de paramètres
if [ $# -lt 2 ]; then
    echo "Nombre de paramètres insuffisant !"
    echo "Usage : ./script.sh <paramètre_1> <paramètre_2>"
    echo "Vous devez fournir exactement 2 paramètres."
else
    echo "Nombre de paramètres fourni : $#"
    echo "Paramètre 1 : $1"
    echo "Paramètre 2 : $2"
fi

# ========================
# Exercice 10 : Ajout d'une option -h/--help pour afficher l'usage
# ========================
echo "Exercice 10 : Ajout d'une option -h/--help"

# Vérification des options passées
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "Usage : ./script.sh <paramètre_1> <paramètre_2>"
    echo "Ce script attend exactement 2 paramètres :"
    echo " - <paramètre_1> : La première valeur à fournir."
    echo " - <paramètre_2> : La seconde valeur à fournir."
    echo "Options disponibles :"
    echo " - -h ou --help : Affiche ce message d'aide."
    exit 0
fi

# Vérification du nombre de paramètres
if [ $# -lt 2 ]; then
    echo "Nombre de paramètres insuffisant !"
    echo "Usage : ./script.sh <paramètre_1> <paramètre_2>"
    echo "Vous devez fournir exactement 2 paramètres."
else
    echo "Nombre de paramètres fourni : $#"
    echo "Paramètre 1 : $1"
    echo "Paramètre 2 : $2"
fi

# ========================
# Exercice 11 : Nettoyage de l'environnement et des services installés
# ========================
echo "Exercice 11 : Nettoyage de l'environnement et des services installés"

# Liste des dossiers et fichiers à supprimer
dossiers=("Exercice_1" "Exercice_2")
fichiers_test=("test.txt" "animaux.txt")

# Confirmation utilisateur pour nettoyer l'environnement
read -p "Voulez-vous nettoyer l'environnement et supprimer tous les fichiers/dossiers créés ? (oui/non) : " confirmation_env

if [[ "$confirmation_env" == "oui" ]]; then
    echo "Nettoyage de l'environnement en cours..."

    # Supprimer les dossiers et leur contenu
    for dossier in "${dossiers[@]}"; do
        if [ -d "$dossier" ]; then
            rm -rf "$dossier"
            echo "Dossier supprimé : $dossier"
        else
            echo "Dossier non trouvé : $dossier"
        fi
    done

    # Supprimer les fichiers spécifiques
    for fichier in "${fichiers_test[@]}"; do
        if [ -f "$fichier" ]; then
            rm -f "$fichier"
            echo "Fichier supprimé : $fichier"
        fi
    done

    echo "Nettoyage de l'environnement terminé."
else
    echo "Nettoyage de l'environnement annulé."
fi

# Confirmation utilisateur pour supprimer LAMP/LEMP
read -p "Voulez-vous désinstaller LAMP ou LEMP si installé ? (oui/non) : " confirmation_lamp_lemp

if [[ "$confirmation_lamp_lemp" == "oui" ]]; then
    echo "Vérification du service installé..."

    # Demander à l'utilisateur ce qui a été installé
    read -p "Quel environnement avez-vous installé ? (lamp/lemp) : " choix_env

    if [[ "$choix_env" == "lamp" ]]; then
        echo "Suppression de LAMP en cours..."

        # Arrêter et désinstaller Apache
        systemctl stop apache2
        apt purge -y apache2 apache2-utils apache2-bin apache2.2-common
        apt autoremove -y
        echo "Apache désinstallé."

        # Désinstaller MySQL
        systemctl stop mysql
        apt purge -y mysql-server mysql-client mysql-common
        apt autoremove -y
        rm -rf /etc/mysql /var/lib/mysql
        echo "MySQL désinstallé."

        # Désinstaller PHP
        apt purge -y php libapache2-mod-php php-mysql
        apt autoremove -y
        echo "PHP désinstallé."

        echo "LAMP a été supprimé avec succès."

    elif [[ "$choix_env" == "lemp" ]]; then
        echo "Suppression de LEMP en cours..."

        # Arrêter et désinstaller Nginx
        systemctl stop nginx
        apt purge -y nginx nginx-common nginx-full
        apt autoremove -y
        echo "Nginx désinstallé."

        # Désinstaller MySQL
        systemctl stop mysql
        apt purge -y mysql-server mysql-client mysql-common
        apt autoremove -y
        rm -rf /etc/mysql /var/lib/mysql
        echo "MySQL désinstallé."

        # Désinstaller PHP
        apt purge -y php-fpm php-mysql
        apt autoremove -y
        echo "PHP désinstallé."

        echo "LEMP a été supprimé avec succès."

    else
        echo "Choix invalide. Aucun environnement supprimé."
    fi
else
    echo "Suppression de LAMP/LEMP annulée."
fi

echo "Nettoyage finalisé."

# ========================
# Fin du script
# ========================
echo "Tous les exercices ont été exécutés avec succès."
