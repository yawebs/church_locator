<?php
session_start();

if (isset($_SESSION['this-is-an-incoming-super-admin'])) {

    if (isset($_POST['btn-approve-payment'])) {
        require '../../../includes/dbh.inc.php';
        $userId = $_POST['request-userId'];
        $_SESSION['payment-approval-notification'] = '';
        $message = "Your Payment as been Approved by Admin and its currently been Disbursed";
        $query = $pdo->prepare("INSERT INTO notifications (userId,notify_message) VALUES(?,?)");
        $exec = $query->execute([$userId, $message]);

        if (!$exec) {
            $_SESSION['payment-approval-notification'] = 'Could not approve this payment';
            header("Location: ../superadmin.php");
            exit;
        } else {
            $query = $pdo->prepare("DELETE FROM payment_request WHERE rep_id=?");
            $exec = $query->execute([$userId]);
            if (!$exec) {
                $_SESSION['payment-approval-notification'] = 'Could not remove request after approval';
                header("Location: ../superadmin.php");
                exit;
            } else {
                $_SESSION['payment-approval-notification'] = 'Payment has been approved';
                header("Location: ../superadmin.php");
                exit;
            }
        }
    } else {
        header("Location: ../../../index.php");
        exit;
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
