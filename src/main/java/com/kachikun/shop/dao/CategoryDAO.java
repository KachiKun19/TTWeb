package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.Category;
import com.kachikun.shop.utils.DBConnection;

public class CategoryDAO {

	public List<Category> getAllCategories() {
		List<Category> list = new ArrayList<>();
		String sql = "SELECT * FROM Categories";

		try {
			Connection conn = DBConnection.getConnection();

			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setIcon(rs.getString("icon"));
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public static void main(String[] args) {
		CategoryDAO dao = new CategoryDAO();
		List<Category> list = dao.getAllCategories();

		System.out.println("--- DANH SÁCH CATEGORY TỪ SQL ---");
		for (Category c : list) {
			System.out.println("ID: " + c.getId() + " | Tên: " + c.getName());
		}
	}

	public Category getCategoryById(int id) {
	    String sql = "SELECT * FROM Categories WHERE id = ?";
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            Category c = new Category();
	            c.setId(rs.getInt("id"));
	            c.setName(rs.getString("name"));
	            return c;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
}
