<%@page import="com.hms.db.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- end of jstl tag -->

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0 ">

        <title>Home Page | Healthcare Appointment Scheduling</title>
        <%@include file="component/allcss.jsp"%>


        <!-- customs css for this page -->
        <style type="text/css">
            .my-card {
                box-shadow: 0px 0px 10px 1px green;
                /*box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);*/
            }
        </style>
        <!-- end of customs css for this page -->

    </head>
    <body>
        <%@include file="component/navbar.jsp"%>


        <!-- carousel code -->

        <div id="carouselExampleIndicators" class="carousel slide"
             data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide-to="0" class="active" aria-current="true"
                        aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide-to="2" aria-label="Slide 3"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide-to="3" aria-label="Slide 4"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/doctor_2.png" class="d-block w-100" alt="..."
                         height="500px">
                </div>
                <div class="carousel-item">
                    <img src="img/doctor_5.png" class="d-block w-100" alt="..."
                         height="500px">
                </div>
                <div class="carousel-item">
                    <img src="img/hospital4.jpeg" class="d-block w-100" alt="..."
                         height="500px">
                </div>
                <div class="carousel-item">
                    <img src="img/doctor_3.jpg" class="d-block w-100" alt="..."
                         height="500px">
                </div>


            </div>
            <button class="carousel-control-prev" type="button"
                    data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
                    class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button"
                    data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span> <span
                    class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- end of carousel code -->



        <!-- First Div Container -->
        <div class="container p-3">
            <p class="text-center mt-2 mb-5 fs-2 myP-color">Some key Features of our
                Healthcare Appointment Scheduling</p>
            <div class="row">
                <!-- 1st col -->
                <div class="col-md-8 p-5">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="card my-card">
                                <div class="card-body">
                                    <a href="https://www.mmgazette.com/" target="_blank" rel="noopener noreferrer" class="text-decoration-none">
                                        <p class="fs-5 myP-color">The Malaysian Medical Gazette</p>
                                    </a>
                                    <iframe src="https://www.mmgazette.com/" width="100%" height="250px" style="border:none;"></iframe>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card my-card">
                                <div class="card-body">
                                    <a href="https://www.medscape.com/" target="_blank" rel="noopener noreferrer" class="text-decoration-none">
                                        <p class="fs-5 myP-color">MedScape</p>
                                    </a>
                                    <iframe src="https://www.medscape.com/" width="100%" height="250px" style="border:none;"></iframe>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card my-card">
                                <div class="card-body">
                                    <a href="https://www.healthline.com/health-news" target="_blank" rel="noopener noreferrer" class="text-decoration-none">
                                        <p class="fs-5 myP-color">HealthLine</p>
                                    </a>
                                    <iframe src="https://www.healthline.com/health-news" width="100%" height="250px" style="border:none;"></iframe>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card my-card">
                                <div class="card-body">
                                    <a href="https://www.medpagetoday.com/" target="_blank" rel="noopener noreferrer" class="text-decoration-none">
                                        <p class="fs-5 myP-color">MedPageToday</p>
                                    </a>
                                    <iframe src="https://www.medpagetoday.com/" width="100%" height="250px" style="border:none;"></iframe>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>
                <!-- End of 1st col -->

                <!-- 2nd col -->

                <div class="col-md-4 mt-2 mys-card">
                    <img class="mt-3" alt="" src="img/doctor_1.png" height="440px"
                         width="470px">
                </div>

                <!-- End of 2nd col -->

            </div>
        </div>
        <!-- End of First Div Container -->

        <hr>

        <!-- Second Div Container -->

        <!-- Second Div Container -->





        <!-- footer -->
        <%@include file="component/footer.jsp"%>
        <!-- end footer -->
    </body>
</html>