<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    if (isset($_POST['update-product-inc'])) {

        require_once '../../../includes/dbh.inc.php';
        require_once '../../../func/prequest.php';

        $productId = $_POST['incoming-update-productId'];


        $productName = $_POST['product-name'];
        $productLink = $_POST['product-link'];
        $productDesc = $_POST['product-desc'];
        $_SESSION['update-product-error'] = '';



        $request = new PaymentRequest;
        $updateProduct = $request->updateUproductById($productId, $productName, $productLink, $productDesc);
        $_SESSION['update-product-error'] = $updateProduct;
        header("Location: ../edit-product.php");
    } else {
        header("Location: ../../../index.php");
        exit;
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
