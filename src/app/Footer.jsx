// src/app/Footer.jsx
// Rodapé simples.

export default function Footer() {
  return (
    <footer className="footer" style={{ padding: '16px', marginTop: 'auto', textAlign: 'center' }}>
      <p>© {new Date().getFullYear()} Leitícia — doe leite, alimente esperanças.</p>
    </footer>
  );
}
