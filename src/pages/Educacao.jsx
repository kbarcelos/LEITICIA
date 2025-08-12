// src/pages/Educacao.jsx
// Página de educação com embed do Instagram (exemplo).

import InstagramEmbed from '../components/InstagramEmbed.jsx';

export default function Educacao() {
  return (
    <div className="page educacao">
      <h1>Educação</h1>
      <p>Materiais educativos sobre amamentação, doação e cuidados.</p>

      {/* Exemplo (troque a URL por um post real seu) */}
      <InstagramEmbed postUrl="https://www.instagram.com/p/Cv0abc12345/" />
    </div>
  );
}
