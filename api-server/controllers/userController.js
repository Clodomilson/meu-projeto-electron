const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../models/userModel');
const SECRET = 'seu_segredo_super_secreto';

exports.register = (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) return res.status(400).json({ error: 'Usuário e senha obrigatórios' });

    const hash = bcrypt.hashSync(password, 8);
    db.run('INSERT INTO users (username, password) VALUES (?, ?)', [username, hash], function(err) {
        if (err) return res.status(400).json({ error: 'Usuário já existe' });
        res.json({ success: true });
    });
};

exports.login = (req, res) => {
    const { username, password } = req.body;
    db.get('SELECT * FROM users WHERE username = ?', [username], (err, user) => {
        if (err || !user) return res.status(401).json({ error: 'Usuário ou senha inválidos' });
        if (!bcrypt.compareSync(password, user.password)) return res.status(401).json({ error: 'Usuário ou senha inválidos' });

        const token = jwt.sign({ id: user.id, username: user.username }, SECRET, { expiresIn: '1h' });
        res.json({ token });
    });
};