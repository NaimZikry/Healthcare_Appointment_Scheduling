package com.hms.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hms.dao.AppointmentDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Appointment;

@WebServlet("/updateAppointment")
public class UpdateAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            // Get all data from the request
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
            String fullName = req.getParameter("fullName");
            String gender = req.getParameter("gender");
            int age = Integer.parseInt(req.getParameter("age"));
            String appointmentDate = req.getParameter("appointmentDate");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String diseases = req.getParameter("diseases");
            int doctorId = Integer.parseInt(req.getParameter("doctorNameSelect"));
            String address = req.getParameter("address");

            // Create Appointment object with the new data
            Appointment appointment = new Appointment(appointmentId, fullName, gender, age, appointmentDate, email, phone, diseases, doctorId, address);

            // Get the DAO and update the appointment
            AppointmentDAO appointmentDAO = new AppointmentDAO(DBConnection.getConn());
            boolean isUpdated = appointmentDAO.updateAppointment(appointment);

            // Get the session and set the message
            HttpSession session = req.getSession();

            if (isUpdated) {
                session.setAttribute("successMsg", "Appointment updated successfully");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on server!");
            }

            // Redirect back to the edit appointment page
            resp.sendRedirect("edit_appointment.jsp?id=" + appointmentId);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
