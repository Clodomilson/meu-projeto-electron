const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../models/database');
const JWT_SECRET = process.env.JWT_SECRET;

exports.register = (req, res) => {
    const { email, senha } = req.body;
    const hash = bcrypt.hashSync(senha, 10);
    
    db.run(`INSERT INTO usuarios (email, senha) VALUES (?, ?)`, [email, hash], function(err) {
        if (err) return res.status(400).json({ error: 'Email já cadastrado' });
        res.json({ id: this.lastID, email });
    });
};

exports.login = (req, res) => {
    const { email, senha } = req.body;

    db.get(`SELECT * FROM usuarios WHERE email = ?`, [email], (err, user) => {
        if (err || !user) return res.status(400).json({ error: 'Usuário não encontrado' });

        const isValid = bcrypt.compareSync(senha, user.senha);
        if (!isValid) return res.status(400).json({ error: 'Senha incorreta' });

        const token = jwt.sign({ id: user.id, email }, JWT_SECRET, { expiresIn: '1h' });
        res.json({ token });
    });
};