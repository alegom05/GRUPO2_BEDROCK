package com.example.grupo2.daos;


import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Incidencia;

import java.sql.*;
import java.util.ArrayList;

public class EventoDao {

    private static String username = "root";
    private static String password = "root";
    private static String url = "jdbc:mysql://localhost:3306/basededatos3";

    //Método que lista todos los eventos, por el momento no podemos listar para una sola coordinadora ya que hace
    //falta una conexión uno amuchos en la base de datos
    //Este listado se debería modificar una vez se tenga la relación uno a muchos en la tabla de datos,
    //lo único que cambiaría es agregar un "where idUsuario= " y estaría correcto
    public static ArrayList<Evento> listarEventosParaCoordi(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> listaEventos = new ArrayList<>();

        String url= "jdbc:mysql://localhost:3306/basededatos3?";
        String username= "root";
        String password= "root";

        String sql="SELECT e.*, p.nombre AS nombreProfesor\n" +
                "                FROM evento e\n" +
                "                INNER JOIN profesor p ON e.idProfesor = p.idProfesor;";


        try(Connection conn= DriverManager.getConnection(url,username,password);
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            ResultSet rs= pstmt.executeQuery();
            while (rs.next()){
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt("idEvento"));
                evento.setNombre(rs.getString("nombre"));//1
                evento.setNombreProfesor(rs.getString("nombreProfesor"));
                evento.setLugar(rs.getString("lugar"));
                evento.setFechaInicial(rs.getDate("fechaInicial"));//3
                evento.setEstadoEvento(rs.getString("estadoEvento"));//2
                listaEventos.add(evento);

            }
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
        System.out.println(listaEventos);
        return listaEventos;
    }

    public static void disminuirVacantes(String eventoId, int numAcompanantes) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "UPDATE evento SET vacantes = vacantes - ? WHERE idEvento = ? AND vacantes > 0;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int totalVacantes = 1 + numAcompanantes; // Disminuir al menos una vacante, más los acompañantes
            pstmt.setInt(1, totalVacantes);
            pstmt.setInt(2, Integer.parseInt(eventoId));
            pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static int noHayVacantes(String eventoId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "SELECT vacantes FROM evento WHERE idEvento = ?";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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

    public static int eventoPasado(String eventoId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "SELECT CASE \n" +
                "    WHEN fechaFinal < CURDATE() THEN 1 \n" +
                "    ELSE 0 \n" +
                "END AS evento_pasado \n" +
                "FROM evento \n" +
                "WHERE idEvento = ?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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

    public static ArrayList<Evento> listarEventosCoordi(String id){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> listaEventos = new ArrayList<>();

        String url= "jdbc:mysql://localhost:3306/basededatos3?";
        String username= "root";
        String password= "root";

        String sql="select e.nombre,p.nombre,e.lugar ,e.fechaInicial,e.lugar,e.estadoEvento\n"+
                "from evento e\n"+
                "join profesor p on e.idProfesor= p.idProfesor\n"+
                "where idUsuario=?";


        try(Connection conn= DriverManager.getConnection(url,username,password);
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
    public static ArrayList<Evento> listarEventosCoordi2() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        ArrayList<Evento> listaEventos = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "SELECT e.nombre, p.nombre, e.lugar, e.fechaInicial, e.lugar, e.estadoEvento " +
                "FROM evento e " +
                "JOIN profesor p ON e.idProfesor = p.idProfesor";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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

    public static ArrayList<Evento> listarEventos() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "select e.idEvento, e.nombre , e.fechaInicial, e.fechaFinal, e.foto, e.materiales, e.lugar, e.hora, e.frecuencia, e.vacantes, e.descripcion, e.tipo, e.idProfesor, e.estadoEvento \n" +
                "from evento e\n" +
                "left join profesor p on e.idProfesor=p.idProfesor\n" +
                "left join evento_has_usuario h on e.idEvento=h.idEvento\n" +
                "left join fotosdeeventos f on e.idEvento = f.idEvento\n" +
                "order by e.fechaInicial desc;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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
    public static ArrayList<Evento> listarEventosCalendario() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT * FROM evento";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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

    public static ArrayList<Evento> listarEventos_limitado(int page, int pageSize, String filtro) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT * FROM basededatos3.evento";

        if (filtro != null && !filtro.isEmpty()) {
            switch (filtro) {
                case "Cultural":
                case "Deportivo":
                    sql += " WHERE tipo = ? ORDER BY CASE WHEN fechaInicial >= CURDATE() THEN 0 ELSE 1 END, fechaInicial DESC";
                    break;
                case "Vigentes":
                    sql += " WHERE fechaInicial >= CURDATE()";
                    break;
                case "Pasados":
                    sql += " WHERE fechaInicial <= CURDATE()";
                    break;
                case "Popular":
                    sql += " ORDER BY CASE WHEN fechaInicial >= CURDATE() THEN 0 ELSE 1 END, vacantes ASC";
                    break;
                default:
                    break;
            }
        } else {
            sql += " ORDER BY CASE WHEN fechaInicial >= CURDATE() THEN 0 ELSE 1 END, fechaInicial DESC";
        }

        sql += " LIMIT ?, ?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int parameterIndex = 1;

            if (filtro != null && !filtro.isEmpty()) {
                switch (filtro){
                    case "Cultural":
                    case "Deportivo":
                        pstmt.setString(parameterIndex++, filtro);
                        break;
                    case "Populares":
                        break; // No hay parámetros adicionales para "Populares"
                    case "Vigentes":
                        break; // No hay parámetros adicionales para "Vigentes"
                    case "Pasados":
                        break; // No hay parámetros adicionales para "Pasados"
                    default:
                        break;
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

    public static ArrayList<Evento> listarEventos_populares() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT idEvento, nombre, fechaInicial, hora, descripcion\n" +
                "FROM basededatos3.evento\n" +
                "ORDER BY vacantes DESC\n" +
                "LIMIT 3;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFechaInicial(rs.getDate(3));
                evento.setHora(rs.getTime(4));
                evento.setDescripcion(rs.getString(5));

                lista.add(evento);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(lista);
        return lista;
    }

    public int contarEventos(String filtro) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

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
                default:
                    break;
            }
        }

        try (Connection conn = DriverManager.getConnection(url, username, password);
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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        String sql = "SELECT e.*, p.nombre AS nombreProfesor\n" +
                "FROM evento e\n" +
                "INNER JOIN profesor p ON e.idProfesor = p.idProfesor where idEvento=?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        String sql= "update evento";

        try(Connection connection = DriverManager.getConnection(url,username,password);
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
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basededatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn= DriverManager.getConnection(url, user,pass)){
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

        }catch (SQLException | ClassNotFoundException e){
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
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String user = "root";
        String pass = "root";

        String sql = "DELETE FROM evento WHERE idEvento = ?";

        try (Connection conn = DriverManager.getConnection(url, user, pass);) {
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, id);
                pstmt.executeUpdate();
            }
        }

    }

    public static ArrayList<Evento> listarEventosporIdUsuario(String id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> listaEventosUsuario = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "SELECT e.idEvento, e.nombre, e.lugar,e.tipo,e.fechaInicial,e.hora\n" +
                "FROM evento e\n" +
                "JOIN evento_has_usuario eu ON e.idEvento = eu.idEvento\n" +
                "JOIN usuario u ON eu.idUsuario = u.idUsuario\n" +
                "WHERE u.idUsuario = ?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://127.0.0.1:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE evento SET estadoEvento = 'En curso' WHERE idEvento = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    //Esta función permitirá la culminación de un evento, (lo usa coordi)
    public void editarEstadoEventoCuliminado(String id) {
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://127.0.0.1:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE evento SET estadoEvento = 'Culminado' WHERE idEvento = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }


    public void publicarFotosAsistencia(Evento evento){

        try{
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basededatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn= DriverManager.getConnection(url, user,pass)){
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

        }catch (SQLException | ClassNotFoundException e){
            e.printStackTrace();
        }

    }
}
