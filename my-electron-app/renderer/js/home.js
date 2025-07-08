import { getToken, clearToken } from './auth.js';
import axios from 'axios';

if (!getToken()) {
    window.location.href = 'index.html';
}

document.getElementById('logoutBtn').onclick = async () => {
    clearToken();
    window.location.href = 'index.html';
};

// Exemplo para listar dados do usuário da API 
axios.get('http://localhost:3000/data', {
    headers: { Authorization: `Bearer ${getToken()}` }
}).then(response => {
    document.getElementById('dataArea').innerText = JSON.stringify(response.data);
}).catch(error => {
    console.error('Error fetching home data:', error);
});