package com.example.grupo2.daos;

import com.example.grupo2.Beans.Solicitudes;
import com.example.grupo2.Beans.Usuario;

import java.sql.*;
import java.util.ArrayList;

public class SerenazgosDao {
    private static String user = "root";
    private static String pass = "root";
    private static String url = "jdbc:mysql://localhost:3306/basededatos3";

    public ArrayList<Usuario> obtenerSerenazgos(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        ArrayList<Usuario> listaSerenazgos = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT nombre, apellido, dni, turnoSerenazgo, tipo, idUsuario, correo FROM basededatos3.usuario WHERE idRoles = 'SE'")){
            while (rs.next()){
                Usuario serenazgo = new Usuario();
                serenazgo.setNombre(rs.getString(1));
                serenazgo.setApellido(rs.getString(2));
                serenazgo.setDni(rs.getString(3));
                serenazgo.setTurnoSerenazgo(rs.getString(4));
                serenazgo.setTipo(rs.getString(5));
                serenazgo.setId(rs.getInt(6));
                serenazgo.setCorreo(rs.getString(7));
                listaSerenazgos.add(serenazgo);
                System.out.println(serenazgo);
            }
        }catch (SQLException e) {
            System.out.println("No se pudo realizar la busqueda");
        }
        return listaSerenazgos;
    }
    public void crearSerenazgos(String nombre, String apellido, String dni, String fecha_nacimiento, String numtelefono, String direccion, String tipo, String TurnoSerenazgo, String correo, String contrasenia){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String sql = "INSERT INTO `basededatos3`.`usuario` (`nombre`, `apellido`, `dni`, `fecha_nacimiento`, `telefono`, `direccion`, `tipo`, `turnoSerenazgo`, `correo`, `clave`, `idRoles`, `horaInicio`, `horaFin`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'SE', '00:00:00', '00:00:01')";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, nombre);
            pstmt.setString(2, apellido);
            pstmt.setString(3, dni);
            pstmt.setString(4, fecha_nacimiento);
            pstmt.setString(5, numtelefono);
            pstmt.setString(6, direccion);
            pstmt.setString(7, tipo);
            pstmt.setString(8, TurnoSerenazgo);
            pstmt.setString(9, correo);
            pstmt.setString(10, contrasenia);
            pstmt.executeUpdate();
            System.out.print("aqui estoy");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Usuario buscarPorId(int id) {
        Usuario serenazgo = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String sql = "SELECT * FROM usuario where idUsuario = ?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery();) {

                if (rs.next()) {
                    serenazgo = new Usuario();
                    serenazgo.setId(rs.getInt(1));
                    serenazgo.setNombre(rs.getString(2));
                    serenazgo.setApellido(rs.getString(3));
                    serenazgo.setDni(rs.getString(4));
                    serenazgo.setFecha_nacimiento(rs.getString(15));
                    serenazgo.setNumtelefono(rs.getString(5));
                    serenazgo.setDireccion(rs.getString(8));
                    serenazgo.setTipo(rs.getString(11));
                    serenazgo.setTurnoSerenazgo(rs.getString(10));
                    serenazgo.setCorreo(rs.getString(6));
                    serenazgo.setClave(rs.getString(7));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return serenazgo;
    }
    public void actualizar(Usuario serenazgo) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String sql = "UPDATE usuario SET telefono=?, direccion=?, tipo=?, turnoSerenazgo=?, correo=? where idUsuario=?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, serenazgo.getNumtelefono());
            pstmt.setString(2, serenazgo.getDireccion());
            pstmt.setString(3, serenazgo.getTipo());
            pstmt.setString(4, serenazgo.getTurnoSerenazgo());
            pstmt.setString(5, serenazgo.getCorreo());
            pstmt.setInt(6, serenazgo.getId());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    public void eliminarSerenazgo(int id) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String sql = "DELETE FROM usuario WHERE idUsuario = ?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void actualizarContrasenia(int id, String nuevaContrasenia) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String sql = "UPDATE usuario SET clave = ? WHERE idUsuario = ?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, nuevaContrasenia);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public ArrayList<Solicitudes> obtenerSolicitudes(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        ArrayList<Solicitudes> listaSolicitudes = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT s.idsolicitudes, u.nombre, u.apellido, u.dni, u.correo, u.direccion, s.roles_idRoles \n" +
                     "FROM solicitudes s \n" +
                     "JOIN usuario u \n" +
                     "ON s.usuario_idUsuario = u.idUsuario \n" +
                     "WHERE s.estadosolicitud is null;")){

            while (rs.next()){

                Solicitudes solicitud = new Solicitudes();
                solicitud.setIdsolicitud(rs.getInt(1));
                solicitud.setNombre(rs.getString(2));
                solicitud.setApellido(rs.getString(3));
                solicitud.setDni(rs.getString(4));
                solicitud.setCorreo(rs.getString(5));
                solicitud.setDireccion(rs.getString(6));
                solicitud.setRol(rs.getString(7));
                listaSolicitudes.add(solicitud);
            }
        }catch (SQLException e) {
            System.out.println("No se pudo realizar la busqueda");
        }
        return listaSolicitudes;
    }
    public void rechazarSolicitud(int id) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String sql = "UPDATE solicitudes SET estadosolicitud = ? WHERE idsolicitudes = ?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setInt(1, 0);
            pstmt.setInt(2, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void aprobarSolicitud(int idSolicitud) {
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/basededatos3"; // Reemplaza con la URL de tu base de datos
            String user = "root"; // Reemplaza con tu nombre de usuario de la base de datos
            String pass = "root"; // Reemplaza con tu contraseña de la base de datos

            connection = DriverManager.getConnection(url, user, pass);

            // Consultar el rol actual del usuario asociado a la solicitud
            String selectSql = "SELECT u.idRoles FROM solicitudes s JOIN usuario u ON s.usuario_idUsuario = u.idUsuario WHERE s.idsolicitudes = ?";
            pstmt = connection.prepareStatement(selectSql);
            pstmt.setInt(1, idSolicitud);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String currentRole = rs.getString("idRoles");
                String newRole = null;

                if (currentRole == null) {
                    newRole = "VE";
                } else if ("VE".equals(currentRole)) {
                    newRole = "CO";
                }

                if (newRole != null) {
                    // Actualizar el rol del usuario y el estado de la solicitud
                    String updateSql = "UPDATE usuario u JOIN solicitudes s ON u.idUsuario = s.usuario_idUsuario SET u.idRoles = ?, s.estadosolicitud = ? WHERE s.idsolicitudes = ?";
                    pstmt = connection.prepareStatement(updateSql);
                    pstmt.setString(1, newRole);
                    pstmt.setInt(2, 1);
                    pstmt.setInt(3, idSolicitud);
                    pstmt.executeUpdate();
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }




}
