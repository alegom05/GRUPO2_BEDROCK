package com.example.grupo2.daos;

import com.example.grupo2.Beans.Profesores;

import java.sql.*;
import java.util.ArrayList;

public class ProfesoresDao {
    private static String user = "root";
    private static String pass = "root";
    private static String url = "jdbc:mysql://localhost:3306/basededatos3";

    public ArrayList<Profesores> obtenerProfesores(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        ArrayList<Profesores> listaProfesores = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(url, user, pass);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT nombre, apellido, curso, idProfesor FROM basededatos3.profesor")){
            while (rs.next()){
                Profesores profesor = new Profesores();
                profesor.setNombre(rs.getString(1));
                profesor.setApellido(rs.getString(2));
                profesor.setCurso(rs.getString(3));
                profesor.setId(rs.getString(4));
                listaProfesores.add(profesor);
                System.out.println(profesor);
            }
        }catch (SQLException e) {
            System.out.println("No se pudo realizar la busqueda");
        }
        return listaProfesores;
    }

    public void crearProfesores(String nombre, String apellido, String curso){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        String sql = "INSERT INTO `basededatos3`.`profesor` (`nombre`, `apellido`, `curso`) VALUES (?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, nombre);
            pstmt.setString(2, apellido);
            pstmt.setString(3, curso);

            pstmt.executeUpdate();
            System.out.print("aqui estoy");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public void eliminarProfesor(String id) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String sql = "DELETE FROM profesor WHERE idProfesor = ?";

        try (Connection connection = DriverManager.getConnection(url, user, pass);
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
