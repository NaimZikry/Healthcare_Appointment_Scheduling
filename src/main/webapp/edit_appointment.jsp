<%@page import="com.hms.entity.Doctor"%>
<%@page import="com.hms.entity.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="com.hms.db.DBConnection"%>
<%@page import="com.hms.dao.DoctorDAO"%>
<%@page import="com.hms.dao.AppointmentDAO"%>
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
    <title>Edit Appointment Page</title>
    <%@include file="../component/allcss.jsp"%>

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

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card my-card">
                    <div class="card-body">
                        <p class="text-center fs-3">Edit Appointment Details</p>

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

                        <%
                            int id = Integer.parseInt(request.getParameter("id"));
                            AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
                            Appointment appointment = appDAO.getAppointmentById(id);
                        %>

                        <!-- boostrap form -->
                        <form class="row g-3" action="updateAppointment" method="post">

                            <!-- take appointment Id in hidden field -->
                            <input type="hidden" name="appointmentId" value="<%= appointment.getId() %>">

                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input required="required" name="fullName" type="text" placeholder="Enter full name" class="form-control" value="<%= appointment.getFullName() %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Gender</label>
                                <select class="form-control" name="gender" required="required">
                                    <option disabled="disabled">---Select Gender---</option>
                                    <option value="male" <%= appointment.getGender().equals("male") ? "selected" : "" %>>Male</option>
                                    <option value="female" <%= appointment.getGender().equals("female") ? "selected" : "" %>>Female</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Age</label>
                                <input name="age" required="required" type="number" placeholder="Enter your Age" class="form-control" value="<%= appointment.getAge() %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Appointment Date</label>
                                <input required="required" name="appointmentDate" type="date" class="form-control" value="<%= appointment.getAppointmentDate() %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input name="email" required="required" type="email" placeholder="Enter email" class="form-control" value="<%= appointment.getEmail() %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Phone</label>
                                <input name="phone" required="required" type="number" maxlength="11" placeholder="Enter Mobile no." class="form-control" value="<%= appointment.getPhone() %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Diseases</label>
                                <input required="required" name="diseases" type="text" placeholder="Enter diseases" class="form-control" value="<%= appointment.getDiseases() %>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Doctor</label>
                                <select required="required" class="form-control" name="doctorNameSelect">
                                    <option selected="selected" disabled="disabled">---Select---</option>
                                    <%
                                    DoctorDAO doctorDAO = new DoctorDAO(DBConnection.getConn());
                                    List<Doctor> listOfDoctor = doctorDAO.getAllDoctor();
                                    for (Doctor d : listOfDoctor) {
                                    %>
                                        <option value="<%= d.getId() %>" <%= d.getId() == appointment.getDoctorId() ? "selected" : "" %>> <%= d.getFullName() %> (<%= d.getSpecialist() %>) </option>
                                    <%
                                    }
                                    %>
                                </select>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Full Address</label>
                                <textarea name="address" required="required" class="form-control" rows="3"><%= appointment.getAddress() %></textarea>
                            </div>

                            <div class="col-md-12">
                                <button type="submit" class="btn my-bg-color text-white col-md-12">Update</button>
                            </div>
                        </form>
                        <!-- end of boostrap form -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
