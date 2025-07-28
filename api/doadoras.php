<?php
// /api/doadoras.php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD']==='OPTIONS') exit;
require __DIR__ . '/../includes/db_connect.php';

if ($_SERVER['REQUEST_METHOD']==='GET') {
  // lista doadoras
  $stmt = $pdo->query("SELECT id, nome, email, telefone FROM doadoras ORDER BY nome");
  echo json_encode($stmt->fetchAll(), JSON_UNESCAPED_UNICODE);
  exit;
}

if ($_SERVER['REQUEST_METHOD']==='POST') {
  $d = json_decode(file_get_contents('php://input'), true);
  $stmt = $pdo->prepare("
    INSERT INTO doadoras (nome, email, telefone, endereco)
    VALUES (?,?,?,?)
  ");
  try {
    $stmt->execute([$d['nome'], $d['email'], $d['telefone'], $d['endereco']]);
    http_response_code(201);
    echo json_encode(['id'=>$pdo->lastInsertId()]);
  } catch (Exception $e) {
    http_response_code(400);
    echo json_encode(['error'=>'Não foi possível cadastrar doadora']);
  }
  exit;
}
