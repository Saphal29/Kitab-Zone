package com.libsquad.lms.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnectionUtil {
    private static String url;
    private static String user;
    private static String password;

    static {
        try (InputStream inputStream = DatabaseConnectionUtil.class.getClassLoader().getResourceAsStream("database.properties")) {
            Properties property = new Properties();
            property.load(inputStream);

            Class.forName(property.getProperty("database.driver"));
            url = property.getProperty("database.url");
            user = property.getProperty("database.username");
            password = property.getProperty("database.password");
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
