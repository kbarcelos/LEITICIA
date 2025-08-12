// public/service-worker.js
// Service Worker simples: cache estático + runtime (API) e página offline.

const CACHE_NAME = 'leiticia-static-v1';
const RUNTIME_CACHE = 'leiticia-runtime-v1';

// Ajuste os caminhos conforme seus arquivos públicos
const STATIC_ASSETS = [
  '/', '/index.html', '/manifest.json', '/offline.html',
  '/assets/css/styles.css',
  '/assets/images/logo.png', '/assets/images/leiticia.png', '/assets/images/favicon.png'
];

self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(STATIC_ASSETS))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((k) => k !== CACHE_NAME && k !== RUNTIME_CACHE)
          .map((k) => caches.delete(k))
      )
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  const url = new URL(req.url);

  // Estratégia "network-first" para API (ajuste o prefixo se necessário)
  if (url.pathname.startsWith('/api/')) {
    e.respondWith(
      caches.open(RUNTIME_CACHE).then((cache) =>
        fetch(req)
          .then((res) => {
            cache.put(req, res.clone());
            return res;
          })
          .catch(() => cache.match(req))
      )
    );
    return;
  }

  // Estratégia "cache-first" para os demais
  e.respondWith(
    caches.match(req).then((cached) => cached || fetch(req))
      .catch(() => {
        if (req.headers.get('accept')?.includes('text/html')) {
          return caches.match('/offline.html');
        }
      })
  );
});
