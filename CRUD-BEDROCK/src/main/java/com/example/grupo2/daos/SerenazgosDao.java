package com.example.grupo2.daos;

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
             ResultSet rs = stmt.executeQuery("SELECT nombre, apellido, dni, turnoSerenazgo, tipo, idUsuario FROM basededatos3.usuario WHERE idRoles = 'SE'")){
            while (rs.next()){
                Usuario serenazgo = new Usuario();
                serenazgo.setNombre(rs.getString(1));
                serenazgo.setApellido(rs.getString(2));
                serenazgo.setDni(rs.getString(3));
                serenazgo.setTurnoSerenazgo(rs.getString(4));
                serenazgo.setTipo(rs.getString(5));
                serenazgo.setId(rs.getInt(6));
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

        String sql = "UPDATE usuario SET telefono=?, direccion=?, tipo=?, turnoSerenazgo=?, correo=?, clave=? where idUsuario=?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, serenazgo.getNumtelefono());
            pstmt.setString(2, serenazgo.getDireccion());
            pstmt.setString(3, serenazgo.getTipo());
            pstmt.setString(4, serenazgo.getTurnoSerenazgo());
            pstmt.setString(5, serenazgo.getCorreo());
            pstmt.setString(6, serenazgo.getClave());
            pstmt.setInt(7, serenazgo.getId());
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



}
