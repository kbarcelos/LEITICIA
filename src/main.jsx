// src/main.jsx
// Ponto de entrada do React. Monta o App e registra o SW para PWA.

import React from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import App from './App.jsx';

// Lê a base do app (no subdomínio é "/")
const basename = import.meta.env.VITE_BASE || '/';

createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter basename={basename}>
      <App />
    </BrowserRouter>
  </React.StrictMode>
);

// Registra o Service Worker (para PWA). Em dev local é normal não funcionar 100%.
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker
      .register('/service-worker.js')
      .catch((err) => console.warn('SW registration failed', err));
  });
}
