#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Necesitas ejecutarlo como root." 1>&2
    exit 100
fi


function report {
    echo "Generando reporte..."
    echo "<========> Reporte <========>" > report.txt
    echo -e "<========> FECHA DE INICIO <========>\n" >> report.txt
    date >> report.txt
    echo -e "<========> INFORMACIÓN DEL SISTEMA <========>\n" >> report.txt
    uname -a >> report.txt
    echo -e "<========> INFORMACIÓN DE LA RED <========>\n" >> report.txt
    ifconfig -a >> report.txt
    echo -e "<========> ESTADO DE LA RED <========>\n" >> report.txt
    netstat -ano >> report.txt
    echo -e "<========> PROCESOS <========>\n" >> report.txt
    ps aux >> report.txt
    echo -e "<========> ENRUTAMIENTO <========>\n" >> report.txt
    route -n >> report.txt
    echo -e "<========> FECHA FINAL <========>\n" >> report.txt
    date >> report.txt
}

report
