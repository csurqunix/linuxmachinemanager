#!/bin/bash

#La variable "bootype" ici crée execute une commande qui nous permet de vérifier très simplement si le système boot via un MBR ou un GPT
boottype=$(parted -l | grep -i "Table de partitions" | grep -v loop | cut -d: -f2)

FUNC_SAVEBOOT()
{
#Demande à l'utilisateur si il veut sauvegarder le MBR ou le GPT
FUNC_BAN
echo -e "\t\t$vert SAUVEGARDE DU BOOT LINUX$neutre\n"
read -p "Sauvegarder la partie de votre disque/SSD relative au boot ? [oui / non] : " repboot
#Dans le cas du "oui", on execute une séquence différente dans le cas d'un MBR ou d'un GPT
if [[ $repboot = "oui" ]]
    then
    if [[ $boottype = " gpt" ]]
        then
            echo -e "$vert\t \t SAUVEGARDE DES SECTEURS DE BOOT"
            echo -e "$neutre\n Votre système utilise une table de partition de type GPT"
            echo -e "\n"
            sleep 02
            read -p "Veuillez préciser le disque sur lequel se trouve la racine [sda ? hda ? nvme0n1 ? mmcblk0 ?] :  " racine
            read -p "Maintenant, donnez un nom au fichier de sauvegarde  : " savefile
            touch $savefile
            sgdisk --backup=./$savefile /dev/$racine
            echo -e "\n $vert sauvegardé dans le répertoire actuel au nom demandé !$neutre"
            sleep 2
                elif [[ $boottype = " msdos" ]]
                    then
                    echo -e "$neutre Votre système utilise une table de partition de type MBR, appelé aussi 'MSDOS'"
                    echo -e "\n"
                    sleep 02
                    read -p "Veuillez préciser le disque sur lequel se trouve la racine [sda ? hda ? nvme0 ? mmcblk0 ?]" racine
                    read -p "Maintenant, donnez un nom au fichier de sauvegarde  : " savefile
                    touch $savefile
                    dd if=/dev/$racine of=./$savefile bs=448 count=1
                    echo -e "\n $vert sauvegardé dans le répertoire actuel au nom demandé !$neutre"
                    sleep 2
    fi
fi
clear
FUNC_BAN
#Dans le cas du "oui", on execute une séquence qui permet de sauvegarder le fichier de conf de GRUB
read -p "Sauvegarder le fichier de configuration de GRUB, le bootloader du système ? [oui / non] " repgrub
if [[ $repgrub = "oui" ]]
    then
        echo -e "$vert\t \t SAUVEGARDE DU FICHIER DE CONFIGURATION DE GRUB$neutre \n"
        clear
        FUNC_BAN
        read -p " Veuillez préciser le nom à donner à la sauvegarde de ce fichier : " grubsave
        cp /etc/default/grub ./$grubsave
        echo -e "\n$vert sauvegardé dans le répertoire actuel au nom demandé !"
        sleep 2
fi
echo -e "\n\n\t$neutre Appuyez sur \"Entrez\" pour afficher de nouveau le menu principal"
#restaurer un MBR depuis le dossier utilisateur
#dd if=/home/$USER/$namefic /dev/$racine bs=448 count=1
#restaurer une GPT depuis un fichier
#sgdisk --load-backup=/home/$USER/$namefic /dev/$racine
}
