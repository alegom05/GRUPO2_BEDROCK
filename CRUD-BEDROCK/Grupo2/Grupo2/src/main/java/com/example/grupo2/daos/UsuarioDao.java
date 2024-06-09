package com.example.grupo2.daos;


import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;

import java.util.ArrayList;
import java.sql.*;
public class UsuarioDao {

    public static ArrayList<Usuario> listarUsuarios() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Usuario> listaUsuarios = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "select u.idUsuario; concat(u.nombre, ' ', u.apellido) as NombreCompleto, u.dni , u.telefono, u.correo, u.clave, u.direccion, u.urbanizacion, u.turnoSerenazgo, u.tipo, u.idRoles, u.horaInicio, u.horaFin, u.fecha_nacimiento\n" +
                "from usuario u\n" +
                "join roles r on u.idRoles = i.idRoles\n" +
                "join incidencia i on u.idUsuario = i.idUsuario;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt(1));
                usuario.setNombre(rs.getString(2));
                usuario.setDni(rs.getString(3));
                usuario.setNumtelefono(rs.getString(4));
                usuario.setCorreo(rs.getString(5));
                usuario.setClave(rs.getString(6));
                usuario.setDireccion(rs.getString(7));
                usuario.setTurnoSerenazgo(rs.getString(8));
                usuario.setUrbanizacion(rs.getString(9));
                usuario.setTurnoSerenazgo(rs.getString(10));
                usuario.setTipo(rs.getString(11));
                usuario.setRol(rs.getString(12));
                usuario.setHoraInicio(rs.getTime(13));
                usuario.setHoraFin(rs.getTime(13));
                usuario.setFechaNacimiento(rs.getTime(13));

                listaUsuarios.add(usuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaUsuarios);
        return listaUsuarios;
    }

    /*public Incidencia obtenerIncidenciaPorId(int id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        Incidencia incidencia = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3";
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
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return incidencia;
    }

    public void borrarIncidencia(String id) {
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "DELETE FROM incidencia WHERE idIncidenciaReportada = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }*/
}

