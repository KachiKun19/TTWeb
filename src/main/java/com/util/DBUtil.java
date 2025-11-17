package main.java.com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	private static final String DB_ServerName = "TP\\\\ASUKA";
	private static final String DB_Login = "sa";
	private static final String DB_Password = "tranhung2005";
	private static final String DB_DatabaseName = "GamingGear";

	public static Connection getConnection() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String DB_URL = "jdbc:sqlserver://" + DB_ServerName + ":1433" + ";databaseName=" + DB_DatabaseName
					+ "; encrypt=true;trustServerCertificate=true;";

			return DriverManager.getConnection(DB_URL, DB_Login, DB_Password);
		} catch (ClassNotFoundException e) {
			System.err.println("❌ Không tìm thấy driver JDBC!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.err.println("❌ Lỗi khi kết nối SQL Server:");
			e.printStackTrace();
		}
		return null;
	}
}
