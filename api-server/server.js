const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const app = express();
const port = 3000;

app.use(cors()); // Permite que o frontend acesse o backend
app.use(bodyParser.json());

// Rotas de login e registro
const authRoutes = require('./routes/auth');
app.use('/', authRoutes);

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`);
});
