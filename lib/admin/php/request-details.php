<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    if (isset($_POST['btn-details'])) {
        include_once '../../includes/dbh.inc.php';
        include_once '../../func/prequest.php';
        $paymentRequest = new PaymentRequest;
        $newPayment = $paymentRequest->fetchAllRequest();

        $userId = $_POST['current-userId'];

        $userDetails = $paymentRequest->fetchUser($userId);
        $username = $userDetails['fname'];
        $requestAmount = $userDetails['request_amount'];
        $paymentMethod = $userDetails['payment_method'];
        $paymentAddress = $userDetails['payment_address'];
        $requestDate = $userDetails['request_date'];

        $requestRep = new PaymentRequest;
        $repDetails = $requestRep->fetchSingleRep($userId);

        // echo '<META HTTP-EQUIV="Refresh" Content="200; URL=' . $location . '">';
    } else {
        header("Location: ../../index.php");
        exit;
    }
} else {
    header("Location: ../../index.php");
    exit;
}



?>
<?php require 'header.php'; ?>

<main class="admin-main">
    <!--site header begins-->
    <header class="admin-header">

        <a href="#" class="sidebar-toggle" data-toggleclass="sidebar-open" data-target="body"> </a>

        <nav class=" mr-auto my-auto">
            <ul class="nav align-items-center">

                <li class="nav-item">
                    <a class="nav-link" data-target="#siteSearchModal" data-toggle="modal" href="#">
                        <i class=" mdi mdi-magnify mdi-24px align-middle"></i>
                    </a>
                </li>
            </ul>
        </nav>
        <nav class=" ml-auto">
            <ul class="nav align-items-center">
                <li class="nav-item">
                    <div class="dropdown">
                        <a href="#" class="nav-link" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i class="mdi mdi-24px mdi-bell-outline"></i>
                            <span class="notification-counter"></span>
                        </a>

                        <div class="dropdown-menu notification-container dropdown-menu-right">
                            <div class="d-flex p-all-15 bg-white justify-content-between border-bottom ">
                                <a href="#!" class="mdi mdi-18px mdi-settings text-muted"></a>
                                <span class="h5 m-0">Notifications</span>
                                <a href="#!" class="mdi mdi-18px mdi-notification-clear-all text-muted"></a>
                            </div>
                            <div class="notification-events bg-gray-300">
                                <div class="text-overline m-b-5">today</div>
                                <a href="#" class="d-block m-b-10">
                                    <div class="card">
                                        <div class="card-body"> <i class="mdi mdi-circle text-success"></i> All systems operational.</div>
                                    </div>
                                </a>
                                <a href="#" class="d-block m-b-10">
                                    <div class="card">
                                        <div class="card-body"> <i class="mdi mdi-upload-multiple "></i> File upload successful.</div>
                                    </div>
                                </a>
                                <a href="#" class="d-block m-b-10">
                                    <div class="card">
                                        <div class="card-body">
                                            <i class="mdi mdi-cancel text-danger"></i> Your holiday has been denied
                                        </div>
                                    </div>
                                </a>


                            </div>

                        </div>
                    </div>
                </li>
                <li class="nav-item dropdown ">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <div class="avatar avatar-sm avatar-online">
                            <span class="avatar-title rounded-circle bg-dark">V</span>

                        </div>
                    </a>
                    <div class="dropdown-menu  dropdown-menu-right">
                        <a class="dropdown-item" href="#"> Add Account
                        </a>
                        <a class="dropdown-item" href="#"> Reset Password</a>
                        <a class="dropdown-item" href="#"> Help </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#"> Logout</a>
                    </div>
                </li>

            </ul>

        </nav>
    </header>
    <!-- Modal -->
    <div class="modal fade modal-slide-right" id="demoModal" tabindex="-1" role="dialog" aria-labelledby="demoLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="demoLabel">Demos</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <iframe src="https://atmos.atomui.com/demos.html" height="100%" width="100%" frameborder="0"></iframe>
                </div>
                <div class="modal-footer">
                    <div class="text-muted"><i class="mdi mdi-information"></i>Demos will open in new tab</div>
                </div>
            </div>
        </div>
    </div>
    <!--site header ends -->
    <section class="admin-content ">
        <div class="bg-light m-b-30">
            <div class="container">
                <div class="row p-b-60 p-t-60">

                    <div class="col-lg-6 text-white p-b-30">
                        <div class="media">
                            <div class="avatar avatar mr-3">
                                <div class="avatar-title bg-success rounded-circle mdi mdi-widgets  ">

                                </div>
                            </div>
                            <div class="media-body">
                                <h1 class="text-dark">PAYMENT DUE</h1>
                                <p class="opacity-75 text-dark">
                                    Dear Admin, kindly note that this user is due for payment
                                </p>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div>
        <div class="pull-up">
            <div class="container">
                <div class="row d-flex justify-content-center">
                    <div class="col-md-6 col-lg-6">


                        <!--widget card begin-->
                        <div class="card m-b-30">
                            <div class="card-body">

                                <div class="text-center pull-up-sm">
                                    <div class="avatar avatar-lg avatar-online">
                                        <img src="../../uploads/avatar.jpg" class="avatar-img rounded-circle" alt="">
                                    </div>
                                </div>
                                <h4 class="text-center m-t-20">
                                    <?php echo  $username; ?>

                                </h4>
                                <div class="text-muted text-center m-b-20">
                                    Total Referrals <a class="btn btn-sm bg-info text-white"><?Php echo $repDetails['total_referrals'] ?></a>

                                </div>
                                <hr>

                                <div class="">
                                    <h4>REP DETAILS</h4>
                                </div>
                                <div class="timeline timeline-xs ">
                                    <div class="timeline-item">
                                        <div class="timeline-wrapper">
                                            <div class="">
                                                <div class="avatar avatar-xs">
                                                    <div class="avatar-title rounded-circle">
                                                        <i class="mdi mdi-email"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <p class="m-0"><?php echo $repDetails['userEmail'] ?></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-wrapper">
                                            <div class="">
                                                <div class="avatar avatar-xs">
                                                    <div class="avatar-title bg-info rounded-circle">
                                                        <i class="mdi mdi-account-alert"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <p class="m-0"><?php echo 'Phone :' . $repDetails['userPhone'] ?></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-wrapper">
                                            <div class="">
                                                <div class="avatar avatar-xs">
                                                    <div class="avatar-title bg-info rounded-circle">
                                                        <i class="mdi mdi-cash-refund"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <p class="m-0"><?php echo 'Amount :' . '$' . $requestAmount ?></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-wrapper">
                                            <div class="">
                                                <div class="avatar avatar-xs">
                                                    <div class="avatar-title bg-info rounded-circle">
                                                        <i class="mdi mdi-cash-refund"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <p class="m-0">Payment Address: <?php echo $paymentAddress; ?></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-wrapper">
                                            <div class="">
                                                <div class="avatar avatar-xs">
                                                    <div class="avatar-title bg-info rounded-circle">
                                                        <i class="mdi mdi-cash-refund"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <p class="m-0">Payment Method: <?php echo $paymentMethod ?></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-wrapper">
                                            <div class="">
                                                <div class="avatar avatar-xs">
                                                    <div class="avatar-title bg-info rounded-circle">
                                                        <i class="mdi mdi-clock"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <p class="m-0">Request Date: <?php echo $requestDate ?></p>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="timeline-item ">
                                        <div class="timeline-wrapper">

                                        </div>
                                        <form action="includes/approve_inc.php" method="POST">
                                            <input type="hidden" name="request-userId" value="<?php echo $userId ?>">
                                            <button type="submit" name="btn-approve-payment" class="btn bg-info text-white mt-2">Approve Payment</button>
                                        </form>
                                        <a href="superadmin.php" class="btn bg-light text-dark mt-2 ml-5">Back</a>


                                    </div>
                                </div>
                                <!--widget card ends-->



                            </div>
                            <div class="col-md-6 col-lg-4">





                            </div>
                        </div>
                    </div>

                </div>
    </section>
</main>

<div class="modal modal-slide-left  fade" id="siteSearchModal" tabindex="-1" role="dialog" aria-labelledby="siteSearchModal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <div class="modal-body p-all-0" id="site-search">
                <button type="button" class="close light" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <div class="form-dark bg-dark text-white p-t-60 p-b-20 bg-dots">
                    <h3 class="text-uppercase    text-center  fw-300 "> Search</h3>

                    <div class="container-fluid">
                        <div class="col-md-10 p-t-10 m-auto">
                            <input type="search" placeholder="Search Something" class=" search form-control form-control-lg">

                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="bg-dark text-muted container-fluid p-b-10 text-center text-overline">
                        results
                    </div>
                    <div class="list-group list  ">


                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm "><img class="avatar-img rounded-circle" src="assets/img/users/user-3.jpg" alt="user-image"></div>
                            </div>
                            <div class="">
                                <div class="name">Eric Chen</div>
                                <div class="text-muted">Developer</div>
                            </div>


                        </div>
                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm "><img class="avatar-img rounded-circle" src="assets/img/users/user-4.jpg" alt="user-image"></div>
                            </div>
                            <div class="">
                                <div class="name">Sean Valdez</div>
                                <div class="text-muted">Marketing</div>
                            </div>


                        </div>
                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm "><img class="avatar-img rounded-circle" src="assets/img/users/user-8.jpg" alt="user-image"></div>
                            </div>
                            <div class="">
                                <div class="name">Marie Arnold</div>
                                <div class="text-muted">Developer</div>
                            </div>


                        </div>
                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm ">
                                    <div class="avatar-title bg-dark rounded"><i class="mdi mdi-24px mdi-file-pdf"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="">
                                <div class="name">SRS Document</div>
                                <div class="text-muted">25.5 Mb</div>
                            </div>


                        </div>
                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm ">
                                    <div class="avatar-title bg-dark rounded"><i class="mdi mdi-24px mdi-file-document-box"></i></div>
                                </div>
                            </div>
                            <div class="">
                                <div class="name">Design Guide.pdf</div>
                                <div class="text-muted">9 Mb</div>
                            </div>


                        </div>
                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm ">
                                    <div class="avatar avatar-sm  ">
                                        <div class="avatar-title bg-primary rounded"><i class="mdi mdi-24px mdi-code-braces"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="">
                                <div class="name">response.json</div>
                                <div class="text-muted">15 Kb</div>
                            </div>


                        </div>
                        <div class="list-group-item d-flex  align-items-center">
                            <div class="m-r-20">
                                <div class="avatar avatar-sm ">
                                    <div class="avatar avatar-sm ">
                                        <div class="avatar-title bg-info rounded"><i class="mdi mdi-24px mdi-file-excel"></i></div>
                                    </div>
                                </div>
                            </div>
                            <div class="">
                                <div class="name">June Accounts.xls</div>
                                <div class="text-muted">6 Mb</div>
                            </div>


                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>


<script src='https://d33wubrfki0l68.cloudfront.net/bundles/9556cd6744b0b19628598270bd385082cda6a269.js'></script>
<!--page specific scripts for demo-->

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-66116118-3"></script>
<script>
    window.dataLayer = window.dataLayer || [];

    function gtag() {
        dataLayer.push(arguments);
    }
    gtag('js', new Date());
    gtag('config', 'UA-66116118-3');
</script>
<script src='https://d33wubrfki0l68.cloudfront.net/bundles/64ad511020d73a0b9af73d5c09b49d191b54cadd.js'></script>
</body>

<!-- Mirrored from atmos.atomui.com/light/widget-01 by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 18 Mar 2020 07:35:05 GMT -->

</html>