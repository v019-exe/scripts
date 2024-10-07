import os
import platform
import sys
import subprocess

if platform.system() != "Windows":
    print("Este script está diseñado solo para sistemas Windows.")
    sys.exit(1)

def eliminar_contenido(directorio):
    if directorio:
        for root, dirs, files in os.walk(directorio, topdown=False):
            for name in files:
                ruta_archivo = os.path.join(root, name)
                if os.path.isfile(ruta_archivo):
                    try:
                        os.remove(ruta_archivo)
                        print(f"Archivo eliminado: {ruta_archivo}")
                    except Exception as e:
                        print(f"Error al eliminar el archivo {ruta_archivo}: {e}")
            
            for name in dirs:
                ruta_carpeta = os.path.join(root, name)
                try:
                    os.rmdir(ruta_carpeta)
                    print(f"Carpeta eliminada: {ruta_carpeta}")
                except OSError as e:
                    print(f"No se pudo eliminar la carpeta {ruta_carpeta}: {e}")

def limpiar():
    TMP = os.getenv("TMP")
    PREFETCH = "C:\Windows\Prefetch"

    try:
        print("Intentando limpiar TMP...")
        eliminar_contenido(TMP)
    except PermissionError:
        print("No se tienen permisos para eliminar en TMP, intentando PREFETCH...")
    
    try:
        print("Intentando limpiar PREFETCH...")
        eliminar_contenido(PREFETCH)
    except PermissionError:
        print("No se tienen permisos para eliminar en PREFETCH.")

def vaciar_papelera():
    try:
        print("Intentando vaciar papelera...")
        comando = ["powershell.exe", "-Command", "Clear-RecycleBin -Confirm:$false"]
        resultado = subprocess.run(comando, check=True)

        print("Papelera vaciada.")
    except Exception as e:
        print(f"No se pudo ejecutar el comando para vaciar la papelera: {e}")

try:
    limpiar()
    papelera = input("Quieres vaciar la papelera? (S/N): ")

    if papelera.lower() == "s" or papelera.lower() == "si":
        vaciar_papelera()
        print("Limpieza completada.")
    else:
        print("Limpieza cancelada.")

except Exception as e:
    print(f"Ocurrió un error durante la limpieza: {e}")
