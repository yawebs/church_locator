<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    if (isset($_POST['upload-media'])) {


        require '../../../includes/dbh.inc.php';

        $_SESSION['media-error'] = "";
        $_SESSION['media-success'] = "";
        $file = $_FILES['file'];
        $fileName = $_FILES['file']['name'];
        $mediaName = $_POST['media-name'];
        $fileTmpName = $_FILES['file']['tmp_name'];
        $fileSize = $_FILES['file']['size'];
        $fileError = $_FILES['file']['error'];
        $fileType = $_FILES['file']['type'];



        //handle attachment


        $fileName2 = $_FILES['file2']['name'];

        $fileTmpName2 = $_FILES['file2']['tmp_name'];
        $fileSize2 = $_FILES['file2']['size'];
        $fileError2 = $_FILES['file2']['error'];
        $fileType2 = $_FILES['file2']['type'];


        $allowed = array('jpg', 'jpeg', 'png');

        if (empty($fileName)) {

            $_SESSION['media-error'] = "Media Image Required";
            header("Location: ../media-uploads.php");
            exit();
        } else if (empty($fileName2)) {
            $_SESSION['media-error'] = "Attachment is required";
            header("Location: ../media-uploads.php");
            exit();
        } else if (empty($mediaName)) {
            $_SESSION['media-error'] = "Product Name Required";
            header("Location: ../media-uploads.php");
            exit();
        } else {


            //start copy
            $fileExt = explode('.', $fileName);
            $fileActualExt = strtolower(end($fileExt));


            if (in_array($fileActualExt, $allowed)) {

                if ($fileError == 0) {
                    if ($fileSize < 700000) {

                        $imageNewName = uniqid('', true) . "." . $fileActualExt;
                        $fileDestionation = "../assets/img/media/" . $imageNewName;



                        move_uploaded_file($fileTmpName, $fileDestionation);

                        //attachment handling starts here
                        $allowed2 = array('pdf', 'doc', 'docx');
                        $fileExt2 = explode('.', $fileName2);
                        $fileActualExt2 = strtolower(end($fileExt2));


                        if (in_array($fileActualExt2, $allowed2)) {

                            if ($fileError2 == 0) {
                                if ($fileSize2 < 4000000) {

                                    $imageNewName2 = uniqid('', true) . "." . $fileActualExt2;
                                    $fileDestionation2 = "../assets/img/attachments/" . $imageNewName2;
                                    move_uploaded_file($fileTmpName2, $fileDestionation2);

                                    $query = $pdo->prepare("INSERT INTO media (media_name,media_img, attachment) VALUES (?,?,?)");
                                    $query->execute([$mediaName, $imageNewName, $imageNewName2]);



                                    $_SESSION['media-success'] = "Media Successfully Added ";
                                    header("Location:../media-uploads.php");
                                    exit();
                                } else {
                                    $_SESSION['error'] = "attachment must be less than 6mb ";
                                    header("Location:../media-uploads.php");
                                    exit();
                                }
                            } else {
                                $_SESSION['media-error'] = "There was an Error Uploading the attachment, Please try again";
                                header("Location: ../media-uploads.php");
                                exit();
                            }
                        } else {
                            $_SESSION['media-error'] = "only pdf and doc are supported";
                            header("Location: ../media-uploads.php");
                            exit();
                        }
                    } else {
                        $_SESSION['error'] = "Image must be less than 4mb ";
                        header("Location:../media-uploads.php");
                        exit();
                    }
                } else {
                    $_SESSION['media-error'] = "There was an Error Uploading this file, Please try again";
                    header("Location: ../media-uploads.php");
                    exit();
                }
            } else {
                $_SESSION['media-error'] = "only Jpg,jpeg,png are supported";
                header("Location: ../media-uploads.php");
                exit();
            }
            //end copy


        }
    } else {


        header("Location: ../../../index.php");
        exit();
    }
} else {


    header("Location: ../../../index.php");
    exit();
}
