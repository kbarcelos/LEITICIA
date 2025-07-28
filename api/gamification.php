<?php
// /api/gamification.php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

require __DIR__ . '/../includes/db_connect.php';

// Exemplo: GET /api/gamification.php?user_id=123
$user_id = filter_input(INPUT_GET, 'user_id', FILTER_VALIDATE_INT);
if (!$user_id) {
  http_response_code(400);
  echo json_encode(['error'=>'user_id é obrigatório']);
  exit;
}

// Busca pontos e badges
$stmt = $pdo->prepare("
  SELECT pontos, badges
  FROM gamification
  WHERE user_id = ?
");
$stmt->execute([$user_id]);
$data = $stmt->fetch();
if (!$data) {
  // se não existir, retorna zeros
  $data = ['pontos'=>0, 'badges'=>[]];
} else {
  $data['badges'] = json_decode($data['badges'], true);
}
echo json_encode($data, JSON_UNESCAPED_UNICODE);
