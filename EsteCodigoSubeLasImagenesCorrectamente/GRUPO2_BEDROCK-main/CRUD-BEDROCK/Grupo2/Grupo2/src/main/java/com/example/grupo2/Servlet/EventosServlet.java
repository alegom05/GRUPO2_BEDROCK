package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Eventos;
import com.example.grupo2.daos.EventosDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

@WebServlet(name = "EventosServlet", value = "/EventosServlet")
@MultipartConfig
public class EventosServlet extends HttpServlet {
    EventosDao dao = new EventosDao();
    Eventos evento = new Eventos();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion != null) {
            switch (accion) {
                case "Listar" -> {
                    ArrayList<Eventos> lista = dao.listarEventos();
                    request.setAttribute("lista", lista);
                    request.getRequestDispatcher("prueba.jsp").forward(request,response);
                }
                case "Nuevo" -> {
                    request.getRequestDispatcher("agregar.jsp").forward(request,response);
                }
                case "Guardar" -> {
                    String nom=request.getParameter("txtNom");
                    Part part=request.getPart("fileFoto");
                    InputStream inputStream=part.getInputStream();
                    evento.setNombre(nom);
                    evento.setFoto(inputStream);
                    dao.agregarnuevoevento(evento);
                    request.getRequestDispatcher("EventosServlet?accion=Listar").forward(request,response);
                }
                default -> {
                    request.getRequestDispatcher("EventosServlet?accion=Listar").forward(request, response);
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}