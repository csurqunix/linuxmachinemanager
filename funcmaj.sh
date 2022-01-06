!#/bin/bash

FUNC_MAJ()
{
    if [[ $pm = "apt" ]]
        then
            $pm update
            $pm upgrade
            echo -e "\n\n\t$neutre Appuyez sur \"Entrez\" pour afficher de nouveau le menu principal"
        elif [[ $pm = "dnf" ]]
            then
            $pm makecache
            $pm upgrade
            echo -e "\n\n\t$neutre Appuyez sur \"Entrez\" pour afficher de nouveau le menu principal"
        else
            clear
            echo -e "$rouge Distribution ou UNIX non pris en charge !"
            echo -e "\n\n\t$neutre Appuyez sur \"Entrez\" pour afficher de nouveau le menu principal"
        fi
}
