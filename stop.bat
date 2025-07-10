@echo off
title Parar Projeto Electron
color 0C

echo ========================================
echo    PARANDO PROJETO ELECTRON
echo ========================================
echo.

echo Finalizando processos...

:: Parar processos Node.js
echo - Parando servidor API (Node.js)...
taskkill /f /im node.exe >nul 2>&1
if errorlevel 1 (
    echo   ⚠️ Nenhum processo Node.js encontrado
) else (
    echo   ✅ Servidor API finalizado
)

:: Parar processos Electron
echo - Parando aplicação Electron...
taskkill /f /im electron.exe >nul 2>&1
if errorlevel 1 (
    echo   ⚠️ Nenhum processo Electron encontrado
) else (
    echo   ✅ Aplicação Electron finalizada
)

:: Liberar porta 3000
echo - Liberando porta 3000...
for /f "tokens=5" %%a in ('netstat -aon ^| find ":3000 " ^| find "LISTENING" 2^>nul') do (
    taskkill /f /pid %%a >nul 2>&1
)
echo   ✅ Porta 3000 liberada

echo.
echo ✅ Aplicação completamente finalizada!
echo.
pause
