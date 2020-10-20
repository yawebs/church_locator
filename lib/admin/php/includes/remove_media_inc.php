<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    if (isset($_POST['btn-remove-media'])) {
        $id = $_POST['media-id'];
        include_once '../../../includes/dbh.inc.php';
        include_once '../../../func/prequest.php';
        $_SESSION['delete-media-error'] = '';
        $request = new PaymentRequest;
        $medias = $request->deleteMedia($id);
        $_SESSION['delete-media-error'] = $medias;
        header("Location: ../remove-media.php");
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
