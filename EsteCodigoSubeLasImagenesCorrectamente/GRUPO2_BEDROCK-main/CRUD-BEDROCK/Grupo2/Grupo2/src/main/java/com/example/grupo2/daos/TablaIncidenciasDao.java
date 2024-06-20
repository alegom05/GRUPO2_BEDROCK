package com.example.grupo2.daos;

import com.example.grupo2.Beans.TablaIncidencias;

import java.util.ArrayList;
import java.sql.*;

public class TablaIncidenciasDao {

    public static ArrayList<TablaIncidencias> listarIncidencias() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<TablaIncidencias> listaIncidencias = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?";
        String username = "root";
        String password = "root";

        String sql = "select i.idIncidenciaReportada, i.nombre , t.nombre as tipoIncidencia, i.estadoIncidencia ,concat(u.nombre,' ',u.apellido) as vecino, u.correo\n" +
                "from incidencia i\n" +
                "join usuario u on u.idUsuario=i.idUsuario\n" +
                "join tipo t on i.idtipo = t.idtipo;";

            try (Connection conn = DriverManager.getConnection(url, username, password);
                 PreparedStatement pstmt = conn.prepareStatement(sql);
                 ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    TablaIncidencias tablaIncidencias = new TablaIncidencias();
                    tablaIncidencias.setIdIncidencia(rs.getInt(1));
                    tablaIncidencias.setNombreIncidencia(rs.getString(2));
                    tablaIncidencias.setTipoIncidencia(rs.getString(3));
                    tablaIncidencias.setEstadoIncidencia(rs.getString(4));
                    tablaIncidencias.setNombreUsuario(rs.getString(5));
                    tablaIncidencias.setCorreoUsuario(rs.getString(6));

                    listaIncidencias.add(tablaIncidencias);
                }
            } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        System.out.println(listaIncidencias);
        return listaIncidencias;
    }
}
