package com.kachikun.shop.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    private static final HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();

        config.setJdbcUrl(System.getenv().getOrDefault(
                "DB_URL",
                "jdbc:sqlserver://localhost:1433;databaseName=GamingGear;encrypt=true;trustServerCertificate=true;"
        ));
        config.setUsername(System.getenv().getOrDefault("DB_USER", "sa"));
        config.setPassword(System.getenv().getOrDefault("DB_PASS", "khanhnhay2k5vcl"));

        config.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        // Pool sizing
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(5);

        // Timeouts
        config.setConnectionTimeout(10_000);
        config.setIdleTimeout(300_000);
        config.setMaxLifetime(600_000);         // kết nối tối đa 10 phút
        config.setKeepaliveTime(60_000);        // ping DB mỗi 60s để tránh bị Azure ngủ
        config.setLeakDetectionThreshold(5_000);

        // Connection test
        //config.setConnectionTestQuery("SELECT 1");
        config.setPoolName("KachiKunPool");

        config.setInitializationFailTimeout(0);

        dataSource = new HikariDataSource(config);
        System.out.println("[HikariCP] Connection pool đã khởi động.");
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("DBConnection: HikariCP Connection Pool đã được đóng.");
        }
    }

    // Dùng cho DBConnection.main() test thủ công
    public static void main(String[] args) throws SQLException {
        System.out.println("Đang thử kết nối...");
        try (Connection c = getConnection()) {
            if (c != null && !c.isClosed()) {
                System.out.println("Kết nối thành công! Pool: " + dataSource.getPoolName());
            }
        }
    }
}