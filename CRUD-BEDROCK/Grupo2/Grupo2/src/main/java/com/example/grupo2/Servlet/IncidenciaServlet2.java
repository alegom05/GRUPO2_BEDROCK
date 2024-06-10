package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.daos.IncidenciaDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "IncidenciaServlet2",value = {"/IncidenciaServlet2"})
public class IncidenciaServlet2 extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        RequestDispatcher view;

        switch (action) {
            case "lista":
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidencias();

                request.setAttribute("lista", listaIncidencias);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request, response);


                break;
            case "detallar":
                String id = request.getParameter("id");
                if(incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id)) != null){
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id));
                    if (incidencia != null) {
                        request.setAttribute("incidencia", incidencia);
                        view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("nuevoTrabajo2.jsp");
                view.forward(request, response);
                break;

            case "borrar":
                String idd = request.getParameter("id");
                if(incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(idd)) != null){
                    incidenciaDao.borrarIncidencia(idd); //Agregar método a Daos
                }
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet2");
                break;
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
