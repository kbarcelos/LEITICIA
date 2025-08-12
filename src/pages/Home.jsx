// src/pages/Home.jsx
// Página inicial: banner, lista de matérias e um mapa Leaflet simples.

import { useEffect, useState } from 'react';
import { listarMaterias } from '../services/materiasApi';
import MateriaCard from '../components/MateriaCard.jsx';
import L from 'leaflet';

export default function Home() {
  const [materias, setMaterias] = useState([]);

  useEffect(() => {
    listarMaterias().then(setMaterias);
  }, []);

  useEffect(() => {
    // Inicializa o mapa Leaflet quando o componente monta
    const map = L.map('home-map', {
      center: [-15.78, -47.93], // Centro aproximado do Brasil
      zoom: 4
    });

    // Camada de tiles (mapa base)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // Marcador de exemplo
    L.marker([-22.9068, -43.1729]).addTo(map).bindPopup('Banco de Leite - RJ');

    return () => map.remove();
  }, []);

  return (
    <div className="page home">
      <section className="hero">
        <img src="/assets/images/leiticia.png" alt="Leitícia" height="90" />
        <h1>Doe leite, alimente esperanças</h1>
        <p>Conectamos mães lactantes, bancos de leite e famílias 💚</p>
      </section>

      <section className="section">
        <h2>Mapa de pontos de coleta (exemplo)</h2>
        <div id="home-map" style={{ height: 320, borderRadius: 12, overflow: 'hidden' }} />
      </section>

      <section className="section">
        <h2>Últimas matérias</h2>
        <div className="grid">
          {materias.map((m) => (
            <MateriaCard key={m.id} {...m} />
          ))}
        </div>
      </section>
    </div>
  );
}
