// src/app/Sidebar.jsx
// Links úteis e uma área de chamada.

import { Link } from 'react-router-dom';

export default function Sidebar() {
  return (
    <div className="sidebar">
      <h3>Atalhos</h3>
      <ul>
        <li><Link to="/educacao">Educação</Link></li>
        <li><a href="https://www.instagram.com" target="_blank" rel="noreferrer">Instagram</a></li>
        <li><Link to="/contato">Fale Conosco</Link></li>
      </ul>

      <div className="sidebar__cta" style={{ textAlign: 'center', marginTop: 16 }}>
        <img src="/assets/images/leiticia.png" alt="Leitícia" width="120" />
        <p>Doe leite, alimente esperanças 💚</p>
      </div>
    </div>
  );
}
