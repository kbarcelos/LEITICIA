<?php
// /api/chat.php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD']==='OPTIONS') exit;
require __DIR__ . '/../includes/db_connect.php';

// GET: retorna últimas 50 mensagens
if ($_SERVER['REQUEST_METHOD']==='GET') {
  $stmt = $pdo->query("
    SELECT usuario, mensagem, criado_em
    FROM chat
    ORDER BY criado_em DESC
    LIMIT 50
  ");
  echo json_encode(array_reverse($stmt->fetchAll()), JSON_UNESCAPED_UNICODE);
  exit;
}

// POST: envia nova mensagem {usuario, mensagem}
if ($_SERVER['REQUEST_METHOD']==='POST') {
  $c = json_decode(file_get_contents('php://input'), true);
  $stmt = $pdo->prepare("
    INSERT INTO chat (usuario, mensagem)
    VALUES (?,?)
  ");
  try {
    $stmt->execute([$c['usuario'], $c['mensagem']]);
    http_response_code(201);
    echo json_encode(['ok'=>true]);
  } catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['error'=>'Falha ao enviar mensagem']);
  }
  exit;
}
