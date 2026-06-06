package com.kachikun.shop.utils;

import com.kachikun.shop.dao.BrandDAO;
import com.kachikun.shop.dao.CategoryDAO;
import com.kachikun.shop.model.Brand;
import com.kachikun.shop.model.Category;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppCache {

    private static final Logger log = Logger.getLogger(AppCache.class.getName());

    private static volatile List<Category> cachedCategories  = Collections.emptyList();
    private static volatile long categoryLastLoaded          = 0L;

    private static volatile List<Brand> cachedBrands         = Collections.emptyList();
    private static volatile long brandLastLoaded             = 0L;

    private static final long TTL_MS = 10 * 60 * 1000L; // 10 phút

    private static final ScheduledExecutorService scheduler =
            Executors.newSingleThreadScheduledExecutor(r -> {
                Thread t = new Thread(r, "AppCache-Refresh");
                t.setDaemon(true);
                return t;
            });

    static {
        refreshCategories();
        refreshBrands();

        //refresh định kỳ
        scheduler.scheduleAtFixedRate(() -> {
            refreshCategories();
            refreshBrands();
        }, 10, 10, TimeUnit.MINUTES);
    }

    // lấy category

    public static List<Category> getCategories() {
        if (System.currentTimeMillis() - categoryLastLoaded > TTL_MS) {
            refreshCategories();
        }
        return cachedCategories;
    }

    public static void invalidateCategories() {
        categoryLastLoaded = 0L;
        log.info("AppCache: Categories invalidated.");
    }

    // lấy brands
    public static List<Brand> getBrands() {
        if (System.currentTimeMillis() - brandLastLoaded > TTL_MS) {
            refreshBrands();
        }
        return cachedBrands;
    }

    public static void invalidateBrands() {
        brandLastLoaded = 0L;
        log.info("AppCache: Brands invalidated.");
    }

    // refresh

    private static synchronized void refreshCategories() {
        try {
            List<Category> fresh = new CategoryDAO().getAllCategories();
            cachedCategories     = Collections.unmodifiableList(fresh);
            categoryLastLoaded   = System.currentTimeMillis();
            log.info("AppCache: Categories refreshed, count=" + fresh.size());
        } catch (Exception e) {
            log.log(Level.WARNING, "AppCache: Không thể refresh categories, giữ cache cũ.", e);
        }
    }

    private static synchronized void refreshBrands() {
        try {
            List<Brand> fresh = new BrandDAO().getAllBrands();
            cachedBrands      = Collections.unmodifiableList(fresh);
            brandLastLoaded   = System.currentTimeMillis();
            log.info("AppCache: Brands refreshed, count=" + fresh.size());
        } catch (Exception e) {
            log.log(Level.WARNING, "AppCache: Không thể refresh brands, giữ cache cũ.", e);
        }
    }

    public static void shutdown() {
        try {
            log.info("AppCache: Đang tắt scheduler ngầm...");
            scheduler.shutdown();
            if (!scheduler.awaitTermination(5, TimeUnit.SECONDS)) {
                scheduler.shutdownNow();
            }
            log.info("AppCache: Scheduler đã dừng hẳn.");
        } catch (InterruptedException e) {
            scheduler.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }
}