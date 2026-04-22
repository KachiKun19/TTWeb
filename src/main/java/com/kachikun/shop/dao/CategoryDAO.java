package com.kachikun.shop.dao;

import com.kachikun.shop.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO xử lý tất cả thao tác với bảng Categories.
 */
public class CategoryDAO extends BaseDAO {

    /**
     * Chuyển đổi một hàng ResultSet thành đối tượng Category.
     */
    private Category mapCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setIcon(rs.getString("icon"));
        return category;
    }

    /**
     * Lấy toàn bộ danh sách danh mục sản phẩm.
     */
    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM Categories";
        List<Category> categoryList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categoryList.add(mapCategory(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryList;
    }

    /**
     * Tìm danh mục theo ID.
     */
    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM Categories WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCategory(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}