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
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.sql.Date;

@WebServlet(name = "EventoServlet", value = "/EventoServlet")
public class EventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        EventoDao eventoDao = new EventoDao();

        switch (action) {
            case "lista":
                ArrayList<Evento> lista = eventoDao.listarEventos();
                request.setAttribute("lista",lista);
                RequestDispatcher view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventos.jsp");
                view.forward(request,response);

                break;

            case "new":
                request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp").forward(request,response);
                break;

            case "editar":
                String id= request.getParameter("id");
                Evento evento = eventoDao.obtenerEventoPorId(id);
                if (evento != null) {
                    request.setAttribute("evento", evento);
                    request.getRequestDispatcher("/CoordinadorasJSPS/ModificarEvento.jsp").forward(request,response);

                } else {
                    response.sendRedirect(request.getContextPath() + "/EventoServlet");
                }
                break;


            case "delete":
                String ide= request.getParameter("id");
                Evento eventoo= eventoDao.obtenerEventoPorId(ide);
                if(eventoo!=null){
                    try{
                        eventoDao.borrarEvento(ide);
                    }catch (SQLException e){
                        System.out.println("Log:exception"+e.getMessage());

                    }
                }
                response.sendRedirect(request.getContextPath()+"/EventoServlet");
                break;

            //JSP
            case "eventos":
                response.sendRedirect(request.getContextPath() + "/VecinosJSPS/paginaEventos-Vecino.jsp");
                break;

            case "calendario":
                ArrayList<Evento> listaCalendario = eventoDao.listarEventosCalendario();
                request.setAttribute("listaCalendario",listaCalendario);
                response.sendRedirect(request.getContextPath() + "/VecinosJSPS/Calendario.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        String action = request.getParameter("action") == null ? "crear" : request.getParameter("action");
        EventoDao eventoDao = new EventoDao();

        switch (action) {
            case "crear":
                /*
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String lugar = request.getParameter("lugar");
                String encargado = request.getParameter("encargado");
                String vacantes = request.getParameter("vacantes");
                String fechaInicio = request.getParameter("fechaInicial");
                String fechaFin = request.getParameter("fechaFinal");
                String hora= request.getParameter("hora");

                boolean esValido= true;
                if(esValido){


                    Evento evento= eventoDao.obtenerEventoPorId();

                    if(evento==null){
                        Evento evento1 = new Evento();
                        evento1.setNombre(nombre);
                        evento1.setDescripcion(descripcion);
                        evento1.setLugar(lugar);
                        evento1.setIdProfesor(Integer.parseInt(encargado));
                        evento1.setVacantes(Integer.parseInt(vacantes));
                        evento1.setFechaInicial(Date.valueOf(fechaInicio));
                        evento1.setFechaFinal(Date.valueOf(fechaFin));
                        evento1.setHora(Time.valueOf(hora));

                        eventoDao.crearEvento(evento1);
                        response.sendRedirect(request.getContextPath()+"/EventoServlet");
                    }else{
                        request.getRequestDispatcher("CoordinadorasJSPS/CrearEvento.jsp").forward(request,response);
                    }
                }else{
                    request.getRequestDispatcher("CoordinadorasJSPS/CrearEvento.jsp").forward(request,response);
                }*/
                break;

            case "modificar":
                /*
                String nombre2 = request.getParameter("nombre");
                String descripcion2 = request.getParameter("descripcion");
                String lugar2 = request.getParameter("lugar");
                String encargado2 = request.getParameter("encargado");
                String vacantes2 = request.getParameter("vacantes");
                String fechaInicio2 = request.getParameter("fechaInicial");
                String fechaFin2 = request.getParameter("fechaFinal");
                String hora2= request.getParameter("hora");

                boolean esValido2= true;

                if(esValido2){
                    Evento evento2= new Evento();
                    evento2.setNombre(nombre2);
                    evento2.setDescripcion(descripcion2);
                    evento2.setLugar(lugar2);
                    evento2.setIdProfesor(Integer.parseInt(encargado2));
                    evento2.setVacantes(Integer.parseInt(vacantes2));
                    evento2.setFechaInicial(Date.valueOf(fechaInicio2));
                    evento2.setFechaFinal(Date.valueOf(fechaFin2));
                    evento2.setHora(Time.valueOf(hora2));

                    eventoDao.modificarEvento(evento2);
                    response.sendRedirect(request.getContextPath() + "/EventoServlet");

                }else{
                    request.setAttribute("evento",eventoDao.obtenerEventoPorId());
                    request.getRequestDispatcher("CoordinadorasJSPS/ModificarEvento.jsp");
                }

                 */
                break;

        }
    }
    /*public Usuario leerParametrosRequest(HttpServletRequest request) {
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
    }*/

}
