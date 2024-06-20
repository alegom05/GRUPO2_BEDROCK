package com.example.grupo2.daos;

import com.example.grupo2.Beans.NombreUsuario;

import java.sql.*;

public class NombreUsuarioDao {

    public NombreUsuario obtenerUsuarioPorId(int id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        NombreUsuario nombreUsuario = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3?serverTimezone=America/Lima";
        String username = "root";
        String password = "root";



        String sql = "SELECT i.idUsuario, i.nombre FROM usuario i WHERE i.idUsuario = ?";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    nombreUsuario = new NombreUsuario();
                    nombreUsuario.setIdUsuario(rs.getInt(1));
                    nombreUsuario.setNombreUsuario(rs.getString(2));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return nombreUsuario;
    }
}
