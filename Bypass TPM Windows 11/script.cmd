@echo off
setlocal


echo Deshabilitando TPM...

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Machine\Default" /v "Value" /t REG_DWORD /d 0 /f

if %errorlevel% neq 0 (
    echo Error al deshabilitar TPM. Ejecutalo como administrador.
    exit /b
)

echo TPM deshabilitado

endlocal
