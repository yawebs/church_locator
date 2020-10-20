<?php
session_start();
if (isset($_POST['login-admin-account'])) {
    require '../../../includes/dbh.inc.php';
    require '../../../func/prequest.php';
    $adminEmail = $_POST['email'];
    $pwd = $_POST['pwd'];
    $secQuestion = $_POST['sec-question'];
    $secAnswer = $_POST['sec-answer'];
    $_SESSION['admin-login-error'] = '';

    if (empty($adminEmail)) {
        $_SESSION['admin-login-error'] = 'Email is required';
        header("Location: ../admin-login.php");
        exit;
    } else if (!filter_var($adminEmail, FILTER_VALIDATE_EMAIL)) {
        $_SESSION['admin-login-error'] = 'Please enter a valid email';
        header("Location: ../admin-login.php");
        exit;
    } else if (empty($pwd)) {
        $_SESSION['admin-login-error'] = 'password field is emty';
        header("Location: ../admin-login.php");
        exit;
    } else if (empty($secQuestion)) {
        $_SESSION['admin-login-error'] = 'please enter security question';
        header("Location: ../admin-login.php");
        exit;
    } else if (empty($secAnswer)) {
        $_SESSION['admin-login-error'] = 'Please enter security answer';
        header("Location: ../admin-login.php");
        exit;
    } else {

        $query = $pdo->prepare("SELECT * FROM super_admin WHERE adminEmail=?");
        $query->execute([$adminEmail]);
        if ($query->rowCount() > 0) {
            $result = $query->fetch(PDO::FETCH_ASSOC);

            if (!password_verify($pwd, $result['pwd'])) {
                $_SESSION['admin-login-error'] = 'You entered an incorrect password';
                header("Location: ../admin-login.php");
                exit;
            } else if ($secQuestion != $result['security_question']) {
                $_SESSION['admin-login-error'] = 'Security Question Incorrect';
                header("Location: ../admin-login.php");
                exit;
            } else if ($secAnswer != $result['security_answer']) {
                $_SESSION['admin-login-error'] = 'Wrong Security Answer';
                header("Location: ../admin-login.php");
                exit;
            } else {
                //remove inactive reps
                $total_referrals = 0;

                $checkbalancesql = "SELECT * FROM users WHERE total_referrals=? LIMIT 1";
                $checkbalancequery = $pdo->prepare($checkbalancesql);
                $check = $checkbalancequery->execute([$total_referrals]);
                if ($checkbalancequery->rowCount() > 0) {
                    $inactive = $checkbalancequery->fetch(PDO::FETCH_ASSOC);

                    $inactiveRepId = $inactive['id'];
                    $dueDateRequest = new PaymentRequest;
                    $dueDate = $dueDateRequest->fetchDueDate($inactiveRepId);
                    $membershipEnds = date("Y-m-d", strtotime(date("Y-m-d", strtotime($dueDate)) . "+ 30 day"));
                    if (date("Y-m-d") > $membershipEnds) {
                        $addToinactiveList = new PaymentRequest;
                        $addInactive = $addToinactiveList->addToInactiveList($inactive['fname'], $inactive['lname'], $inactive['userEmail'], $inactive['referral_link'], $inactive['userProduct'], $inactive['pwd']);
                        $removeRepRequest = new PaymentRequest;
                        $removeRep = $removeRepRequest->removeRep($inactiveRepId);

                        $getTotalRepCount = new PaymentRequest;
                        $repcount = $getTotalRepCount->getTotalRepCount();
                        if ($repcount == 1000000) {
                            $fetchFromWaitingList = new PaymentRequest;
                            $fromWaitingList = $fetchFromWaitingList->getFromWaitingList();


                            //take from waiting list and add to reps


                            $addToReps = new PaymentRequest;
                            $addRep = $addToReps->addToReps($fromWaitingList['fname'], $fromWaitingList['lnam'], $fromWaitingList['userEmail'], $fromWaitingList['userProduct'], $fromWaitingList['pwd'], $fromWaitingList['referral_link']);

                            //remove the user from waiting list after adding to reps list
                            $removeFromWaitingList = new PaymentRequest;
                            $removeWaiting = $removeFromWaitingList->removeFromWaitingList($fromWaitingList['id']);
                            require_once '../../../phpmailertesting/mail.php';

                            $to = $fromWaitingList['userEmail'];
                            $from = 'verification@abitreps.com';
                            $from_name = 'Abitrep Account Approval';
                            $subject = 'Account Approved';


                            $body = '<html>' . '<head><title>Abitrep Account Approval</title></head>' .
                                '<body><p>Hi ' . $fromWaitingList['fname'] . ' </p>' . '<p> you are no longer in the waiting list </p>' .
                                '<p>Your account has been approved you can now login to your dashboard</p>' . "<a href='http://abitreps.com/dboard/src/php/auths/auth-login.php'>Login</a>"
                                . '</body' . '</html>';

                            smtpmailer($to, $from, $from_name, $subject, $body);

                            $duequery = $pdo->prepare("INSERT INTO dueDate (userId,date_due) VALUES(?,?)");
                            $duequery->execute([$fromWaitingList['id'], $fromWaitingList['reg_date']]);
                        }
                    }
                }


                //Login admin
                $_SESSION['this-is-an-incoming-super-admin'] = $result['id'];
                header("Location: ../superadmin.php");
                exit;
            }
        } else {
            $_SESSION['admin-login-error'] = 'This account doesnt exist';
            header("Location: ../admin-login.php");
            exit;
        }
    }
} else {
    header("Location: ../../../index.php");
    exit;
}
