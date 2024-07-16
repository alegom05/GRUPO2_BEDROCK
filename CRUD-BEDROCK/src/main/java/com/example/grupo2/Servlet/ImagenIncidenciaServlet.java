package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Evento;
import com.example.grupo2.daos.EventoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(name = "ImagenIncidenciaServlet",value="/imagenIncidencia")
public class ImagenIncidenciaServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://35.196.35.10:3306/basededatos3?serverTimezone=America/Lima";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String incidenciaId = request.getParameter("id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Registrar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Obtener la conexión a la base de datos
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Consulta para obtener la imagen del evento
            String sql = "SELECT foto FROM incidencia WHERE idIncidenciaReportada = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, incidenciaId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("foto");
                if (blob != null) {
                    byte[] bytes = blob.getBytes(1, (int) blob.length());

                    response.setContentType("image/jpeg"); // Ajusta el tipo de contenido según el tipo de imagen
                    OutputStream os = response.getOutputStream();
                    os.write(bytes);
                    os.flush();
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // Imagen no encontrada
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Error accediendo a la base de datos", e);
        } finally {
            // Cerrar la conexión
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
