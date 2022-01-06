!#/bin/bash

OS=$(cat /etc/os-release | grep ^NAME | cut -d= -f2 | cut -c2-7) #Détecte le type de système Linux
pm="" #définit le gestionnaire de paquets à utiliser

FUNC_DISTRO()
{
    if [[ $OS = "Debian" ]] || [ $OS = "Ubuntu" ]
        then
            pm="apt"
            repo=""
    elif [[ $OS = "Fedora" ]] || [[ $OS = "CentOS" ]]
        then
            pm="dnf"
            repo=""
    else
        clear
        echo -e "$rouge Distribution ou UNIX non prise en charge !"
    fi

    #Vérifie en utilisant une commande interne à bash si le paquet "pv" est installé
    #pv est utilisé pour afficher une barre de progression sur beaucoup de tâches du scrit
    if command -v pv &> /dev/null
        then
            echo ""
        else
            echo "Installation de la dépendance 'pv' pour la bonne execution du programme"
            $pm install -y pv &> /dev/null
    fi
}
