<?php
error_reporting(E_ERROR | E_PARSE);
include 'connect.php';



//Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;
$testId = 1;
$userId = $_POST['userId'];
$destination_dir = "videoverfication/";
$base_filename = basename($_FILES["file"]["name"]);
$temp = explode(".", $base_filename);
$target_file = $destination_dir . round(microtime(true)) . '.' . end($temp);
$path = "http://churchlocates.com/apiTest/" . $target_file;


if ($userId != null) {
    move_uploaded_file($_FILES['file']['tmp_name'], $target_file);
    $query = $connect->prepare("INSERT INTO verification_video (videoUrl,userId)VALUES (?,?)");
    if ($query->execute([$path, $userId])) {
        $response->status = true;
        $response->message = "Video Successfully Submited";
    } else {
        $response->status = false;
        $response->message = "unable to perform request";
    }
} else {
    $response->status = false;
    $response->message = 'You must be login to upload video';
}




header('Content-type: application/json');
echo json_encode($response);
