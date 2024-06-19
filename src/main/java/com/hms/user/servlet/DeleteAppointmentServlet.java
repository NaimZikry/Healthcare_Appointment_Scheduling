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

@WebServlet("/deleteAppointment")
public class DeleteAppointmentServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//get id(which is coming as string value) and convert into int	
		int id = Integer.parseInt(req.getParameter("id"));
		
		AppointmentDAO appDAO = new AppointmentDAO(DBConnection.getConn());
		HttpSession session = req.getSession();
		
		boolean f = appDAO.deleteAppointmentById(id);
		
		if(f==true) {
			session.setAttribute("successMsg", "Appointment Deleted Successfully.");
			resp.sendRedirect("view_appointment.jsp");
		}
		else {
			session.setAttribute("errorMsg", "Something went wrong on server!");
			resp.sendRedirect("view_appointment.jsp");
		}
	}
	
	

}
