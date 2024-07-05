package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Solicitudes;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.SerenazgosDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "Solicitudes", value = "/Solicitudes")
public class SolicitudesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();
        switch (action) {
            case "listar" -> {
                ArrayList<Solicitudes> listaSolicitudes = serenazgosDao.obtenerSolicitudes();
                request.setAttribute("solicitudes", listaSolicitudes);
                RequestDispatcher view = request.getRequestDispatcher("/AdministradorJSPS/solicitudes-Admin.jsp");
                view.forward(request, response);
            }
            case "aprobar" -> {
                int idsolicitud = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.aprobarSolicitud(idsolicitud);
                response.sendRedirect(request.getContextPath() + "/Solicitudes");

            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        SerenazgosDao serenazgosDao = new SerenazgosDao();
        switch (action) {
            case "rechazar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.rechazarSolicitud(id);
                response.sendRedirect(request.getContextPath() + "/Solicitudes");
            }
        }
    }
}
