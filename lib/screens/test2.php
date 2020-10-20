<?php
error_reporting(E_ERROR | E_PARSE);
include 'connect.php';



//Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;

$testId = 8;
$userId = $_POST['userId'];

if ($userId != null) {
    $query = $connect->prepare("SELECT videoUrl FROM verification_video WHERE userId =? LIMIT 1");
    $stmt = $query->execute([$userId]);
    if ($query->rowCount() > 0) {
        $row = $query->fetch(PDO::FETCH_ASSOC);
        $response->status = true;
        $response->message = $row['videoUrl'];
    } else {
        $response->status = false;
        $response->message = 'No Image Uploaded';
    }
} else {
    $response->status = false;
    $response->message = 'Please Login to access this feature';
}


header('Content-type: application/json');
echo json_encode($response);
