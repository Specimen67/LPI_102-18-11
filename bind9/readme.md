# BIND9
Les fichiers de configuration doivent se trouver dans /etc/bind

## Plusieurs type d'enregistrement:

Enregistrement de type A : Associer un nom  FQDN à une adresse IPV4
Enregistrement de type AAAA: Associer un nom FQDN à une adresse IPV6
Enregistrement de type CNAME: Associer un nom à un autre nom (alias)
Enregistrement de type MX: détermine où les mails doivent être envoyés pour un domaine
Enregistrement de type PTR: Permet la résolution inverse

## Les fichiers named.conf permettent de déclarer une zone de résolution de nom

## Les fichiers db. (comme par exemple db.mondomaine.lan) dont utilisés pour déclarer le nom.

Il ne faut pas hésiter à utiliser les fichiers par défaut de bind9