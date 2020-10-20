<?php
session_start();
if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
    $incomingSuperAdmin = $_SESSION['this-is-an-incoming-super-admin'];

    if (isset($_SESSION['payment-approval-notification'])) {
        $error = $_SESSION['payment-approval-notification'];
    }

    include_once '../../includes/dbh.inc.php';
    include_once '../../func/prequest.php';
    $paymentRequest = new PaymentRequest;
    $newPayment = $paymentRequest->fetchAllRequest();

    $totalrepRequest = new PaymentRequest;
    $totalreps = $totalrepRequest->getTotalRepCount();

    $partnersRequest = new PaymentRequest;
    $totalPartners = $partnersRequest->getTotalPartnersCount();

    $refferalsRequest = new PaymentRequest;
    $totalreferrals = $refferalsRequest->getTotalReferrals();

    $suspendedRequest = new PaymentRequest;
    $totalSuspended = $suspendedRequest->getTotalSuspendedReps();
    $superAdminRequest = new PaymentRequest;
    $adminDetails = $superAdminRequest->getSuperadmin($incomingSuperAdmin);

    $totalAwaitingList = new PaymentRequest;
    $awaitingList = $totalAwaitingList->getTotalWaitingListCount();
    $awatingListCount = 0;
    if ($awaitingList > 0) {
        $awatingListCount = $awaitingList;
    } else {
        $awatingListCount = 0;
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
        <div class="jumbotron">
            <div class="row">
                <div class="col-lg-6 col-xlg-4">
                    <h3 class="">Hi <?php echo $adminDetails['fname'] ?>, Welcome Back</h3>
                    <p class="text-muted">
                        manage,take actions,organize and take control of abitreps
                    </p>
                    <p class="text-success">
                        <?php echo $error;
                        unset($_SESSION['payment-approval-notification']); ?>
                    </p>
                </div>
            </div>
            <div class="row">

                <div class="col-xlg-6  m-b-30 col-lg-8">
                    <div class="row">

                        <div class=" col-md-4">
                            <!--widget card begin-->
                            <div class="card m-b-30">
                                <div class="card-body ">
                                    <div class="row">
                                        <div class="col-md-7">
                                            <h6 class="fw-600">Total Reps</h6>
                                            <p class="text-muted">
                                                Registered
                                            </p>
                                        </div>
                                        <div class="col-md-5 my-auto text-right">
                                            <h4 class="text-danger"><?Php echo $totalreps ?></h4>

                                        </div>
                                    </div>
                                    <div class="progress" style="height: 5px">
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: 82%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="row m-t-10">
                                        <div class="col-md-7">

                                            <p class="text-muted">
                                                Referred
                                            </p>
                                        </div>
                                        <div class="col-md-5 text-right">
                                            <p class="text-danger">82%</p>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--widget card ends-->
                        </div>
                        <div class=" col-md-4">
                            <!--widget card begin-->
                            <div class="card m-b-30">
                                <div class="card-body ">
                                    <div class="row">
                                        <div class="col-md-7">
                                            <h6 class="fw-600">Total Partners</h6>
                                            <p class="text-muted">
                                                Registered
                                            </p>
                                        </div>
                                        <div class="col-md-5 my-auto text-right">
                                            <h4 class="text-success"><?php echo $totalPartners ?></h4>

                                        </div>
                                    </div>
                                    <div class="progress" style="height: 5px">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 37%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="row m-t-10">
                                        <div class="col-md-7">

                                            <p class="text-muted">
                                                Currently
                                            </p>
                                        </div>
                                        <div class="col-md-5 text-right">
                                            <p class="text-success">37%</p>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--widget card ends-->
                        </div>
                        <div class=" col-md-4">
                            <!--widget card begin-->
                            <div class="card m-b-30">
                                <div class="card-body ">
                                    <div class="row">
                                        <div class="col-md-7">
                                            <h6 class="fw-600">Total Referrals</h6>
                                            <p class="text-muted">
                                                By Reps
                                            </p>
                                        </div>
                                        <div class="col-md-5 my-auto text-right">
                                            <h4 class="text-primary"><?php echo $totalreferrals ?></h4>

                                        </div>
                                    </div>
                                    <div class="progress" style="height: 5px">
                                        <div class="progress-bar" role="progressbar" style="width: 45%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="row m-t-10">
                                        <div class="col-md-7">

                                            <p class="text-muted">
                                                Currently
                                            </p>
                                        </div>
                                        <div class="col-md-5 text-right">
                                            <p class="text-primary">45%</p>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--widget card ends-->
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card m-b-30">
                                <div class="card-header">
                                    <h5 class=" m-b-0">Pending Payment Request</h5>


                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Username</th>
                                                <th scope="col">Unique</th>
                                                <th scope="col">Details</th>
                                                <th scope="col">Status</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <?php foreach ($newPayment as $requests) { ?>

                                                <tr>
                                                    <th scope="row">
                                                        <div><img class="rounded-circle" src="../../uploads/avatar.jpg" width="50px" height="50px"></div>
                                                    </th>
                                                    <td><?php echo $requests['fname'] ?></td>
                                                    <td><?php echo $requests['rep_uniqueId'] ?></td>


                                                    <form action="request-details.php" method="POST">
                                                        <td><button name="btn-details" class="btn btn-danger">Details</button></td>
                                                        <td><button name="btn-approve" class="btn btn-success">Approve</button></td>
                                                        <input type="hidden" name="current-userId" value="<?php echo $requests['rep_id'] ?>">
                                                    </form>

                                                </tr>

                                            <?php } ?>

                                        </tbody>

                                    </table>


                                </div>

                                <div class="card-body">
                                    <div class=""></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xlg-6 col-lg-4">
                    <div class="row">
                        <div class=" col-md-12 col-xlg-6">
                            <!--widget card begin-->
                            <div class="card m-b-30">

                                <div class="card-body">

                                    <div class="row p-t-10 ">
                                        <div class="col-sm-12 my-auto ">
                                            <h5 class="m-0">Total Suspended Reps<a href="#" class="mdi mdi-information text-muted"></a></h5>
                                        </div>

                                    </div>

                                    <div class="row p-t-10">
                                        <div class="col-sm-6 my-auto ">
                                            <h3 class=""><?php echo $totalSuspended ?></h3>
                                        </div>
                                        <div class="col-sm-6 my-auto  text-right ">
                                            <h3 class="text-success"><i class="mdi mdi-arrow-up"></i> </h3>
                                        </div>
                                    </div>

                                    <div id="chart-03"></div>

                                </div>
                            </div>
                            <!--widget card ends-->

                        </div>
                        <div class=" col-md-12 col-xlg-6">
                            <!--widget card begin-->
                            <div class="card m-b-30">
                                <div class="card-body">

                                    <div class="row p-t-10 ">
                                        <div class="col-sm-12 my-auto ">
                                            <h5 class="m-0">Total Awaiting List <a href="#" class="mdi mdi-information text-muted"></a></h5>
                                        </div>

                                    </div>

                                    <div class="row p-t-10">
                                        <div class="col-sm-6 my-auto ">
                                            <h3 class=""><?php echo $awatingListCount; ?></h3>
                                        </div>
                                        <div class="col-sm-6 my-auto  text-right ">
                                            <h3 class="text-success"><i class="mdi mdi-arrow-up"></i></h3>
                                        </div>
                                    </div>

                                    <div id="chart-04"></div>

                                </div>
                            </div>
                            <!--widget card ends-->

                        </div>


                    </div>

                </div>
            </div>
        </div>
    </section>
</main>


<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form class="ml-5" id="withdraw_form">

                <div class="modal-body">
                    <input type="text" class="form-control" disabled name="requestAmount" id="requestAmount" placeholder="<?php echo $requestAmount; ?>" class="col-9 bg-flat-color-2 border-0 p-2 ">
                    <div class="mt-2"><input type="text" disabled class="form-control" name="paymentAddress" id="paymentAddress" placeholder="<?php echo $username; ?>" class="col-9 bg-flat-color-2 border-0 p-2 mt-3"></div>
                    <div class="mt-2"><input type="text" disabled class="form-control" name="paymentMethod" id="paymentMethod" placeholder="<?php echo $paymentMethod; ?>" class="col-9 bg-flat-color-2 border-0 p-2 mt-3"></div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" name="send" id="send" class="btn btn-primary">Send</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--withdrawal Modal-->


<script src='https://d33wubrfki0l68.cloudfront.net/bundles/9556cd6744b0b19628598270bd385082cda6a269.js'></script>
<!--page specific scripts for demo-->

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-66116118-3"></script>
<script src="../../dboard/src/assets/js/bundle.js?ver=1.1.0"></script>
<script src="../../dboard/src/assets/js/scripts.js?ver=1.1.0"></script>
<script>
    window.dataLayer = window.dataLayer || [];

    function gtag() {
        dataLayer.push(arguments);
    }
    gtag('js', new Date());
    gtag('config', 'UA-66116118-3');
</script>
<!--Additional Page includes-->
<script src='https://d33wubrfki0l68.cloudfront.net/js/c36248babf70a3c7ad1dcd98d4250fa60842eea9/crisp/assets/vendor/apexchart/apexcharts.min.js'></script>
<!--chart data for current dashboard-->
<script type='text/javascript' src='https://d33wubrfki0l68.cloudfront.net/js/67402a3f617470ab013a6bebaa4dd07784dd9948/light/assets/js/dashboard-02.js'></script>
</body>

<!-- Mirrored from atmos.atomui.com/light/dashboard-02 by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 18 Mar 2020 07:34:29 GMT -->

</html>