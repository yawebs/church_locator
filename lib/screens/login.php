<?php
error_reporting(E_ERROR | E_PARSE);
include 'connect.php';



//Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;
$response->userid = null;


$email = $_POST['email'];
$password = $_POST['password'];


if (!empty($password) && filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $sql = "SELECT id,userEmail,userPassword FROM users WHERE userEmail=?";
    $query = $connect->prepare($sql);
    $stmt = $query->execute([$email]);

    if ($query->rowCount() > 0) {

        $row = $query->fetch(PDO::FETCH_ASSOC);
        if (password_verify($password, $row['userPassword'])) {
            $response->status = true;
            $response->message = "login successfully";
            $response->userid = $row['id'];
        } else {

            $response->status = false;
            $response->message = "invalid password";
        }
    } else {

        $response->status = false;
        $response->message = "Account Doesnt Exist";
    }
} else {
    $response->status = false;
    $response->message = "either empty field or invalid email charracter";
}

header('Content-type: application/json');
echo json_encode($response);
