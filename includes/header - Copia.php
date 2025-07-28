<?php
require_once __DIR__ . '/../config/config.php';
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><?= defined('SITE_NAME') ? SITE_NAME : 'Plataforma Leitícia' ?></title>

  <meta name="description" content="Plataforma Leitícia - Doe leite, alimente esperanças.">
  <link rel="manifest" href="<?= BASE_URL ?>/manifest.json">
  <meta name="theme-color" content="#336964">
  <link rel="icon" href="<?= BASE_URL ?>/assets/images/favicon.png" type="image/png">

  <link rel="stylesheet" href="<?= BASE_URL ?>/assets/css/styles.css">
  <link rel="stylesheet" href="<?= BASE_URL ?>/fonts/material-icons.css">

  <script>
    window.BASE_URL = '<?= defined('BASE_URL') ? BASE_URL : "/"; ?>';
  </script>
</head>
<body>

<div class="site-wrapper">

  <aside class="sidebar">
    <div class="sidebar-header">
      <a href="<?= BASE_URL ?>/index.php">
        <img src="<?= BASE_URL ?>/assets/images/logo.png" alt="Logo pequeno" class="sidebar-logo">
      </a>
      <p class="sidebar-slogan">doe leite, alimente esperanças</p>
    </div>
    <nav class="sidebar-nav-features">
      <ul>
        <li class="sidebar-feature accordion-item">
          <div class="sidebar-feature__icon"><span class="material-icons">home</span></div>
          <div class="sidebar-feature__content">
            <h4>Início</h4>
            <p class="feature-desc">Acesse a página principal da plataforma.</p>
            <ul class="submenu">
              <li><a href="<?= BASE_URL ?>/index.php">Página Inicial</a></li>
            </ul>
          </div>
        </li>

        <li class="sidebar-feature">
          <div class="sidebar-feature__icon"><span class="material-icons">emoji_objects</span></div>
          <div class="sidebar-feature__content">
            <h4>Dica</h4>
            <p class="feature-desc">10ml de leite podem salvar uma vida!</p>
          </div>
        </li>

        <li class="sidebar-feature">
          <div class="sidebar-feature__icon"><span class="material-icons">redeem</span></div>
          <div class="sidebar-feature__content">
            <h4>Descubra</h4>
            <p class="feature-desc">Doar leite pode trazer benefícios pra você!</p>
          </div>
        </li>
        <li class="sidebar-feature accordion-item">
          <div class="sidebar-feature__icon"><span class="material-icons">school</span></div>
          <div class="sidebar-feature__content">
            <h4>Educação</h4>
            <p class="feature-desc">Saiba mais sobre a doação de leite.</p>
            <ul class="submenu">
              <li><a href="#">Como funciona?</a></li>
              <li><a href="#">Locais de coleta</a></li>
              <li><a href="#">Quem pode doar?</a></li>
              <li><a href="#">Por que doar?</a></li>
            </ul>
          </div>
        </li>

        <li class="sidebar-feature">
          <div class="sidebar-feature__icon"><span class="material-icons">handshake</span></div>
          <div class="sidebar-feature__content">
            <h4>Parcerias</h4>
            <p class="feature-desc">Farmácias, mercados e academias apoiam!</p>
          </div>
        </li>
      </ul>
    </nav>

    <div class="sidebar-footer">
      <div class="sidebar-feature__icon"><span class="material-icons">contact_support</span></div>
      <div class="sidebar-feature__content">
        <h4><a href="<?= BASE_URL ?>/contato.php">Contato</a></h4>
        <p class="feature-desc">Fale conosco para dúvidas ou sugestões.</p>
      </div>
    </div>
  </aside>

  <div class="main-content-area">
    <header class="content-header">
      <div class="content-header-left">
        <button class="mobile-menu-toggle" id="mobile-menu-toggle">
          <span class="material-icons">menu</span>
        </button>
      </div>

      <div class="content-header-center">
        <img src="<?= BASE_URL ?>/assets/images/leiticia.png" alt="Logotipo Leitícia Central" class="main-logo-header">
      </div>

      <div class="content-header-right">
        <div class="account-link">
          <a href="<?= BASE_URL ?>/login.php">ACESSE SUA CONTA</a>
        </div>
      </div>
    </header>

    <main class="page-content">