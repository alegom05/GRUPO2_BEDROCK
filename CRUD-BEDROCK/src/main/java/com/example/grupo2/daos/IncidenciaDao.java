package com.example.grupo2.daos;


import com.example.grupo2.Beans.CantidadIncidencias;
import com.example.grupo2.Beans.Incidencia;

import java.util.ArrayList;
import java.sql.*;
public class IncidenciaDao {

    public static ArrayList<Incidencia> listarIncidencias() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Incidencia> listaIncidencias = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "select i.idIncidenciaReportada, i.nombre , t.nombre as tipoIncidencia, DATE_FORMAT(i.fecha, '%d-%m-%Y %H:%i') AS fecha_formateada, i.estadoIncidencia ,concat(u.nombre,' ',u.apellido) as vecino, u.correo, i.lugar\n" +
                "                           from incidencia i\n" +
                "                            join usuario u on u.idUsuario=i.idUsuario\n" +
                "                           join tipo t on i.idtipo = t.idtipo\n" +
                "                            where i.isDeleted = 0;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Incidencia incidencia = new Incidencia();
                incidencia.setIdIncidencia(rs.getInt(1));
                incidencia.setNombreIncidencia(rs.getString(2));
                incidencia.setTipoIncidencia(rs.getString(3));
                incidencia.setFechaIncidencia(rs.getString(4));
                incidencia.setEstadoIncidencia(rs.getString(5));
                incidencia.setNombreUsuario(rs.getString(6));
                incidencia.setCorreoUsuario(rs.getString(7));
                incidencia.setLugar(rs.getString(8));

                listaIncidencias.add(incidencia);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaIncidencias);
        return listaIncidencias;
    }

    public Incidencia obtenerIncidenciaPorId(int id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        Incidencia incidencia = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        String sql = "select i.idIncidenciaReportada, i.nombre, i.descripcion, i.lugar, i.referencia, t.nombre as tipo, i.contacto, i.requiereAmbulancia,i.requiereBomberos,i.requierePolicia, concat(u.nombre, ' ', u.apellido) as usuario, i.foto, i.estadoIncidencia,DATE_FORMAT(i.fecha, '%Y-%m-%d %H:%i') AS fecha_formateada, i.criticidad, i.personalRefuerzo,i.descripcionSolucion\n" +
                "                           from incidencia i \n" +
                "                         join usuario u on u.idUsuario = i.idUsuario \n" +
                "                             join tipo t on i.idtipo = t.idtipo \n" +
                "                             where i.idIncidenciaReportada = ?;";

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
                    incidencia.setRequiereBomberos(rs.getBoolean(9));
                    incidencia.setRequierePolicia(rs.getBoolean(10));
                    incidencia.setUsuario(rs.getString(11));
                    incidencia.setFotoIncidencia(rs.getBytes(12));
                    incidencia.setEstadoIncidencia(rs.getString(13));
                    incidencia.setFechaIncidencia(rs.getString(14));
                    incidencia.setCriticidad(rs.getString(15));
                    incidencia.setPersonalRefuerzo(rs.getString(16));
                    incidencia.setDescripcionSolucion(rs.getString(17));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return incidencia;
    }

    public void borrarIncidencia(String id, String descripcionEliminacion) {
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE incidencia \n" +
                        "SET isDeleted = 1, descripcionEliminacion = ?\n" +
                        "WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1,descripcionEliminacion);
                    pstmt.setInt(2, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void crearIncidencia(Incidencia incidencia){
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "INSERT INTO incidencia (nombre,descripcion,lugar,referencia,contacto,requiereAmbulancia,foto,idUsuario,estadoIncidencia,idtipo,isDeleted) \n" +
                        "                        VALUES (?,?,?,?,?,?,?,?,\"Nueva\",?,0);";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1,incidencia.getNombreIncidencia());
                    pstmt.setString(2,incidencia.getDescripcion());
                    pstmt.setString(3,incidencia.getLugar());
                    pstmt.setString(4,incidencia.getReferencia());
                    if (incidencia.getContacto() != null) {
                        pstmt.setString(5, incidencia.getContacto());
                    } else {
                        pstmt.setNull(5, Types.VARCHAR); // Assuming contacto is a VARCHAR type
                    }
                    pstmt.setBoolean(6,incidencia.isRequiereAmbulancia());
                    if (incidencia.getFotoIncidencia() != null) {
                        pstmt.setBytes(7, incidencia.getFotoIncidencia());
                    } else {
                        pstmt.setNull(7, Types.BLOB); // Assuming foto is a BLOB type
                    }
                    pstmt.setInt(8,incidencia.getIdUsuario());
                    pstmt.setString(9,incidencia.getIdTipoIncidencia());

                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void editarEstadoFalsaAlarma(String id) {
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://127.0.0.1:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE incidencia SET estadoIncidencia = 'Falsa alarma' WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void editarEstadoCerrado(String id) {
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://127.0.0.1:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE incidencia SET estadoIncidencia = 'Cerrado' WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public CantidadIncidencias hallarCantidadIncidencias (){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        CantidadIncidencias cantidadIncidencias = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement("SELECT\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'nueva' THEN 1 ELSE 0 END) AS nuevas,\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'en proceso' THEN 1 ELSE 0 END) AS en_proceso,\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'falsa alarma' THEN 1 ELSE 0 END) AS falsa_alarma,\n" +
                     "    SUM(CASE WHEN estadoIncidencia = 'cerrado' THEN 1 ELSE 0 END) AS cerrado,\n" +
                     "    COUNT(*) AS total\n" +
                     "FROM incidencia;")) {

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cantidadIncidencias = new CantidadIncidencias();
                    cantidadIncidencias.setCantidadNuevas(rs.getInt(1));
                    cantidadIncidencias.setCantidadEnProceso(rs.getInt(2));
                    cantidadIncidencias.setCatidadFalsasAlarmas(rs.getInt(3));
                    cantidadIncidencias.setCantidadCerradas(rs.getInt(4));
                    cantidadIncidencias.setCantidadTotal(rs.getInt(5));

                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cantidadIncidencias;

    }

    public void evaluarIncidencias(Incidencia incidencia){
        try {
            String user = "root";
            String pass = "root";
            String url = "jdbc:mysql://localhost:3306/basedeDatos3";

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, pass);) {
                String sql = "UPDATE incidencia\n" +
                        "SET\n" +
                        "criticidad = ?,\n" +
                        "requiereBomberos = ?,\n" +
                        "requierePolicia = ?,\n" +
                        "requiereAmbulancia = ?,\n" +
                        "personalRefuerzo = ?,\n" +
                        "descripcionSolucion = ?,\n" +
                        "estadoIncidencia = 'En proceso'\n" +
                        "WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1,incidencia.getCriticidad());
                    pstmt.setBoolean(2,incidencia.isRequiereBomberos());
                    pstmt.setBoolean(3,incidencia.isRequierePolicia());
                    pstmt.setBoolean(4,incidencia.isRequiereAmbulancia());
                    pstmt.setString(5,incidencia.getPersonalRefuerzo());
                    pstmt.setString(6,incidencia.getDescripcionSolucion());
                    pstmt.setInt(7,incidencia.getIdIncidencia());
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public Incidencia verEvaluacion(int id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
        Incidencia incidencia = null;
        String url = "jdbc:mysql://localhost:3306/basededatos3";
        String username = "root";
        String password = "root";

        String sql = "SELECT  criticidad, requiereBomberos, requierePolicia, requiereAmbulancia, personalRefuerzo, descripcionSolucion, estadoIncidencia\n" +
                "FROM incidencia\n" +
                "WHERE idIncidenciaReportada = ?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    incidencia = new Incidencia();
                    incidencia.setCriticidad(rs.getString(1));
                    incidencia.setRequiereBomberos(rs.getBoolean(2));
                    incidencia.setRequierePolicia(rs.getBoolean(3));
                    incidencia.setRequiereAmbulancia(rs.getBoolean(4));
                    incidencia.setPersonalRefuerzo(rs.getString(5));
                    incidencia.setDescripcionSolucion(rs.getString(6));
                    incidencia.setEstadoIncidencia(rs.getString(7));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return incidencia;
    }

    public static ArrayList<Incidencia> listarIncidenciasDeUnUsuario(String id) {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Incidencia> listaIncidenciasUnUsuario = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "select i.nombre , t.nombre as tipoIncidencia, DATE_FORMAT(i.fecha, '%d-%m-%Y %H:%i') AS fecha_formateada, i.lugar\n" +
                "                                          from incidencia i\n" +
                "                                          join tipo t on i.idtipo = t.idtipo\n" +
                "                                         where i.isDeleted = 0 and idUsuario=?;";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Incidencia incidencia = new Incidencia();
                incidencia.setNombreIncidencia(rs.getString(1));
                incidencia.setTipoIncidencia(rs.getString(2));
                incidencia.setFechaIncidencia(rs.getString(3));
                incidencia.setLugar(rs.getString(4));

                listaIncidenciasUnUsuario.add(incidencia);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaIncidenciasUnUsuario);
        return listaIncidenciasUnUsuario;
    }






}
