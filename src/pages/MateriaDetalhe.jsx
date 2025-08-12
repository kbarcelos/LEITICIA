// src/pages/MateriaDetalhe.jsx
// Busca uma matéria pelo :id da rota e exibe conteúdo.

import { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { obterMateria } from '../services/materiasApi.js';
import { formatDate } from '../app/utils.js';

export default function MateriaDetalhe() {
  const { id } = useParams();
  const [materia, setMateria] = useState(null);

  useEffect(() => {
    obterMateria(id).then(setMateria);
  }, [id]);

  if (!materia) return <p>Carregando…</p>;

  return (
    <article className="page materia-detalhe">
      <Link to="/" className="btn btn-link">← Voltar</Link>
      <h1>{materia.titulo}</h1>
      <p className="muted">{formatDate(materia.data)}</p>
      <img
        src={materia.capa || '/assets/images/logo.png'}
        alt=""
        className="banner"
      />
      <div
        className="conteudo"
        dangerouslySetInnerHTML={{ __html: materia.conteudo }}
      />
    </article>
  );
}
