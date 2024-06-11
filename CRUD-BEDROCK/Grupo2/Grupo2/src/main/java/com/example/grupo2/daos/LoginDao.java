package com.example.grupo2.daos;
import com.example.grupo2.Beans.Usuario;
import java.sql.*;

public class LoginDao {
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
                    usuario.setCorreo(rs.getString(6));
                    usuario.setRol(rs.getString(12));
                }
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return usuario;
    }

}
