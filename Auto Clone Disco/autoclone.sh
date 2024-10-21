#!/bin/bash

echo -e "\033[0;35m
            _    __
 _  _____  (_)__/ /
| |/ / _ \/ / _  / 
|___/\___/_/\_,_/  
                   
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
    echo -e "[\e[34mINFO\e[0m][$(date +"%H:%M:%S")]: Comprobando si el disco existe..."
    if [ -e "$ruta" ]; then
        echo -e "[\e[34mINFO\e[0m][$(date +"%H:%M:%S")]: El disco duro existe"

		echo -e "[\e[34mINFO\e[0m][$(date +"%H:%M:%S")]: Comprobando el particionamiento..."
		if [ -b "$ruta" ] && blkid "$ruta" > /dev/null; then
			FSTYPE=$(lsblk -nr -o FSTYPE /dev/sda | head -n 3 | tr -d '\n')
			
			echo -e "[\e[34mINFO\e[0m][$(date +"%H:%M:%S")]: El disco está formateado con $FSTYPE"
		else
			echo -e "[\e[43mWARN\e[0m][$(date +"%H:%M:%S")]: El disco no tiene formato"
			echo -e "[\e[43mWARN\e[0m][$(date +"%H:%M:%S")]: Formateando con ext4"
			
			# Formatear el disco con ext4
			sudo mkfs.ext4 "$ruta"
			
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
                sudo mount $ruta $montaje
                if [ $? -ne 0 ]; then
                    echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al montar el disco"
                    return
                else
                    echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Disco montado correctamente"
                fi
            fi

            echo $contenido > $ruta_fichero/$fichero
            if [ $? -ne 0 ]; then
                echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al crear el fichero en $ruta_fichero"
            else
                echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Fichero creado correctamente"
            fi

            echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Hasheando el fichero usando md5"
            hash=$(md5sum $ruta_fichero/$fichero | awk '{print $1}')
            if [ $? -eq 0 ]; then
                echo -e "[\e[32mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Hash del fichero: $hash"
            else
                echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al hacer el hash del archivo ubicado en $ruta_fichero"
            fi

            echo -e "[\e[33mWARN\e[0m][$(date +"%H:%M:%S")]: Intentando desmontar el disco de $montaje"
            sudo umount $montaje
            if [ $? -ne 0 ]; then
                echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al desmontar el disco"
            else
                echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Disco desmontado correctamente"
				echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Reformateando el disco $ruta"
				sudo mkfs.ext4 -F "$ruta"
				if [ $? -ne 0 ]; then
					echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al formatear el disco"
				else
					echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Disco reformateado correctamente"
					sudo mount $montaje
					if [ $? -ne 0 ]; then
						echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al remontar el disco en $montaje"
					else
						echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Disco montado correctamente en $montaje"
						echo -e "[\e[44mINFO\e[0m][$(date +"%H:%M:%S")]: Creando la imagen del disco"
						sudo dd if=$ruta of=$imagen bs=4M
						if [ $? -ne 0 ]; then
							echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: Error al crear la imagen"
						else
							echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: Se ha creado correctamente la imagen, $imagen"
							hash_despues=$(md5sum $imagen | awk '{print $1}')

							if [ $hash -eq $hash_despues ]; then
								echo -e "[\e[42mSUCCESS\e[0m][$(date +"%H:%M:%S")]: El hash es igual, la copia ha tenido éxito"
							else
								echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: El hash no es igual, error al crear la copia"
								return
							fi
						fi
					fi
				fi
            fi
        else
            echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: El punto de montaje no existe"
        fi
    else
        echo -e "[\e[41mERROR\e[0m][$(date +"%H:%M:%S")]: El disco no existe"
    fi
}

autoclone
