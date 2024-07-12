package com.example.grupo2.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ResgistroDao extends daoBase{

    // Método para obtener el idUsuario a partir del DNI
    public String obtenerIdUsuario(String dni) throws SQLException {
        String idUsuario = null;
        String sql = "SELECT idUsuario FROM usuario WHERE dni = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dni);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    idUsuario = rs.getString("idUsuario");
                }
            }
        }
        return idUsuario;
    }


    public void crearSolicitudVecino(String idUsuario) throws SQLException {

        String sql = "INSERT INTO solicitudes (usuario_idUsuario) "
                + "VALUES (?)";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setString(1, idUsuario);
            pstmt.executeUpdate();
        }
    }

}
