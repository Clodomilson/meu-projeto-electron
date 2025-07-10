// middlewares/authMiddleware.js

const jwt = require('jsonwebtoken');
require('dotenv').config(); // Para garantir acesso à variável JWT_SECRET

const JWT_SECRET = process.env.JWT_SECRET;

function verifyToken(req, res, next) {
    const authHeader = req.headers['authorization'];

    // Verifica se o token está presente no header
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Acesso negado. Token não fornecido.' });
    }

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        req.user = decoded; // Salva os dados decodificados do usuário para usar depois
        next(); // Continua para a próxima função/middleware
    } catch (err) {
        return res.status(403).json({ error: 'Token inválido ou expirado.' });
    }
}

module.exports = verifyToken;
