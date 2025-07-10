# Script PowerShell simples para executar o projeto
# Uso: .\run.ps1

Write-Host "Iniciando Projeto Electron..." -ForegroundColor Cyan

# Navegar para api-server e iniciar em background
Write-Host "Iniciando API Server..." -ForegroundColor Yellow
Start-Process -FilePath "cmd" -ArgumentList "/c", "cd /d `"$PWD\api-server`" && npm start" -WindowStyle Minimized

# Aguardar 3 segundos
Start-Sleep -Seconds 3

# Navegar para my-electron-app e iniciar
Write-Host "Iniciando Electron App..." -ForegroundColor Yellow
Set-Location "my-electron-app"
npm start

Write-Host "Aplicacao finalizada." -ForegroundColor Green
