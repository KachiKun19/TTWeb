package main.java.com.test;

import java.sql.Connection;

import main.java.com.util.DBUtil;


public class TestConnection {
	 public static void main(String[] args) {
	        Connection con = DBUtil.getConnection();
	        if (con != null) {
	            System.out.println("✅ Kết nối thành công!");
	        } else {
	            System.out.println("❌ Kết nối thất bại!");
	        }
	    }
}
