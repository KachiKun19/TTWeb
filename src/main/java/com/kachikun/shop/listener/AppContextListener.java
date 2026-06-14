package com.kachikun.shop.listener;

import com.kachikun.shop.utils.AppCache;
import com.kachikun.shop.utils.DBConnection;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

@WebListener
public class AppContextListener implements ServletContextListener {

    private static final Logger log = Logger.getLogger(AppContextListener.class.getName());
    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        log.info("[Lifecycle] Ứng dụng đang khởi động... Tiến hành nạp dữ liệu Cache hệ thống.");

        //  Kiểm tra cấu hình Azure/Môi trường trước khi chạy
        if (System.getenv("DB_URL") == null) {
            log.severe("[Lifecycle] ⚠️ CẢNH BÁO: Biến môi trường DB_URL chưa được cấu hình trên Azure Portal!");
        }

        // warmup DB pool
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                log.info("[Lifecycle] DB pool warmup thành công.");
            }
        } catch (Exception e) {
            log.warning("[Lifecycle] DB pool warmup thất bại: " + e.getMessage());
        }

        // nạp dữ liệu lần đầu ngay khi bật App
        AppCache.refreshCategories();
        AppCache.refreshBrands();

        // khởi tạo luồng chạy ngầm cập nhật định kỳ
        scheduler = Executors.newSingleThreadScheduledExecutor(r -> {
            Thread t = new Thread(r, "AppCache-Background-Worker");
            t.setDaemon(true);
            return t;
        });

        scheduler.scheduleAtFixedRate(() -> {
            log.info("[Lifecycle] Đang chạy tác vụ làm mới dữ liệu định kỳ ngầm...");
            AppCache.refreshCategories();
            AppCache.refreshBrands();
        }, 10, 10, TimeUnit.MINUTES);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        log.info("[Lifecycle] 🛑 Ứng dụng đang tắt... Đang dọn dẹp tài nguyên.");

        // Hủy luồng ngầm một cách an toàn khi ứng dụng dừng để tránh rò rỉ bộ nhớ
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            try {
                if (!scheduler.awaitTermination(3, TimeUnit.SECONDS)) {
                    scheduler.shutdownNow();
                }
                log.info("[Lifecycle] Luồng ngầm AppCache-Background-Worker đã dừng hoàn toàn.");
            } catch (InterruptedException e) {
                scheduler.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
    }
}