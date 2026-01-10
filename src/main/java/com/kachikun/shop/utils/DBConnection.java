package com.kachikun.shop.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String DB_URL = "jdbc:sqlserver://localhost:1433;" + "databaseName=GamingGear;"
			+ "encrypt=true;trustServerCertificate=true;";
	private static final String USER = "sa";
	private static final String PASS = "tranhung2005";

	// Hàm lấy kết nối
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

			conn = DriverManager.getConnection(DB_URL, USER, PASS);

		} catch (ClassNotFoundException e) {
			System.out.println("Lỗi: Không tìm thấy Driver SQL Server!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("Lỗi: Không thể kết nối Database!");
			e.printStackTrace();
		}
		return conn;
	}

	public static void main(String[] args) {
		System.out.println("Đang thử kết nối...");
		Connection c = getConnection();
		if (c != null) {
			System.out.println("Kết nối thành công! (SQL Server)");
		} else {
			System.out.println("Kết nối thất bại.");
		}
	}
}