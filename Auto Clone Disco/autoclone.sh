#!/bin/bash

clear

echo -e "\033[0;35m
            _    __
 _  _____  (_)__/ /
| |/ / _ \/ / _  / 
|___/\___/_/\_,_/  
                   
[*] Github: github.com/v019-exe
[*] Script hecha por v019.exe
\033[0m"

if [ "$EUID" -ne 0 ]
  then echo -e "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Ejecuta el script como root"
  exit
fi

echo -ne "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Ruta del disco: "
read ruta
echo -ne "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Ruta de montaje: "
read montaje
echo -ne "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Nombre del fichero: "
read fichero
echo -ne "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Contenido del fichero (Solo una línea): "
read contenido
echo -ne "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Ruta del fichero: "
read ruta_fichero
echo -ne "[\033[0;35m\e[1mVOID\e[0m\033[0m][$(date +"%H:%M:%S")]: Ruta de la imagen (incluye el nombre de la img): "
read imagen

autoclone() {
    echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Comprobando si el disco existe..."
    if [ -e "$ruta" ]; then
        echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: El disco duro existe"

		echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Comprobando el particionamiento..."
		if [ -b "$ruta" ] && blkid "$ruta" > /dev/null; then
			FSTYPE=$(lsblk -nr -o FSTYPE /dev/sda | head -n 3 | tr -d '\n')
			echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: El disco está formateado con $FSTYPE"
		else
            echo -e "[\e[43mWARN\e[0m][$(date +"%H:%M:%S")]: El disco no tiene formato"
			echo -e "[\e[43mWARN\e[0m][$(date +"%H:%M:%S")]: Formateando con ext4"
			sudo mkfs.ext4 "$ruta" > /dev/null
			
			if [ $? -ne 0 ]; then
				echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al formatear el disco"
				return
			else
				echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Disco formateado correctamente"
			fi
		fi

        echo -e "[\e[43mWARN\e[0m][$(date +"%H:%M:%S")]: Intentando montar el disco en $montaje"
        
        if [ -d "$montaje" ]; then
            echo -e "[\e[43mWARN\e[0m][$(date +"%H:%M:%S")]: Montando en $montaje"
            
            if mount | grep "on $ruta" > /dev/null; then
                echo -e "[\e[33mWARN\e[0m][$(date +"%H:%M:%S")]: El disco ya está montado"
            else
                sudo mount $ruta $montaje > /dev/null
                if [ $? -ne 0 ]; then
                    echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al montar el disco"
                    return
                else
                    echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Disco montado correctamente"
                fi
            fi

            echo "$contenido" > "$ruta_fichero/$fichero"
            if [ $? -ne 0 ]; then
                echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al crear el fichero en $ruta_fichero"
            else
                echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Fichero creado correctamente"
            fi

            echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Borrando el archivo $fichero"
            sudo rm -rf "$ruta_fichero/$fichero"
            if [ $? -eq 0 ]; then
                echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Archivo borrado correctamente"
            else
                echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al borrar el archivo"
            fi

            echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Hasheando el fichero usando md5"
            hash=$(md5sum "$ruta" | awk '{print $1}')
            echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Hash del disco: $hash"
            if [ $? -eq 0 ]; then
                echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Hash del disco: $hash"
                sudo dd if=$ruta of=$imagen bs=4M status=progress 2> /dev/null
                if [ $? -eq 0 ]; then
                    echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Se ha creado la imagen correctamente."
                    hash_imagen=$(md5sum "$imagen" | awk '{ print $1 }')
                    if [ "$hash" == "$hash_imagen" ]; then
                        echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Los hashes coinciden, imagen creada correctamente"
                    else
                        echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Los hashes no coinciden, imagen errónea"
                    fi
                else
                    echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al crear la imagen del disco."
                fi
            else
                echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al hacer el hash del archivo ubicado en $ruta_fichero"
            fi
        else
            echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: El punto de montaje no existe"
        fi
    else
        echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: El disco no existe"
    fi
}

autoclone
