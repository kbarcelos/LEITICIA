// src/app/Layout.jsx
// Componente de layout: cabeçalho, conteúdo com sidebar e rodapé.

import Header from './Header.jsx';
import Sidebar from './Sidebar.jsx';
import Footer from './Footer.jsx';
import './layout.css'; // CSS específico do layout (leve e opcional)

export default function Layout({ children }) {
  return (
    <div className="app-shell">
      <Header />
      <div className="app-content">
        <aside className="app-sidebar">
          <Sidebar />
        </aside>
        <main className="app-main">{children}</main>
      </div>
      <Footer />
    </div>
  );
}
