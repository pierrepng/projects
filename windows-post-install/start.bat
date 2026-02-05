@echo off
setlocal

REM obtem o diretorio do arquivo bat seja onde estiver
set "SCRIPT_DIR=%~dp0"

REM executa o script via powershell ja com bypass
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%automacao.ps1"

endlocal