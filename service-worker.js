const CACHE_NAME   = 'leiticia-static-v1';
const RUNTIME_CACHE= 'leiticia-runtime-v1';
const STATIC_ASSETS = [
  '/', '/index.php', '/manifest.json', '/offline.html',
  '/assets/css/styles.css',
  '/assets/js/main.js', '/assets/js/mapas.js',
  '/assets/images/logo.png'
];

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(STATIC_ASSETS))
      .then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys.filter(k => k !== CACHE_NAME && k !== RUNTIME_CACHE)
            .map(k => caches.delete(k))
      )
    ).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', e => {
  const req = e.request;
  const url = new URL(req.url);

  if (url.pathname.startsWith('/api/')) {
    // network-first for API
    e.respondWith(
      caches.open(RUNTIME_CACHE).then(cache =>
        fetch(req)
          .then(res => { cache.put(req, res.clone()); return res; })
          .catch(() => cache.match(req))
      )
    );
    return;
  }

  // cache-first for others
  e.respondWith(
    caches.match(req).then(cached => cached || fetch(req))
      .catch(() => {
        if (req.headers.get('accept').includes('text/html')) {
          return caches.match('/offline.html');
        }
      })
  );
});
