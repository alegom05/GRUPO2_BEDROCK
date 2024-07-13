package com.example.grupo2.daos;

import com.example.grupo2.Beans.Profesores;
import com.example.grupo2.Beans.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfesoresDao extends daoBase{

    public ArrayList<Profesores> obtenerProfesores(){

        ArrayList<Profesores> listaProfesores = new ArrayList<>();
        try (Connection conn = this.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT nombre, apellido, curso, idProfesor FROM basededatos3.profesor")){
            while (rs.next()){
                Profesores profesor = new Profesores();
                profesor.setNombre(rs.getString(1));
                profesor.setApellido(rs.getString(2));
                profesor.setCurso(rs.getString(3));
                profesor.setId(rs.getInt(4));
                listaProfesores.add(profesor);
                System.out.println(profesor);
            }
        }catch (SQLException e) {
            System.out.println("No se pudo realizar la busqueda");
        }
        return listaProfesores;
    }

    public void crearProfesores(String nombre, String apellido, String curso){

        String sql = "INSERT INTO `basededatos3`.`profesor` (`nombre`, `apellido`, `curso`) VALUES (?, ?, ?)";

        try (Connection connection = this.getConnection();
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

        String sql = "DELETE FROM profesor WHERE idProfesor = ?";

        try (Connection connection = getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Profesores buscarPorIdProf(int id) {
        Profesores profesor = null;

        String sql = "SELECT * FROM profesor where idProfesor = ?";

        try (Connection connection = getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery();) {

                if (rs.next()) {
                    profesor = new Profesores();
                    profesor.setId(rs.getInt(1));
                    profesor.setNombre(rs.getString(2));
                    profesor.setApellido(rs.getString(3));
                    profesor.setCurso(rs.getString(4));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return profesor;
    }
    public void actualizar(Profesores serenazgo) {

        String sql = "UPDATE profesor SET curso=? where idProfesor=?";

        try (Connection connection = getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql);) {

            pstmt.setString(1, serenazgo.getCurso());
            pstmt.setInt(2, serenazgo.getId());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    //se implementa para el combobox de crear evento en coordis
    public List<Profesores> listandoProfesores() {
        List<Profesores> listaProfesores = new ArrayList<>();
        String sql = "SELECT nombre, apellido, curso, idProfesor FROM basededatos3.profesor";

        try (Connection conn = getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql);
             ResultSet rs = preparedStatement.executeQuery()) {


            while (rs.next()) {
                Profesores profesor = new Profesores();
                profesor.setNombre(rs.getString("nombre"));
                profesor.setApellido(rs.getString("apellido"));
                profesor.setCurso(rs.getString("curso"));
                profesor.setId(rs.getInt("idProfesor"));
                listaProfesores.add(profesor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaProfesores;
    }
}
