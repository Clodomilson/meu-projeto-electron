# PowerShell script para parar o Projeto Electron
# Uso: .\stop.ps1

Write-Host "================================================" -ForegroundColor Red
Write-Host "         PROJETO ELECTRON - PARANDO" -ForegroundColor Red  
Write-Host "================================================" -ForegroundColor Red
Write-Host ""

Write-Host "🛑 Parando processos do Electron..." -ForegroundColor Yellow

# Parar processos Electron
Get-Process -Name "electron*" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Write-Host "✅ Processos Electron finalizados" -ForegroundColor Green

# Parar processos Node relacionados ao projeto
$nodePorts = @(3000, 3001, 8080, 8081)
foreach ($port in $nodePorts) {
    try {
        $process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess
        if ($process) {
            Stop-Process -Id $process -Force -ErrorAction SilentlyContinue
            Write-Host "✅ Processo na porta $port finalizado" -ForegroundColor Green
        }
    } catch {
        # Ignorar erros se não houver processo na porta
    }
}

Write-Host ""
Write-Host "✅ Todos os processos foram finalizados!" -ForegroundColor Green
Write-Host "Pressione qualquer tecla para sair..."
Read-Host
