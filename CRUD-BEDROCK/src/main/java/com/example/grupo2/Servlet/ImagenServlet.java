package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.daos.IncidenciaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
@WebServlet("/imagenIncidenciaMostrar")
public class ImagenServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de imagen no proporcionado");
            return;
        }

        IncidenciaDao incidenciaDao = new IncidenciaDao();
        Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id));

        if (incidencia == null || incidencia.getFoto() == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Imagen no encontrada");
            return;
        }

        String imagePath = getServletContext().getRealPath("/") + incidencia.getFoto();
        File imageFile = new File(imagePath);

        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Archivo de imagen no encontrado: " + imagePath);
            return;
        }

        String contentType = getServletContext().getMimeType(imagePath);
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);

        System.out.println("ID recibido: " + id);
        System.out.println("Ruta de la imagen: " + imagePath);
        System.out.println("¿El archivo existe? " + imageFile.exists());

        try (FileInputStream fis = new FileInputStream(imageFile);
             OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }


}