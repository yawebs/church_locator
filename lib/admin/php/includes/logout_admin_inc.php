<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    if (isset($_POST['logout'])) {
        unset($_SESSION['this-is-an-incoming-super-admin']);
        session_unset();
        session_destroy();
        header("Location: ../../../index.php");
        exit;
    }
}
