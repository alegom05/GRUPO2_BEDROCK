package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Incidencia;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ExportarPDFServlet")
public class ExportarPDFServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=detalles_incidencia.pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Incidencia incidencia = (Incidencia) request.getSession().getAttribute("incidenciaParaExportar");

            document.add(new Paragraph("Detalles de incidencia"));
            document.add(new Paragraph("Estado: " + incidencia.getEstadoIncidencia()));
            document.add(new Paragraph("Fecha de reporte: " + incidencia.getFechaIncidencia()));
            document.add(new Paragraph("Incidencia: " + incidencia.getNombreIncidencia()));
            document.add(new Paragraph("Descripción: " + incidencia.getDescripcion()));
            document.add(new Paragraph("Lugar: " + incidencia.getLugar()));
            document.add(new Paragraph("Referencia: " + incidencia.getReferencia()));
            document.add(new Paragraph("Tipo de incidencia: " + incidencia.getTipoIncidencia()));
            document.add(new Paragraph("Contacto: " + incidencia.getContacto()));
            document.add(new Paragraph("Requiere Ambulancia: " + (incidencia.isRequiereAmbulancia() ? "Sí" : "No")));
            document.add(new Paragraph("Usuario que reportó: " + incidencia.getUsuario()));

            document.close();
        } catch (DocumentException e) {
            throw new ServletException(e);
        }
    }
}