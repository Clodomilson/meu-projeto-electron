# PowerShell script para iniciar o Projeto Electron
# Uso: .\start.ps1

Write-Host "================================================" -ForegroundColor Green
Write-Host "         PROJETO ELECTRON - INICIANDO" -ForegroundColor Green  
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Definir diretório do projeto
$projectDir = Get-Location

# Verificar Node.js
Write-Host "Verificando Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host "✅ Node.js $nodeVersion encontrado" -ForegroundColor Green
    } else {
        Write-Host "❌ Node.js não encontrado! Instale em: https://nodejs.org/" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "❌ Node.js não encontrado! Instale em: https://nodejs.org/" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Instalar dependências do API Server
Write-Host "🔧 Instalando dependências do API Server..." -ForegroundColor Cyan
Set-Location "$projectDir\api-server"
if (-not (Test-Path "node_modules")) {
    npm install
}

# Instalar dependências do Electron App
Write-Host "🔧 Instalando dependências do Electron App..." -ForegroundColor Cyan
Set-Location "$projectDir\my-electron-app"
if (-not (Test-Path "node_modules")) {
    npm install
}

# Voltar ao diretório raiz
Set-Location $projectDir

Write-Host ""
Write-Host "🚀 Iniciando aplicação..." -ForegroundColor Green
Write-Host ""

# Iniciar API Server em background
Write-Host "📡 Iniciando API Server..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-Command", "cd '$projectDir\api-server'; npm start" -WindowStyle Minimized

# Aguardar um pouco para o servidor iniciar
Start-Sleep -Seconds 3

# Iniciar Electron App
Write-Host "🖥️ Iniciando Electron App..." -ForegroundColor Yellow
Set-Location "$projectDir\my-electron-app"
npm start

Write-Host ""
Write-Host "✅ Aplicação finalizada!" -ForegroundColor Green
Write-Host "Pressione qualquer tecla para sair..."
Read-Host
