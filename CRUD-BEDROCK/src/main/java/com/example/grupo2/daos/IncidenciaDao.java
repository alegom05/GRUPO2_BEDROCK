package com.example.grupo2.daos;


import com.example.grupo2.Beans.CantidadIncidencias;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.IncidenciasPorMes;
import com.example.grupo2.Beans.Usuario;

import java.io.InputStream;
import java.util.ArrayList;
import java.sql.*;
public class IncidenciaDao extends daoBase {

    public ArrayList<Incidencia> listarIncidencias() {

        ArrayList<Incidencia> listaIncidencias = new ArrayList<>();

        String sql = "select i.idIncidenciaReportada, i.nombre , t.nombre as tipoIncidencia, DATE_FORMAT(i.fecha, '%d-%m-%Y %H:%i') AS fecha_formateada, i.estadoIncidencia ,concat(u.nombre,' ',u.apellido) as vecino, u.correo, i.lugar\n" +
                "                           from incidencia i\n" +
                "                            join usuario u on u.idUsuario=i.idUsuario\n" +
                "                           join tipo t on i.idtipo = t.idtipo\n" +
                "                            where i.isDeleted = 0;";

        try (Connection conn = this.getConnection();
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

        Incidencia incidencia = null;

        String sql = "select i.idIncidenciaReportada, i.nombre, i.descripcion, i.lugar, i.referencia, t.nombre as tipo, i.contacto, i.requiereAmbulancia,i.requiereBomberos,i.requierePolicia, concat(u.nombre, ' ', u.apellido) as usuario, i.foto, i.estadoIncidencia,DATE_FORMAT(i.fecha, '%d-%m-%Y %H:%i') AS fecha_formateada, i.criticidad, i.personalRefuerzo,i.descripcionSolucion\n" +
                "                           from incidencia i \n" +
                "                         join usuario u on u.idUsuario = i.idUsuario \n" +
                "                             join tipo t on i.idtipo = t.idtipo \n" +
                "                             where i.idIncidenciaReportada = ?;";

        try (Connection conn = this.getConnection();
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
                    /*
                    // Obtener la foto como InputStream desde el Blob
                    Blob fotoBlob = rs.getBlob(12);
                    if (fotoBlob != null) {
                        incidencia.setFotoIncidencia(fotoBlob.getBinaryStream());
                    } else {
                        incidencia.setFotoIncidencia(null);
                    }*/
                    incidencia.setFoto(rs.getString(12));
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

            try (Connection conn = this.getConnection();) {
                String sql = "UPDATE incidencia \n" +
                        "SET isDeleted = 1, descripcionEliminacion = ?\n" +
                        "WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1,descripcionEliminacion);
                    pstmt.setInt(2, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void crearIncidencia(Incidencia incidencia) {
        try {
            try (Connection conn = this.getConnection()) {
                String sql = "INSERT INTO incidencia (nombre, descripcion, lugar, referencia, contacto, requiereAmbulancia, foto, idUsuario, estadoIncidencia, idtipo, isDeleted) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Nueva', ?, 0)";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, incidencia.getNombreIncidencia());
                    pstmt.setString(2, incidencia.getDescripcion());
                    pstmt.setString(3, incidencia.getLugar());
                    pstmt.setString(4, incidencia.getReferencia());
                    if (incidencia.getContacto() != null) {
                        pstmt.setString(5, incidencia.getContacto());
                    } else {
                        pstmt.setNull(5, Types.VARCHAR);
                    }
                    pstmt.setBoolean(6, incidencia.isRequiereAmbulancia());
                    if (incidencia.getFotoIncidencia() != null) {
                        pstmt.setBlob(7, incidencia.getFotoIncidencia());
                    } else {
                        pstmt.setNull(7, Types.BLOB);
                    }
                    pstmt.setInt(8, incidencia.getIdUsuario());
                    pstmt.setString(9, incidencia.getIdTipoIncidencia());
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void editarEstadoFalsaAlarma(String idIncidencia) {
        try (Connection conn = this.getConnection()) {
            // Primero, actualizamos el estado de la incidencia a "Falsa alarma"
            String sqlUpdateIncidencia = "UPDATE incidencia SET estadoIncidencia = 'Falsa alarma' WHERE idIncidenciaReportada = ?";
            try (PreparedStatement pstmtUpdateIncidencia = conn.prepareStatement(sqlUpdateIncidencia)) {
                pstmtUpdateIncidencia.setInt(1, Integer.parseInt(idIncidencia));
                pstmtUpdateIncidencia.executeUpdate();
            }

            // Segundo, incrementamos el contador falsasAlarmasReportadas en la tabla usuario
            String sqlUpdateUsuario = "UPDATE usuario SET falsasAlarmasReportadas = falsasAlarmasReportadas + 1 WHERE idUsuario = (SELECT idUsuario FROM incidencia WHERE idIncidenciaReportada = ?)";
            try (PreparedStatement pstmtUpdateUsuario = conn.prepareStatement(sqlUpdateUsuario)) {
                pstmtUpdateUsuario.setInt(1, Integer.parseInt(idIncidencia));
                pstmtUpdateUsuario.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void editarEstadoCerrado(String id) {
        try {

            try (Connection conn = this.getConnection();) {
                String sql = "UPDATE incidencia SET estadoIncidencia = 'Cerrado' WHERE idIncidenciaReportada = ?;";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setInt(1, Integer.parseInt(id));
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public CantidadIncidencias hallarCantidadIncidencias (){

        CantidadIncidencias cantidadIncidencias = null;


        try (Connection conn = this.getConnection();
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
            try (Connection conn = this.getConnection();) {
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
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Incidencia verEvaluacion(int id) {

        Incidencia incidencia = null;

        String sql = "SELECT  criticidad, requiereBomberos, requierePolicia, requiereAmbulancia, personalRefuerzo, descripcionSolucion, estadoIncidencia\n" +
                "FROM incidencia\n" +
                "WHERE idIncidenciaReportada = ?;";

        try (Connection conn = this.getConnection();
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

    public  ArrayList<Incidencia> listarIncidenciasDeUnUsuario(String id) {

        ArrayList<Incidencia> listaIncidenciasUnUsuario = new ArrayList<>();

        String sql = "select i.idIncidenciaReportada,i.nombre , t.nombre as tipoIncidencia, DATE_FORMAT(i.fecha, '%d-%m-%Y %H:%i') AS fecha_formateada, i.lugar\n" +
                "                                          from incidencia i\n" +
                "                                          join tipo t on i.idtipo = t.idtipo\n" +
                "                                         where i.isDeleted = 0 and idUsuario=?;";

        try (Connection conn = this.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Incidencia incidencia = new Incidencia();
                incidencia.setIdIncidencia(rs.getInt(1));
                incidencia.setNombreIncidencia(rs.getString(2));
                incidencia.setTipoIncidencia(rs.getString(3));
                incidencia.setFechaIncidencia(rs.getString(4));
                incidencia.setLugar(rs.getString(5));

                listaIncidenciasUnUsuario.add(incidencia);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaIncidenciasUnUsuario);
        return listaIncidenciasUnUsuario;
    }

    public IncidenciasPorMes hallarIncidenciasPorMes() {

        IncidenciasPorMes incidenciasPorMes = null;
        String sql = "SELECT\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 1 THEN 1 ELSE 0 END) AS Enero,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 2 THEN 1 ELSE 0 END) AS Febrero,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 3 THEN 1 ELSE 0 END) AS Marzo,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 4 THEN 1 ELSE 0 END) AS Abril,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 5 THEN 1 ELSE 0 END) AS Mayo,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 6 THEN 1 ELSE 0 END) AS Junio,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 7 THEN 1 ELSE 0 END) AS Julio,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 8 THEN 1 ELSE 0 END) AS Agosto,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 9 THEN 1 ELSE 0 END) AS Septiembre,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 10 THEN 1 ELSE 0 END) AS Octubre,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 11 THEN 1 ELSE 0 END) AS Noviembre,\n" +
                "    SUM(CASE WHEN MONTH(fecha) = 12 THEN 1 ELSE 0 END) AS Diciembre\n" +
                "FROM \n" +
                "    incidencia\n" +
                "WHERE \n" +
                "    YEAR(fecha) = 2024;";
        try (Connection connection = this.getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            try (ResultSet rs = pstmt.executeQuery();) {

                if (rs.next()) {
                    incidenciasPorMes = new IncidenciasPorMes();
                   incidenciasPorMes.setEneroIncidencias(rs.getInt(1));
                   incidenciasPorMes.setFebreroIncidencias(rs.getInt(2));
                   incidenciasPorMes.setMarzoIncidencias(rs.getInt(3));
                   incidenciasPorMes.setAbrilIncidencias(rs.getInt(4));
                   incidenciasPorMes.setMayoIncidencias(rs.getInt(5));
                   incidenciasPorMes.setJunioIncidencias(rs.getInt(6));
                   incidenciasPorMes.setJulioIncidencias(rs.getInt(7));
                   incidenciasPorMes.setAugustIncidencias(rs.getInt(8));
                   incidenciasPorMes.setSeptiemIncidencias(rs.getInt(9));
                   incidenciasPorMes.setOctopusIncidencias(rs.getInt(10));
                   incidenciasPorMes.setNovemIncidencias(rs.getInt(11));
                   incidenciasPorMes.setDezemIncidencias(rs.getInt(12));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        return incidenciasPorMes;
    }






}
