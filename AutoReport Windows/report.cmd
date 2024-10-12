@echo off
chcp 65001 >nul

:: Colores púrpuras en gradiente
:: Fondo negro, texto púrpura claro
color 0D

net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Este script necesita ejecutarse como administrador.
    pause
    exit /b
)

:: Cambio a púrpura oscuro
color 05
echo ==================== > reporte.txt
echo Reporte de Estadísticas del Sistema >> reporte.txt
echo ==================== >> reporte.txt

echo Recuperando estadísticas de red...
netsh interface ip show interface >> reporte.txt

:: Cambio a púrpura claro
color 0D
echo Recuperando estadísticas de disco...
wmic diskdrive get name,freespace,size | findstr /v "NULL" >> reporte.txt

:: Cambio a púrpura oscuro
color 05
echo Recuperando estadísticas de procesos...
tasklist /v >> reporte.txt

echo Recuperando estadísticas de servicios...
echo Servicios instalados: >> reporte.txt
sc query type= service state= all >> reporte.txt

:: Cambio a púrpura claro
color 0D
echo Servicios en ejecución... >> reporte.txt
sc query type= service state= running >> reporte.txt

echo Servicios detenidos... >> reporte.txt
sc query type= service state= stopped >> reporte.txt

:: Cambio a púrpura oscuro
color 05
echo Usuarios con sesión activa... >> reporte.txt
query user >> reporte.txt

echo Usuarios con sesión inactiva... >> reporte.txt
query user /server:localhost >> reporte.txt

:: Cambio a púrpura claro
color 0D
echo Estadísticas de memoria... >> reporte.txt
systeminfo | findstr "Total Physical Memory" >> reporte.txt
systeminfo | findstr "Available Physical Memory" >> reporte.txt

:: Cambio a púrpura oscuro
color 05
echo Versión del sistema operativo... >> reporte.txt
ver >> reporte.txt

:: Cambio a púrpura claro
color 0D
echo Estadísticas del CPU... >> reporte.txt
wmic cpu get name, currentclockspeed, maxclockspeed | findstr /v "NULL" >> reporte.txt

echo Programas instalados... >> reporte.txt
wmic product get name, version | findstr /v "NULL" >> reporte.txt

:: Cambio a púrpura oscuro
color 05
echo Eventos recientes... >> reporte.txt
wevtutil qe System "/q:*[System[(EventID=1)]]" /f:text >> reporte.txt

:: Cambio a púrpura claro
color 0D
echo Reporte generado el: %date% %time% >> reporte.txt

echo Reporte generado en reporte.txt.
pause
exit
