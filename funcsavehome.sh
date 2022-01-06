!#/bin/bash

FUNC_HOMESAVE()
{
echo -e "\t$vert SAUVEGARDE D'UN DOSSIER PERSONNEL"
#boucle "tant que les réponses aux questions ne sont pas une de ces possibilités, reafficher les questions"
echo -e "\n$rouge /!\ Toute sauvegarde doit être testée /!\ $neutre"
echo -e "$rouge Une restauration dans un environnement virtuel à des fins de test est recommandé !$neutre"
echo -e "$rouge Les bonnes pratiques veulent que vous suiviez la règle 3,2,1 :$neutre"
echo -e "$rouge 3 copies, sur 2 supports différents, dont 1 copie hors site$neutre \n"
until [[ "$rephomesave" = "oui" ]] && [[ "$repdestsave" != "" ]] || [[ "$rephomesave" = "autre" ]] && [[ "$repdestsave" != "" ]]
do
    echo -e -n "\n\tVous êtes connecté en tant que $vertg$USER$neutre, faut il sauvegarder son répertoire ou celui d'un autre ? [oui|autre] : "
    read rephomesave
    clear
    FUNC_BAN
    echo -e -n "\n\tOu souhaitez vous sauvegarder ? merci d'indiquer le chemin absolu du répertoire, c'est à depuis la racine '/' : "
    read repdestsave
    clear
done
#Si l'utilisateur veut sauvegarder son propre home, alors go, si il veut sauvegarder celui d'un autre, alors lui demander de quel utilisateur on parle
if [[ "$rephomesave" = "oui" ]]
    then
    FUNC_BAN
    #crée une archive du répertoire en gardant les chemins absolus, envoie vers pv pour mesurer la progression, qui l'envoie vers gzip pour compression...
    #...vers le répertoire choisi par l'utilisateur
    tar cf - /home/$USER -P | pv -p --timer --rate --bytes | gzip > $repdestsave/home_save_of_$USER.tar.gz
    echo -e "\n$vertg Sauvegarde du répertoire personnel terminée !$neutre"
    sleep 3
    #afficher les sauvegardes réalisées
    ls -l $repdestsave | grep "hom_save_of"
    elif [[ "$rephomesave" = "autre" ]]
    then
        FUNC_BAN
        echo -n -e "\tVeuillez donner le nom de l'utilisateur dont vous souhaitez sauvegarder le répertoire personnel  : "
        read givenuser
        clear
        #vérifie que le dossier de l'utilisateur existe bel et bien, si tel est le cas, on y go, sinon, erreur
        if [[ -d /home/$givenuser ]]
            then
                FUNC_BAN
                tar cf - /home/$givenuser -P | pv -p --timer --rate --bytes | gzip > $repdestsave/home_save_of_$givenuser.tgz
                echo "Sauvegardé du répertoire personnel dans le répertoire actuel terminée !"
                sleep 3
                else
                echo -e "\n\n $rouge le dossier personnel de cet utilisateur n'existe pas ou n'est pas dans /home, abandon$neutre"
                sleep 3
                echo -e "Appuyez sur entrée pour retourner au menu principal"
        fi
    elif [[ "$rephomesave" = "non" ]]
        then
            FUNC_MENU
fi
}

