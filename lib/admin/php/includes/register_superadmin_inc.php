<?php
session_start();
if (isset($_POST['create-admin-account'])) {
    require '../../../includes/dbh.inc.php';
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $fname = $_POST['fname'];
    $email = $_POST['email'];
    $pwd = $_POST['pwd'];
    $secQuestion = $_POST['sec-question'];
    $secAnswer = $_POST['sec-answer'];
    $_SESSION['admin-reg-error'] = '';
    $_SESSION['admin-reg-success'] = '';

    if (empty($fname)) {
        $_SESSION['admin-reg-error'] = 'Firstname required';
        header("Location: ../admin-reg.php");
        exit;
    } else if (empty($lname)) {

        $_SESSION['admin-reg-error'] = 'Lastname required';
        header("Location: ../admin-reg.php");
        exit;
    } else if (empty($email)) {
        $_SESSION['admin-reg-error'] = 'email required';
        header("Location: ../admin-reg.php");
        exit;
    } else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $_SESSION['admin-reg-error'] = 'Please Enter a valid Email';
        header("Location: ../admin-reg.php");
        exit;
    } else if (empty($secQuestion)) {
        $_SESSION['admin-reg-error'] = 'security question required';
        header("Location: ../admin-reg.php");
        exit;
    } else if (empty($secAnswer)) {
        $_SESSION['admin-reg-error'] = 'Security answer required';
        header("Location: ../admin-reg.php");
        exit;
    } else {
        $query = $pdo->prepare("SELECT * FROM super_admin WHERE adminEmail=?");
        $exec = $query->execute([$email]);
        if (!$exec) {
            $_SESSION['admin-reg-error'] = 'Could not run verifiy user';
            header("Location: ../admin-reg.php");
            exit;
        } else if ($query->rowCount() > 0) {
            $_SESSION['admin-reg-error'] = 'This account already exist';
            header("Location: ../admin-reg.php");
            exit;
        } else {
            $newPwd = password_hash($pwd, PASSWORD_DEFAULT);
            $query = $pdo->prepare("INSERT INTO super_admin (fname,lname,adminEmail,pwd,security_question,security_answer) VALUES (?,?,?,?,?,?)");
            $exec = $query->execute([$fname, $lname, $email, $newPwd, $secQuestion, $secAnswer]);

            if (!$exec) {
                $_SESSION['admin-reg-error'] = 'Unable to create admin account';
                header("Location: ../admin-reg.php");
                exit;
            } else {

                header("Location: ../admin-login.php?login=success");
                exit;
            }
        }
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
