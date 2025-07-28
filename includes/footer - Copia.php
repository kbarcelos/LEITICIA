<?php
// /includes/footer.php
?>
    </main> <footer class="site-footer">
    <div class="container">
        <p>
            © Copyright <?= date('Y') ?> - Plataforma Leitícia - Todos os direitos reservados.<br>
            Desenvolvido por Kapta Soluções e Negócios Sociais em parceria com o Ecossistema de Inovação Capixaba.
        </p>
    </div>
</footer>

<script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js" integrity="sha256-DvxtJg3u8C6UDP2AnuKV4EvFD8M6Oa+QbTy8grelbXY=" crossorigin=""></script>

<script src="<?= BASE_URL ?>/assets/js/main.js"></script>
<script src="<?= BASE_URL ?>/assets/js/mapas.js"></script>

<script>
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
            navigator.serviceWorker.register('<?= BASE_URL ?>/service-worker.js')
                .then(reg => console.log('Service Worker registrado com sucesso:', reg.scope))
                .catch(err => console.error('Falha no registro do Service Worker:', err));
        });
    }
</script>

</body>
</html>