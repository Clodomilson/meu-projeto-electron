window.showRegister = function() {
  document.getElementById('login-form').style.display = 'none';
  document.getElementById('register-form').style.display = 'block';
  document.getElementById('main-content').style.display = 'none';
  document.getElementById('login-msg').innerText = '';
}

window.showLogin = function() {
  document.getElementById('register-form').style.display = 'none';
  document.getElementById('login-form').style.display = 'block';
  document.getElementById('main-content').style.display = 'none';
  document.getElementById('reg-msg').innerText = '';
}

window.showMain = function() {
  document.getElementById('register-form').style.display = 'none';
  document.getElementById('login-form').style.display = 'none';
  document.getElementById('main-content').style.display = 'block';
}

window.register = async function() {
  const username = document.getElementById('reg-username').value;
  const password = document.getElementById('reg-password').value;
  const res = await fetch('http://localhost:3000/register', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  });
  const data = await res.json();
  document.getElementById('reg-msg').innerText = data.success ? 'Cadastro realizado com sucesso!' : data.error;
  if (data.success) setTimeout(window.showLogin, 1500);
}

window.login = async function() {
  const username = document.getElementById('login-username').value;
  const password = document.getElementById('login-password').value;
  const res = await fetch('http://localhost:3000/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  });
  const data = await res.json();
  if (data.token) {
    window.showMain();
  } else {
    document.getElementById('login-msg').innerText = data.error;
  }
}