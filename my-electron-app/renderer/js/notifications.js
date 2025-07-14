// Sistema de notificações não-bloqueantes
function showNotification(message, type = 'success', duration = 3000) {
    // Remover notificação anterior se existir
    const existingNotification = document.querySelector('.app-notification');
    if (existingNotification) {
        existingNotification.remove();
    }
    
    // Criar elemento de notificação
    const notification = document.createElement('div');
    notification.className = `app-notification alert alert-${type === 'success' ? 'success' : 'danger'} alert-dismissible fade show`;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        max-width: 500px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    `;
    
    notification.innerHTML = `
        <strong>${type === 'success' ? 'Sucesso!' : 'Erro!'}</strong> ${message}
        <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>
    `;
    
    // Adicionar ao body
    document.body.appendChild(notification);
    
    // Remover automaticamente após duração especificada
    if (duration > 0) {
        setTimeout(() => {
            if (notification.parentElement) {
                notification.classList.remove('show');
                setTimeout(() => notification.remove(), 150);
            }
        }, duration);
    }
    
    return notification;
}

// Função para redirecionamento suave
function smoothRedirect(url, delay = 2000) {
    console.log(`Redirecionando para ${url} em ${delay}ms`);
    
    // Limpar todo o estado
    localStorage.clear();
    sessionStorage.clear();
    
    // Aguardar e redirecionar
    setTimeout(() => {
        console.log('Executando redirecionamento...');
        
        // Forçar limpeza de event listeners
        const allElements = document.querySelectorAll('*');
        allElements.forEach(element => {
            const clonedElement = element.cloneNode(true);
            if (element.parentNode) {
                element.parentNode.replaceChild(clonedElement, element);
            }
        });
        
        // Redirecionar
        window.location.replace(url);
    }, delay);
}

// Exportar funções globalmente
window.showNotification = showNotification;
window.smoothRedirect = smoothRedirect;
