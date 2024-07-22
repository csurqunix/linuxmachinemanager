 #!/bin/bash

FUNC_LOGS()
{
echo -e "\t\t$vert EXPORT DE JOURNAUX :$neutre "
echo -e "\nExporter tous les journaux     :       tout"
echo -e "Exporter les journaux du noyau :       noyau"
echo -e "Exporter les erreurs           :       erreurs"
echo -e "Exporter les journaux sur 30j  :       tout30"
echo -e "Exporter les erreurs sur 30j   :       erreurs30"
echo -e "Retourner au menu              :       q"
echo -e "\n Tapez le terme en fonction de l'export souhaité :\n \t"
read selec
 case "$selec" in
    "tout")
    clear
    echo "Attention, cela peut prendre un moment..."
    sleep 2
    journalctl > tous_les_journaux.txt
    sleep 1
    echo -e "\nAppuyez sur 'Entrée' pour afficher le menu principal"
    ;;
    "noyau")
    clear
    journalctl --dmesg > journaux_noyaux.txt
    sleep 1
    clear
    FUNC_BAN
    echo -e "\nExport Terminé ! Appuyez sur 'Entrée' pour afficher le menu principal"
    ;;
    "erreurs")
    clear
    journalctl -p err > journaux_des_erreurs.txt
    sleep 1
    clear
    FUNC_BAN
    echo -e "\nExport Terminé ! Appuyez sur 'Entrée' pour afficher le menu principal"
    ;;
    "tout30")
    journalctl --since "1 month ago" > journaux_du_mois.txt
    sleep 1
    clear
    FUNC_BAN
    echo -e "\nExport Terminé ! Appuyez sur 'Entrée' pour afficher le menu principal"
    ;;
    "erreurs30")
    journalctl -p err --since "1 month ago" > journaux_des_erreurs_sur_30j.txt
    sleep 1
    clear
    FUNC_BAN
    echo -e "\nExport Terminé !Appuyez sur 'Entrée' pour afficher le menu principal"
    ;;
    "q")
    FUNC_BAN
    FUNC_MENU
    ;;
esac
}
