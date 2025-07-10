// Verificar se o usuário está autenticado
function checkAuth() {
    const token = localStorage.getItem('token');
    if (!token) {
        window.location.href = 'index.html';
        return false;
    }
    return true;
}

// Carregar dados do usuário
function loadUserData() {
    const user = localStorage.getItem('user');
    if (user) {
        const userData = JSON.parse(user);
        document.getElementById('userName').textContent = userData.nome;
        document.getElementById('userEmail').textContent = userData.email;
    }
}

// Função de logout
function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = 'index.html';
}

// Inicializar a página
document.addEventListener('DOMContentLoaded', function() {
    if (checkAuth()) {
        loadUserData();
    }
});

// Event listener para o botão de logout
document.getElementById('logoutBtn').addEventListener('click', logout);