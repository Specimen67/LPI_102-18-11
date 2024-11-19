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

iptables -P INPUT DROP # Bloquer tout par défaut
iptables -A INPUT -p tcp --dport 22 -j ACCEPT