// src/components/InstagramEmbed.jsx
// Exemplo de incorporação simples de um post do Instagram via iframe.

export default function InstagramEmbed({ postUrl }) {
  if (!postUrl) return null;
  return (
    <div className="instagram-embed">
      <iframe
        title="Instagram"
        src={`https://www.instagram.com/p/${postUrl.split('/p/')[1]?.split('/')[0]}/embed`}
        width="100%"
        height="500"
        frameBorder="0"
        scrolling="no"
        allowTransparency
      />
    </div>
  );
}
