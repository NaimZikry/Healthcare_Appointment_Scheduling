package com.hms.servlet;

import com.hms.dao.FeedbackDAO;
import com.hms.db.DBConnection;
import com.hms.entity.Feedback;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String comment = request.getParameter("comment");

        Feedback feedback = new Feedback();
        feedback.setAppointmentId(appointmentId);
        feedback.setComment(comment);

        FeedbackDAO fbDAO = new FeedbackDAO(DBConnection.getConn());
        boolean result = fbDAO.saveOrUpdateFeedback(feedback);

        if (result) {
            response.sendRedirect("view_appointment.jsp");
        } else {
            response.getWriter().println("Failed to submit comment");
        }
    }
}
