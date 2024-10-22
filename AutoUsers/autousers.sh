#!/bin/bash

echo -e "\033[0;35m
            _    __
 _  _____  (_)__/ /
| |/ / _ \/ / _  / 
|___/\___/_/\_,_/  
                   
[*] Github: github.com/v019-exe
[*] Script hecha por v019.exe
\033[0m"

fondo_azul="\e[44m"
fondo_amarillo="\e[43m"
fondo_verde="\e[42m"
fondo_rojo="\e[41m"
reset="\e[0m"
fondo_morado="\033[45;1m"

if [ "$EUID" -ne 0 ]
  then echo -e "[${fondo_morado}VOID${reset}][$(date +"%H:%M:%S")]: Ejecuta el script como root"
  exit
fi


if [ $# -eq 0 ]; then
    echo -e "[${fondo_morado}INFO VOID${reset}] Uso: $0 <archivo.csv>"
    exit 1
fi

FILE="$1"

while IFS="," read -r usuario password
do
    if id "$usuario" &>/dev/null; then
        echo -e "[${fondo_azul}INFO${reset}][$(date +"%H:%M:%S")]: El usuario $usuario existe"
        echo -e "[${fondo_azul}INFO${reset}][$(date +"%H:%M:%S")]: Cambiando contraseña del usuario $usuario"
        echo "$usuario:$password" | sudo chpasswd
    else
        echo -e "[${fondo_amarillo}WARN${reset}][$(date +"%H:%M:%S")]: El usuario no existe, creando el usuario $usuario"
        sudo useradd -m "$usuario"
        if [ $? -ne 0 ]; then
            echo -e "[${fondo_rojo}ERROR${reset}][$(date +"%H:%M:%S")]: Error al crear el usuario"
            exit 1
        else
            echo -e "[${fondo_azul}INFO${reset}][$(date +"%H:%M:%S")]: Cambiando contraseña del usuario $usuario"
            echo "$usuario:$password" | sudo chpasswd
            if [ $? -ne 0 ]; then
                echo -e "[${fondo_rojo}ERROR${reset}][$(date +"%H:%M:%S")]: Error al cambiar la contraseña del usuario $usuario"
                exit 1
            else
                echo -e "[${fondo_verde}SUCCESS${reset}][$(date +"%H:%M:%S")]: Contraseña cambiada con éxito."
            fi
        fi
    fi

done < $FILE
