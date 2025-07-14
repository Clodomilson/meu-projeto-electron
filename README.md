# Projeto Electron - Sistema de Login

Projeto Electron desenvolvido em ambiente educacional para demonstrar um sistema de autenticação simples com banco de dados SQLite3.

## Características

- **Frontend**: Electron com HTML, CSS (Bootstrap) e JavaScript
- **Backend**: Node.js com Express
- **Banco de Dados**: SQLite3
- **Autenticação**: JWT (JSON Web Tokens)
- **Criptografia**: bcryptjs para senhas

## Estrutura do Projeto

```
├── api-server/              # Servidor API
│   ├── controllers/         # Controladores
│   ├── middleware/          # Middlewares
│   ├── models/             # Modelos e configuração do banco
│   ├── routes/             # Rotas da API
│   └── server.js           # Arquivo principal do servidor
├── my-electron-app/        # Aplicação Electron
│   ├── renderer/           # Interface do usuário
│   │   ├── js/            # Scripts JavaScript
│   │   ├── index.html     # Página de login
│   │   ├── register.html  # Página de cadastro
│   │   └── home.html      # Página inicial
│   ├── main.js            # Processo principal do Electron
│   └── preload.js         # Script de preload
└── README.md              # Este arquivo
```

## Como Executar

### 🚀 **Método 1: Menu Interativo (Recomendado)**

**Command Prompt / CMD:**
```batch
menu.bat
```

**PowerShell:**
```powershell
.\menu.bat
```

**Funcionalidades:**
- Menu completo com todas as opções
- Instalação automática de dependências
- Status do sistema
- Limpeza e manutenção
- Ajuda integrada

### ⚡ **Método 2: Início Rápido**

**Command Prompt / CMD:**
```batch
start.bat
```

**PowerShell:**
```powershell
.\start.ps1
# ou
.\start.bat
```

**Características:**
- Verificação automática de dependências
- Instalação silenciosa se necessário
- Verificação de porta e conflitos
- Inicio automático da aplicação

### 🔧 **Método 3: Início Avançado**

**Command Prompt / CMD:**
```batch
launch.bat
```

**PowerShell:**
```powershell
.\launch.bat
# ou
.\launch.ps1
```

**Recursos:**
- Verificações completas do sistema
- Retry automático em caso de falha
- Limpeza de processos anteriores
- Logs detalhados
- Verificação de conectividade

### 🛑 **Parar Aplicação**

**Command Prompt / CMD:**
```batch
stop.bat
```

**PowerShell:**
```powershell
.\stop.ps1
# ou
.\stop.bat
```

**Funciona:**
- Finaliza todos os processos
- Libera portas ocupadas
- Limpeza completa

### 📋 **Scripts Disponíveis**

| Script | Descrição | Uso |
|--------|-----------|-----|
| `menu.bat` | Menu principal interativo | Recomendado para uso geral |
| `start.bat` | Início rápido e automático | Desenvolvimento diário |
| `launch.bat` | Início com verificações completas | Troubleshooting |
| `stop.bat` | Parar aplicação completamente | Finalizar processos |
| `test-bug.bat` | Teste específico de funcionalidades | Debug e teste |
| `dev.bat` | Menu de desenvolvimento avançado | Desenvolvimento avançado |

### 🔧 **Comandos NPM**

```bash
# Instalar todas as dependências
npm run install-all

# Iniciar desenvolvimento (API + Electron)
npm run dev

# Apenas servidor API
npm run server

# Apenas Electron (aguarda API)
npm run electron
```

### 💻 **Compatibilidade com PowerShell**

Este projeto é totalmente compatível com PowerShell. Use os comandos específicos para melhor experiência:

**Scripts PowerShell Nativos:**
- `.\start.ps1` - Início rápido
- `.\stop.ps1` - Parar aplicação
- `.\launch.ps1` - Início avançado

**Scripts Batch (funcionam em ambos):**
- `.\menu.bat` - Menu interativo
- `.\dev.bat` - Menu de desenvolvimento
- `.\test-bug.bat` - Debug

**Dica:** No PowerShell, sempre use `.\` antes do nome do arquivo para executar scripts locais.

### ⚙️ **Configuração**

O arquivo `config.env` permite personalizar:
- Porta da API
- Modo de desenvolvimento
- Configurações de debug
- Timeouts e tentativas

### 🆘 **Solução de Problemas**

1. **Dependências não instaladas:**
   ```bash
   menu.bat → Opção 4 (Instalar Dependências)
   ```

2. **Porta 3000 ocupada:**
   ```bash
   stop.bat
   ```

3. **Aplicação travada:**
   ```bash
   menu.bat → Opção 5 (Limpeza Completa)
   ```

4. **Verificar status:**
   ```bash
   menu.bat → Opção 7 (Status do Sistema)
   ```

## Funcionalidades

- ✅ Cadastro de usuários
- ✅ Login de usuários
- ✅ Autenticação com JWT
- ✅ Proteção de rotas
- ✅ Interface responsiva com Bootstrap
- ✅ Banco de dados SQLite local

## Uso

1. Execute o servidor API
2. Execute a aplicação Electron
3. Na tela de login, clique em "Não tem conta? Cadastre-se"
4. Faça seu cadastro com nome, email e senha
5. Faça login com suas credenciais
6. Acesse a página inicial protegida

## Tecnologias Utilizadas

### Backend
- Node.js
- Express
- SQLite3
- bcryptjs
- jsonwebtoken
- cors
- dotenv

### Frontend
- Electron
- HTML5
- CSS3 (Bootstrap 5)
- JavaScript (ES6+)

## Desenvolvimento

Este projeto foi desenvolvido para fins educacionais e demonstra conceitos básicos de:
- Desenvolvimento de aplicações desktop com Electron
- API REST com Node.js e Express
- Autenticação JWT
- Banco de dados SQLite
- Segurança básica (hash de senhas)

## Licença

Este projeto é de uso educacional.
