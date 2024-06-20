package com.example.grupo2.daos;

import com.example.grupo2.Beans.Eventos;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

public class EventosDao {
    public ArrayList<Eventos> listarEventos(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        ArrayList<Eventos> listaeventos = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/basededatos3?serverTimezone=America/Lima";
        String username = "root";
        String password = "root";

        String sql = "SELECT * FROM basededatos3.evento";

        try (Connection conn = DriverManager.getConnection(url, username, password)){
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Eventos evento=new Eventos();
                evento.setIdEvento(rs.getInt(1));
                evento.setNombre(rs.getString(2));
                evento.setFoto(rs.getBinaryStream(5));
                listaeventos.add(evento);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return listaeventos;
    }
    public void agregarnuevoevento(Eventos evento){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }

        String url = "jdbc:mysql://localhost:3306/basededatos3?serverTimezone=America/Lima";
        String username = "root";
        String password = "root";

        String sql = "INSERT INTO evento(nombre,foto) values(?,?)";

        try (Connection conn = DriverManager.getConnection(url, username, password)){
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,evento.getNombre());
            pstmt.setBlob(2,evento.getFoto());
            pstmt.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
