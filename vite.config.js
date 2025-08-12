// vite.config.js
// Configura o Vite para React. A base (VITE_BASE) é "/" no subdomínio de dev.

import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';

export default ({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  return defineConfig({
    plugins: [react()],
    base: env.VITE_BASE || '/', // no subdomínio de dev, deixe "/"
    server: { port: 5173, open: true },
    build: { outDir: 'dist' }
  });
};
