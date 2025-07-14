const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../models/database');
const JWT_SECRET = process.env.JWT_SECRET;

exports.register = (req, res) => {
    const { nome, email, senha } = req.body;
    
    if (!nome || !email || !senha) {
        return res.status(400).json({ error: 'Todos os campos são obrigatórios' });
    }
    
    const hash = bcrypt.hashSync(senha, 10);
    
    db.run(`INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)`, [nome, email, hash], function(err) {
        if (err) {
            if (err.message.includes('UNIQUE constraint failed')) {
                return res.status(400).json({ error: 'Email já cadastrado' });
            }
            return res.status(500).json({ error: 'Erro interno do servidor' });
        }
        res.json({ id: this.lastID, nome, email });
    });
};

exports.login = (req, res) => {
    const { email, senha } = req.body;

    if (!email || !senha) {
        return res.status(400).json({ error: 'Email e senha são obrigatórios' });
    }

    db.get(`SELECT * FROM usuarios WHERE email = ?`, [email], (err, user) => {
        if (err) {
            return res.status(500).json({ error: 'Erro interno do servidor' });
        }
        
        if (!user) {
            return res.status(400).json({ error: 'Usuário não encontrado' });
        }

        const isValid = bcrypt.compareSync(senha, user.senha);
        if (!isValid) {
            return res.status(400).json({ error: 'Senha incorreta' });
        }

        const token = jwt.sign({ id: user.id, email: user.email, nome: user.nome }, JWT_SECRET || 'secretkey', { expiresIn: '1h' });
        res.json({ token, user: { id: user.id, nome: user.nome, email: user.email } });
    });
};