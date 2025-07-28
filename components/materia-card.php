<?php
function renderMateria($materia) {
  if (!$materia) return;

  $imagem = basename($materia['imagem'] ?? '');
  $classe = in_array($imagem, [
      'Agosto_Dourado.png', 'Amamentacao.png', 'Caderneta_truques.png', 'homenagem.png'
  ]) ? 'retrata' : '';

  $titulo = htmlspecialchars($materia['titulo'] ?? '');
  $resumo = $materia['resumo'] ?? (isset($materia['conteudo']) ? substr(strip_tags($materia['conteudo']), 0, 150).'...' : '');
  $resumo = nl2br(htmlspecialchars($resumo));
  $id = $materia['id'] ?? '';

  echo '<div class="materia-card vertical '.$classe.'">';
    echo '<div class="materia-image-container">';
      echo '<img class="materia-image" src="assets/images/'.$imagem.'" alt="'.$titulo.'">';
    echo '</div>';
    echo '<div class="materia-body">';
      echo '<h2 class="materia-title">'.$titulo.'</h2>';
      echo '<div class="materia-content"><p>'.$resumo.'</p></div>';
      echo '<a class="materia-readmore" href="materia.php?id='.$id.'"></a>';
    echo '</div>';
  echo '</div>';
}
?>