package main.java.com.dao;

import main.java.com.model.Brand;
import main.java.com.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {
    
    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM Brand";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("brandId"));
                brand.setBrandName(rs.getString("brandName"));
                brands.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }
    
    public Brand getBrandById(int brandId) {
        Brand brand = null;
        String sql = "SELECT * FROM Brand WHERE brandId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, brandId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                brand = new Brand();
                brand.setBrandId(rs.getInt("brandId"));
                brand.setBrandName(rs.getString("brandName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brand;
    }
}