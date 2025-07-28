<?php
// google-callback.php
require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/config/config.php';
require __DIR__ . '/includes/db_connect.php';
session_start();

$client = new Google\Client();
$client->setClientId(GOOGLE_CLIENT_ID);
$client->setClientSecret(GOOGLE_CLIENT_SECRET);
$client->setRedirectUri(GOOGLE_REDIRECT_URI);

if (!isset($_GET['code'])) {
    header('Location: ' . BASE_URL . '/login.php');
    exit;
}

$token = $client->fetchAccessTokenWithAuthCode($_GET['code']);
if (isset($token['error'])) {
    die('Erro ao obter token: ' . htmlspecialchars($token['error']));
}
$client->setAccessToken($token['access_token']);

$oauth2   = new Google\Service\Oauth2($client);
$userInfo = $oauth2->userinfo->get();

$email    = $userInfo->email;
$name     = $userInfo->name;
$googleId = $userInfo->id;

// Insere ou atualiza usuário
$stmt = $pdo->prepare("SELECT id FROM users WHERE google_id = ?");
$stmt->execute([$googleId]);
$user = $stmt->fetch();

if ($user) {
    $userId = $user['id'];
} else {
    $stmt = $pdo->prepare("INSERT INTO users (name, email, google_id) VALUES (?, ?, ?)");
    $stmt->execute([$name, $email, $googleId]);
    $userId = $pdo->lastInsertId();
}

$_SESSION['user_id'] = $userId;
header('Location: ' . BASE_URL . '/perfil.php');
exit;
