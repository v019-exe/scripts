@echo off

net.exe user "nombre" /add
net.exe localgroup "Administradores" /add "nombre"
cd oobe
msoobe.exe && shutdown /r /t 0
