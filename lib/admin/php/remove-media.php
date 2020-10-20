<?php
session_start();
require_once '../../includes/dbh.inc.php';
require_once '../../func/prequest.php';
if (isset($_SESSION['delete-media-error'])) {
    $actionResult = $_SESSION['delete-media-error'];
}

$request = new PaymentRequest;
$products = $request->fetchAllMedia();

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
    <section class="admin-content " id="contact-search">
        <div class="m-b-30" style="background-color: #d1d1d1">
            <div class="container">
                <div class="row p-b-60 p-t-60">

                    <div class="col-md-6 text-center mx-auto text-white p-b-30">
                        <div class="m-b-10">
                            <div class="avatar ">
                                <div class="avatar-title rounded-circle mdi mdi-contacts "></div>
                            </div>
                        </div>
                        <h3 class="text-dark">Remove Media </h3>
                        <p class="text-success"><?php echo $actionResult;
                                                unset($_SESSION['delete-media-error']) ?></p>
                        <form>
                            <div class="form-dark">
                                <div class="input-group input-group-flush mb-3">

                                    <input name="admin-search" placeholder="Search By Name" class="form-control form-control-lg search form-control-prepended">
                                    <div class="input-group-prepend">
                                        <div class="input-group-text">
                                            <i class="mdi mdi-magnify"></i>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </form>

                    </div>


                </div>
            </div>
        </div>

        <section class="pull-up">

            <div class="container">

                <div class="row list">
                    <?php foreach ($products as $product) { ?>
                        <div class=" col-lg-6 col-md-6 mb-3">

                            <div class="card border-0 " data-aos="fade-right">
                                <div class="card-img-top">
                                    <img src="assets/img/media/<?php echo $product['media_img'] ?>" height="300px" width="100%">
                                </div>

                                <div class="card-body  bg-dark text-white product-card-border">

                                    <div class="float-right w-75 pt-5 pb-5">
                                        <h4 class="card-title"><?php echo $product['media_name'] ?></h4>

                                        <div class="row">

                                            <button data-toggle="modal" data-target="#logoutModalCenter<?php echo $product['id'] ?>" target="_blank" class="btn bg-danger ml-4 text-white">Remove Product</button>
                                        </div>

                                    </div>
                                </div>


                            </div>


                        </div>
                        <!--logout Modal-->
                        <div class="modal fade" id="logoutModalCenter<?php echo $product['id'] ?>" tabindex="-1" role="dialog" aria-labelledby="logoutModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="logoutModalLongTitle">Remove Media</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <form class="ml-5" id="withdraw_form" method="POST" action="includes/remove_media_inc.php">
                                        <div class="modal-body">
                                            <h6>Are you sure you want to remove this media?</h6>

                                        </div>
                                        <div class="modal-footer">
                                            <input name="media-id" type="hidden" value="<?php echo $product['id'] ?>">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Ignore</button>
                                            <button type="submit" name="btn-remove-media" id="send" class="btn btn-primary text-white">Delete</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!--end Logout Modal-->
                    <?php } ?>




                </div>

            </div>



        </section>

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


</body>



</html>