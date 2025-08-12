// src/pages/Contato.jsx
// Formulário simples (sem backend). Integraremos ao PHP depois.

export default function Contato() {
  function handleSubmit(e) {
    e.preventDefault();
    alert('Mensagem enviada! (demo) — depois conectamos à API.');
  }

  return (
    <div className="page contato">
      <h1>Contato</h1>
      <form className="form" onSubmit={handleSubmit}>
        <label>
          Nome
          <input required name="nome" placeholder="Seu nome" />
        </label>
        <label>
          E-mail
          <input required type="email" name="email" placeholder="voce@exemplo.com" />
        </label>
        <label>
          Mensagem
          <textarea required name="mensagem" rows={4} />
        </label>

        <button className="btn btn-primary">Enviar</button>
      </form>
    </div>
  );
}
