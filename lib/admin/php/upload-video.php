<?php
session_start();

if (isset($_SESSION['this-is-an-incoming-super-admin'])) {
} else {
    header("Location: ../../index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">


<meta http-equiv="content-type" content="text/html;charset=UTF-8" />

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" name="viewport">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta content="" name="author" />
    <meta content="atlas is Bootstrap 4 based admin panel.It comes with 100's widgets,charts and icons" name="description" />
    <meta property="og:locale" content="en_US" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="atlas is Bootstrap 4 based admin panel.It comes with 100's widgets,charts and icons" />
    <meta property="og:description" content="atlas is Bootstrap 4 based admin panel.It comes with 100's widgets,charts and icons" />
    <meta property="og:image" content="https://cdn.dribbble.com/users/180706/screenshots/5424805/the_sceens_-_mobile_perspective_mockup_3_-_by_tranmautritam.jpg" />
    <meta property="og:site_name" content="atlas " />
    <title>AbitRep Admin</title>
    <link rel="icon" type="image/x-icon" href="../../uploads/abitrep.png" />
    <link rel="icon" href="../../uploads/abitrep.png" type="image/png" sizes="16x16">
    <link rel='stylesheet' href='https://d33wubrfki0l68.cloudfront.net/css/478ccdc1892151837f9e7163badb055b8a1833a5/crisp/assets/vendor/pace/pace.css' />
    <script src='https://d33wubrfki0l68.cloudfront.net/js/3d1965f9e8e63c62b671967aafcad6603deec90c/theme/html/assets/js/pace.min.js'></script>
    <!--vendors-->
    <link rel='stylesheet' type='text/css' href='https://d33wubrfki0l68.cloudfront.net/bundles/291bbeead57f19651f311362abe809b67adc3fb5.css' />

    <link rel='stylesheet' href='https://d33wubrfki0l68.cloudfront.net/bundles/30bc673ce76f73ecf02568498f6b139269f6e4c7.css' />



    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,600" rel="stylesheet">
    <!--Material Icons-->
    <link rel='stylesheet' type='text/css' href='https://d33wubrfki0l68.cloudfront.net/css/548117a22d5d22545a0ab2dddf8940a2e32c04ed/default/assets/fonts/materialdesignicons/materialdesignicons.min.css' />
    <!--Material Icons-->
    <link rel='stylesheet' type='text/css' href='https://d33wubrfki0l68.cloudfront.net/css/0940f25997c8e50e65e95510b30245d116f639f0/light/assets/fonts/feather/feather-icons.css' />
    <!--Bootstrap + atmos Admin CSS-->
    <link rel='stylesheet' type='text/css' href='https://d33wubrfki0l68.cloudfront.net/css/16e33a95bb46f814f87079394f72ef62972bd197/light/assets/css/atmos.min.css' />
    <!-- Additional library for page -->

</head>

<body class="sidebar-pinned ">
    <aside class="admin-sidebar">
        <div class="admin-sidebar-brand">
            <!-- begin sidebar branding-->
            <img class="admin-brand-logo" src="../../uploads/abitrep.png" width="40" alt="atmos Logo">
            <!-- end sidebar branding-->
            <div class="ml-auto">
                <!-- sidebar pin-->
                <a href="#" class="admin-pin-sidebar btn-ghost btn btn-rounded-circle"></a>
                <!-- sidebar close for mobile device-->
                <a href="#" class="admin-close-sidebar"></a>
            </div>
        </div>
        <div class="admin-sidebar-wrapper js-scrollbar">
            <ul class="menu">


                <l, class="menu-item ">


                    <li class="menu-item ">
                        <a href="superadmin.php" class="open-dropdown menu-link">
                            <span class="menu-label">
                                <span class="menu-name">Dashboard
                                    <span class="menu-arrow"></span>
                                </span>
                            </span>
                            <span class="menu-icon">
                                <i class="icon-placeholder fe fe-thermometer"></i>
                            </span>
                        </a>
                        <ul class="sub-menu">
                            <li class="menu-item">
                                <a href='superadmin.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Home </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            H
                                        </i>
                                    </span>
                                </a>
                            </li>


                        </ul>
                    </li>

                    <li class="menu-item ">
                        <a href="#" class="open-dropdown menu-link">
                            <span class="menu-label">
                                <span class="menu-name">MEDIA
                                    <span class="menu-arrow"></span>
                                </span>
                            </span>
                            <span class="menu-icon">
                                <i class="icon-placeholder fe fe-camera"></i>
                            </span>
                        </a>
                        <!--submenu-->
                        <ul class="sub-menu">
                            <li class="menu-item">
                                <a href='media-uploads.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Upload Media </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            U
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='upload-video.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Upload Video </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            V
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='remove-media.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Remove Media </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            R
                                        </i>
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <!-- Products M-->
                    <li class="menu-item ">
                        <a href="#" class="open-dropdown menu-link">
                            <span class="menu-label">
                                <span class="menu-name">PRODUCTS
                                    <span class="menu-arrow"></span>
                                </span>
                            </span>
                            <span class="menu-icon">
                                <i class="icon-placeholder fe fe-camera-off"></i>
                            </span>
                        </a>
                        <!--submenu-->
                        <ul class="sub-menu">
                            <li class="menu-item">
                                <a href='products-upload.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Upload Products </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            U
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='remove-product.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Remove Products </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            R
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='edit-product.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Edit Products </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            E
                                        </i>
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- Products M-->


                    <!-- Partners M-->
                    <li class="menu-item ">
                        <a href="#" class="open-dropdown menu-link">
                            <span class="menu-label">
                                <span class="menu-name">PARTNERS
                                    <span class="menu-arrow"></span>
                                </span>
                            </span>
                            <span class="menu-icon">
                                <i class="icon-placeholder fe fe-user-check"></i>
                            </span>
                        </a>
                        <!--submenu-->
                        <ul class="sub-menu">
                            <li class="menu-item">
                                <a href='search-partner.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Search Partner </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            S
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='search-partner.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Remove Partner </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            R
                                        </i>
                                    </span>
                                </a>
                            </li>


                        </ul>
                    </li>
                    <!-- Partners M-->

                    <!-- Reps M-->
                    <li class="menu-item ">
                        <a href="#" class="open-dropdown menu-link">
                            <span class="menu-label">
                                <span class="menu-name">ABitReps
                                    <span class="menu-arrow"></span>
                                </span>
                            </span>
                            <span class="menu-icon">
                                <i class="icon-placeholder fe fe-users"></i>
                            </span>
                        </a>
                        <!--submenu-->
                        <ul class="sub-menu">
                            <li class="menu-item">
                                <a href='search-reps.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Upgrade A Rep </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            U
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='search-reps.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Search Rep </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            S
                                        </i>
                                    </span>
                                </a>
                            </li>

                            <li class="menu-item">
                                <a href='search-reps.php' class=' menu-link'>
                                    <span class="menu-label">
                                        <span class="menu-name">Remove Rep </span>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder  ">
                                            R
                                        </i>
                                    </span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- Reps M-->

                    <!-- Settings M-->
                    <li class="menu-item ">
                        <a href="#" class="open-dropdown menu-link">
                            <span class="menu-label">
                                <span class="menu-name">Settings
                                    <span class="menu-arrow"></span>
                                </span>
                            </span>
                            <span class="menu-icon">
                                <i class="icon-placeholder fe fe fe fe-settings"></i>
                            </span>
                        </a>
                        <!--submenu-->
                        <ul class="sub-menu">
                            <li class="menu-item">
                                <form action="includes/logout_admin_inc.php" method="POST" class=' menu-link'>
                                    <span class="menu-label">
                                        <button type="submit" name="logout" class="menu-name btn btn-primary">Logout </button>
                                    </span>
                                    <span class="menu-icon">
                                        <i class="icon-placeholder">
                                            L
                                        </i>
                                    </span>
                                </form>
                            </li>
                        </ul>
                    </li>




            </ul>

        </div>

    </aside>
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
                                    <div class="">

                                    </div>
                                </div>
                                <div class="media-body">

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

                                <!-- <div class="card-media " style="height: 100px">

                                    <img class="card-img-top" src="assets/img/upload2.png" width="100px" height="100px" alt="Card image cap">
                                </div> -->
                                <div class="card-body">

                                    <div class="text-center pull-up-sm">
                                        <div class="">
                                            <img src="assets/img/upload.png" width="70px" height="70px" alt="">
                                        </div>
                                    </div>
                                    <form action="includes/video_upload_inc.php" method="POST" enctype="multipart/form-data">
                                        <h4 class="text-center m-t-20">

                                            <input type="file" name="file" class="btn bg-info text-white mt-2">video only</button>
                                        </h4>

                                        <hr>
                                        <?php { ?>
                                            <div class="">
                                                <p class="text-danger">
                                                    <?php echo $error;
                                                    unset($_SESSION['error-video']) ?>
                                                </p>
                                                <p class="text-success">
                                                    <?php echo $success;
                                                    unset($_SESSION['video-success']) ?>
                                                </p>
                                                <p>VIDEO DETAILS</p>
                                            </div>
                                        <?php } ?>
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
                                                    <div class="col-auto form-group">
                                                        <input class="form-control form-control-lg" name="video-title" type="text" placeholder="Video Title">
                                                    </div>
                                                </div>

                                            </div>



                                            <div class="timeline-item ">
                                                <div class="timeline-wrapper">

                                                </div>
                                                <button name="upload-video" class="btn bg-info text-white mt-2">Save video</button>


                                    </form>
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