package com.example.grupo2.daos;
import com.example.grupo2.Beans.Usuario;
import java.util.ArrayList;
import java.sql.*;
public class VecinosDao {
    public static ArrayList<Usuario> listarVecinos() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Usuario> listaVeci = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        String sql = "select u.idUsuario,u.nombre,u.apellido, u.dni , u.telefono, u.correo, u.clave, u.direccion, " +
                "u.urbanizacion, r.nombre, u.horaInicio, u.horaFin, u.fecha_nacimiento\n" +
                "from usuario u\n" +
                "join roles r on u.idRoles = r.idRoles\n" +
                "join incidencia i on u.idUsuario = i.idUsuario\n" +
                "where u.idRoles='VE';";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt(1));
                usuario.setNombre(rs.getString(2));
                usuario.setApellido(rs.getString(3));
                usuario.setDni(rs.getString(4));
                usuario.setNumtelefono(rs.getString(5));
                usuario.setCorreo(rs.getString(6));
                usuario.setClave(rs.getString(7));
                usuario.setDireccion(rs.getString(8));
                usuario.setUrbanizacion(rs.getString(9));
                usuario.setRol(rs.getString(10));
                usuario.setHoraInicio(rs.getTime(11));
                usuario.setHoraFin(rs.getTime(12));
                usuario.setFechaNacimiento(rs.getTime(13));
                listaVeci.add(usuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return listaVeci;
    }


    public void crearIncidencia(String nombreIncidencia, String descripcionIncidencia,
                                String lugarIncidencia, String referenciaIncidencia, String contactoIncidencia,
                                String idTipoIncidencia, Boolean requiereAmbulancia){

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/hr";
        String username = "root";
        String password = "root";

        String sql = "insert into incidencia (nombre," +
                " descripcion,lugar,referencia,contacto,idtipo,requiereAmbulancia,foto) values (?,?,?,?)";

        try(Connection connection = DriverManager.getConnection(url,username,password);
            PreparedStatement pstmt = connection.prepareStatement(sql)){

            pstmt.setString(1,nombreIncidencia);
            pstmt.setString(2,descripcionIncidencia);
            pstmt.setString(3,lugarIncidencia);
            pstmt.setString(4,referenciaIncidencia);
            pstmt.setString(5,contactoIncidencia);
            pstmt.setString(6,idTipoIncidencia);
            pstmt.setBoolean(7,requiereAmbulancia);
            /*pstmt.setBlob(8,fotoIncidencia);*/

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
