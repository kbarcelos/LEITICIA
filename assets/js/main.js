document.addEventListener('DOMContentLoaded', () => {
  // ✅ Service Worker + Push Notification
  if ('serviceWorker' in navigator && 'PushManager' in window) {
    navigator.serviceWorker.register(`${BASE_URL}/service-worker.js`)
      .then(reg => {
        return Notification.requestPermission().then(permission => {
          if (permission !== 'granted') throw new Error('Permissão negada');
          return reg.pushManager.getSubscription()
            .then(sub => sub || reg.pushManager.subscribe({
              userVisibleOnly: true,
              applicationServerKey: urlBase64ToUint8Array(window.PUSH_PUBLIC_KEY)
            }));
        });
      })
      .then(subscription => {
        fetch(`${BASE_URL}/api/push/subscribe.php`, {
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
          body: JSON.stringify(subscription)
        });
      })
      .catch(console.error);
  }

  function urlBase64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - (base64String.length % 4)) % 4);
    const base64 = (base64String + padding).replace(/-/g, '+').replace(/_/g, '/');
    const raw = window.atob(base64);
    return Uint8Array.from([...raw].map(c => c.charCodeAt(0)));
  }

  // ✅ Toggle do menu mobile (hamburguer)
  const toggleBtn = document.getElementById('mobile-menu-toggle');
  const wrapper = document.querySelector('.site-wrapper');

  if (toggleBtn && wrapper) {
    toggleBtn.addEventListener('click', () => {
      wrapper.classList.toggle('sidebar-open');
    });

    document.addEventListener('click', e => {
      if (!wrapper.contains(e.target) && wrapper.classList.contains('sidebar-open')) {
        wrapper.classList.remove('sidebar-open');
      }
    });
  }

  // ✅ Sidebar Accordion Feature
  const accordionItems = document.querySelectorAll('.sidebar-feature.accordion-item');
  accordionItems.forEach(item => {
    item.addEventListener('click', () => {
      accordionItems.forEach(el => {
        if (el !== item) el.classList.remove('active');
      });
      item.classList.toggle('active');
    });
  });

  // ✅ Validação simples de formulário de login
  const loginForm = document.querySelector('#login-form');
  if (loginForm) {
    loginForm.addEventListener('submit', e => {
      const email = loginForm.email.value.trim();
      if (!email.includes('@')) {
        e.preventDefault();
        alert('Informe um e-mail válido');
      }
    });
  }

  // ✅ Máscara de telefone
  const telInput = document.querySelector('input[type="tel"]');
  if (telInput) {
    telInput.addEventListener('input', e => {
      e.target.value = e.target.value
        .replace(/\D/g, '')
        .replace(/(\d{2})(\d)/, '($1) $2')
        .replace(/(\d{4,5})(\d{4})$/, '$1-$2');
    });
  }
});
const collapseBtn = document.querySelector('#sidebar-toggle');
collapseBtn?.addEventListener('click', () => {
  document.body.classList.toggle('collapsed');
  collapseBtn.classList.toggle('fa-chevron-right');
  collapseBtn.classList.toggle('fa-chevron-left');
});
