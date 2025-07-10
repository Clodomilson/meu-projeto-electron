document.getElementById('registerForm').onsubmit = async (e) => {
    e.preventDefault();
    // logica para registrar o usuário
    const response = await fetch('http://localhost:3000/register', {
        method: 'POST',
        body: new FormData(e.target),
    });
    if (response.ok) {
        // usuário registrado com sucesso
    } else {
        // houve um erro ao registrar o usuário
    }
};