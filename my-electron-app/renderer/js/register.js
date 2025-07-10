// Aguarda o carregamento total do DOM
document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('registerForm');

    form.addEventListener('submit', async (e) => {
        e.preventDefault(); // Impede o envio padrão do formulário

        // Captura os valores dos campos
        const username = document.getElementById('username').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        try {
            // Envia os dados para o backend
            const response = await fetch('http://localhost:3000/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    email: email,
                    senha: password // o backend espera 'senha', não 'password'
                }),
            });

            const data = await response.json();

            if (response.ok) {
                alert('Usuário cadastrado com sucesso! ID: ' + data.id);
                form.reset(); // limpa os campos
            } else {
                alert('Erro: ' + data.error);
            }
        } catch (err) {
            console.error('Erro ao cadastrar:', err);
            alert('Erro ao conectar com o servidor.');
        }
    });
});
