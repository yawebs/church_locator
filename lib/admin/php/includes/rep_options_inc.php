<?php
session_start();

if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    require '../../../includes/dbh.inc.php';
    require '../../../func/prequest.php';
    $_SESSION['action-result'] = "";
    if (isset($_POST['btn-remove-current-rep'])) {
        $repId = $_POST['current-rep-id'];
        $request = new PaymentRequest;
        $removeRep = $request->removeRep($repId);
        $_SESSION['action-result'] = "Rep Successfully Removed";
        header("Location: ../search-reps.php");
        exit;
    } else if (isset($_POST['btn-suspend-current-rep'])) {

        $repId = $_POST['current-rep-id'];
        $request = new PaymentRequest;
        $suspendRep = $request->suspendRep($repId);
        $_SESSION['action-result'] = $suspendRep;
        header("Location: ../search-reps.php");
        exit;
    } else if (isset($_POST['btn-upgrade-current-rep'])) {

        $repId = $_POST['current-rep-id'];
        $request = new PaymentRequest;
        $upgradeRep = $request->upgradeRep($repId);
        $_SESSION['action-result'] = $upgradeRep;
        header("Location: ../search-reps.php");
        exit;
    } else {
        header("Location: ../../../index.php");
        exit;
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
