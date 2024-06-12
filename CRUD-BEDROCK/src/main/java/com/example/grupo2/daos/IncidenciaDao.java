package com.example.grupo2.daos;


import com.example.grupo2.Beans.CantidadIncidencias;
import com.example.grupo2.Beans.Incidencia;

import java.util.ArrayList;
import java.sql.*;
public class IncidenciaDao {

    public static ArrayList<Incidencia> listarIncidencias() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Incidencia> listaIncidencias = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "select i.idIncidenciaReportada, i.nombre , t.nombre as tipoIncidencia, i.estadoIncidencia ,concat(u.nombre,' ',u.apellido) , u.correo, i.fecha, i.lugar\n" +
                "from incidencia i\n" +
                "join usuario u on u.idUsuario=i.idUsuario\n" +
                "join tipo t on i.idtipo = t.idtipo;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Incidencia incidencia = new Incidencia();
                incidencia.setIdIncidencia(rs.getInt(1));
                incidencia.setNombreIncidencia(rs.getString(2));
                incidencia.setTipoIncidencia(rs.getString(3));
                incidencia.setEstadoIncidencia(rs.getString(4));
                incidencia.setNombreUsuario(rs.getString(5));
                incidencia.setCorreoUsuario(rs.getString(6));
                incidencia.setFecha(rs.getDate(7));
                incidencia.setLugar(rs.getString(8));


                listaIncidencias.add(incidencia);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaIncidencias);
        return listaIncidencias;
    }

    public Incidencia obtenerIncidenciaPorId(int id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        Incidencia incidencia = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        String sql = "select i.idIncidenciaReportada, i.nombre, i.descripcion, i.lugar, i.referencia, t.nombre as tipo, i.contacto, i.requiereAmbulancia, concat(u.nombre, ' ', u.apellido) as usuario, i.foto, i.fecha " +
                "from incidencia i " +
                "join usuario u on u.idUsuario = i.idUsuario " +
                "join tipo t on i.idtipo = t.idtipo " +
                "where i.idIncidenciaReportada = ?";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    incidencia = new Incidencia();
                    incidencia.setIdIncidencia(rs.getInt(1));
                    incidencia.setNombreIncidencia(rs.getString(2));
                    incidencia.setDescripcion(rs.getString(3));
                    incidencia.setLugar(rs.getString(4));
                    incidencia.setReferencia(rs.getString(5));
                    incidencia.setTipoIncidencia(rs.getString(6));
                    incidencia.setContacto(rs.getString(7));
                    incidencia.setRequiereAmbulancia(rs.getBoolean(8));
                    incidencia.setUsuario(rs.getString(9));
                    incidencia.setFotoIncidencia(rs.getBytes(10));
                    incidencia.setFecha(rs.getDate(11));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return incidencia;
    }

    public void borrarIncidencia(String id, String descripcionEliminacion) {
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE incidencia \n" +
                        "SET isDeleted = 1, descripcionEliminacion = ?\n" +
                        "WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1,descripcionEliminacion);
                    pstmt.setInt(2, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    public CantidadIncidencias hallarCantidadIncidencias (){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        CantidadIncidencias cantidadIncidencias = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement("SELECT\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'nueva' THEN 1 ELSE 0 END) AS nuevas,\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'en proceso' THEN 1 ELSE 0 END) AS en_proceso,\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'falsa alarma' THEN 1 ELSE 0 END) AS falsa_alarma,\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'cerrado' THEN 1 ELSE 0 END) AS cerrado,\n" +
                     "    COUNT(*) AS total\n" +
                     "FROM incidencia;")) {

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cantidadIncidencias = new CantidadIncidencias();
                    cantidadIncidencias.setCantidadNuevas(rs.getInt(1));
                    cantidadIncidencias.setCantidadEnProceso(rs.getInt(2));
                    cantidadIncidencias.setCatidadFalsasAlarmas(rs.getInt(3));
                    cantidadIncidencias.setCantidadCerradas(rs.getInt(4));
                    cantidadIncidencias.setCantidadTotal(rs.getInt(5));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cantidadIncidencias;

    }
}
