# Herramienta para provisionamiento rapido de claves publicas SSH

## Ejecuccion del script

1. Debemos de estar en el usuario que aparece nada mas arrancar el servidor (no root)
2. Ejecutamos el siguiente comando: wget http://172.16.0.5/pubfiles/sshkey-deploy.sh && chmod +x sshkey-deploy.sh && ./sshkey-deploy.sh
3. Seguimos los pasos que sale en la terminal, nos pedira nuestra contraseña de usuario para ejecutar ciertos comandos como root
4. Si todo ha salido bien, ya tendremos las claves instaladas de forma masiva


## Informacion sobre copias de seguridad

Este script realiza una copia de seguridad del archivo anterior para que, en caso de que algo falle, podamos restaurarlo simplemente eliminado el archivo malo y renombrando el de la copia.
Los archivos que se realizan copia son:

- authorized_keys (dentro de /home/usuario/.ssh/) y quedaria como authorized_keys-fechaActual.bak
- sshd_config (dentro de /etc/ssh/) y quedaria como sshd_config-fechaActual.bak

Para restaurarlo, ejecutamos los siguientes comandos (reemplazar 'usuario' por el nuestro y fechaActual por el formato mes-dia-año Ej. sshd_config-12-09-24.bak):

//Claves Publicas
- rm /home/usuario/.ssh/authorized_keys
- mv /home/usuario/.ssh/authorized_keys-fechaActual.bak /home/usuario/.ssh/authorized_keys

//Configuracion Servidor SSH
- sudo rm /etc/ssh/sshd_config
- sudo mv /etc/ssh/sshd_config-fechaActual.bak /etc/ssh/sshd_config
- sudo service sshd restart
