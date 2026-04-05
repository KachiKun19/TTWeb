package com.kachikun.shop.dao;

import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends BaseDAO {

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setImage(rs.getString("image"));
        product.setStock(rs.getInt("stock_quantity"));
        product.setSoldCount(rs.getInt("sold_count"));
        product.setAverageRating(rs.getDouble("average_rating"));
        product.setReviewCount(rs.getInt("review_count"));
        product.setConnectionType(rs.getString("connection_type"));
        product.setMaterial(rs.getString("material"));
        product.setSize(rs.getString("product_size"));

        Category category = new Category();
        category.setId(rs.getInt("category_id"));
        category.setName(rs.getString("cat_name"));
        product.setCategory(category);

        Brand brand = new Brand();
        brand.setId(rs.getInt("brand_id"));
        brand.setName(rs.getString("brand_name"));
        product.setBrand(brand);

        return product;
    }

    private Product mapProductWithLogo(ResultSet rs) throws SQLException {
        Product product = mapProduct(rs);
        product.getBrand().setLogo(rs.getString("brand_logo"));
        return product;
    }

    // lấy toàn bộ sản phẩm để panging cho adminProduct
    public List<Product> getAllProducts() {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name "
                + "FROM Products p "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "INNER JOIN Brands b ON p.brand_id = b.id";

        List<Product> productList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) productList.add(mapProduct(rs));

        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage());
            e.printStackTrace();
        }
        return productList;
    }

    //tìm bằng id
    public Product getProductById(int productId) {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name "
                + "FROM Products p "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "INNER JOIN Brands b ON p.brand_id = b.id "
                + "WHERE p.id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapProduct(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // search tên sp - loại sp
    public List<Product> findByName(String keyword) {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name "
                + "FROM Products p "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "INNER JOIN Brands b ON p.brand_id = b.id "
                + "WHERE p.name LIKE ? OR b.name LIKE ? OR c.name LIKE ?";

        List<Product> productList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) productList.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // search sp theo danh mục
    public List<Product> findByCategoryName(String categoryName) {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name "
                + "FROM Products p "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "INNER JOIN Brands b ON p.brand_id = b.id "
                + "WHERE c.name LIKE ?";

        List<Product> productList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + categoryName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) productList.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // chỉ lấy ra sản phẩm , ko lọc
    public List<Product> pagingProduct(int pageIndex) {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name, b.logo AS brand_logo "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.id "
                + "LEFT JOIN Brands b ON p.brand_id = b.id "
                + "ORDER BY p.id "
                + "OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";

        List<Product> productList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, (pageIndex - 1) * 3);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) productList.add(mapProductWithLogo(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // lấy sp theo trang trong danh mục
    public List<Product> pagingProductByCategory(String categoryName, int pageIndex) {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name, b.logo AS brand_logo "
                + "FROM Products p "
                + "LEFT JOIN Categories c ON p.category_id = c.id "
                + "LEFT JOIN Brands b ON p.brand_id = b.id "
                + "WHERE c.name LIKE ? "
                + "ORDER BY p.id "
                + "OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";

        List<Product> productList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + categoryName + "%");
            ps.setInt(2, (pageIndex - 1) * 3);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) productList.add(mapProductWithLogo(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // lấy sp theo trang
    public List<Product> getProductsByPage(int pageIndex, int pageSize) {
        String sql = "SELECT p.*, c.name AS cat_name, b.name AS brand_name "
                + "FROM Products p "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "INNER JOIN Brands b ON p.brand_id = b.id "
                + "ORDER BY p.id DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        List<Product> productList = new ArrayList<>();
        int offset = (pageIndex - 1) * pageSize;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) productList.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }


    public List<Product> filterProducts(String[] brandIds, String[] connections,
                                        String[] materials, String[] sizes,
                                        String category, int pageIndex, String sort) {
        List<Object> params = new ArrayList<>();
        String sql = buildFilterSql(false, brandIds, connections, materials, sizes,
                category, sort, pageIndex, params);

        List<Product> productList = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement ps = bindParams(conn.prepareStatement(sql), params);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) productList.add(mapProduct(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    public int countFilteredProducts(String[] brandIds, String[] connections,
                                     String[] materials, String[] sizes,
                                     String category) {
        List<Object> params = new ArrayList<>();
        String sql = buildFilterSql(true, brandIds, connections, materials, sizes,
                category, null, 0, params);

        try (Connection conn = getConnection();
             PreparedStatement ps = bindParams(conn.prepareStatement(sql), params);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private String buildFilterSql(boolean isCount,
                                  String[] brandIds, String[] connections,
                                  String[] materials, String[] sizes,
                                  String category, String sort,
                                  int pageIndex, List<Object> params) {
        StringBuilder sql = new StringBuilder();

        if (isCount) {
            sql.append("SELECT COUNT(*) FROM Products p ");
        } else {
            sql.append("SELECT p.*, c.name AS cat_name, b.name AS brand_name, b.logo AS brand_logo ");
            sql.append("FROM Products p ");
        }

        sql.append("INNER JOIN Categories c ON p.category_id = c.id ");
        sql.append("INNER JOIN Brands b ON p.brand_id = b.id ");
        sql.append("WHERE 1=1 ");

        // Lọc theo danh mục
        if (category != null && !category.isEmpty()) {
            sql.append("AND c.name LIKE ? ");
            params.add("%" + category + "%");
        }

        // Lọc theo thương hiệu
        if (brandIds != null && brandIds.length > 0) {
            sql.append("AND p.brand_id IN (");
            for (int i = 0; i < brandIds.length; i++) {
                sql.append(i > 0 ? ",?" : "?");
                params.add(Integer.parseInt(brandIds[i]));
            }
            sql.append(") ");
        }

        // Lọc theo loại kết nối
        if (connections != null && connections.length > 0) {
            sql.append("AND (");
            for (int i = 0; i < connections.length; i++) {
                sql.append(i > 0 ? " OR p.connection_type LIKE ?" : "p.connection_type LIKE ?");
                params.add("%" + connections[i] + "%");
            }
            sql.append(") ");
        }

        // Lọc theo chất liệu
        if (materials != null && materials.length > 0) {
            sql.append("AND (");
            for (int i = 0; i < materials.length; i++) {
                sql.append(i > 0 ? " OR p.material LIKE ?" : "p.material LIKE ?");
                params.add("%" + materials[i] + "%");
            }
            sql.append(") ");
        }

        // Lọc theo kích thước
        if (sizes != null && sizes.length > 0) {
            sql.append("AND p.product_size IN (");
            for (int i = 0; i < sizes.length; i++) {
                sql.append(i > 0 ? ",?" : "?");
                params.add(sizes[i]);
            }
            sql.append(") ");
        }

        if (!isCount) {
            if ("price_asc".equals(sort)) {
                sql.append("ORDER BY p.price ASC ");
            } else if ("price_desc".equals(sort)) {
                sql.append("ORDER BY p.price DESC ");
            } else {
                sql.append("ORDER BY p.id DESC ");
            }
            sql.append("OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY");
            params.add((pageIndex - 1) * 3);
        }

        return sql.toString();
    }


    private PreparedStatement bindParams(PreparedStatement ps, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        return ps;
    }


    // Đếm tổng sp để tính tổng trang ở admin
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) AS total FROM Products";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt("total");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    //Đếm sp trong danh mục để tính số trang lọc theo danh mục
    public int countProductsByCategory(String categoryName) {
        String sql = "SELECT COUNT(*) FROM Products p "
                + "INNER JOIN Categories c ON p.category_id = c.id "
                + "WHERE c.name LIKE ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + categoryName + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    //thêm sp vào database
    public boolean insertProduct(Product product) {
        String sql = "INSERT INTO Products "
                + "(name, description, price, image, stock_quantity, "
                + " category_id, brand_id, connection_type, material, size) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setInt(5, product.getStock());
            ps.setInt(6, product.getCategory().getId());
            ps.setInt(7, product.getBrand().getId());
            ps.setString(8, product.getConnectionType());
            ps.setString(9, product.getMaterial());
            ps.setString(10, product.getSize());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Lỗi khi thêm sản phẩm: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // xóa sp
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM Products WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

