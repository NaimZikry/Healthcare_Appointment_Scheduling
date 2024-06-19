<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.dao.FeedbackDAO"%>
<%@page import="com.hms.entity.Feedback"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
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
<title>Patient Page</title>


<%@include file="../component/allcss.jsp"%>


<!-- customs css for this page -->
<style type="text/css">
.bg-success {
    background-color: #2980B9 !important;
}  
.text-success {
    color: #2980B9 !important;
}.my-card {
    box-shadow: 0px 0px 10px 1px #2980B9;
    /*box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.3);*/
}

</style>
<!-- end of customs css for this page -->


</head>
<body>
    <%@include file="navbar.jsp"%>

    <!-- if "doctorObj" is empty means no one is login. -->

    <c:if test="${empty doctorObj }">

        <c:redirect url="../doctor_login.jsp"></c:redirect>

    </c:if>

    <!-- check is doctor is login or not -->


    <div class="container p-3">
        <div class="row">
            <div class="col-md-12">
                <div class="card my-card">
                    <div class="card-body">
                        <p class="text-center text-success fs-3">Patient Details</p>

                        <!-- message print -->
                        <!-- for success msg -->
                        <c:if test="${not empty successMsg }">
                            <p class="text-center text-success fs-5">${successMsg}</p>
                            <c:remove var="successMsg" scope="session" />
                        </c:if>

                        <!-- for error msg -->
                        <c:if test="${not empty errorMsg }">
                            <p class="text-center text-danger fs-5">${errorMsg}</p>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>
                        <!-- End of message print -->

                        <!-- table for patient list -->

                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col" style="padding-right: 100px">Full Name</th>
                                    <th scope="col">Gender</th>
                                    <th scope="col">Age</th>
                                    <th scope="col">Appointment Date</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                    <th scope="col">Feedback</th>
                                </tr>
                            </thead>
                            <tbody>

                                <%
                                Doctor doctor = (Doctor) session.getAttribute("doctorObj");

                                //DoctorDAO docDAO = new DoctorDAO(DBConnection.getConn());
                                AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
                                FeedbackDAO feedbackDAO = new FeedbackDAO(DBConnection.getConn());
                                List<Appointment> list = appDAO.getAllAppointmentByLoginDoctor(doctor.getId());
                                for (Appointment applist : list) {
                                    Feedback feedback = feedbackDAO.getFeedbackByAppointmentId(applist.getId());
                                %>

                                <tr>
                                    <th><%=applist.getFullName()%></th>
                                    <td><%=applist.getGender()%></td>
                                    <td><%=applist.getAge()%></td>
                                    <td><%=applist.getAppointmentDate()%></td>
                                    <td><%=applist.getEmail()%></td>
                                    <td><%=applist.getPhone()%></td>
                                    <td><%=applist.getDiseases()%></td>
                                    <td><%=applist.getStatus()%></td>

                                    <td>
                                        <%
                                        if ("Pending".equals(applist.getStatus())) {
                                        %> <a href="comment.jsp?id=<%=applist.getId()%>"
                                        class="btn btn-success btn-sm">Comment / Prescription</a> 
                                        <%
                                        } else {
                                        %> 
                                         <a href="#!" class="btn btn-success btn-sm disabled"><i
                                            class="fa fa-comment"></i> Comment / Prescription</a>
                                             
                                        <%
                                        }
                                        %>
                                    </td>
                                    
                                    <td>
                                        <%
                                        if (feedback != null) {
                                            out.print(feedback.getComment());
                                        } else {
                                            out.print("No Feedback");
                                        }
                                        %>
                                    </td>
                                </tr>

                                <%
                                }
                                %>


                            </tbody>
                        </table>

                        <!-- end table for patient list -->

                    </div>
                </div>
            </div>

        </div>

        <!-- Upcoming Appointments section -->
        <div class="row mt-5">
            <div class="col-md-12">
                <div class="card my-card">
                    <div class="card-body">
                        <p class="text-center text-success fs-3">Upcoming Appointments</p>

                        <!-- table for upcoming appointments list -->
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col" style="padding-right: 100px">Full Name</th>
                                    <th scope="col">Gender</th>
                                    <th scope="col">Age</th>
                                    <th scope="col">Appointment Date</th>
                                    <th scope="col">Email</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Days Until Appointment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for (Appointment applist : list) {
                                    if ("Pending".equals(applist.getStatus())) {
                                        LocalDate appointmentDate = LocalDate.parse(applist.getAppointmentDate().toString());
                                        long daysUntil = ChronoUnit.DAYS.between(LocalDate.now(), appointmentDate);
                                %>
                                <tr>
                                    <th><%=applist.getFullName()%></th>
                                    <td><%=applist.getGender()%></td>
                                    <td><%=applist.getAge()%></td>
                                    <td><%=applist.getAppointmentDate()%></td>
                                    <td><%=applist.getEmail()%></td>
                                    <td><%=applist.getPhone()%></td>
                                    <td><%=applist.getDiseases()%></td>
                                    <td><%=applist.getStatus()%></td>
                                    <td>
                                        <%=daysUntil%> days
                                    </td>
                                </tr>
                                <%
                                    }
                                }
                                %>
                            </tbody>
                        </table>
                        <!-- end table for upcoming appointments list -->

                    </div>
                </div>
            </div>
        </div>
        <!-- End of Upcoming Appointments section -->

    </div>

</body>
</html>
