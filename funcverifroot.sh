#!/bin/bash

# Morceau de script pour vérifier que l'utilisateur est bien root

i=$(id -u)
if [[ $? -ne 0 ]]
    then exit 1
fi

if [[ "$i" -ne 0 ]]
	then
	echo "Le script doit s'executer en tant que root" >&2
	exit 2
fi
