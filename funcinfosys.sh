#!/bin/bash

FUNC_INFOHARD()
{
echo -e $vert
echo -e "\t INFORMATIONS HARDWARE $neutre\n"
echo -e "$neutre Fabricant du système                  : $vertg" `cat /sys/devices/virtual/dmi/id/sys_vendor`
echo -e "$neutre Modèle du système                     : $vertg" `cat /sys/devices/virtual/dmi/id/product_family`
echo -e "$neutre Modèle du processeur                  : $vertg" `cat /proc/cpuinfo | grep -i "model name" | uniq | cut -d: -f2`
echo -e "$neutre Architecture                          : $vertg" `lscpu | grep "Architecture" | cut -d:  -f2`
echo -e "$neutre Mémoire vive de la machine            : $vertg" `lsmem | grep -i "Mémoire partagée" | cut -d: -f2`
echo -e "$neutre Espace disque total sur la racine     : $vertg" `df -h --sync --print-type / | grep -v Sys | tr "\t" " " | cut -d" " -f7`
echo -e "$neutre Espace disque restant sur la racine   : $vertg" `df -h --sync --print-type / | grep -v Sys | tr "\t" " " | cut -d" " -f14,16`
sleep 2
echo -e "\n\n\t$neutre Appuyez sur \"Entrez\" pour afficher de nouveau le menu principal"
}

FUNC_INFOSOFT()
{
echo -e $vert
echo -e "\t INFORMATIONS SOFTWARE $neutre\n"
echo -e "$neutre Version de la distribution            : $vertg" `cat /etc/os-release | grep ^NAME | cut -d= -f2`
echo -e "$neutre Version du noyau                      : $vertg $(uname -r)"
echo -e "$neutre Langue du système                     : $vertg" `echo $LANG | cut -d_ -f1`
echo -e "$neutre Date du jour                          : $vertg" `date`
#Ne garde que les champs 1 et 3 du fichier utilisateur, pour ensuite chercher les UID qui commencent par 1 suivis forcément de 3 chiffres, pas moins, pour identifier les comptes humains, puis ne garder que leurs noms
echo -e "$neutre Utilisateurs Humains sur ce système   : $vertg" `cat /etc/passwd | cut -d: -f1,3 | grep 1... | cut -d: -f1`
# Va consulter une variable crée par le système au démarrage (et que je n'ai donc pas eu à créer), et à laquelle je peux faire appel : $USER
echo -e "$neutre Utilisateur en cours                  : $vertg" $USER
# Afficher uniquement les ipv4, chercher la ligne inet, puis "tout ce qui ne correspond PAS à l'adresse de loopback", puis "tout ce qui ne correspond PAS à une carte virtuelle", et garder le champ 6 uniquement
echo -e "$neutre Adresse IPv4                          : $vertg" `ip -4 addr sh | grep inet | grep -v 127.0.0.1 | grep -v virbr* | cut -d" " -f6`
sleep 2
echo -e "\n\n\t$neutre Appuyez sur \"Entrez\" pour afficher de nouveau le menu principal"
}
