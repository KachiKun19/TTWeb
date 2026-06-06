package com.kachikun.shop.utils;

import com.kachikun.shop.dao.BrandDAO;
import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Category;

import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppCache {

    private static final Logger log = Logger.getLogger(AppCache.class.getName());

    // Khởi tạo danh sách trống mặc định
    private static volatile List<Category> cachedCategories  = Collections.emptyList();
    private static volatile List<Brand> cachedBrands         = Collections.emptyList();

    public static List<Category> getCategories() {
        return cachedCategories;
    }

    public static List<Brand> getBrands() {
        return cachedBrands;
    }

    // Hàm làm mới danh sách Categories do Listener hoặc Admin gọi
    public static synchronized void refreshCategories() {
        try {
            log.info("[AppCache] Đang làm mới danh sách Categories từ Database...");
            List<Category> fresh = new CategoryDAO().getAllCategories();
            cachedCategories     = Collections.unmodifiableList(fresh);
            log.info("[AppCache] Cập nhật Categories thành công, số lượng: " + fresh.size());
        } catch (Throwable e) {
            log.log(Level.SEVERE, "[AppCache] THẤT BẠI khi cập nhật Categories! Đang giữ lại dữ liệu cũ.", e);
        }
    }

    // Hàm làm mới danh sách Brands do Listener hoặc Admin gọi
    public static synchronized void refreshBrands() {
        try {
            log.info("[AppCache] Đang làm mới danh sách Brands từ Database...");
            List<Brand> fresh = new BrandDAO().getAllBrands();
            cachedBrands      = Collections.unmodifiableList(fresh);
            log.info("[AppCache] Cập nhật Brands thành công, số lượng: " + fresh.size());
        } catch (Throwable e) {
            log.log(Level.SEVERE, "[AppCache] THẤT BẠI khi cập nhật Brands! Đang giữ lại dữ liệu cũ.", e);
        }
    }
}