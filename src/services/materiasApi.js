// src/services/materiasApi.js
// Camada de acesso a dados. Primeiro tenta buscar da API (PHP);
// se der erro, usa "mock" local para você conseguir ver a UI.

import axios from 'axios';

const API = axios.create({
  baseURL: import.meta.env.VITE_API_URL || '',
  timeout: 8000
});

// --- MOCK local: substitua por sua resposta real quando a API estiver disponível
const mockMaterias = [
  {
    id: '1',
    titulo: 'Como doar leite materno',
    resumo: 'Passo a passo para se tornar doadora de leite humano.',
    capa: '/assets/images/leiticia.png',
    data: '2024-08-01',
    conteudo: '<p>Conteúdo de exemplo com orientações…</p>'
  },
  {
    id: '2',
    titulo: 'Bancos de leite pelo Brasil',
    resumo: 'Veja no mapa os principais pontos de coleta.',
    capa: '/assets/images/logo.png',
    data: '2024-08-03',
    conteudo: '<p>Mapa e lista de unidades…</p>'
  }
];

export async function listarMaterias() {
  try {
    if (!API.defaults.baseURL) throw new Error('Sem API_URL');
    const { data } = await API.get('/materias'); // ex.: GET /api/materias
    return data;
  } catch {
    return mockMaterias;
  }
}

export async function obterMateria(id) {
  try {
    if (!API.defaults.baseURL) throw new Error('Sem API_URL');
    const { data } = await API.get(`/materias/${id}`);
    return data;
  } catch {
    return mockMaterias.find((m) => m.id === id) || null;
  }
}
