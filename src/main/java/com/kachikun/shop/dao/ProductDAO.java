package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Product;
import com.kachikun.shop.utils.DBConnection;
import com.kachikun.shop.model.Category;

public class ProductDAO {

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setImage(rs.getString("image"));
        p.setStock(rs.getInt("stock_quantity"));
        p.setConnectionType(rs.getString("connection_type"));
        p.setMaterial(rs.getString("material"));
        p.setSize(rs.getString("product_size"));

        Category c = new Category();
        c.setId(rs.getInt("category_id"));
        c.setName(rs.getString("cat_name"));
        p.setCategory(c);

        Brand b = new Brand();
        b.setId(rs.getInt("brand_id"));
        b.setName(rs.getString("brand_name"));
        p.setBrand(b);

        return p;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name " +
                "FROM Products p " +
                "INNER JOIN Categories c ON p.category_id = c.id " +
                "INNER JOIN Brands b ON p.brand_id = b.id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> findByCategoryName(String categoryName) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.* FROM Products p " + "INNER JOIN Categories c ON p.category_id = c.id "
                + "WHERE c.name LIKE ? ";

        try {
            Connection conn = new DBConnection().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, "%" + categoryName + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Category c = new Category();
                c.setId(rs.getInt("category_id"));

                Brand b = new Brand();
                b.setId(rs.getInt("brand_id"));

                Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"),
                        rs.getDouble("price"), rs.getString("image"), rs.getInt("stock_quantity"), b, c);
                list.add(p);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> findByName(String name) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name " +
                "FROM Products p " +
                "INNER JOIN Categories c ON p.category_id = c.id " +
                "INNER JOIN Brands b ON p.brand_id = b.id " +
                "WHERE p.name LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> pagingProduct(int index) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.id " + "LEFT JOIN Brands b ON p.brand_id = b.id "
                + "ORDER BY p.id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, (index - 1) * 3);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock_quantity"));
                p.setPrice(rs.getDouble("price"));

                Category c = new Category();
                c.setId(rs.getInt("category_id"));
                c.setName(rs.getString("cat_name"));
                p.setCategory(c);

                Brand b = new Brand();
                b.setId(rs.getInt("brand_id"));
                b.setName(rs.getString("brand_name"));
                b.setLogo(rs.getString("brand_logo"));
                p.setBrand(b);

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countProductsByCategory(String cateName) {
        String sql = "SELECT count(*) FROM Products p " + "INNER JOIN Categories c ON p.category_id = c.id "
                + "WHERE c.name LIKE ?";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + cateName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Product> pagingProductByCategory(String cateName, int index) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.id " + "LEFT JOIN Brands b ON p.brand_id = b.id "
                + "WHERE c.name LIKE ? " + "ORDER BY p.id OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + cateName + "%");
            ps.setInt(2, (index - 1) * 3);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setStock(rs.getInt("stock_quantity"));
                p.setPrice(rs.getDouble("price"));

                Category c = new Category();
                c.setId(rs.getInt("category_id"));
                c.setName(rs.getString("cat_name"));
                p.setCategory(c);

                Brand b = new Brand();
                b.setId(rs.getInt("brand_id"));
                b.setName(rs.getString("brand_name"));
                b.setLogo(rs.getString("brand_logo"));
                p.setBrand(b);

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductById(int id) {
        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name " +
                "FROM Products p " +
                "INNER JOIN Categories c ON p.category_id = c.id " +
                "INNER JOIN Brands b ON p.brand_id = b.id " +
                "WHERE p.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> filterProducts(String[] brandIds, String[] connections, String[] materials, String[] sizes,
                                        String category, int index, String sort) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, c.name as cat_name, b.name as brand_name, b.logo as brand_logo " +
                        "FROM Products p " +
                        "INNER JOIN Categories c ON p.category_id = c.id " +
                        "INNER JOIN Brands b ON p.brand_id = b.id WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (category != null && !category.isEmpty()) {
            sql.append(" AND c.name LIKE ?");
            params.add("%" + category + "%");
        }

        if (brandIds != null && brandIds.length > 0) {
            sql.append(" AND p.brand_id IN (");
            for (int i = 0; i < brandIds.length; i++) {
                sql.append("?");
                params.add(Integer.parseInt(brandIds[i]));
                if (i < brandIds.length - 1) sql.append(",");
            }
            sql.append(")");
        }

        if (connections != null && connections.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < connections.length; i++) {
                sql.append("p.connection_type LIKE ?");
                params.add("%" + connections[i] + "%");
                if (i < connections.length - 1) sql.append(" OR ");
            }
            sql.append(")");
        }

        if (materials != null && materials.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < materials.length; i++) {
                sql.append("p.material LIKE ?");
                params.add("%" + materials[i] + "%");
                if (i < materials.length - 1) sql.append(" OR ");
            }
            sql.append(")");
        }

        if (sizes != null && sizes.length > 0) {
            sql.append(" AND p.product_size IN (");
            for (int i = 0; i < sizes.length; i++) {
                sql.append("?");
                params.add(sizes[i]);
                if (i < sizes.length - 1) sql.append(",");
            }
            sql.append(")");
        }

        if ("price_asc".equals(sort)) {
            sql.append(" ORDER BY p.price ASC");
        } else if ("price_desc".equals(sort)) {
            sql.append(" ORDER BY p.price DESC");
        } else {
            sql.append(" ORDER BY p.id DESC");
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY");
        params.add((index - 1) * 3);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countFilteredProducts(String[] brandIds, String[] connections, String[] materials, String[] sizes,
                                     String category) {
        StringBuilder sql = new StringBuilder(
                "SELECT count(*) FROM Products p " +
                        "INNER JOIN Categories c ON p.category_id = c.id " +
                        "INNER JOIN Brands b ON p.brand_id = b.id WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (category != null && !category.isEmpty()) {
            sql.append(" AND c.name LIKE ?");
            params.add("%" + category + "%");
        }

        if (brandIds != null && brandIds.length > 0) {
            sql.append(" AND p.brand_id IN (");
            for (int i = 0; i < brandIds.length; i++) {
                sql.append("?");
                params.add(Integer.parseInt(brandIds[i]));
                if (i < brandIds.length - 1) sql.append(",");
            }
            sql.append(")");
        }

        if (connections != null && connections.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < connections.length; i++) {
                sql.append("p.connection_type LIKE ?");
                params.add("%" + connections[i] + "%");
                if (i < connections.length - 1) sql.append(" OR ");
            }
            sql.append(")");
        }

        if (materials != null && materials.length > 0) {
            sql.append(" AND (");
            for (int i = 0; i < materials.length; i++) {
                sql.append("p.material LIKE ?");
                params.add("%" + materials[i] + "%");
                if (i < materials.length - 1) sql.append(" OR ");
            }
            sql.append(")");
        }

        if (sizes != null && sizes.length > 0) {
            sql.append(" AND p.product_size IN (");
            for (int i = 0; i < sizes.length; i++) {
                sql.append("?");
                params.add(sizes[i]);
                if (i < sizes.length - 1) sql.append(",");
            }
            sql.append(")");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean insertProduct(Product p) {
        String sql = "INSERT INTO Products (name, description, price, image, stock_quantity, " +
                "category_id, brand_id, connection_type, material, size) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getImage());
            ps.setInt(5, p.getStock());
            ps.setInt(6, p.getCategory().getId());
            ps.setInt(7, p.getBrand().getId());
            ps.setString(8, p.getConnectionType());
            ps.setString(9, p.getMaterial());
            ps.setString(10, p.getSize());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Lỗi khi thêm sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM Products WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> getProductsByPage(int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT p.*, c.name as cat_name, b.name as brand_name " +
                "FROM Products p " +
                "INNER JOIN Categories c ON p.category_id = c.id " +
                "INNER JOIN Brands b ON p.brand_id = b.id " +
                "ORDER BY p.id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProduct(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) as total FROM Products";
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int total = rs.getInt("total");
                System.out.println("Total products in database: " + total);
                return total;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Error getting total products, returning 0");
        return 0;
    }
}