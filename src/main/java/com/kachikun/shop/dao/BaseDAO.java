package com.kachikun.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.kachikun.shop.utils.DBConnection;

public abstract class BaseDAO {
    protected Connection getConnection() throws Exception {
        return DBConnection.getConnection();
    }

    protected void closeQuietly(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            if (resource != null) {
                try {
                    resource.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
