package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.ContactMessage;
import com.kachikun.shop.utils.DBConnection;

public class ContactDAO {
    
    public boolean insertMessage(ContactMessage msg) {
        String sql = "INSERT INTO ContactMessages (full_name, email, phone, subject, message, status, created_at) VALUES (?, ?, ?, ?, ?, N'Chưa đọc', GETDATE())";
        
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, msg.getFullName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getPhone());
            ps.setString(4, msg.getSubject());
            ps.setString(5, msg.getMessage());
            
            int row = ps.executeUpdate();
            return row > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM ContactMessages ORDER BY created_at DESC";
        
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ContactMessage msg = new ContactMessage();
                msg.setId(rs.getInt("id"));
                msg.setFullName(rs.getString("full_name"));
                msg.setEmail(rs.getString("email"));
                msg.setPhone(rs.getString("phone"));
                msg.setSubject(rs.getString("subject"));
                msg.setMessage(rs.getString("message"));
                msg.setCreatedAt(rs.getTimestamp("created_at"));
                msg.setStatus(rs.getString("status"));
                list.add(msg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateStatus(int id, String status) {
        String sql = "UPDATE ContactMessages SET status = ? WHERE id = ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}