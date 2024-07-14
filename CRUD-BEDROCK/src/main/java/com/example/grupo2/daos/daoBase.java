package com.example.grupo2.daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class daoBase {

    public Connection getConnection(boolean useLocalhost) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            //e.printStackTrace();
            throw new RuntimeException(e);
        }

        String username = "root";
        String password = "root";
        String database = "basededatos3";
        String url;

        if (useLocalhost) {
            url = "jdbc:mysql://localhost:3306/" + database;
        } else {
            String ip = "http://34.148.147.86/"; // Reemplaza con la IP específica que deseas usar
            url = "jdbc:mysql://" + ip + ":3306/" + database;
        }

        return DriverManager.getConnection(url, username, password);
    }
}