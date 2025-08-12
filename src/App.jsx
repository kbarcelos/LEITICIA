// src/App.jsx
// Define as rotas e aplica o Layout em volta das páginas.

import { Routes, Route, Navigate } from 'react-router-dom';
import Layout from './app/Layout.jsx';
import Home from './pages/Home.jsx';
import Educacao from './pages/Educacao.jsx';
import Contato from './pages/Contato.jsx';
import Login from './pages/Login.jsx';
import MateriaDetalhe from './pages/MateriaDetalhe.jsx';

export default function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/educacao" element={<Educacao />} />
        <Route path="/contato" element={<Contato />} />
        <Route path="/login" element={<Login />} />
        <Route path="/materias/:id" element={<MateriaDetalhe />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  );
}
