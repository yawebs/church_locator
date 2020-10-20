<?php
error_reporting(E_ERROR | E_PARSE);
include 'connect.php';



//Response object structure
$response = new stdClass;
$response->status = null;
$response->length = null;
$response->message = null;


//new
$churchName = $_POST['churchName'];


if ($churchName != '') {
    $queryRe = $connect->prepare("SELECT * FROM churches WHERE churchName LIKE :churchName");
    $exec = $queryRe->execute(["churchName" => "%" . $churchName]);
    if ($exec) {
        $response->status = 'successful';
        $response->length = $queryRe->rowCount();
        $response->message = $queryRe->fetchAll();
    } else {
        echo 'Something went wrong';
    }
}

header('Content-type: application/json');
echo json_encode($response);
