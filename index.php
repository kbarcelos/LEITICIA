<?php
// Conecta ao banco
require_once __DIR__ . '/db/conexao.php';

// Incluir o header (carrega config, abre <html>, <body>, <main>)
include __DIR__ . '/includes/header.php';

// 1. BUSCAR TODAS AS MATÉRIAS
$stmt = $pdo->query(
    "SELECT * FROM materias ORDER BY data_publicacao DESC LIMIT 12"
);
$all_materias = $stmt->fetchAll(PDO::FETCH_ASSOC);

// 2. PREPARAR A ORDEM DE EXIBIÇÃO
$ordem_fixa_nomes = [
    'Agosto_Dourado.png',
    'Amamentacao.png',
    'Caderneta_truques.png',
    'homenagem.png'
];

// Mapear nome da imagem → matéria
$materias_por_imagem = [];
foreach ($all_materias as $materia) {
    $nomeImg = basename($materia['imagem']);
    $materias_por_imagem[$nomeImg] = $materia;
}

// 3. MONTAR LISTA FINAL E ORDENADA
$materias_para_exibir = [];

// Primeiro, as fixas na ordem desejada
foreach ($ordem_fixa_nomes as $nome_imagem) {
    if (isset($materias_por_imagem[$nome_imagem])) {
        $materias_para_exibir[] = $materias_por_imagem[$nome_imagem];
        unset($materias_por_imagem[$nome_imagem]);
    }
}
// Depois, o resto em ordem decrescente de publicação
$materias_para_exibir = array_merge(
    $materias_para_exibir,
    array_values($materias_por_imagem)
);

// Inclui o componente de card (com a função renderMateria)
include_once __DIR__ . '/components/materia-card.php';

// Índice para percorrer o array
$materia_idx = 0;
?>

<div class="homepage-grid">
  <div class="materias-column">

    <div class="grid-row">
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
      
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
    </div>

    <div class="grid-row">
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>

      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
    </div>

    <div class="grid-row triple">
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-third">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>

      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-third">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>

      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-third">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
    </div>

    <div class="grid-row">
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>

      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
    </div>

    <div class="grid-row">
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
      
      <?php if (isset($materias_para_exibir[$materia_idx])): ?>
        <div class="materia-half">
          <?php renderMateria($materias_para_exibir[$materia_idx++]); ?>
        </div>
      <?php endif; ?>
    </div>

  </div>

  <div class="video-column">
    <div class="video-youtube">
      <iframe width="100%" height="200"
        src="https://www.youtube.com/embed/iZS0qRE9UKc"
        title="YouTube video player"
        frameborder="0"
        allowfullscreen>
      </iframe>
    </div>
    <div class="video-destaque">
      <blockquote class="instagram-media"
        data-instgrm-permalink="https://www.instagram.com/reel/DMEgP3qMDSh/?utm_source=ig_embed"
        data-instgrm-version="14">
      </blockquote>
      <script async src="//www.instagram.com/embed.js"></script>
      <div class="video-destaque">VIDEO DESTAQUE</div>
      <div class="video-destaque">VIDEO DESTAQUE</div>
    </div>
  </div>
</div>

</main>  <!-- fecha o <main> aberto no header -->

<?php
// Incluir o footer (fecha <body> e <html>, registra SW e carrega scripts)
include __DIR__ . '/includes/footer.php';
?>
