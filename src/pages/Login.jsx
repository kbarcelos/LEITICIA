// src/pages/Login.jsx
// Placeholder de login. Depois conectamos com JWT/sessão da sua API PHP.

import { useState } from 'react';

export default function Login() {
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');

  function handleLogin(e) {
    e.preventDefault();
    alert(`Login (demo) para ${email}. Depois conectamos à API.`);
  }

  return (
    <div className="page login">
      <h1>Entrar</h1>
      <form className="form" onSubmit={handleLogin}>
        <label>
          E-mail
          <input value={email} onChange={(e) => setEmail(e.target.value)} type="email" />
        </label>
        <label>
          Senha
          <input value={senha} onChange={(e) => setSenha(e.target.value)} type="password" />
        </label>
        <button className="btn btn-primary">Entrar</button>
      </form>
    </div>
  );
}
