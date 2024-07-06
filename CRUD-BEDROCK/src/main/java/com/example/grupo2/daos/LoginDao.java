package com.example.grupo2.daos;
import com.example.grupo2.Beans.Usuario;
import java.sql.*;

public class LoginDao {
    private static String user = "root";
    private static String pass = "root";
    private static String url = "jdbc:mysql://localhost:3306/basededatos3";
    public Usuario validar(String correo,String clave){
        Usuario usuario = null;
        String user = "root";
        String pass = "root";
        String url = "jdbc:mysql://localhost:3306/basededatos3";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        String sql = "SELECT * FROM usuario WHERE correo =? and clave =?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1,correo);
            pstmt.setString(2,clave);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    usuario = new Usuario();
                    usuario.setId(rs.getInt(1));
                    usuario.setNombre(rs.getString(2));
                    usuario.setApellido(rs.getString(3));
                    usuario.setDni(rs.getString(4));
                    usuario.setNumtelefono(rs.getString(5));
                    usuario.setCorreo(rs.getString(6));
                    usuario.setClave(rs.getString(7));
                    usuario.setDireccion(rs.getString(8));
                    usuario.setUrbanizacion(rs.getString(9));
                    usuario.setTurnoSerenazgo(rs.getString(10));
                    usuario.setTipo(rs.getString(11));
                    usuario.setRol(rs.getString(12));
                    usuario.setFechaNacimiento(rs.getDate(15));
                }

            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

    //Para usar contraseña hasheada
    public Usuario validarHash(String username, String password) {

        Usuario usuario = null;
        UsuarioDao usuarioDao = new UsuarioDao();

        String user = "root";
        String pass = "root";
        String url = "jdbc:mysql://localhost:3306/basededatos3";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String sql = "SELECT * FROM credenciales WHERE correo = ? AND claveHash = SHA2(?, 256);";

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = conn.prepareStatement(sql);) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery();) {
                if (rs.next()) {
                    int employeeId = rs.getInt(5);
                    usuario = usuarioDao.listarPorId(employeeId);
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return usuario;
    }

}
