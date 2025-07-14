@echo off
title Menu Principal - Projeto Electron
color 0E

:menu
cls
echo ================================================
echo         PROJETO ELECTRON - MENU PRINCIPAL
echo ================================================
echo.
echo Escolha uma opção:
echo.
echo   1. 🚀 Iniciar Aplicação (Rápido)
echo   2. 🔧 Iniciar Aplicação (Avançado)
echo   3. ⛔ Parar Aplicação
echo   4. 📦 Instalar/Atualizar Dependências
echo   5. 🧹 Limpeza Completa
echo   6. 🧪 Teste de Funcionalidades
echo   7. 📊 Status do Sistema
echo   8. ❓ Ajuda
echo   9. 🚪 Sair
echo.
echo ================================================

set /p choice="Digite sua opção (1-9): "

if "%choice%"=="1" goto start_quick
if "%choice%"=="2" goto start_advanced
if "%choice%"=="3" goto stop_app
if "%choice%"=="4" goto install_deps
if "%choice%"=="5" goto clean_all
if "%choice%"=="6" goto test_features
if "%choice%"=="7" goto system_status
if "%choice%"=="8" goto help
if "%choice%"=="9" goto exit

echo.
echo ❌ Opção inválida! Tente novamente.
timeout /t 2 /nobreak >nul
goto menu

:start_quick
echo.
echo 🚀 Iniciando aplicação (modo rápido)...
call start.bat
pause
goto menu

:start_advanced
echo.
echo 🔧 Iniciando aplicação (modo avançado)...
call launch.bat
pause
goto menu

:stop_app
echo.
echo ⛔ Parando aplicação...
call stop.bat
goto menu

:install_deps
echo.
echo 📦 Instalando/Atualizando dependências...
echo.
echo Projeto principal:
npm install
echo.
echo Servidor API:
cd api-server
npm install
cd ..
echo.
echo Aplicação Electron:
cd my-electron-app
npm install
cd ..
echo.
echo ✅ Dependências atualizadas!
pause
goto menu

:clean_all
echo.
echo 🧹 Limpeza completa do projeto...
echo.
echo ⚠️ ATENÇÃO: Isso irá remover todas as dependências!
set /p confirm="Deseja continuar? (S/N): "
if /i not "%confirm%"=="S" goto menu

echo.
echo Removendo node_modules...
if exist "node_modules" rmdir /s /q "node_modules"
if exist "api-server\node_modules" rmdir /s /q "api-server\node_modules"
if exist "my-electron-app\node_modules" rmdir /s /q "my-electron-app\node_modules"

echo Removendo package-lock.json...
if exist "package-lock.json" del "package-lock.json"
if exist "api-server\package-lock.json" del "api-server\package-lock.json"
if exist "my-electron-app\package-lock.json" del "my-electron-app\package-lock.json"

echo.
echo ✅ Limpeza concluída!
echo.
echo Reinstalando dependências...
call :install_deps
goto menu

:test_features
echo.
echo 🧪 Teste de funcionalidades específicas...
call test-bug.bat
pause
goto menu

:system_status
echo.
echo 📊 Status do sistema...
echo.
echo Node.js:
node --version 2>nul || echo ❌ Node.js não instalado
echo.
echo NPM:
npm --version 2>nul || echo ❌ NPM não instalado
echo.
echo Dependências instaladas:
if exist "node_modules" (echo ✅ Projeto principal) else (echo ❌ Projeto principal)
if exist "api-server\node_modules" (echo ✅ Servidor API) else (echo ❌ Servidor API)
if exist "my-electron-app\node_modules" (echo ✅ Aplicação Electron) else (echo ❌ Aplicação Electron)
echo.
echo Processos ativos:
tasklist | find "node.exe" >nul && echo ✅ Node.js rodando || echo ❌ Node.js parado
tasklist | find "electron.exe" >nul && echo ✅ Electron rodando || echo ❌ Electron parado
echo.
echo Porta 3000:
netstat -an | find ":3000 " | find "LISTENING" >nul && echo ✅ Em uso || echo ❌ Disponível
echo.
pause
goto menu

:help
echo.
echo ❓ Ajuda - Projeto Electron
echo.
echo Este menu facilita o gerenciamento da aplicação Electron.
echo.
echo OPÇÕES DISPONÍVEIS:
echo.
echo 1. Iniciar Rápido: Usa start.bat para início básico
echo 2. Iniciar Avançado: Usa launch.bat com verificações completas
echo 3. Parar: Finaliza todos os processos da aplicação
echo 4. Dependências: Instala/atualiza todas as dependências NPM
echo 5. Limpeza: Remove e reinstala tudo do zero
echo 6. Teste: Executa testes específicos de funcionalidades
echo 7. Status: Mostra informações do sistema e aplicação
echo 8. Ajuda: Esta tela
echo 9. Sair: Fecha o menu
echo.
echo ESTRUTURA DO PROJETO:
echo - api-server/: Servidor Express com SQLite
echo - my-electron-app/: Aplicação Electron
echo - Arquivos .bat: Scripts de automação
echo.
echo PORTAS UTILIZADAS:
echo - 3000: Servidor API
echo.
echo Para mais informações, consulte o README.md
echo.
pause
goto menu

:exit
echo.
echo 🚪 Encerrando menu...
echo.
echo Obrigado por usar o Projeto Electron!
echo.
timeout /t 2 /nobreak >nul
exit /b 0
