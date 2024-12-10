#!/bin/bash

#Herramienta para la instalacion masiva de claves publicas en servidores Linux
# Github: @zheanel | v 0.1

originSERVER=172.16.0.5
keyFILE=authorized_keys

if [ $(id -u) -eq 0 ]
then
    echo "¡Estas como usuario root, cancelando!"
else
    echo "¡AVISO! SI EXISTE UN ARCHIVO "$keyFILE", ESTE SE MOVERA A "$keyFILE"-$(date +"%m-%d-%y").bak. Esto tambien se aplica para el fichero sshd_config"
    read -p "Presiona cualquier tecla para continuar"
    echo "Realizando configuracion, no presionar ninguna tecla hasta que finalize el proceso"
    sleep 3
    mkdir -p /home/"$USER"/.ssh
    chmod 700 /home/"$USER"/.ssh
    mv /home/"$USER"/.ssh/"$keyFILE" /home/"$USER"/.ssh/"$keyFILE"-$(date +"%m-%d-%y").bak &>/dev/null
    wget http://"$originSERVER"/pubfiles/"$keyFILE" -P /home/"$USER"/.ssh/ &>/dev/null
    chmod 600 /home/"$USER"/.ssh/"$keyFILE"
    chown -R "$USER":"$USER" /home/"$USER"/.ssh/
    sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config-$(date +"%m-%d-%y").bak
    sudo wget http://"$originSERVER"/pubfiles/sshd_config -P /etc/ssh/ &>/dev/null
    sudo chmod 644 /etc/ssh/ssh_config
    sudo service sshd restart
    if [ $? -ne 0 ]
    then
        echo "Error al descargar ficheros o aplicar cambios requeridos. Realize los pasos manualmente"
    else
        echo "Proceso Finalizado. Yipeee"
    fi
fi
