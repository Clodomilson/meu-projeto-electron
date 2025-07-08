import { saveToken } from './auth.js';
import axios from 'axios';

document.getElementById('loginForm').onsubmit = async (e) => {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    try {
        const res = await axios.post('http://localhost:3000/api/login', { email, password });
        saveToken(res.data.token);
        window.location.href = 'home.html';
    } catch (error) {
        alert('Login inválido');
    }
};