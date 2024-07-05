package com.example.grupo2.daos;


import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;

import java.util.ArrayList;
import java.sql.*;
public class UsuarioDao extends daoBase {

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

        String sql = "select u.idUsuario, concat(u.nombre, ' ', u.apellido) as NombreCompleto, u.dni , u.telefono, u.correo, u.clave, u.direccion, u.urbanizacion, u.turnoSerenazgo, u.tipo, r.nombre, u.horaInicio, u.horaFin, u.fecha_nacimiento\n" +
                "from usuario u\n" +
                "left join roles r on u.idRoles = r.idRoles\n" +
                "left join incidencia i on u.idUsuario = i.idUsuario\n" +
                "where u.idRoles='VE';";

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
                usuario.setUrbanizacion(rs.getString(8));
                usuario.setTurnoSerenazgo(rs.getString(9));
                usuario.setTipo(rs.getString(10));
                usuario.setRol(rs.getString(11));
                usuario.setHoraInicio(rs.getTime(12));
                usuario.setHoraFin(rs.getTime(13));
                usuario.setFechaNacimiento(rs.getDate(14));

                listaUsuarios.add(usuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaUsuarios);
        return listaUsuarios;
    }

    public static int esUsuario(int IdUsuario) {
        int Es_un_usuario=0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "        SELECT\n" +
                "                CASE\n" +
                "        WHEN EXISTS (\n" +
                "                SELECT 1\n" +
                "        FROM basededatos3.usuario\n" +
                "        WHERE idUsuario = ?\n" +
                "        ) THEN 1\n" +
                "        ELSE 0\n" +
                "        END AS usuario_existe;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, IdUsuario);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Es_un_usuario=(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Es_un_usuario;
    }

    public static int esEvento(int IdEvento) {
        int Es_un_evento=0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "SELECT \n" +
                "    CASE \n" +
                "        WHEN EXISTS (\n" +
                "            SELECT 1\n" +
                "            FROM basededatos3.evento\n" +
                "            WHERE idEvento = ?\n" +
                "        ) THEN 1\n" +
                "        ELSE 0\n" +
                "    END AS evento_existe;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, IdEvento);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Es_un_evento=(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Es_un_evento;
    }

    public static int EstaInscrito(int IdEvento, int IdUsuario) {
        int Esta_inscrito=0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "SELECT \n" +
                "    CASE \n" +
                "        WHEN EXISTS (\n" +
                "            SELECT 1 \n" +
                "            FROM basededatos3.evento_has_usuario \n" +
                "            WHERE idUsuario = ? AND idEvento = ?\n" +
                "        ) THEN 1 \n" +
                "        ELSE 0 \n" +
                "    END AS estaInscrito";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, IdUsuario);
            pstmt.setInt(2, IdEvento);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Esta_inscrito=(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Esta_inscrito;
    }

    public static void inscribirEvento(int IdUsuario, int IdEvento){
        // Falta aplicar algunaas resstricciones como que no se pueda inscribir al mismo evento mas de una vez
        // Tambien lo de los acompañantes y sus tablas
        // Tambien paginas de redireccionamiento
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "INSERT INTO basededatos3.evento_has_usuario (idEvento, idUsuario)\n" +
                "VALUES (?,?);";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, IdEvento);
            pstmt.setInt(2, IdUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void inscribirConAconpanante(Usuario aconpanante, int IdUsuario, int IdEvento){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "INSERT INTO basededatos3.aconpanantes (NombreAconpanantes, ApellidoAconpanantes, DniAconpanantes, evento_has_usuario_idEvento, evento_has_usuario_idUsuario)\n" +
                "VALUES (?,?,?,?,?);\n";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, aconpanante.getNombre());
            pstmt.setString(2, aconpanante.getApellido());
            pstmt.setString(3, aconpanante.getDni());
            pstmt.setInt(4, IdEvento);
            pstmt.setInt(5, IdUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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
    public Usuario buscarPorId(int id) {
        Usuario vecino = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String user = "root";
        String pass = "root";

        String sql = "SELECT * FROM usuario where idUsuario = ?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery();) {

                if (rs.next()) {
                    vecino = new Usuario();
                    vecino.setId(rs.getInt(1));
                    vecino.setNombre(rs.getString(2));
                    vecino.setApellido(rs.getString(3));
                    vecino.setDni(rs.getString(4));
                    vecino.setNumtelefono(rs.getString(5));
                    vecino.setClave(rs.getString(7));
                    vecino.setDireccion(rs.getString(8));
                    vecino.setUrbanizacion(rs.getString(9));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return vecino;
    }
    public void actualizar(Usuario vecino) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String user = "root";
        String pass = "root";

        String sql = "UPDATE usuario SET telefono=?, direccion=?, urbanizacion=? where idUsuario=?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, vecino.getNumtelefono());
            pstmt.setString(2, vecino.getDireccion());
            pstmt.setString(3, vecino.getUrbanizacion());
            pstmt.setInt(4, vecino.getId());
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
        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String user = "root";
        String pass = "root";
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

    //Método para actualizar el número de celular del serenazgo puesto que este solo puede actualizar este campo y también su contraseña
    public void actualizarCelular(Usuario serenazgo) {
        String sql = "UPDATE usuario SET telefono=? where idUsuario=?";

        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, serenazgo.getNumtelefono());
            pstmt.setInt(2, serenazgo.getId());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Listar información de serenazgo (usuario) realizo esto con el objetivo de que la info sea en tiempo real, por ejemplo si
    //el administrador cambia algo y el sereno no tenga que esperar a volver a ingresar a su cuenta para ver los cambios
    //nota: este método podrá ser utilizado en totalidad para otros roles
    //No listaremos la clave por motivos de seguridad, esta solo queda al realizar el login
    public Usuario listarPorId(int id) {

        Usuario usuario = new Usuario();
        String sql = "SELECT * FROM usuario where idUsuario = ?";

        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery();) {

                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt(1));
                    usuario.setNombre(rs.getString(2));
                    usuario.setApellido(rs.getString(3));
                    usuario.setDni(rs.getString(4));
                    usuario.setNumtelefono(rs.getString(5));
                    usuario.setCorreo(rs.getString(6));
                    usuario.setDireccion(rs.getString(8));
                    usuario.setUrbanizacion(rs.getString(9));
                    usuario.setTurnoSerenazgo(rs.getString(10));
                    usuario.setTipo(rs.getString(11));
                    usuario.setRol(rs.getString(12));
                    usuario.setHoraInicio(rs.getTime(13));
                    usuario.setHoraFin(rs.getTime(14));
                    usuario.setFechaNacimiento(rs.getDate(15));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return usuario;
    }


}

