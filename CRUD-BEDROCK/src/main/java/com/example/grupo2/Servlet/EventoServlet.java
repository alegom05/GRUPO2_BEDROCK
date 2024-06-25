package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.EventoDao;
import com.example.grupo2.daos.IncidenciaDao;
import com.example.grupo2.daos.SerenazgosDao;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.sql.Date;

@MultipartConfig
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
                String idCoordii= request.getParameter("idUsuario");

                ArrayList<Evento> listaEventos2 = eventoDao.listarEventosCoordi(idCoordii);
                request.setAttribute("evento",listaEventos2);
                RequestDispatcher view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventos.jsp");
                view.forward(request,response);

                break;
            case "lista2":
                String idCoordinadora = request.getParameter("idUsuario");
                //ArrayList<Evento> listaEventosCoordi = eventoDao.


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
                String idUsuario1 = request.getParameter("idUsuario");
                ArrayList<Evento> listaVeciCale = eventoDao.listarEventosporIdUsuario(idUsuario1);
                request.setAttribute("listaCalendario",listaVeciCale);
                view = request.getRequestDispatcher("/VecinosJSPS/Calendario.jsp");
                view.forward(request, response);
                break;

            case "listaEventosVecino":
                String idUsuario = request.getParameter("idUsuario");
                ArrayList<Evento> listaVeci = eventoDao.listarEventosporIdUsuario(idUsuario);
                request.setAttribute("listaEventos",listaVeci);
                view = request.getRequestDispatcher("/VecinosJSPS/historialEventosVecino.jsp");
                view.forward(request, response);
                break;
            case "evento_detallados":
                String id_ev = request.getParameter("id");
                if (id_ev == null || id_ev.isEmpty()) {
                    id_ev = "default_value"; // Valor por defecto si 'id' está vacío
                }
                request.setAttribute("id", id_ev);
                response.sendRedirect(request.getContextPath() + "/VecinosJSPS/EventosDetallado.jsp?id=" + id_ev);
                break;
            case "listarEventoFiltrado":
                int pageSize = 6;
                String filtro = request.getParameter("filtro"); // Obtener filtro
                int totalEvents = eventoDao.contarEventos(filtro);
                int totalPages = (int) Math.ceil(totalEvents / (double) pageSize);
                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

                ArrayList<Evento> listaEventos = eventoDao.listarEventos_limitado(currentPage, pageSize, filtro);

                request.setAttribute("totalPages", totalPages);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("listaEventos", listaEventos);
                request.setAttribute("filtro", filtro); // Pasar el filtro a la vista
                request.getRequestDispatcher("/VecinosJSPS/paginaEventos-Vecino.jsp").forward(request, response);
                break;

            //Este caso servirá para cuando la coordinadora desea revisar los detalles de alguno de sus eventos creados
            case "detallarParaCoordi":
                String idCoordi = request.getParameter("id");
                if(eventoDao.obtenerEventoPorId(idCoordi) != null){
                    Evento evento2 = eventoDao.obtenerEventoPorId(idCoordi);
                    if (evento2 != null) {
                        request.setAttribute("evento", evento2);

                        String estado = evento2.getEstadoEvento();
                        /*request.setAttribute("mostrarEvaluar", "Nueva".equals(estado));
                        request.setAttribute("mostrarVerEvaluacion", "En proceso".equals(estado));
                        request.setAttribute("mostrarFalsaAlarma", "Nueva".equals(estado) || "En proceso".equals(estado));
                        request.setAttribute("mostrarCerrar","En proceso".equals(estado));*/


                        view = request.getRequestDispatcher("/CoordinadorasJSPS/detallesEvento.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/HistorialDeEventos.jsp");
                view.forward(request, response);
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

                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("detalles");
                String lugar = request.getParameter("lugar");
                String encargado = request.getParameter("profesor");
                String vacantes = request.getParameter("vacantes");
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");
                String hora= request.getParameter("hora");
                String materiales= request.getParameter("materiales");
                String frecuencia= request.getParameter("frecuencia");


                Part filePart= request.getPart("imagen");
                InputStream foto= null;
                if (filePart != null && filePart.getSize() >0){
                    foto= filePart.getInputStream();
                }


                Evento evento1 = new Evento();

                evento1.setNombre(nombre);
                evento1.setDescripcion(descripcion);
                evento1.setLugar(lugar);
                evento1.setIdProfesor(Integer.parseInt(encargado));
                evento1.setVacantes(Integer.parseInt(vacantes));
                evento1.setFechaInicial(Date.valueOf(fechaInicio));
                evento1.setFechaFinal(Date.valueOf(fechaFin));
                evento1.setHora(Time.valueOf(hora));
                evento1.setMateriales(materiales);
                evento1.setFrecuencia(Integer.parseInt(frecuencia));

                eventoDao.crearEvento(evento1);

                System.out.println(evento1.getNombre());
                System.out.println(evento1.getDescripcion());
                System.out.println(evento1.getLugar());
                System.out.println(evento1.getIdProfesor());
                System.out.println(evento1.getVacantes());
                System.out.println(evento1.getFechaInicial());
                System.out.println(evento1.getFechaFinal());
                System.out.println(evento1.getHora());
                System.out.println(evento1.getMateriales());
                System.out.println(evento1.getFrecuencia());

                response.sendRedirect(request.getContextPath()+"/EventoServlet?action=lista");


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
            case "inscribirse":
                UsuarioDao usuarioDao = new UsuarioDao();
                Usuario acompanante= new Usuario();
                String idUsuarioStr = request.getParameter("idUsuario");
                if (idUsuarioStr != null && !idUsuarioStr.isEmpty()){
                    int idUsuario = Integer.parseInt(idUsuarioStr);
                    //usuarioDao.obtenerUsuarioPorID();
                }
                // Obtener los acompañantes adicionales
                ArrayList<Usuario> lista_acompanantes = new ArrayList<>();
                for (int i = 1; i <= 3; i++) { // Suponiendo máximo 3 acompañantes
                    String nombreAcomp = request.getParameter("nombreAcomp" + i);
                    String apellidoAcomp = request.getParameter("apellidoAcomp" + i);
                    String dniAcomp = request.getParameter("dniAcomp" + i);
                    if (nombreAcomp != null && !nombreAcomp.isEmpty() &&
                            apellidoAcomp != null && !apellidoAcomp.isEmpty() &&
                            dniAcomp != null && !dniAcomp.isEmpty()) {
                        acompanante.setNombre(nombreAcomp);
                        acompanante.setNombre(apellidoAcomp);
                        acompanante.setNombre(dniAcomp);
                        lista_acompanantes.add(acompanante);
                    }
                }
                //response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=lista3&idUsuario=" + idUsuario);

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
