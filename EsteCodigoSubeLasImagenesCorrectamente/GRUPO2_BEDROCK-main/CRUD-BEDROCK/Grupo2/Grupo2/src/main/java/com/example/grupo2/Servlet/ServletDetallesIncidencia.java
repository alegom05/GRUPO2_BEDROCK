package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.DetallesIncidencia;
import com.example.grupo2.daos.DetallesIncidenciaDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name="ServletDetallesIncidencia", value="/ServletDetallesIncidencia")
public class ServletDetallesIncidencia extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        /*IncidenciaDao3 incidenciaDao3 = new IncidenciaDao3();
        ArrayList<Incidencia3> listarDetalles = incidenciaDao3.listarDetalles();

        request.setAttribute("lista", listarDetalles);

        RequestDispatcher view = request.getRequestDispatcher("detallesIncidencia-Serenazgo.jsp");
        view.forward(request,response);*/

        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            DetallesIncidenciaDao detallesIncidenciaDao = new DetallesIncidenciaDao();
            DetallesIncidencia incidencia = detallesIncidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id));

            if (incidencia != null) {
                request.setAttribute("incidencia", incidencia);
                RequestDispatcher view = request.getRequestDispatcher("detallesIncidencia-Serenazgo.jsp");
                view.forward(request, response);
            } else {
                response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
            }
        } else {
            response.sendRedirect("error.jsp"); // Página de error en caso de que el ID sea nulo o vacío
        }
    }
}



