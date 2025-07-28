<?php
require __DIR__ . '/../includes/db_connect.php';
require __DIR__ . '/../vendor/autoload.php';

use Minishlink\WebPush\WebPush;
use Minishlink\WebPush\Subscription;

$vapid = [
  'VAPID' => [
    'subject'    => VAPID_SUBJECT,
    'publicKey'  => VAPID_PUBLIC_KEY,
    'privateKey' => VAPID_PRIVATE_KEY,
  ],
];

$payload = json_encode([
  'title' => 'Olá! Novidade na Leitícia',
  'body'  => 'Confira agora as últimas doações e conteúdos educativos.',
  'url'   => BASE_URL
]);

$subs = $pdo->query("SELECT subscription FROM push_subscriptions")->fetchAll(PDO::FETCH_COLUMN);
$webPush = new WebPush($vapid);

foreach ($subs as $json) {
  $webPush->queueNotification(Subscription::create(json_decode($json, true)), $payload);
}

foreach ($webPush->flush() as $report) {
  $endpoint = $report->getRequest()->getUri();
  if ($report->isSuccess()) {
    error_log("[v] Push enviado: {$endpoint}");
  } else {
    error_log("[x] Falha no push {$endpoint}: {$report->getReason()}");
  }
}

echo "Notificações enviadas.";
