<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    require '../../../includes/dbh.inc.php';
    require '../../../func/prequest.php';
    $_SESSION['action-result-partners'] = "";
    if (isset($_POST['btn-remove-current-part'])) {
        $repId = $_POST['current-part-id'];
        $request = new PaymentRequest;
        $removeRep = $request->removePart($repId);
        $_SESSION['action-result-partners'] = "Partner Successfully Removed";
        header("Location: ../search-partner.php");
        exit;
    } else if (isset($_POST['btn-suspend-current-part'])) {

        $repId = $_POST['current-part-id'];
        $request = new PaymentRequest;
        $suspendRep = $request->suspendPart($repId);
        $_SESSION['action-result-partners'] = $suspendRep;
        header("Location: ../search-partner.php");
        exit;
    } else {
        header("Location: ../../../index.php");
        exit;
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
