// Aguardar o carregamento completo da página
document.addEventListener('DOMContentLoaded', function() {
    console.log('Página de registro carregada');
    
    // Focar no campo de nome após um pequeno delay
    setTimeout(() => {
        const nomeField = document.getElementById('nome');
        if (nomeField) {
            nomeField.focus();
        }
    }, 200);
    
    // Configurar o formulário de registro
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', handleRegister);
    }
});

async function handleRegister(e) {
    e.preventDefault();
    
    const nome = document.getElementById('nome').value.trim();
    const email = document.getElementById('email').value.trim();
    const senha = document.getElementById('senha').value;

    // Validações básicas
    if (!nome || !email || !senha) {
        showNotification('Por favor, preencha todos os campos', 'error', 3000);
        return;
    }

    if (senha.length < 6) {
        showNotification('A senha deve ter pelo menos 6 caracteres', 'error', 3000);
        return;
    }

    try {
        console.log('Tentando registrar usuário...');
        
        const response = await fetch('http://localhost:3000/api/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ nome, email, senha })
        });

        const data = await response.json();

        if (response.ok) {
            console.log('Cadastro realizado com sucesso');
            
            // Usar notificação não-bloqueante ao invés de alert
            showNotification('Cadastro realizado com sucesso! Redirecionando para o login...', 'success', 2000);
            
            // Redirecionar suavemente
            smoothRedirect('index.html', 2500);
        } else {
            console.error('Erro no cadastro:', data.error);
            
            // Usar notificação não-bloqueante ao invés de alert
            showNotification(data.error || 'Erro no cadastro', 'error', 5000);
            
            // Limpar senha em caso de erro
            document.getElementById('senha').value = '';
            document.getElementById('nome').focus();
        }
    } catch (error) {
        console.error('Erro de conexão:', error);
        
        // Usar notificação não-bloqueante ao invés de alert
        showNotification('Erro de conexão com o servidor. Verifique se a API está rodando.', 'error', 5000);
        
        // Limpar senha em caso de erro
        document.getElementById('senha').value = '';
    }
}