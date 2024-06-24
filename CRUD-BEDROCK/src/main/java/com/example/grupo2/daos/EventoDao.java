package com.example.grupo2.daos;


import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Incidencia;

import java.sql.*;
import java.util.ArrayList;

public class EventoDao {

    private static String username = "root";
    private static String password = "root";
    private static String url = "jdbc:mysql://localhost:3306/basededatos3";

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
                evento.setFoto(rs.getBlob(5));
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
                evento.setFoto(rs.getBlob(5));
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

    public static ArrayList<Evento> listarEventos_limitado(int page, int pageSize) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Evento> lista = new ArrayList<>();

        String sql = "SELECT * FROM evento " +
                "ORDER BY fechaInicial DESC " +
                "LIMIT ?, ?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFechaInicial(rs.getDate(3));
                evento.setFechaFinal(rs.getDate(4));
                evento.setFoto(rs.getBlob(5));
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

    public int contarEventos() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        int count = 0;
        String sql = "SELECT COUNT(*) FROM evento";


        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)){
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
                    evento.setFoto(rs.getBlob(5));
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
                        "VALUES (?,?,?,?,?,?,?,?,?,?,'Cultural',?,'Pronto')";

                try(PreparedStatement pstmt = conn.prepareStatement(sql)){
                    pstmt.setString(1,evento.getNombre());
                    pstmt.setDate(2, evento.getFechaInicial());
                    pstmt.setDate(3,evento.getFechaFinal());
                    pstmt.setBlob(4,evento.getFoto());
                    pstmt.setString(5,evento.getMateriales());
                    pstmt.setString(6,evento.getLugar());
                    pstmt.setTime(7,evento.getHora());
                    pstmt.setInt(8,evento.getFrecuencia());
                    pstmt.setInt(9,evento.getVacantes());
                    pstmt.setString(10,evento.getDescripcion());
                    pstmt.setInt(11,evento.getIdProfesor());
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
}
