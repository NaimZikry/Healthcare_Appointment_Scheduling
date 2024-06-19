package com.hms.dao;

import com.hms.entity.Feedback;
import com.hms.db.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FeedbackDAO {
    private Connection conn;

    public FeedbackDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean saveOrUpdateFeedback(Feedback feedback) {
        boolean result = false;
        try {
            String query = "INSERT INTO feedback (appointment_id, comment) VALUES (?, ?) ON DUPLICATE KEY UPDATE comment = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, feedback.getAppointmentId());
            pstmt.setString(2, feedback.getComment());
            pstmt.setString(3, feedback.getComment());
            result = pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public Feedback getFeedbackByAppointmentId(int appointmentId) {
        Feedback feedback = null;
        try {
            String query = "SELECT * FROM feedback WHERE appointment_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, appointmentId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                feedback = new Feedback();
                feedback.setId(rs.getInt("id"));
                feedback.setAppointmentId(rs.getInt("appointment_id"));
                feedback.setComment(rs.getString("comment"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedback;
    }
}
