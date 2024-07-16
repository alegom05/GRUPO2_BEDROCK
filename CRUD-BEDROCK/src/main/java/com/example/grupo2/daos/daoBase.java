package com.example.grupo2.daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class daoBase {

    private static final String LOCALHOST = "localhost";
    private static final String IP_ADDRESS = "35.196.35.10"; // Reemplaza con la IP específica
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String DATABASE = "basededatos3";
    private static final int PORT = 3306;

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        SQLException lastException = null;

        // Intenta primero la conexión local
        try {
            return tryConnection(LOCALHOST);
        } catch (SQLException e) {
            lastException = e;
            // Si falla, intenta la conexión remota
            try {
                return tryConnection(IP_ADDRESS);
            } catch (SQLException e2) {
                lastException = e2;
            }
        }

        // Si ambas conexiones fallan, lanza la última excepción
        throw lastException;
    }

    private Connection tryConnection(String host) throws SQLException {
        String url = String.format("jdbc:mysql://%s:%d/%s", host, PORT, DATABASE);
        return DriverManager.getConnection(url, USERNAME, PASSWORD);
    }
}