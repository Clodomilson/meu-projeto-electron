const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/userRoutes');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/', userRoutes);

app.listen(3000, () => console.log('API rodando na porta 3000'));