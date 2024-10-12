<<<<<<< HEAD
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host -ForegroundColor Red "Necesitas ejecutarlo como administrador."
    exit 100
}

function Generar-Reporte {
    $reportPath = "C:\reporte.txt"
    
    Write-Host -ForegroundColor Cyan "Generando reporte..."
    Add-Content -Path $reportPath -Value "v019.exe Script"
    Add-Content -Path $reportPath -Value "`n`<========`> Reporte `<========`>"

    Write-Host -ForegroundColor Green "`n`<========`> FECHA DE INICIO `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> FECHA DE INICIO `<========`>`n"
    $startDate = Get-Date
    Write-Host -ForegroundColor Yellow $startDate
    Add-Content -Path $reportPath -Value $startDate
a
    Write-Host -ForegroundColor Green "`n`<========`> INFORMACIÓN DEL SISTEMA `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> INFORMACIÓN DEL SISTEMA `<========`>`n"
    $sysInfo = Get-ComputerInfo
    Write-Host -ForegroundColor Yellow $sysInfo.CsName
    Add-Content -Path $reportPath -Value $sysInfo

    Write-Host -ForegroundColor Green "`n`<========`> INFORMACIÓN DE LA RED `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> INFORMACIÓN DE LA RED `<========`>`n"
    $netInfo = Get-NetAdapter
    Write-Host -ForegroundColor Yellow $netInfo | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $netInfo

    Write-Host -ForegroundColor Green "`n`<========`> ESTADO DE LA RED `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> ESTADO DE LA RED `<========`>`n"
    $tcpConn = Get-NetTCPConnection
    Write-Host -ForegroundColor Yellow $tcpConn | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $tcpConn

    Write-Host -ForegroundColor Green "`n`<========`> PROCESOS `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> PROCESOS `<========`>`n"
    $processes = Get-Process
    Write-Host -ForegroundColor Yellow $processes | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $processes

    Write-Host -ForegroundColor Green "`n`<========`> ENRUTAMIENTO `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> ENRUTAMIENTO `<========`>`n"
    $routing = Get-NetRoute
    Write-Host -ForegroundColor Yellow $routing | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $routing

    Write-Host -ForegroundColor Green "`n`<========`> FECHA FINAL `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> FECHA FINAL `<========`>`n"
    $endDate = Get-Date
    Write-Host -ForegroundColor Yellow $endDate
    Add-Content -Path $reportPath -Value $endDate
    
    Write-Host -ForegroundColor Cyan "Reporte generado y guardado en $reportPath"
}

Generar-Reporte
=======
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host -ForegroundColor Red "Necesitas ejecutarlo como administrador."
    exit 100
}

function Generar-Reporte {
    $reportPath = "C:\reporte.txt"
    
    Write-Host -ForegroundColor Cyan "Generando reporte..."
    Add-Content -Path $reportPath -Value "v019.exe Script"
    Add-Content -Path $reportPath -Value "`n`<========`> Reporte `<========`>"

    Write-Host -ForegroundColor Green "`n`<========`> FECHA DE INICIO `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> FECHA DE INICIO `<========`>`n"
    $startDate = Get-Date
    Write-Host -ForegroundColor Yellow $startDate
    Add-Content -Path $reportPath -Value $startDate
a
    Write-Host -ForegroundColor Green "`n`<========`> INFORMACIÓN DEL SISTEMA `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> INFORMACIÓN DEL SISTEMA `<========`>`n"
    $sysInfo = Get-ComputerInfo
    Write-Host -ForegroundColor Yellow $sysInfo.CsName
    Add-Content -Path $reportPath -Value $sysInfo

    Write-Host -ForegroundColor Green "`n`<========`> INFORMACIÓN DE LA RED `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> INFORMACIÓN DE LA RED `<========`>`n"
    $netInfo = Get-NetAdapter
    Write-Host -ForegroundColor Yellow $netInfo | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $netInfo

    Write-Host -ForegroundColor Green "`n`<========`> ESTADO DE LA RED `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> ESTADO DE LA RED `<========`>`n"
    $tcpConn = Get-NetTCPConnection
    Write-Host -ForegroundColor Yellow $tcpConn | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $tcpConn

    Write-Host -ForegroundColor Green "`n`<========`> PROCESOS `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> PROCESOS `<========`>`n"
    $processes = Get-Process
    Write-Host -ForegroundColor Yellow $processes | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $processes

    Write-Host -ForegroundColor Green "`n`<========`> ENRUTAMIENTO `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> ENRUTAMIENTO `<========`>`n"
    $routing = Get-NetRoute
    Write-Host -ForegroundColor Yellow $routing | Format-Table -AutoSize
    Add-Content -Path $reportPath -Value $routing

    Write-Host -ForegroundColor Green "`n`<========`> FECHA FINAL `<========`>`n"
    Add-Content -Path $reportPath -Value "`n`<========`> FECHA FINAL `<========`>`n"
    $endDate = Get-Date
    Write-Host -ForegroundColor Yellow $endDate
    Add-Content -Path $reportPath -Value $endDate
    
    Write-Host -ForegroundColor Cyan "Reporte generado y guardado en $reportPath"
}

Generar-Reporte
>>>>>>> 513305e1d6e6fd41a0416758698221e589374f8d
