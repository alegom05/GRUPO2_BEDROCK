package com.example.grupo2.daos;

import com.example.grupo2.Beans.DetallesIncidencia;

import java.util.ArrayList;
import java.sql.*;

public class DetallesIncidenciaDao {

    public static ArrayList<DetallesIncidencia> listarDetalles() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<DetallesIncidencia> listaDetalles = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?serverTimezone=America/Lima";
        String username = "root";
        String password = "root";

        String sql = "select i.nombre, i.descripcion, i.lugar, i.referencia, t.nombre, i.contacto, i.requiereAmbulancia, concat(u.nombre, ' ', u.apellido) as usuario, i.foto\n" +
                "from incidencia i\n" +
                "join usuario u on u.idUsuario = i.idUsuario\n" +
                "join tipo t on i.idUsuario=u.idUsuario\n" +
                "and i.idtipo=t.idtipo;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                DetallesIncidencia detallesIncidencia = new DetallesIncidencia();
                detallesIncidencia.setNombreIncidencia(rs.getString(1));
                detallesIncidencia.setDescripcion(rs.getString(2));
                detallesIncidencia.setLugar(rs.getString(3));
                detallesIncidencia.setReferencia(rs.getString(4));
                detallesIncidencia.setTipoIncidencia(rs.getString(5));
                detallesIncidencia.setContacto(rs.getString(6));
                detallesIncidencia.setRequiereAmbulancia(rs.getInt(7));
                detallesIncidencia.setUsuario(rs.getString(8));
                detallesIncidencia.setFoto(rs.getBytes(9));

                listaDetalles.add(detallesIncidencia);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaDetalles;
    }

    public DetallesIncidencia obtenerIncidenciaPorId(int id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        DetallesIncidencia incidencia = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3?serverTimezone=America/Lima";
        String username = "root";
        String password = "root";

        String sql = "select i.idIncidenciaReportada, i.nombre, i.descripcion, i.lugar, i.referencia, t.nombre as tipo, i.contacto, i.requiereAmbulancia, concat(u.nombre, ' ', u.apellido) as usuario, i.foto " +
                "from incidencia i " +
                "join usuario u on u.idUsuario = i.idUsuario " +
                "join tipo t on i.idtipo = t.idtipo " +
                "where i.idIncidenciaReportada = ?";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    incidencia = new DetallesIncidencia();
                    incidencia.setIdIncidencia(rs.getInt(1));
                    incidencia.setNombreIncidencia(rs.getString(2));
                    incidencia.setDescripcion(rs.getString(3));
                    incidencia.setLugar(rs.getString(4));
                    incidencia.setReferencia(rs.getString(5));
                    incidencia.setTipoIncidencia(rs.getString(6));
                    incidencia.setContacto(rs.getString(7));
                    incidencia.setRequiereAmbulancia(rs.getInt(8));
                    incidencia.setUsuario(rs.getString(9));
                    incidencia.setFoto(rs.getBytes(10));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return incidencia;
    }
}
