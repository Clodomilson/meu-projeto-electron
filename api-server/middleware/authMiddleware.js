
// Middleware para limitar tentativas de cadastro por IP
const rateLimit = {};
const WINDOW_SIZE = 15 * 60 * 1000; // 15 minutos
const MAX_ATTEMPTS = 5;

function registrationRateLimiter(req, res, next) {
    const ip = req.ip;
    const now = Date.now();
    if (!rateLimit[ip]) {
        rateLimit[ip] = [];
    }
    // Remove tentativas antigas
    rateLimit[ip] = rateLimit[ip].filter(ts => now - ts < WINDOW_SIZE);
    if (rateLimit[ip].length >= MAX_ATTEMPTS) {
        return res.status(429).json({ message: 'Muitas tentativas de cadastro. Tente novamente mais tarde.' });
    }
    rateLimit[ip].push(now);
    next();
}

// Sugestão: adicionar integração com CAPTCHA (ex: Google reCAPTCHA) na rota de cadastro

module.exports = {
    registrationRateLimiter
};