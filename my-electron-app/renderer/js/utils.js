// Utilitários para verificação de conectividade
async function checkAPIHealth() {
    try {
        const response = await fetch('http://localhost:3000/', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            }
        });
        
        if (response.ok) {
            const data = await response.json();
            console.log('API está funcionando:', data);
            return true;
        } else {
            console.error('API respondeu com erro:', response.status);
            return false;
        }
    } catch (error) {
        console.error('Erro ao conectar com a API:', error);
        return false;
    }
}

// Verificar API quando a página carregar
document.addEventListener('DOMContentLoaded', async () => {
    console.log('Verificando conectividade com a API...');
    const apiOk = await checkAPIHealth();
    
    if (!apiOk) {
        // Mostrar alerta sobre problema de conectividade
        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-warning alert-dismissible fade show';
        alertDiv.innerHTML = `
            <strong>Atenção!</strong> Não foi possível conectar com o servidor API. 
            Certifique-se de que o servidor está rodando na porta 3000.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        document.body.insertBefore(alertDiv, document.body.firstChild);
    }
});
