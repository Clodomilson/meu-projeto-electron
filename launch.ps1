#!/usr/bin/env pwsh
# Script PowerShell para iniciar o projeto Electron

Write-Host "================================================" -ForegroundColor Green
Write-Host "         PROJETO ELECTRON - LAUNCHER" -ForegroundColor Green  
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Definir título da janela
$Host.UI.RawUI.WindowTitle = "Projeto Electron - Launcher"

Write-Host "🚀 Inicializando sistema completo..." -ForegroundColor Cyan
Write-Host "📅 Data: $(Get-Date -Format 'dd/MM/yyyy')" -ForegroundColor Gray
Write-Host "🕒 Hora: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Gray
Write-Host "💻 Sistema: $($PSVersionTable.Platform)" -ForegroundColor Gray
Write-Host "👤 Usuário: $env:USERNAME" -ForegroundColor Gray
Write-Host ""

# Verificar Node.js
Write-Host "[VERIFICAÇÃO] Testando Node.js..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host "✅ Node.js $nodeVersion detectado" -ForegroundColor Green
    } else {
        throw "Node.js não encontrado"
    }
} catch {
    Write-Host "❌ Node.js não encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Por favor, instale o Node.js:" -ForegroundColor Yellow
    Write-Host "https://nodejs.org/" -ForegroundColor Blue
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

# Verificar NPM
Write-Host "[VERIFICAÇÃO] Testando NPM..." -ForegroundColor Yellow
try {
    $npmVersion = npm --version 2>$null
    if ($npmVersion) {
        Write-Host "✅ NPM $npmVersion detectado" -ForegroundColor Green
    } else {
        throw "NPM não encontrado"
    }
} catch {
    Write-Host "❌ NPM não encontrado!" -ForegroundColor Red
    Read-Host "Pressione Enter para sair"
    exit 1
}

# Verificar conectividade
Write-Host "[VERIFICAÇÃO] Testando conectividade..." -ForegroundColor Yellow
try {
    $ping = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet -TimeoutSeconds 3
    if ($ping) {
        Write-Host "✅ Conectividade OK" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Sem conexão com internet (pode afetar instalação de dependências)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️ Não foi possível verificar conectividade" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "         INSTALAÇÃO DE DEPENDÊNCIAS" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green

# Função para instalar dependências
function Install-Dependencies {
    param($Path, $Name)
    
    $nodeModulesPath = Join-Path $Path "node_modules"
    
    if (Test-Path $nodeModulesPath) {
        Write-Host "✅ Dependências do $Name já instaladas" -ForegroundColor Green
        return
    }
    
    Write-Host "[INSTALAÇÃO] Instalando dependências do $Name..." -ForegroundColor Yellow
    
    $currentLocation = Get-Location
    if ($Path -ne ".") {
        Set-Location $Path
    }
    
    $retryCount = 0
    $maxRetries = 3
    
    do {
        try {
            npm install --silent --no-audit --no-fund
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Dependências do $Name instaladas com sucesso" -ForegroundColor Green
                break
            } else {
                throw "Falha na instalação"
            }
        } catch {
            $retryCount++
            if ($retryCount -lt $maxRetries) {
                Write-Host "⚠️ Falha na instalação. Tentativa $retryCount/$maxRetries..." -ForegroundColor Yellow
                Start-Sleep 2
            } else {
                Write-Host "❌ Falha ao instalar dependências do $Name após $maxRetries tentativas!" -ForegroundColor Red
                Set-Location $currentLocation
                Read-Host "Pressione Enter para sair"
                exit 1
            }
        }
    } while ($retryCount -lt $maxRetries)
    
    if ($Path -ne ".") {
        Set-Location $currentLocation
    }
}

# Instalar dependências
Install-Dependencies "." "projeto principal"
Install-Dependencies "api-server" "servidor API"
Install-Dependencies "my-electron-app" "aplicação Electron"

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "         PRÉ-INICIALIZAÇÃO" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green

# Verificar e limpar processos anteriores
Write-Host "[LIMPEZA] Verificando processos anteriores..." -ForegroundColor Yellow

$nodeProcesses = Get-Process -Name "node" -ErrorAction SilentlyContinue
if ($nodeProcesses) {
    Write-Host "⚠️ Processos Node.js detectados. Limpando..." -ForegroundColor Yellow
    $nodeProcesses | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep 2
}

$electronProcesses = Get-Process -Name "electron" -ErrorAction SilentlyContinue
if ($electronProcesses) {
    Write-Host "⚠️ Processos Electron detectados. Limpando..." -ForegroundColor Yellow
    $electronProcesses | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep 2
}

# Verificar porta 3000
Write-Host "[VERIFICAÇÃO] Checando porta 3000..." -ForegroundColor Yellow
$portInUse = Get-NetTCPConnection -LocalPort 3000 -State Listen -ErrorAction SilentlyContinue
if ($portInUse) {
    Write-Host "⚠️ Porta 3000 em uso. Liberando..." -ForegroundColor Yellow
    foreach ($connection in $portInUse) {
        Stop-Process -Id $connection.OwningProcess -Force -ErrorAction SilentlyContinue
    }
    Start-Sleep 2
    Write-Host "✅ Porta 3000 liberada" -ForegroundColor Green
} else {
    Write-Host "✅ Porta 3000 disponível" -ForegroundColor Green
}

# Verificar arquivos críticos
Write-Host "[VERIFICAÇÃO] Checando arquivos essenciais..." -ForegroundColor Yellow
$missingFiles = 0

$requiredFiles = @(
    "package.json",
    "api-server\server.js", 
    "my-electron-app\main.js"
)

foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "❌ $file não encontrado!" -ForegroundColor Red
        $missingFiles++
    }
}

if ($missingFiles -gt 0) {
    Write-Host ""
    Write-Host "❌ $missingFiles arquivo(s) essencial(is) não encontrado(s)!" -ForegroundColor Red
    Write-Host "Verifique a estrutura do projeto." -ForegroundColor Yellow
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host "✅ Todos os arquivos essenciais OK" -ForegroundColor Green

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "         INICIANDO APLICAÇÃO" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Servidor API: http://localhost:3000" -ForegroundColor Cyan
Write-Host "🖥️ Aplicação Electron: Abrindo automaticamente" -ForegroundColor Cyan
Write-Host "📊 Monitoramento: Terminal ativo" -ForegroundColor Cyan
Write-Host "🔧 Debug: F12 para DevTools" -ForegroundColor Cyan
Write-Host "⛔ Parar: Ctrl+C" -ForegroundColor Cyan
Write-Host ""
Write-Host "⏳ Iniciando em 3 segundos..." -ForegroundColor Yellow

Start-Sleep 3

Write-Host ""
Write-Host "[EXECUÇÃO] Rodando: npm run dev" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Green

npm run dev

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "         APLICAÇÃO FINALIZADA" -ForegroundColor Green  
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Status: Aplicação encerrada" -ForegroundColor Gray
Write-Host "🕒 Encerrado em: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')" -ForegroundColor Gray
Write-Host ""

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Aplicação encerrada com erro!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possíveis causas:" -ForegroundColor Yellow
    Write-Host "- Dependências não instaladas corretamente" -ForegroundColor Gray
    Write-Host "- Porta 3000 ocupada por outro processo" -ForegroundColor Gray
    Write-Host "- Arquivos de configuração corrompidos" -ForegroundColor Gray
    Write-Host "- Problemas de permissão" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Soluções:" -ForegroundColor Yellow
    Write-Host "1. Execute: npm install" -ForegroundColor Gray
    Write-Host "2. Reinicie o computador" -ForegroundColor Gray
    Write-Host "3. Execute como administrador" -ForegroundColor Gray
    Write-Host "4. Verifique se não há antivírus bloqueando" -ForegroundColor Gray
} else {
    Write-Host "✅ Aplicação encerrada normalmente" -ForegroundColor Green
}

Write-Host ""
Read-Host "Pressione Enter para sair"
