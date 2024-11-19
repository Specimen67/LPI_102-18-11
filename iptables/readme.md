# Iptables

## Règles de base

** les règles sont appliquée dans l'ordre dans lequel elles sont construites. Dans les bonnes pratiques, on bloque TOUT puis on autorise au compte goutte les entrées/sorties/transferts

### Lister les règles existantes:
`iptables -L -v -n`

### Permettre tout le trafic entrant, sortant et transféré
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD ACCEPT

### Bloquer tout le trafic entrant, sortant et transféré
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

### Exemple

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -P INPUT DROP # Bloquer tout par défaut

### Autoriser un traffic SSH

iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j accept

**-A** Ajoute une règle à la chaine spécifiée (ici INPUT)

**INPUT** (Chaîne quigère le trafic enrant ves la machine)

**-p** précise le protocole des paquets auxquels la règle s'applique

**tcp** Protocole tcp (utilié pour les connexions fiable )

**--dport** Spécifie le port de destination auquel les paquets sont destinés

**22** Correspond au port par défaut de SSH

**-m** charge un module

**conntrack** Module qui permet de suivre l'état des connexion

**--ctstate** Définit les états des connexion auxquels la règle doit s'appliquer

**New**:  paquets qui tentent de démarrer une nouvelle connexion (exemple un tentative de connexion ssh)

**ESTABLISHED**: Paquets faisant partie d'une connexion déjà établie


**-j** Spécifie la cible (target) pour les paquets qui correspondent à cette règle 

**ACCEPT** Autorise les paquets à passer


