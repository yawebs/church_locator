<?php
error_reporting(E_ERROR | E_PARSE);
include 'connect.php';



//Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;

//new
$firstName = $_POST['firstName'];
$lastName = $_POST['lastName'];
$email = $_POST['email'];
$password = $_POST['password'];

$newPassword = password_hash($password, PASSWORD_DEFAULT);


if (!empty($firstName) && !empty($lastName) && !empty($email) && !empty($password) && filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $sql = "SELECT * FROM users WHERE userEmail =?";
    $query = $connect->prepare($sql);
    $stmt = $query->execute([$email]);

    if ($query->rowCount() > 0) {
        $response->status = false;
        $response->message = "account already exist";
    } else {

        $sql = "INSERT INTO users (firstName,lastName,userEmail,userPassword)VALUES(?,?,?,?)";
        $query = $connect->prepare($sql);
        if ($query->execute([$firstName, $lastName, $email, $newPassword])) {

            $response->status = true;
            $response->message = "Account Successfully Created";
        } else {

            $response->status = false;
            $response->message = "could not execute query, try again";
        }
    }
} else {
    $response->status = false;
    $response->message = "either empty field or invalid email charracter";
}

header('Content-type: application/json');
echo json_encode($response);
