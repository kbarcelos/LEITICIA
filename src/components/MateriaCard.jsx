// src/components/MateriaCard.jsx
// Cartão de matéria/notícia. Recebe props e renderiza um "card" clicável.

import { Link } from 'react-router-dom';
import { formatDate } from '../app/utils';

export default function MateriaCard({ id, titulo, resumo, capa, data }) {
  return (
    <article className="card materia-card">
      <Link to={`/materias/${id}`} className="card__media">
        <img src={capa || '/assets/images/logo.png'} alt={titulo} loading="lazy" />
      </Link>

      <div className="card__body">
        <h3 className="card__title">
          <Link to={`/materias/${id}`}>{titulo}</Link>
        </h3>
        <p className="card__meta">{formatDate(data)}</p>
        <p className="card__text">{resumo}</p>

        <div className="card__actions">
          <Link className="btn btn-primary" to={`/materias/${id}`}>Ler mais</Link>
        </div>
      </div>
    </article>
  );
}
