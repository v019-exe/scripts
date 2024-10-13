if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Por favor, ejecuta este script como administrador."
    exit
}

$regPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender",
    "HKCU:\SOFTWARE\Policies\Microsoft\Windows Defender"
)

foreach ($path in $regPaths) {
    if (Test-Path $path) {
        $values = Get-ItemProperty -Path $path

        foreach ($value in $values.PSObject.Properties) {
            if ($value.Value -eq 0) {
                Set-ItemProperty -Path $path -Name $value.Name -Value 1
                Write-Host "Cambiado $($value.Name) de 0 a 1 en $path"
            } elseif ($value.Value -eq 1) {
                Set-ItemProperty -Path $path -Name $value.Name -Value 0
                Write-Host "Cambiado $($value.Name) de 1 a 0 en $path"
            }
        }
    } else {
        Write-Host "No se encontraron políticas en: $path"
    }
}

Write-Host "Script completado."
