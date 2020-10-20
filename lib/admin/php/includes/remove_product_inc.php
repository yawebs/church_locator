<?php
session_start();

if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    if (isset($_POST['btn-remove-product'])) {
        $id = $_POST['product-id'];
        include_once '../../../includes/dbh.inc.php';
        include_once '../../../func/prequest.php';
        $_SESSION['delete-product-error'] = '';
        $request = new PaymentRequest;
        $products = $request->deleteProduct($id);
        $_SESSION['delete-product-error'] = $products;
        header("Location: ../remove-product.php");
        exit;
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
