<?php
// /api/bancos.php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
if ($_SERVER['REQUEST_METHOD']==='OPTIONS') {
  header('Access-Control-Allow-Methods: GET');
  exit;
}
require __DIR__ . '/../includes/db_connect.php';

try {
  $stmt = $pdo->query("
    SELECT id, nome, endereco, latitude, longitude
    FROM bancos_de_leite
    ORDER BY nome
  ");
  $rows = $stmt->fetchAll();
  echo json_encode($rows, JSON_UNESCAPED_UNICODE);
} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(['error'=>'Erro ao buscar bancos de leite']);
}
