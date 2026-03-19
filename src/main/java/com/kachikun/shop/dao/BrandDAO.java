package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.utils.DBConnection;

public class BrandDAO {
	public List<Brand> getAllBrands()	{
		List<Brand> list = new ArrayList<>();
		String sql = "SELECT * FROM brands";
		
		try {
			Connection conn = DBConnection.getConnection();
			
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Brand b = new Brand();
				b.setId(rs.getInt("id"));
				b.setName(rs.getString("name"));
				b.setLogo(rs.getString("logo"));
				
				list.add(b);
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public Brand getBrandById(int id) {
	    String sql = "SELECT * FROM Brands WHERE id = ?";
	    try {
	        Connection conn = DBConnection.getConnection();
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            Brand b = new Brand();
	            b.setId(rs.getInt("id"));
	            b.setName(rs.getString("name"));
	            b.setLogo(rs.getString("logo"));
	            return b;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	public static void main(String[] args) {
		BrandDAO dao = new BrandDAO();
		List<Brand> list = dao.getAllBrands();
		
		for(Brand b : list) {
			System.out.println(b.getId() + " | " + b.getName() + " - Logo: " + b.getLogo());
		}
	}
}
