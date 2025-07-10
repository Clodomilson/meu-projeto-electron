const express = require('express');
const router = express.Router();
const verifyToken = require('../middlewares/authMiddleware');

// Rota protegida por token JWT
router.get('/dados-sigilosos', verifyToken, (req, res) => {
    res.json({ mensagem: 'Acesso autorizado!', usuario: req.user });
});

module.exports = router;
