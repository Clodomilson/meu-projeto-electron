// Funções de autenticação
function saveAuthToken(token) {
    localStorage.setItem('token', token);
}

function getAuthToken() {
    return localStorage.getItem('token');
}

function clearAuthToken() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
}

function getUser() {
    const user = localStorage.getItem('user');
    return user ? JSON.parse(user) : null;
}

function isAuthenticated() {
    return !!getAuthToken();
}

function logout() {
    clearAuthToken();
    window.location.href = 'index.html';
}

// Verificar se o usuário está autenticado ao carregar a página
function checkAuth() {
    if (!isAuthenticated() && window.location.pathname.includes('home.html')) {
        window.location.href = 'index.html';
    }
}
