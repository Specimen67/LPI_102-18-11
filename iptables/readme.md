# iptables

### **Commandes principales**
- `iptables -L`  
  Liste toutes les règles des chaînes par défaut (INPUT, OUTPUT, FORWARD).
  
- `iptables -A <chaîne>`  
  Ajoute une règle en **fin** de la chaîne spécifiée. Exemple : `iptables -A INPUT -p tcp --dport 80 -j ACCEPT`.
  
- `iptables -I <chaîne> <numéro>`  
  Insère une règle à une **position spécifique** dans la chaîne. Exemple : `iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT`.
  
- `iptables -D <chaîne> <numéro>`  
  Supprime une règle spécifique par **son numéro**. Exemple : `iptables -D INPUT 3`.
  
- `iptables -F`  
  Vide toutes les règles de la chaîne spécifiée ou de toutes les chaînes si aucune n’est précisée. Exemple : `iptables -F INPUT`.

- `iptables -P <chaîne> <policy>`  
  Définit la **politique par défaut** pour une chaîne. Exemple : `iptables -P INPUT DROP`.


### **Options pour la correspondance des paquets**
- `-p <protocole>`  
  Spécifie le protocole (tcp, udp, icmp, all). Exemple : `-p tcp`.

- `-s <IP/masque>` ou `--source`  
  Spécifie l’adresse source. Exemple : `-s 192.168.1.0/24`.

- `-d <IP/masque>` ou `--destination`  
  Spécifie l’adresse de destination. Exemple : `-d 10.0.0.1`.

- `--sport <port>`  
  Définit un port ou une plage de ports source. Exemple : `--sport 1024:65535`.

- `--dport <port>`  
  Définit un port ou une plage de ports de destination. Exemple : `--dport 80`.


### **Actions (cibles)**
- `-j ACCEPT`  
  Accepte les paquets correspondants à la règle.

- `-j DROP`  
  Rejette les paquets **silencieusement**.

- `-j REJECT`  
  Rejette les paquets **avec une réponse** ICMP ou TCP.

- `-j LOG`  
  Journalise les paquets correspondants. Exemple : `-j LOG --log-prefix "DROP_LOG: "`.

### **Exemples pratiques**
1. **Bloquer tout trafic entrant sauf SSH :**
   ```bash
   iptables -P INPUT DROP
   iptables -A INPUT -p tcp --dport 22 -j ACCEPT
   ```

2. **Redirection de port :**
   ```bash
   iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80
   ```

3. **Limiter les connexions à 10 par minute par IP :**
   ```bash
   iptables -A INPUT -p tcp --dport 22 -m limit --limit 10/min -j ACCEPT
   ```
