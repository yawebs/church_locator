<?php
session_start();
if (isset($_POST['btn-submit'])) {
    include_once '../../../includes/dbh.inc.php';
    include_once '../../../func/prequest.php';

    $userId = $_POST['current-userId'];
    $_SESSION['id'] = $userId;
    header("Location:../superadmin.php");
    exit;
}
