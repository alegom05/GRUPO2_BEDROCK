package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.EventoDao;
import com.example.grupo2.daos.SerenazgosDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "EventoServlet", value = "/EventoServlet")
public class EventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        EventoDao eventoDao = new EventoDao();

        switch (action) {
            case "lista" -> {
                ArrayList<Evento> lista = eventoDao.listarEventos();
                request.setAttribute("lista",lista);
                RequestDispatcher view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventos.jsp");
                view.forward(request,response);

                break;
            }
            case "formCrear" -> {
                RequestDispatcher view = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view.forward(request, response);
                break;
            }
            case "editar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Evento evento = eventoDao.obtenerEventoPorId(id);
                if (evento != null) {
                    request.setAttribute("evento", evento);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                    requestDispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/Serenazgos");
                }
            }



        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        EventoDao eventoDao = new EventoDao();

        switch (action) {
            case "agregar" -> {
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String lugar = request.getParameter("lugar");
                String encargado = request.getParameter("encargado");
                String vacantes = request.getParameter("vacantes");
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");
                /*String diasDeLaSemana = request.getParameter("turno");*/

                /*PENDIENTE. CREAR EVENTO EN EVENTODAO
                eventoDao.crearEvento(nombre, descripcion, lugar, encargado, vacantes, fechaInicio, fechaFin);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");*/
            }
            /*case "actualizar" -> {
                Evento evento = leerParametrosRequest(request);
                eventoDao.actualizar(evento);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }
            case "borrar" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                serenazgosDao.eliminarSerenazgo(id);
                response.sendRedirect(request.getContextPath() + "/Serenazgos");
            }*/


        }
    }
    public Usuario leerParametrosRequest(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String tipo = request.getParameter("tipo");
        String turno = request.getParameter("turno");
        String correo = request.getParameter("correo");
        String contrasenia = request.getParameter("contrasenia");

        Usuario serenazgo = new Usuario();
        serenazgo.setId(id);
        serenazgo.setNumtelefono(telefono);
        serenazgo.setDireccion(direccion);
        serenazgo.setTipo(tipo);
        serenazgo.setTurnoSerenazgo(turno);
        serenazgo.setCorreo(correo);
        serenazgo.setClave(contrasenia);

        return serenazgo;
    }

}
