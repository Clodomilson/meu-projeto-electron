@echo off
setlocal enabledelayedexpansion
title Projeto Electron - Launcher Avançado
color 0B

:: Verificar se está sendo executado como administrador (opcional)
net session >nul 2>&1
if %errorLevel% == 0 (
    set ADMIN_MODE=true
    echo [INFO] Executando com privilégios de administrador
) else (
    set ADMIN_MODE=false
)

echo ================================================
echo         PROJETO ELECTRON - LAUNCHER
echo ================================================
echo.
echo 🚀 Inicializando sistema completo...
echo 📅 Data: %date%
echo 🕒 Hora: %time%
echo 💻 Sistema: %OS%
echo 👤 Usuário: %USERNAME%
echo.

:: Verificar Node.js
echo [VERIFICAÇÃO] Testando Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js não encontrado!
    echo.
    echo Por favor, instale o Node.js:
    echo https://nodejs.org/
    echo.
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo ✅ Node.js !NODE_VERSION! detectado
)

:: Verificar NPM
echo [VERIFICAÇÃO] Testando NPM...
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ NPM não encontrado!
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo ✅ NPM !NPM_VERSION! detectado
)

:: Verificar conexão com internet (opcional)
echo [VERIFICAÇÃO] Testando conectividade...
ping -n 1 8.8.8.8 >nul 2>&1
if errorlevel 1 (
    echo ⚠️ Sem conexão com internet (pode afetar instalação de dependências)
) else (
    echo ✅ Conectividade OK
)

echo.
echo ================================================
echo         INSTALAÇÃO DE DEPENDÊNCIAS
echo ================================================

:: Função para instalar dependências com retry
call :install_dependencies "." "projeto principal"
call :install_dependencies "api-server" "servidor API"
call :install_dependencies "my-electron-app" "aplicação Electron"

echo.
echo ================================================
echo         PRÉ-INICIALIZAÇÃO
echo ================================================

:: Verificar e limpar processos anteriores
echo [LIMPEZA] Verificando processos anteriores...
tasklist | find "node.exe" >nul
if not errorlevel 1 (
    echo ⚠️ Processos Node.js detectados. Limpando...
    taskkill /f /im node.exe >nul 2>&1
    timeout /t 2 /nobreak >nul
)

tasklist | find "electron.exe" >nul
if not errorlevel 1 (
    echo ⚠️ Processos Electron detectados. Limpando...
    taskkill /f /im electron.exe >nul 2>&1
    timeout /t 2 /nobreak >nul
)

:: Verificar porta 3000
echo [VERIFICAÇÃO] Checando porta 3000...
netstat -an | find ":3000 " | find "LISTENING" >nul
if not errorlevel 1 (
    echo ⚠️ Porta 3000 em uso. Liberando...
    for /f "tokens=5" %%a in ('netstat -aon ^| find ":3000 " ^| find "LISTENING"') do (
        taskkill /f /pid %%a >nul 2>&1
    )
    timeout /t 2 /nobreak >nul
    echo ✅ Porta 3000 liberada
) else (
    echo ✅ Porta 3000 disponível
)

:: Verificar arquivos críticos
echo [VERIFICAÇÃO] Checando arquivos essenciais...
set MISSING_FILES=0

if not exist "package.json" (
    echo ❌ package.json não encontrado!
    set /a MISSING_FILES+=1
)

if not exist "api-server\server.js" (
    echo ❌ api-server\server.js não encontrado!
    set /a MISSING_FILES+=1
)

if not exist "my-electron-app\main.js" (
    echo ❌ my-electron-app\main.js não encontrado!
    set /a MISSING_FILES+=1
)

if !MISSING_FILES! gtr 0 (
    echo.
    echo ❌ !MISSING_FILES! arquivo(s) essencial(is) não encontrado(s)!
    echo Verifique a estrutura do projeto.
    pause
    exit /b 1
)

echo ✅ Todos os arquivos essenciais OK

echo.
echo ================================================
echo         INICIANDO APLICAÇÃO
echo ================================================
echo.
echo 🌐 Servidor API: http://localhost:3000
echo 🖥️ Aplicação Electron: Abrindo automaticamente
echo 📊 Monitoramento: Terminal ativo
echo 🔧 Debug: F12 para DevTools
echo ⛔ Parar: Ctrl+C
echo.
echo ⏳ Iniciando em 3 segundos...
timeout /t 3 /nobreak >nul

echo.
echo [EXECUÇÃO] Rodando: npm run dev
echo ================================================
npm run dev

echo.
echo ================================================
echo         APLICAÇÃO FINALIZADA
echo ================================================
echo.
echo 📊 Status: Aplicação encerrada
echo 🕒 Encerrado em: %date% %time%
echo.

if errorlevel 1 (
    echo ❌ Aplicação encerrada com erro!
    echo.
    echo Possíveis causas:
    echo - Dependências não instaladas corretamente
    echo - Porta 3000 ocupada por outro processo
    echo - Arquivos de configuração corrompidos
    echo - Problemas de permissão
    echo.
    echo Soluções:
    echo 1. Execute: npm install
    echo 2. Reinicie o computador
    echo 3. Execute como administrador
    echo 4. Verifique se não há antivírus bloqueando
) else (
    echo ✅ Aplicação encerrada normalmente
)

echo.
pause
goto :eof

:: Função para instalar dependências com retry
:install_dependencies
set "DIR=%~1"
set "NAME=%~2"
set "RETRY_COUNT=0"

:retry_install
if exist "%DIR%\node_modules" (
    echo ✅ Dependências do %NAME% já instaladas
    goto :eof
)

echo [INSTALAÇÃO] Instalando dependências do %NAME%...
if not "%DIR%"=="." (
    cd "%DIR%"
)

npm install --silent --no-audit --no-fund
if errorlevel 1 (
    set /a RETRY_COUNT+=1
    if !RETRY_COUNT! lss 3 (
        echo ⚠️ Falha na instalação. Tentativa !RETRY_COUNT!/3...
        timeout /t 2 /nobreak >nul
        goto :retry_install
    ) else (
        echo ❌ Falha ao instalar dependências do %NAME% após 3 tentativas!
        if not "%DIR%"=="." (
            cd ..
        )
        pause
        exit /b 1
    )
) else (
    echo ✅ Dependências do %NAME% instaladas com sucesso
)

if not "%DIR%"=="." (
    cd ..
)
goto :eof
