<?php
require __DIR__ . '/../includes/db_connect.php';
session_start();

$sub = json_decode(file_get_contents('php://input'), true);
if (!$sub) { http_response_code(400); exit; }

$userId = $_SESSION['user_id'] ?? null;
$stmt = $pdo->prepare("
  INSERT INTO push_subscriptions (user_id, subscription)
  VALUES (?, ?)
  ON DUPLICATE KEY UPDATE subscription = VALUES(subscription)
");
$stmt->execute([$userId, json_encode($sub)]);

echo json_encode(['success'=>true]);
