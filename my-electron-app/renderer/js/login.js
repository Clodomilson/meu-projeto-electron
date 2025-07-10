// Aguardar o carregamento completo da página
document.addEventListener('DOMContentLoaded', function() {
    console.log('Página de login carregada');
    
    // Configurar o formulário de login
    setTimeout(() => {
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', handleLogin);
            console.log('Event listener configurado para o formulário de login');
        } else {
            console.error('Formulário de login não encontrado!');
        }
    }, 300);
});

async function handleLogin(e) {
    e.preventDefault();
    console.log('Formulário de login submetido');
    
    const emailField = document.getElementById('email');
    const passwordField = document.getElementById('password');
    
    if (!emailField || !passwordField) {
        console.error('Campos de email ou senha não encontrados!');
        showNotification('Erro interno: campos não encontrados', 'error', 5000);
        return;
    }
    
    const email = emailField.value.trim();
    const senha = passwordField.value;

    console.log('Dados do formulário:', { email: email, senhaLength: senha.length });

    if (!email || !senha) {
        showNotification('Por favor, preencha todos os campos', 'error', 3000);
        return;
    }

    try {
        console.log('Tentando fazer login...');
        
        const response = await fetch('http://localhost:3000/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ email, senha })
        });

        const data = await response.json();
        console.log('Resposta da API:', { status: response.status, data });

        if (response.ok) {
            console.log('Login realizado com sucesso');
            
            // Salvar token e dados do usuário
            localStorage.setItem('token', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
            
            // Redirecionar para a página home
            window.location.href = 'home.html';
        } else {
            console.error('Erro no login:', data.error);
            showNotification(data.error || 'Erro no login', 'error', 5000);
            
            // Limpar os campos em caso de erro
            passwordField.value = '';
            emailField.focus();
        }
    } catch (error) {
        console.error('Erro de conexão:', error);
        showNotification('Erro de conexão com o servidor. Verifique se a API está rodando.', 'error', 5000);
        
        // Limpar senha em caso de erro
        if (passwordField) {
            passwordField.value = '';
        }
    }
}
