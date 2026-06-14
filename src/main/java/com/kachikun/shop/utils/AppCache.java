package com.kachikun.shop.utils;

import com.kachikun.shop.dao.BrandDAO;
import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.dao.DiscountDAO;
import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Category;
import com.kachikun.shop.model.Discount;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppCache {

    private static final Logger log = Logger.getLogger(AppCache.class.getName());

    private static volatile List<Category> cachedCategories  = null;
    private static volatile List<Brand> cachedBrands         = null;

    // Áp dụng double-checked locking để tự động nạp lại an toàn khi trống
    public static List<Category> getCategories() {
        if (cachedCategories == null || cachedCategories.isEmpty()) {
            synchronized (AppCache.class) {
                if (cachedCategories == null || cachedCategories.isEmpty()) {
                    try {
                        log.info("[AppCache] Cache Categories trống, tự động nạp từ Database...");
                        List<Category> fresh = new CategoryDAO().getAllCategories();
                        if (fresh != null && !fresh.isEmpty()) {
                            cachedCategories = Collections.unmodifiableList(fresh);
                            log.info("[AppCache] Tự động nạp Categories thành công, số lượng: " + fresh.size());
                        }
                    } catch (Throwable e) {
                        log.log(Level.SEVERE, "[AppCache] Tự động nạp Categories THẤT BẠI!", e);
                    }
                }
            }
        }
        return cachedCategories != null ? cachedCategories : Collections.emptyList();
    }

    // áp dụng double check giống trên
    public static List<Brand> getBrands() {
        if (cachedBrands == null || cachedBrands.isEmpty()) {
            synchronized (AppCache.class) {
                if (cachedBrands == null || cachedBrands.isEmpty()) {
                    try {
                        log.info("[AppCache] Cache Brands trống, tự động nạp từ Database...");
                        List<Brand> fresh = new BrandDAO().getAllBrands();
                        if (fresh != null && !fresh.isEmpty()) {
                            cachedBrands = Collections.unmodifiableList(fresh);
                            log.info("[AppCache] Tự động nạp Brands thành công, số lượng: " + fresh.size());
                        }
                    } catch (Throwable e) {
                        log.log(Level.SEVERE, "[AppCache] Tự động nạp Brands THẤT BẠI!", e);
                    }
                }
            }
        }
        return cachedBrands != null ? cachedBrands : Collections.emptyList();
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

    private static volatile List<Discount> cachedDiscounts = new ArrayList<>();

    public static void refreshDiscounts() {
        cachedDiscounts = new DiscountDAO().getActiveDiscounts();
    }

    public static List<Discount> getDiscounts() {
        return cachedDiscounts;
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