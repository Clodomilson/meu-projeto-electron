@echo off
title Projeto Electron - Sistema de Login
color 0A

echo ========================================
echo    PROJETO ELECTRON - SISTEMA LOGIN
echo ========================================
echo.
echo Iniciando aplicacao completa...
echo Data/Hora: %date% %time%
echo.

echo [1/4] Verificando dependencias...
if not exist "node_modules" (
    echo   - Instalando dependencias do projeto principal...
    npm install --silent
    if errorlevel 1 (
        echo   ❌ Erro ao instalar dependencias principais!
        pause
        exit /b 1
    )
    echo   ✅ Dependencias principais instaladas
) else (
    echo   ✅ Dependencias principais OK
)

if not exist "api-server\node_modules" (
    echo   - Instalando dependencias do servidor API...
    cd api-server
    npm install --silent
    if errorlevel 1 (
        echo   ❌ Erro ao instalar dependencias da API!
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo   ✅ Dependencias da API instaladas
) else (
    echo   ✅ Dependencias da API OK
)

if not exist "my-electron-app\node_modules" (
    echo   - Instalando dependencias do Electron...
    cd my-electron-app
    npm install --silent
    if errorlevel 1 (
        echo   ❌ Erro ao instalar dependencias do Electron!
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo   ✅ Dependencias do Electron instaladas
) else (
    echo   ✅ Dependencias do Electron OK
)

echo.
echo [2/4] Verificando se a porta 3000 esta livre...
netstat -an | find "3000" | find "LISTENING" >nul
if not errorlevel 1 (
    echo   ⚠️  Porta 3000 em uso. Tentando liberar...
    taskkill /f /im node.exe >nul 2>&1
    timeout /t 2 /nobreak >nul
)
echo   ✅ Porta 3000 disponivel

echo.
echo [3/4] Verificando arquivos essenciais...
if not exist "api-server\server.js" (
    echo   ❌ Arquivo server.js nao encontrado!
    pause
    exit /b 1
)
if not exist "my-electron-app\main.js" (
    echo   ❌ Arquivo main.js nao encontrado!
    pause
    exit /b 1
)
if not exist "package.json" (
    echo   ❌ Arquivo package.json principal nao encontrado!
    pause
    exit /b 1
)
echo   ✅ Arquivos essenciais OK

echo.
echo [4/4] Iniciando aplicacao...
echo   🚀 Servidor API: http://localhost:3000
echo   🖥️  Aplicacao Electron: Abrindo automaticamente
echo   📋 Logs: Visiveis no terminal
echo.
echo ========================================
echo    APLICACAO RODANDO
echo ========================================
echo.
echo Comandos disponiveis durante execucao:
echo   Ctrl+C : Parar aplicacao
echo   F12    : DevTools (no Electron)
echo.
echo Iniciando em 3 segundos...
timeout /t 3 /nobreak >nul

echo Executando: npm run dev
npm run dev

echo.
echo ========================================
echo    APLICACAO FINALIZADA
echo ========================================
echo.
echo Se houve algum erro, verifique:
echo - Se o Node.js esta instalado
echo - Se as portas estao disponiveis
echo - Se nao ha processos conflitantes
echo.
pause
