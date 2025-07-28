<?php
// /api/doacoes.php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD']==='OPTIONS') {
  exit;
}
require __DIR__ . '/../includes/db_connect.php';

if ($_SERVER['REQUEST_METHOD']==='GET') {
  // lista doações
  $stmt = $pdo->query("SELECT * FROM doacoes ORDER BY data_solicitacao DESC");
  echo json_encode($stmt->fetchAll(), JSON_UNESCAPED_UNICODE);
  exit;
}

if ($_SERVER['REQUEST_METHOD']==='POST') {
  $data = json_decode(file_get_contents('php://input'), true);
  // campos esperados: doadora_id, banco_id, quantidade, endereco_coleta, data_coleta
  $stmt = $pdo->prepare("
    INSERT INTO doacoes
      (doadora_id, banco_id, quantidade, endereco_coleta, data_coleta)
    VALUES (?,?,?,?,?)
  ");
  try {
    $stmt->execute([
      $data['doadora_id'],
      $data['banco_id'],
      $data['quantidade'],
      $data['endereco_coleta'],
      $data['data_coleta']
    ]);
    http_response_code(201);
    echo json_encode(['id'=>$pdo->lastInsertId()]);
  } catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['error'=>'Falha ao registrar doação']);
  }
  exit;
}
