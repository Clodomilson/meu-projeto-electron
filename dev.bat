@echo off
setlocal

echo ======================================
echo    PROJETO ELECTRON - SETUP COMPLETO
echo ======================================
echo.

:menu
echo Escolha uma opcao:
echo 1. Instalar todas as dependencias
echo 2. Iniciar desenvolvimento (API + Electron)
echo 3. Iniciar apenas o servidor API
echo 4. Iniciar apenas o Electron
echo 5. Limpar node_modules e reinstalar
echo 6. Sair
echo.
set /p choice="Digite sua opcao (1-6): "

if "%choice%"=="1" goto install
if "%choice%"=="2" goto dev
if "%choice%"=="3" goto api
if "%choice%"=="4" goto electron
if "%choice%"=="5" goto clean
if "%choice%"=="6" goto exit
echo Opcao invalida. Tente novamente.
goto menu

:install
echo.
echo Instalando dependencias...
call npm install
cd api-server
call npm install
cd ..\my-electron-app
call npm install
cd ..
echo.
echo Dependencias instaladas com sucesso!
pause
goto menu

:dev
echo.
echo Iniciando desenvolvimento (API + Electron)...
call npm run dev
pause
goto menu

:api
echo.
echo Iniciando apenas o servidor API...
cd api-server
call npm start
cd ..
pause
goto menu

:electron
echo.
echo Iniciando apenas o Electron...
cd my-electron-app
call npm start
cd ..
pause
goto menu

:clean
echo.
echo Limpando node_modules...
if exist "node_modules" rmdir /s /q "node_modules"
if exist "api-server\node_modules" rmdir /s /q "api-server\node_modules"
if exist "my-electron-app\node_modules" rmdir /s /q "my-electron-app\node_modules"
echo.
echo Reinstalando dependencias...
call npm install
cd api-server
call npm install
cd ..\my-electron-app
call npm install
cd ..
echo.
echo Limpeza e reinstalacao concluidas!
pause
goto menu

:exit
echo.
echo Encerrando...
exit /b 0
