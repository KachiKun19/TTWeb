package com.kachikun.shop.dao;

import com.kachikun.shop.model.Reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static com.kachikun.shop.utils.DBConnection.getConnection;

public class ReplyDAO {
    public List<Reply> getRepliesByUser(String email) {
        List<Reply> list = new ArrayList<>();
        String sql = "SELECT c.id, c.subject, c.message, r.reply_message, r.reply_date FROM ContactMessages c LEFT JOIN AdminReplies r ON c.id = r.contact_id  WHERE c.email = ? ORDER BY r.reply_date DESC";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reply r = new Reply();
                r.setContactId(rs.getInt("id"));
                r.setSubject(rs.getString("subject"));
                r.setMessage(rs.getString("message"));
                r.setReplyMessage(rs.getString("reply_message"));
                r.setReplyDate(rs.getTimestamp("reply_date"));

                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countUnread(String email) {
        String sql = "SELECT COUNT(*) FROM AdminReplies r JOIN ContactMessages c ON r.contact_id = c.id WHERE c.email = ? AND r.is_read = 0";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void markAsRead(String email) {
        String sql = " UPDATE AdminReplies SET is_read = 1 WHERE contact_id IN( SELECT id FROM ContactMessages WHERE email = ?)";
        try {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
