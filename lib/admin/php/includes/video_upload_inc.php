<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {

    if (isset($_POST['upload-video'])) {


        require '../../../includes/dbh.inc.php';

        $_SESSION['error-video'] = "";
        $_SESSION['video-success'] = "";
        $file = $_FILES['file'];
        $fileName = $_FILES['file']['name'];
        $fileTmpName = $_FILES['file']['tmp_name'];
        $fileSize = $_FILES['file']['size'];
        $fileError = $_FILES['file']['error'];
        $fileType = $_FILES['file']['type'];
        $videoTitle = $_POST['video-title'];

        $allowed = array('mp4', '3gp', 'mov', 'avi', 'wmv', 'flv',);

        if (empty($fileName)) {

            $_SESSION['error-video'] = "Video Required";
            header("Location: ../upload-video.php");
            exit();
        } else if (empty($videoTitle)) {
            $_SESSION['error-video'] = "Video Title Required";
            header("Location: ../upload-video.php");
            exit();
        } else {
            $fileExt = explode('.', $fileName);
            $fileActualExt = strtolower(end($fileExt));


            if (in_array($fileActualExt, $allowed)) {

                if ($fileError == 0) {
                    if ($fileSize < 20000000) {

                        $videosName = uniqid('', true) . "." . $fileActualExt;
                        $fileDestionation = "../assets/videos/" . $videosName;

                        $querySelc = $pdo->prepare("SELECT * FROM videos");
                        $querySelc->execute();

                        if ($querySelc->rowCount() > 0) {
                            $videoId = 1;
                            $queryUpdate = $pdo->prepare("UPDATE videos SET video_title=?, video_name=? WHERE id=?");
                            $execUpdate = $queryUpdate->execute([$videoTitle, $videosName, $videoId]);
                            if (!$execUpdate) {
                                $_SESSION['error-video'] = "Could not update video";
                                header("Location: ../upload-video.php");
                                exit();
                            } else {
                                move_uploaded_file($fileTmpName, $fileDestionation);

                                $_SESSION['video-success'] = "Video successfully updated ";
                                header("Location:../upload-video.php");
                                exit();
                            }
                            //run update
                        } else {
                            $query = $pdo->prepare("INSERT INTO  videos (video_title,video_name)VALUES (?,?)");
                            $exec = $query->execute([$videoTitle, $videosName]);
                            if (!$exec) {
                                $_SESSION['error-video'] = "Could not upload video to database";
                                header("Location: ../upload-video.php");
                                exit();
                            } else {

                                move_uploaded_file($fileTmpName, $fileDestionation);

                                $_SESSION['video-success'] = "Video successfully uploaded ";
                                header("Location:../upload-video.php");
                                exit();
                            }
                        }
                    } else {
                        $_SESSION['error-video'] = "Video must be less than 9mb ";
                        header("Location:../upload-video.php");
                        exit();
                    }
                } else {
                    $_SESSION['error-video'] = "There was an Error Uploading this file, Please try again";
                    header("Location:../upload-video.php");
                    exit();
                }
            } else {
                $_SESSION['error-video'] = "only video files are supported";
                header("Location:../upload-video.php");
                exit();;
            }
        }
    } else {


        header("Location:../upload-video.php");
        exit();
    }
} else {


    header("Location: ../../../index.php");
    exit();
}
