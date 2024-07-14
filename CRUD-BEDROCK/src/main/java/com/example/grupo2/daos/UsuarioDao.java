package com.example.grupo2.daos;


import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.Beans.Historial;

import java.util.ArrayList;
import java.sql.*;
public class UsuarioDao extends daoBase {

    public ArrayList<Usuario> listarUsuarios() {


        ArrayList<Usuario> listaUsuarios = new ArrayList<>();


        String sql = "select u.idUsuario, concat(u.nombre, ' ', u.apellido) as NombreCompleto, u.dni , u.telefono, u.correo, u.clave, u.direccion, u.urbanizacion, u.turnoSerenazgo, u.tipo, r.nombre, u.horaInicio, u.horaFin, u.fecha_nacimiento\n" +
                "from usuario u\n" +
                "inner join roles r on u.idRoles = r.idRoles\n" +
                "where u.idRoles='VE'\n" +
                "order by u.nombre DESC;";

        try (Connection conn = this.getConnection();
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

    public ArrayList<Usuario> listarVecinoPorEvento(String idEvento) {

        ArrayList<Usuario> listaVecinos = new ArrayList<>();

        String sql = "select ehu.idUsuario, u.dni, concat(u.nombre,' ',u.apellido) as NombreCompleto, u.correo " +
                "from evento_has_usuario ehu " +
                "inner join evento e on ehu.idEvento = e.idEvento " +
                "inner join usuario u on ehu.idUsuario = u.idUsuario " +
                "where ehu.asistio= 1 and ehu.idEvento = ?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, Integer.parseInt(idEvento)); // Aquí se debe asignar el parámetro antes de ejecutar la consulta

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();

                    usuario.setId(rs.getInt(1));
                    usuario.setDni(rs.getString(2));
                    usuario.setNombre(rs.getString(3));
                    usuario.setCorreo(rs.getString(4));

                    listaVecinos.add(usuario);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaVecinos);
        return listaVecinos;
    }






    public int esUsuario(int IdUsuario) {
        int Es_un_usuario=0;

        String sql = "        SELECT\n" +
                "                CASE\n" +
                "        WHEN EXISTS (\n" +
                "                SELECT 1\n" +
                "        FROM basededatos3.usuario\n" +
                "        WHERE idUsuario = ?\n" +
                "        ) THEN 1\n" +
                "        ELSE 0\n" +
                "        END AS usuario_existe;";

        try (Connection conn = this.getConnection();
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

    public int esEvento(int IdEvento) {
        int Es_un_evento=0;
        String sql = "SELECT \n" +
                "    CASE \n" +
                "        WHEN EXISTS (\n" +
                "            SELECT 1\n" +
                "            FROM basededatos3.evento\n" +
                "            WHERE idEvento = ?\n" +
                "        ) THEN 1\n" +
                "        ELSE 0\n" +
                "    END AS evento_existe;";

        try (Connection conn = this.getConnection();
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

    public int EstaInscrito(int IdEvento, int IdUsuario) {
        int Esta_inscrito=0;

        String sql = "SELECT \n" +
                "    CASE \n" +
                "        WHEN EXISTS (\n" +
                "            SELECT 1 \n" +
                "            FROM basededatos3.evento_has_usuario \n" +
                "            WHERE idUsuario = ? AND idEvento = ?\n" +
                "        ) THEN 1 \n" +
                "        ELSE 0 \n" +
                "    END AS estaInscrito";

        try (Connection conn = this.getConnection();
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

    public void inscribirEvento(int IdUsuario, int IdEvento){
        // Falta aplicar algunaas resstricciones como que no se pueda inscribir al mismo evento mas de una vez
        // Tambien lo de los acompañantes y sus tablas
        // Tambien paginas de redireccionamiento

        String sql = "INSERT INTO basededatos3.evento_has_usuario (idEvento, idUsuario,asistio)\n" +
                "VALUES (?,?,1);";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, IdEvento);
            pstmt.setInt(2, IdUsuario);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void inscribirConAconpanante(Usuario aconpanante, int IdUsuario, int IdEvento){

        String sql = "INSERT INTO basededatos3.aconpanantes (NombreAconpanantes, ApellidoAconpanantes, DniAconpanantes, evento_has_usuario_idEvento, evento_has_usuario_idUsuario)\n" +
                "VALUES (?,?,?,?,?);\n";

        try (Connection conn = this.getConnection();
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

        String sql = "SELECT * FROM usuario where idUsuario = ?";

        try (Connection connection = this.getConnection();
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
                    vecino.setTipo(rs.getString("tipo"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return vecino;
    }
    public void actualizar(Usuario vecino) {

        String sql = "UPDATE usuario SET telefono=?, direccion=?, urbanizacion=? where idUsuario=?";

        try (Connection connection = this.getConnection();
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

        String sql = "UPDATE usuario SET clave = ? WHERE idUsuario = ?";

        try (Connection connection = this.getConnection();
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
    //usado para crear un usuario que luego se volver[a vecino
    public void saveUsuario(Usuario usuario) throws SQLException {
        /*Connection conn =null;
        PreparedStatement = null;*/


        try (Connection conn = this.getConnection()){

            String sql = "INSERT INTO usuario (nombre, apellido, dni,direccion, urbanizacion, correo, horaInicio, horaFin) VALUES (?,?, ?,?, ?,?, '00:00:00','00:00:00')";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setString(1, usuario.getNombre());
                    pstmt.setString(2, usuario.getApellido());
                    pstmt.setString(3, usuario.getDni());
                    pstmt.setString(4, usuario.getDireccion());
                    pstmt.setString(5, usuario.getUrbanizacion());
                    pstmt.setString(6, usuario.getCorreo());
                    pstmt.executeUpdate();
            }
        }  catch (SQLException e) {
            throw new RuntimeException(e);
        } /*finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }*/
    }
    /*public boolean existeUsuario(String email) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, username, password)){
            String query = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, email);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) > 0;
                    }
                }
            }
        }
        return false;
    }*/
    //para verificar la existencia de un usuario buscando a traves del correo
    public int esUsuarioPorCorreo(String correo) {
        int Es_un_usuario = 0;


        String sql = "SELECT CASE " +
                "WHEN EXISTS ( " +
                "    SELECT 1 " +
                "    FROM basededatos3.usuario " +
                "    WHERE correo = ? " +
                ") THEN 1 " +
                "ELSE 0 " +
                "END AS usuario_existe;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, correo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Es_un_usuario = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Es_un_usuario;
    }

    /*METODOS AÑADIDOS POR ADRIAN*/
    public void crearSolicitudCoordi(int idUsuario){
        Date fechaActual = new Date(System.currentTimeMillis());
        String fa= String.valueOf(fechaActual);


        String sql = "INSERT INTO `basededatos3`.`solicitudes` (`estadoSolicitud`,`fechasolicitud`,`usuario_idUsuario`,`roles_idRoles`) VALUES (?,?,?,?)";

        int estado=0;
        String rol="CO";
        System.out.print("en proceso");

        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {
            pstmt.setInt(1,estado);
            pstmt.setDate(2,fechaActual);
            pstmt.setInt(3,idUsuario);
            pstmt.setString(4,rol);
            pstmt.executeUpdate();
            System.out.print(fa);
            System.out.print("solicitud enviada");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Metodos Coordi
    public void reportarVecino(Usuario usuario){
        try {

            try (Connection conn = this.getConnection();) {
                String sql = "UPDATE evento_has_usuario\n" +
                        "SET\n" +
                        "descripcion = ?,\n" +
                        "WHERE idUsuario = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

                    pstmt.setString(1,usuario.getMotivoReporte());
                    pstmt.setInt(2,usuario.getId());
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Historial> historialUsuario2(String id){


        ArrayList<Historial> historialUsuario = new ArrayList<>();


        String sql = "select e.fechaInicial, e.nombre, e.lugar,ehu.descripcion \n" +
                "from evento_has_usuario ehu\n" +
                "join evento e on ehu.idEvento=e.idEvento\n"+
                "where idUsuario=?;";
        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Historial historial = new Historial();
                historial.setFechaInicial(rs.getDate(1));
                historial.setNombre(rs.getString(2));
                historial.setLugar(rs.getString(3));
                historial.setDescripcion(rs.getString(4));

                historialUsuario.add(historial);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(historialUsuario);
        return historialUsuario;
    }

    public void borrarVecinoDeEvento(String id){
        String sql= "DELETE FROM evento_has_usuario WHERE idUsuario = ?";

        try (Connection conn = this.getConnection();) {
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, id);
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


}

