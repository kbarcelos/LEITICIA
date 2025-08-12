// src/app/Header.jsx
// Cabeçalho com logo e navegação (rotas ativas com NavLink).

import { NavLink } from 'react-router-dom';

export default function Header() {
  return (
    <header className="header" style={{ padding: '10px 16px' }}>
      <div className="header__brand" style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
        <img src="/assets/images/logo.png" alt="Leitícia" height="40" />
        <div className="brand__text" style={{ lineHeight: 1 }}>
          <strong>leitícia</strong>
          <div style={{ fontSize: 12, opacity: 0.85 }}>doe leite, alimente esperanças</div>
        </div>
      </div>

      <nav className="header__nav" style={{ display: 'flex', gap: 16, marginTop: 8 }}>
        <NavLink to="/" end>Home</NavLink>
        <NavLink to="/educacao">Educação</NavLink>
        <NavLink to="/contato">Contato</NavLink>
        <NavLink to="/login">Entrar</NavLink>
      </nav>
    </header>
  );
}
