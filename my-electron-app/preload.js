const { contextBridge, ipcRenderer } = require('electron');

// Expor APIs seguras para o renderer process
contextBridge.exposeInMainWorld('electronAPI', {
  platform: process.platform,
  versions: process.versions,
  
  // Funções para lidar com problemas de estado
  reloadPage: () => ipcRenderer.invoke('reload-page'),
  resetApp: () => ipcRenderer.invoke('reset-app')
});

window.addEventListener('DOMContentLoaded', () => {
    console.log('Preload script carregado');
    
    // Garantir que os elementos de formulário estejam funcionando
    setTimeout(() => {
        // Verificar se há formulários na página e garantir que estejam funcionais
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            const inputs = form.querySelectorAll('input');
            inputs.forEach(input => {
                // Garantir que os inputs sejam clicáveis e editáveis
                input.style.pointerEvents = 'auto';
                input.tabIndex = 0;
                input.disabled = false;
                input.readOnly = false;
            });
        });
        
        console.log('Formulários verificados e reativados pelo preload');
    }, 100);
});