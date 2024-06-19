<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.entity.User"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
<%@page import="com.hms.dao.FeedbackDAO"%>
<%@page import="com.hms.entity.Feedback"%>
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
    <title>View Appointment Page</title>
    <!-- all css include -->
    <%@include file="../component/allcss.jsp"%>
    <!-- customs css for this page -->
    <style type="text/css">
        .my-card {
            box-shadow: 0px 0px 10px 1px green;
        }
        .my-bg-img {
            background: linear-gradient(rgba(0, 0, 0, .4), rgba(0, 0, 0, .4)),
            url("img/hospital1.jpg");
            height: 20vh;
            width: 100%;
            background-size: cover;
            background-repeat: no-repeat;
        }
    </style>
</head>
<body>
    <%@include file="component/navbar.jsp"%>
    <!-- if not login then log in first -->
    <c:if test="${empty userObj }">
        <c:redirect url="/user_login.jsp"></c:redirect>
    </c:if>
    <div class="container-fluid my-bg-img p-5">
        <p class="text-center fs-2 text-white"></p>
    </div>

    <div class="container-fluid p-3">
        <p class="fs-2"></p>
        <div class="row">
            <div class="col-md-9">
                <div class="card my-card">
                    <div class="card-body">
                        <p class="fw-bold text-center myP-color fs-4">Appointment List</p>
                        <table class="table table-striped">
                            <thead>
                                <tr class="my-bg-color text-white">
                                    <th scope="col">Full Name</th>
                                    <th scope="col">Gender</th>
                                    <th scope="col">Age</th>
                                    <th scope="col">Appointment Date</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Doctor Name</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                    <th scope="col">Comment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                User user = (User) session.getAttribute("userObj");
                                DoctorDAO dDAO = new DoctorDAO(DBConnection.getConn());
                                AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
                                FeedbackDAO fbDAO = new FeedbackDAO(DBConnection.getConn());

                                List<Appointment> list = appDAO.getAllAppointmentByLoginUser(user.getId());
                                for (Appointment apptList : list) {
                                    Doctor doctor = dDAO.getDoctorById(apptList.getDoctorId());
                                    Feedback feedback = fbDAO.getFeedbackByAppointmentId(apptList.getId());
                                %>
                                <tr>
                                    <td><%=apptList.getFullName()%></td>
                                    <td><%=apptList.getGender()%></td>
                                    <td><%=apptList.getAge()%></td>
                                    <td><%=apptList.getAppointmentDate()%></td>
                                    <td><%=apptList.getPhone()%></td>
                                    <td><%=apptList.getDiseases()%></td>
                                    <td><%=doctor.getFullName()%></td>
                                    <td>
                                        <%
                                        if ("Pending".equals(apptList.getStatus())) {
                                        %> <a href="" class="btn btn-sm btn-warning">Pending</a> <%
                                        } else {
                                        %> <%=apptList.getStatus()%> <%
                                        }
                                        %>
                                    </td>
                                    <td>
                                        <%
                                        if ("Pending".equals(apptList.getStatus())) {
                                        %>
                                        <a class="btn btn-sm btn-primary" href="edit_appointment.jsp?id=<%=apptList.getId()%>">Edit</a>
                                        <a class="btn btn-sm btn-danger" href="deleteAppointment?id=<%=apptList.getId()%>">Delete</a>
                                        <%
                                        }
                                        %>
                                    </td>
                                    <td>
                                        <%
                                        if (!"Pending".equals(apptList.getStatus())) {
                                        %>
                                            <form action="CommentServlet" method="post">
                                                <input type="hidden" name="appointmentId" value="<%=apptList.getId()%>">
                                                <input type="text" name="comment" value="<%=feedback != null ? feedback.getComment() : ""%>" required>
                                                <button type="submit" class="btn btn-sm btn-success">Submit</button>
                                            </form>
                                        <%
                                        }
                                        %>
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- New Card for Upcoming Appointment -->
                <div class="card my-card mt-3">
                    <div class="card-body">
                        <p class="fw-bold text-center myP-color fs-4">Upcoming Appointment</p>
                        <table class="table table-striped">
                            <thead>
                                <tr class="my-bg-color text-white">
                                    <th scope="col">Full Name</th>
                                    <th scope="col">Gender</th>
                                    <th scope="col">Age</th>
                                    <th scope="col">Appointment Date</th>
                                    <th scope="col">Phone</th>
                                    <th scope="col">Diseases</th>
                                    <th scope="col">Doctor Name</th>
                                    <th scope="col">Days Until Appointment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                LocalDate currentDate = LocalDate.now();
                                for (Appointment apptList : list) {
                                    if ("Pending".equals(apptList.getStatus())) {
                                        Doctor doctor = dDAO.getDoctorById(apptList.getDoctorId());
                                        LocalDate appointmentDate = LocalDate.parse(apptList.getAppointmentDate());
                                        long daysUntilAppointment = ChronoUnit.DAYS.between(currentDate, appointmentDate);
                                %>
                                <tr>
                                    <td><%=apptList.getFullName()%></td>
                                    <td><%=apptList.getGender()%></td>
                                    <td><%=apptList.getAge()%></td>
                                    <td><%=apptList.getAppointmentDate()%></td>
                                    <td><%=apptList.getPhone()%></td>
                                    <td><%=apptList.getDiseases()%></td>
                                    <td><%=doctor.getFullName()%></td>
                                    <td><%=daysUntilAppointment%> days</td>
                                </tr>
                                <%
                                    }
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- End of New Card for Upcoming Appointment -->
            </div>
        </div>
    </div>
</body>
</html>
