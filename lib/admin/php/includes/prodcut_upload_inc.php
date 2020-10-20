<?php
session_start();


if (isset($_POST['upload-product'])) {


    require '../../../connect.php';


    $_SESSION['error-product'] = "";
    $_SESSION['success-product'] = "";
    $file = $_FILES['file'];
    $fileName = $_FILES['file']['name'];
    $fileTmpName = $_FILES['file']['tmp_name'];
    $fileSize = $_FILES['file']['size'];
    $fileError = $_FILES['file']['error'];
    $fileType = $_FILES['file']['type'];
    $churchName = $_POST['churchName'];
    $address = $_POST['address'];
    $churchCity = $_POST['city'];
    $lga = $_POST['lga'];
    $userId = 1;
    $allowed = array('jpg', 'jpeg', 'png');

    if (empty($fileName)) {

        $_SESSION['error-product'] = "Church Logo Required";
        header("Location:../products-upload.php");
        exit();
    } else if (empty($churchName)) {
        $_SESSION['error-product'] = "Church Name Required";
        header("Location:../Church-upload.php");
        exit();
    } else if (empty($address)) {
        $_SESSION['error-product'] = "Product Description Required";
        header("Location:../Church-upload.php");
        exit();
    } else if (empty($churchCity)) {
        $_SESSION['error-product'] = "Church City Required";
        header("Location:../products-upload.php");
        exit();
    } else {
        $fileExt = explode('.', $fileName);
        $fileActualExt = strtolower(end($fileExt));


        if (in_array($fileActualExt, $allowed)) {

            if ($fileError == 0) {
                if ($fileSize < 700000) {

                    $imageNewName = uniqid('', true) . "." . $fileActualExt;
                    $fileDestionation = "../../../uploads/" . $imageNewName;
                    $fileDestionation2 = "uploads/" . $imageNewName;
                    $path = "http://churchlocates.com/apiTest/" . $fileDestionation2;

                    $query = $connect->prepare("INSERT INTO churches (userId, churchImage, churchName,category, churchLocation, churchAddress,churchLga) VALUES (?,?,?,?,?,?,?)");
                    $query->execute([$userId, $path, $churchName, $churchName, $churchCity, $address, $lga]);

                    move_uploaded_file($fileTmpName, $fileDestionation);


                    $_SESSION['success-product'] = $churchName . " Successfully Added ";
                    header("Location:../products-upload.php");
                    exit();
                } else {
                    $_SESSION['error-product'] = "Image must be less than 4mb ";
                    header("Location:../products-upload.php");
                    exit();
                }
            } else {
                $_SESSION['error-product'] = "There was an Error Uploading this file, Please try again";
                header("Location:../products-upload.php");
                exit();
            }
        } else {
            $_SESSION['error-product'] = "only Jpg,jpeg,png are supported";
            header("Location:../products-upload.php");
            exit();
        }
    }
} else {


    header("Location: ../products-upload.php");
    exit();
}
