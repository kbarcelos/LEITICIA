document.getElementById('loginForm').addEventListener('submit', async function (e) {
  e.preventDefault();

  const usuario = document.getElementById('login').value.trim();
  const senha = document.getElementById('senha').value.trim();
  const csvFile = document.getElementById('csvUpload').files[0];

  if (!usuario || !senha || !csvFile) {
    alert('Preencha todos os campos e selecione o arquivo CSV.');
    return;
  }

  const texto = await csvFile.text();
  const linhas = texto.split('\n').map(l => l.trim()).filter(Boolean);
  const cabecalho = linhas[0].split(';').map(h => h.toLowerCase().trim());

  let logado = null;

  for (let i = 1; i < linhas.length; i++) {
    const valores = linhas[i].split(';');
    const registro = {};
    cabecalho.forEach((chave, idx) => registro[chave] = valores[idx]);

    if (registro.login === usuario && registro.senha === senha) {
      logado = registro;
      break;
    }
  }

  if (!logado) {
    alert('Usuário ou senha incorretos.');
    return;
  }

  localStorage.setItem('usuarioLogado', JSON.stringify(logado));
  window.location.href = 'dashboard.html';
});
