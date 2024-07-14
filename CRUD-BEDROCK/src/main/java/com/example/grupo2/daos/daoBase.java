package com.example.grupo2.daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class daoBase {

    private static final boolean USE_LOCALHOST = true; // Cambia a false para usar una IP específica
    private static final String IP_ADDRESS = "34.148.147.86"; // Reemplaza con la IP específica
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String DATABASE = "basededatos3";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String url;
        if (USE_LOCALHOST) {
            url = "jdbc:mysql://localhost:3306/" + DATABASE;
        } else {
            url = "jdbc:mysql://" + IP_ADDRESS + ":3306/" + DATABASE;
        }

        return DriverManager.getConnection(url, USERNAME, PASSWORD);
    }
}