<?php echo json_encode(["ok" => true]); ?>
<?php
// /api/mapas.php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
require __DIR__ . '/../includes/db_connect.php';

// Retorna geoJSON dos bancos de leite
$stmt = $pdo->query("
  SELECT id, nome, latitude, longitude
  FROM bancos_de_leite
");
$features = [];
while ($row = $stmt->fetch()) {
  $features[] = [
    'type'       => 'Feature',
    'geometry'   => [
      'type'        => 'Point',
      'coordinates' => [(float)$row['longitude'], (float)$row['latitude']]
    ],
    'properties' => [
      'id'   => $row['id'],
      'name' => $row['nome']
    ]
  ];
}

echo json_encode([
  'type'     => 'FeatureCollection',
  'features' => $features
], JSON_UNESCAPED_UNICODE);
