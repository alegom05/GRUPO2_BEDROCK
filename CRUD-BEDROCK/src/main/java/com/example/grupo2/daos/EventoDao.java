package com.example.grupo2.daos;


import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Incidencia;

import java.sql.*;
import java.util.ArrayList;

public class EventoDao extends daoBase{

    //Método que lista todos los eventos, por tipo de usuario(cultura, deporte)

    public  ArrayList<Evento> listarEventosParaCoordi(String tipoUsuario) {

        ArrayList<Evento> listaEventos = new ArrayList<>();
        // Se modifica la consulta SQL para filtrar por tipo de coordinadora
        String sql = "SELECT DISTINCT e.*, p.nombre AS nombreProfesor " +
                "FROM evento e " +
                //"INNER JOIN evento_has_usuario eu ON e.idEvento = eu.idEvento " +
                //"INNER JOIN usuario u ON eu.idUsuario = u.idUsuario " +
                "INNER JOIN profesor p ON e.idProfesor = p.idProfesor " ;

        // Añadimos las condiciones según el tipo de usuario
        if ("Deporte".equalsIgnoreCase(tipoUsuario)) {
            sql += "WHERE e.tipo IN ('Deportivo', 'Deporte')";
        } else if ("Cultura".equalsIgnoreCase(tipoUsuario)) {
            sql += "WHERE e.tipo IN ('Cultural', 'Cultura')";
        } else {
            // Si es otro tipo, asegurarse de manejarlo adecuadamente
            sql += "WHERE e.tipo = ?";
        }


        try (Connection conn= this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            if (!"Deporte".equalsIgnoreCase(tipoUsuario) && !"Cultura".equalsIgnoreCase(tipoUsuario)) {
                pstmt.setString(1, tipoUsuario);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt("idEvento"));
                evento.setNombre(rs.getString("nombre"));
                evento.setNombreProfesor(rs.getString("nombreProfesor"));
                evento.setLugar(rs.getString("lugar"));
                evento.setFechaInicial(rs.getDate("fechaInicial"));
                evento.setEstadoEvento(rs.getString("estadoEvento"));

                listaEventos.add(evento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaEventos);
        return listaEventos;
    }

    public void disminuirVacantes(String eventoId, int numAcompanantes) {

        String sql = "UPDATE evento SET vacantes = vacantes - ? WHERE idEvento = ? AND vacantes > 0;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int totalVacantes = 1 + numAcompanantes; // Disminuir al menos una vacante, más los acompañantes
            pstmt.setInt(1, totalVacantes);
            pstmt.setInt(2, Integer.parseInt(eventoId));
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int noHayVacantes(String eventoId) {

        String sql = "SELECT vacantes FROM evento WHERE idEvento = ?";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(eventoId));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int vacantes = rs.getInt("vacantes");
                if (vacantes == 0) {
                    return 1; // No hay vacantes
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0; // Hay vacantes disponibles
    }

    public int eventoPasado(String eventoId) {

        String sql = "SELECT CASE \n" +
                "    WHEN fechaFinal < CURDATE() OR estadoEvento = 'Culminado' THEN 1 \n" +
                "    ELSE 0 \n" +
                "END AS evento_pasado \n" +
                "FROM evento \n" +
                "WHERE idEvento = ?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(eventoId));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int pasado = rs.getInt("evento_pasado");
                if (pasado == 1) {
                    return 1; // Ya pasó el evento
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0; // Evento vigente
    }

    public int eventoEnCurso(String eventoId) {

        String sql = "SELECT CASE \n" +
                "    WHEN estadoEvento = 'En curso' THEN 1 \n" +
                "    ELSE 0 \n" +
                "END AS evento_en_curso \n" +
                "FROM evento \n" +
                "WHERE idEvento = ?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(eventoId));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int enCurso = rs.getInt("evento_en_curso");
                if (enCurso == 1) {
                    return 1; // Evento en curso
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0; // Evento no está en curso
    }

    public ArrayList<Evento> listarEventosCoordi(String id){

        ArrayList<Evento> listaEventos = new ArrayList<>();

        String sql="select e.nombre,p.nombre,e.lugar ,e.fechaInicial,e.lugar,e.estadoEvento\n"+
                "from evento e\n"+
                "join profesor p on e.idProfesor= p.idProfesor\n"+
                "where idUsuario=?";


        try(Connection conn= this.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs= pstmt.executeQuery();
            while (rs.next()){
                Evento evento = new Evento();
                evento.setNombre(rs.getString(1));
                evento.setNombreProfesor(rs.getString(2));
                evento.setLugar(rs.getString(3));
                evento.setFechaInicial(rs.getDate(4));
                evento.setEstadoEvento(rs.getString(5));

                listaEventos.add(evento);

            }
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
        System.out.println(listaEventos);
        return listaEventos;
    }

    //Este se usa para Coordis
    public ArrayList<Evento> listarEventosCoordi2() {

        ArrayList<Evento> listaEventos = new ArrayList<>();

        String sql = "SELECT e.nombre, p.nombre, e.lugar, e.fechaInicial, e.lugar, e.estadoEvento " +
                "FROM evento e " +
                "JOIN profesor p ON e.idProfesor = p.idProfesor";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Evento evento = new Evento();
                    evento.setNombre(rs.getString(1));
                    evento.setNombreProfesor(rs.getString(2));
                    evento.setLugar(rs.getString(3));
                    evento.setFechaInicial(rs.getDate(4));
                    evento.setEstadoEvento(rs.getString(5));

                    listaEventos.add(evento);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        System.out.println(listaEventos);
        return listaEventos;
    }

    public ArrayList<Evento> listarEventos() {

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "select e.idEvento, e.nombre , e.fechaInicial, e.fechaFinal, e.foto, e.materiales, e.lugar, e.hora, e.frecuencia, e.vacantes, e.descripcion, e.tipo, e.idProfesor, e.estadoEvento \n" +
                "from evento e\n" +
                "left join profesor p on e.idProfesor=p.idProfesor\n" +
                "left join evento_has_usuario h on e.idEvento=h.idEvento\n" +
                "left join fotosdeeventos f on e.idEvento = f.idEvento\n" +
                "order by e.fechaInicial desc;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFechaInicial(rs.getDate(3));
                evento.setFechaFinal(rs.getDate(4));
                Blob fotoBlob = rs.getBlob(5);
                if (fotoBlob != null) {
                    evento.setFoto(fotoBlob.getBinaryStream());
                } else {
                    evento.setFoto(null);
                }
                evento.setMateriales(rs.getString(6));
                evento.setLugar(rs.getString(7));
                evento.setHora(rs.getTime(8));
                evento.setFrecuencia(rs.getInt(9));
                evento.setVacantes(rs.getInt(10));
                evento.setDescripcion(rs.getString(11));
                evento.setTipo(rs.getString(12));
                evento.setIdProfesor(rs.getInt(13));
                evento.setEstadoEvento(rs.getString(14));

                lista.add(evento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(lista);
        return lista;
    }
    public ArrayList<Evento> listarEventosCalendario() {

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT * FROM evento";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFechaInicial(rs.getDate(3));
                evento.setFechaFinal(rs.getDate(4));
                Blob fotoBlob = rs.getBlob(12);
                if (fotoBlob != null) {
                    evento.setFoto(fotoBlob.getBinaryStream());
                } else {
                    evento.setFoto(null);
                }
                evento.setMateriales(rs.getString(6));
                evento.setLugar(rs.getString(7));
                evento.setHora(rs.getTime(8));
                evento.setFrecuencia(rs.getInt(9));
                evento.setVacantes(rs.getInt(10));
                evento.setDescripcion(rs.getString(11));
                evento.setTipo(rs.getString(12));
                evento.setIdProfesor(rs.getInt(13));
                evento.setEstadoEvento(rs.getString(14));

                lista.add(evento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(lista);
        return lista;
    }

    public ArrayList<Evento> listarEventos_limitado(int page, int pageSize, String filtro) {

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT * FROM basededatos3.evento";

        if (filtro != null && !filtro.isEmpty()) {
            switch (filtro) {
                case "Cultural":
                case "Deportivo":
                    sql += " WHERE tipo = ?\n" +
                            "ORDER BY \n" +
                            "  CASE WHEN estadoEvento = 'Pronto' THEN 0\n" +
                            "       WHEN estadoEvento = 'En curso' THEN 1\n" +
                            "       WHEN estadoEvento = 'Culminado' THEN 2\n" +
                            "       ELSE 3\n" +
                            "  END,\n" +
                            "  CASE WHEN tipo = 'Cultural' THEN fechaInicial END DESC";
                    break;
                case "Vigentes":
                    sql += " WHERE estadoEvento = 'Pronto'";
                    break;
                case "Pasados":
                    sql += " WHERE fechaInicial <= CURDATE() OR estadoEvento = 'Culminado' OR estadoEvento = 'En curso'\n" +
                            "ORDER BY \n" +
                            "  CASE \n" +
                            "    WHEN estadoEvento = 'En curso' THEN 0\n" +
                            "    WHEN estadoEvento = 'Culminado' THEN 1\n" +
                            "    WHEN fechaInicial <= CURDATE() THEN 2\n" +
                            "    ELSE 3\n" +
                            "  END,\n" +
                            "  fechaInicial DESC";
                    break;
                case "Popular":
                    sql += " WHERE estadoEvento = 'Pronto' ORDER BY vacantes ASC";
                    break;
                default:
                    break;
            }
        } else {
            sql += " ORDER BY \n" +
                    "  CASE WHEN estadoEvento = 'Pronto' THEN 0\n" +
                    "       WHEN estadoEvento = 'En curso' THEN 1\n" +
                    "       WHEN estadoEvento = 'Culminado' THEN 2\n" +
                    "       ELSE 3\n" +
                    "  END,\n" +
                    "  fechaInicial DESC";
        }

        sql += " LIMIT ?, ?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int parameterIndex = 1;

            if (filtro != null && !filtro.isEmpty()) {
                switch (filtro){
                    case "Cultural":
                    case "Deportivo":
                        pstmt.setString(parameterIndex++, filtro);
                        break;
                    // No se agregan parámetros adicionales para otros casos
                }
            }

            pstmt.setInt(parameterIndex++, (page - 1) * pageSize);
            pstmt.setInt(parameterIndex, pageSize);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFechaInicial(rs.getDate(3));
                evento.setFechaFinal(rs.getDate(4));
                Blob fotoBlob = rs.getBlob(12);
                if (fotoBlob != null) {
                    evento.setFoto(fotoBlob.getBinaryStream());
                } else {
                    evento.setFoto(null);
                }
                evento.setMateriales(rs.getString(6));
                evento.setLugar(rs.getString(7));
                evento.setHora(rs.getTime(8));
                evento.setFrecuencia(rs.getInt(9));
                evento.setVacantes(rs.getInt(10));
                evento.setDescripcion(rs.getString(11));
                evento.setTipo(rs.getString(12));
                evento.setIdProfesor(rs.getInt(13));
                evento.setEstadoEvento(rs.getString(14));

                lista.add(evento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(lista);
        return lista;
    }


    public ArrayList<Evento> listarEventos_populares() {

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT idEvento, nombre, fechaInicial, hora, descripcion, lugar\n" +
                "FROM basededatos3.evento\n" +
                "WHERE estadoEvento = 'Pronto'\n" +
                "ORDER BY vacantes ASC\n" +
                "LIMIT 3;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFechaInicial(rs.getDate(3));
                evento.setHora(rs.getTime(4));
                evento.setDescripcion(rs.getString(5));
                evento.setLugar(rs.getString(6));

                lista.add(evento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(lista);
        return lista;
    }

    public int contarEventos(String filtro) {

        int count = 0;
        String sql = "SELECT COUNT(*) FROM evento";

        if (filtro != null && !filtro.isEmpty()) {
            switch (filtro){
                case "Cultural":
                    sql += " where tipo=?";
                    break;
                case "Deportivo":
                    sql += " where tipo=?";
                    break;
                case "Popular":
                case "Vigentes":
                    sql += " WHERE estadoEvento = 'Pronto'";
                    break;
                case "Pasados":
                    sql += " WHERE fechaInicial <= CURDATE() OR estadoEvento = 'Culminado' OR estadoEvento = 'En curso'";
                    break;
                default:
                    break;
            }
        }

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            if (filtro != null && (filtro.equals("Cultural") || filtro.equals("Deportivo"))) {
                pstmt.setString(1, filtro);
            }

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return count;
    }

    public Evento obtenerEventoPorId(String id) {
        Evento evento = null;

        String sql = "SELECT e.*, p.nombre AS nombreProfesor\n" +
                "FROM evento e\n" +
                "INNER JOIN profesor p ON e.idProfesor = p.idProfesor where idEvento=?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    evento = new Evento();

                    evento.setIdEvento(rs.getInt(1));
                    evento.setNombre(rs.getString(2));
                    evento.setFechaInicial(rs.getDate(3));
                    evento.setFechaFinal(rs.getDate(4));
                    Blob fotoBlob = rs.getBlob(5);
                    if (fotoBlob != null) {
                        evento.setFoto(fotoBlob.getBinaryStream());
                    } else {
                        evento.setFoto(null);
                    }
                    evento.setMateriales(rs.getString(6));
                    evento.setLugar(rs.getString(7));
                    evento.setHora(rs.getTime(8));
                    evento.setFrecuencia(rs.getInt(9));
                    evento.setVacantes(rs.getInt(10));
                    evento.setDescripcion(rs.getString(11));
                    evento.setTipo(rs.getString(12));
                    evento.setIdProfesor(rs.getInt(13));
                    evento.setEstadoEvento(rs.getString(14));
                    evento.setNombreProfesor(rs.getString(15));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return evento;
    }

    public void modificarEvento(Evento evento){

        String sql= "update evento";

        try(Connection connection = this.getConnection();
            PreparedStatement pstmt = connection.prepareStatement(sql)){

            pstmt.setString(1,evento.getNombre());
            pstmt.setString(2,evento.getDescripcion());
            pstmt.setString(3,evento.getLugar());
            pstmt.setInt(4,evento.getIdProfesor());
            pstmt.setInt(5,evento.getVacantes());
            pstmt.setDate(6,evento.getFechaInicial());
            pstmt.setDate(7,evento.getFechaFinal());
            pstmt.setTime(8,evento.getHora());
            pstmt.executeUpdate();

        }catch (SQLException e){
            throw new RuntimeException(e);
        }
    }


    public void crearEvento(Evento evento){

        try{

            try (Connection conn= this.getConnection()){
                String sql= "INSERT INTO evento (nombre,fechaInicial,fechaFinal,foto,materiales, lugar, hora, frecuencia,vacantes, descripcion, tipo,idProfesor,estadoEvento)"+
                        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,'Pronto')";

                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setString(1,evento.getNombre());
                    pstmt.setDate(2, evento.getFechaInicial());
                    pstmt.setDate(3,evento.getFechaFinal());
                    if (evento.getFoto() != null) {
                        pstmt.setBlob(4, evento.getFoto());
                    } else {
                        pstmt.setNull(4, Types.BLOB);
                    }
                    pstmt.setString(5,evento.getMateriales());
                    pstmt.setString(6,evento.getLugar());
                    pstmt.setTime(7,evento.getHora());
                    pstmt.setInt(8,evento.getFrecuencia());
                    pstmt.setInt(9,evento.getVacantes());
                    pstmt.setString(10,evento.getDescripcion());
                    pstmt.setString(11,evento.getTipo());
                    pstmt.setInt(12,evento.getIdProfesor());
                    pstmt.executeUpdate();
                }
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
        /*try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String sql = "INSERT INTO `basededatos3`.`usuario` (`nombre`, `descripcion`, `lugar`, `encargado`, `vacantes`, `fechaInicio`, `fechaFin`) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, evento.getNombre());
            pstmt.setString(2, evento.getDescripcion());
            pstmt.setString(3, evento.getLugar());
            pstmt.setInt(4, evento.getIdProfesor());
            pstmt.setInt(5, evento.getVacantes());
            pstmt.setDate(6, evento.getFechaInicial());
            pstmt.setDate(7, evento.getFechaFinal());
            pstmt.setTime(8,evento.getHora());
            pstmt.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }*/
    }

    public void borrarEvento(String id) throws SQLException{

        String sql = "DELETE FROM evento WHERE idEvento = ?";

        try (Connection conn = this.getConnection();) {
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, id);
                pstmt.executeUpdate();
            }
        }

    }

    public ArrayList<Evento> listarEventosporIdUsuario(String id) {

        ArrayList<Evento> listaEventosUsuario = new ArrayList<>();

        String sql = "SELECT e.idEvento, e.nombre, e.lugar,e.tipo,e.fechaInicial,e.hora\n" +
                "FROM evento e\n" +
                "JOIN evento_has_usuario eu ON e.idEvento = eu.idEvento\n" +
                "JOIN usuario u ON eu.idUsuario = u.idUsuario\n" +
                "WHERE u.idUsuario = ?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Evento eventoUsuario= new Evento();
                eventoUsuario.setIdEvento(rs.getInt(1));
                eventoUsuario.setNombre(rs.getString(2));
                eventoUsuario.setLugar(rs.getString(3));
                eventoUsuario.setTipo(rs.getString(4));
                eventoUsuario.setFechaInicial(rs.getDate(5));
                eventoUsuario.setHora(rs.getTime(6));

                listaEventosUsuario.add(eventoUsuario);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaEventosUsuario);
        return listaEventosUsuario;
    }

    //Este dao permitirá iniciar un evento, debido a eso el query actualizará el estado del evento,
    public void editarEstadoEventoEnCurso(String id) {
        try {
            try (Connection conn = this.getConnection();) {
                String sql = "UPDATE evento SET estadoEvento = 'En curso' WHERE idEvento = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Esta función permitirá la culminación de un evento, (lo usa coordi)
    public void editarEstadoEventoCuliminado(String id) {
        try {
            try (Connection conn = this.getConnection();) {
                String sql = "UPDATE evento SET estadoEvento = 'Culminado' WHERE idEvento = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public void publicarFotosAsistencia(Evento evento){

        try{
            try (Connection conn= this.getConnection()){
                String sql= "INSERT INTO fotosdeeventos (fotosDeEventos,idEvento)"+
                        "VALUES (?,?)";

                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    if (evento.getFotoAsistenciaEvento() != null) {
                        pstmt.setBlob(1, evento.getFotoAsistenciaEvento());
                    } else {
                        pstmt.setNull(1, Types.BLOB);
                    }
                    pstmt.setInt(2, evento.getIdEvento());
                    pstmt.executeUpdate();
                }
            }

        }catch (SQLException e){
            e.printStackTrace();
        }

    }

    public void updateEventStatus() {
        /*String query = "UPDATE evento SET estadoEvento = CASE " +
                "WHEN NOW() < CONCAT(fechaInicial, ' ', hora) THEN 'Pronto' " +
                "WHEN NOW() BETWEEN CONCAT(fechaInicial, ' ', hora) AND IFNULL( horaFin, '9999-12-31 23:59:59') THEN 'En curso' " +
                "WHEN NOW() > fechaFinal OR (horaFin IS NOT NULL AND NOW() > horaFin) THEN 'Finalizado' " +
                "ELSE estadoEvento END";*/
        String query = "UPDATE evento SET estadoEvento = CASE " +
                "WHEN NOW() < CONCAT(fechaInicial, ' ', hora) THEN 'Pronto' " +
                "WHEN NOW() BETWEEN CONCAT(fechaInicial, ' ', hora) AND   '9999-12-31 23:59:59' THEN 'En curso' " +
                "WHEN NOW() > fechaFinal THEN 'Finalizado' " +
                "ELSE estadoEvento END";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            int rowsUpdated = pstmt.executeUpdate();
            System.out.println("Updated " + rowsUpdated + " rows.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
