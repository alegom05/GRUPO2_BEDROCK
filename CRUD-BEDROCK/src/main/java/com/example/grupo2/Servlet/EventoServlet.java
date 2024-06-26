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

import javax.swing.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;

@MultipartConfig
@WebServlet(name = "EventoServlet", value = "/EventoServlet")
public class EventoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        EventoDao eventoDao = new EventoDao();
        RequestDispatcher view;
        switch (action) {
            //Este case será para el listado de eventos de coordinadora
            case "lista":
                ArrayList<Evento> listaEventos2 = eventoDao.listarEventosParaCoordi();
                request.setAttribute("listaEventos",listaEventos2);

                view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventos.jsp");
                view.forward(request,response);

                break;

            case "formCrear":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view.forward(request, response);
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
            case "inscribirse_evento":
                UsuarioDao usuarioDao = new UsuarioDao();
                String idStrUsu = request.getParameter("idUsu");
                String idStrEvento = request.getParameter("idEven");
                if (idStrEvento != null && !idStrEvento.isEmpty() && idStrUsu != null && !idStrUsu.isEmpty()){
                    int idUsuario2 = Integer.parseInt(idStrUsu);
                    int idEvento = Integer.parseInt(idStrEvento);
                    int veri_usu = usuarioDao.esUsuario(idUsuario2);
                    int veri_even = usuarioDao.esEvento(idEvento);
                    if (veri_usu!=0 && veri_even!=0) {
                        request.setAttribute("IDusuario", idUsuario2);
                        request.setAttribute("IDevento", idEvento);
                        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/VecinosJSPS/inscribirse-Vecino.jsp");
                        requestDispatcher.forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/EventoServlet");
                    }
                }
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
                String descripcion = request.getParameter("descripcion");
                String lugar = request.getParameter("lugar");
                String encargado = request.getParameter("profesor");
                String vacantes = request.getParameter("vacantes");
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");

                String horaParam = request.getParameter("hora");

                String materiales= request.getParameter("materiales");
                String frecuencia= request.getParameter("frecuencia");

                String tipoEvento= request.getParameter("tipoEvento");

                Part filePart = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream foto = null;
                if (filePart != null && filePart.getSize() > 0) {
                    foto = filePart.getInputStream(); // Lee el contenido del archivo como un InputStream
                }
                System.out.println(nombre);
                System.out.println(descripcion);
                System.out.println(lugar);
                System.out.println(encargado);
                System.out.println(vacantes);
                System.out.println(fechaInicio);
                System.out.println(fechaFin);
                System.out.println(horaParam);
                System.out.println(materiales);
                System.out.println(frecuencia);
                System.out.println(tipoEvento);

                Evento evento1 = new Evento();

                try {
                    evento1.setNombre(nombre);
                    evento1.setDescripcion(descripcion);
                    evento1.setLugar(lugar);
                    evento1.setVacantes(Integer.parseInt(vacantes));
                    evento1.setFechaInicial(Date.valueOf(fechaInicio));
                    evento1.setFechaFinal(Date.valueOf(fechaFin));

                    // Validar y convertir la hora
                    if (horaParam != null && !horaParam.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                        long ms = sdf.parse(horaParam).getTime();
                        evento1.setHora(new Time(ms));
                    }

                    evento1.setMateriales(materiales);
                    evento1.setFrecuencia(Integer.parseInt(frecuencia));
                    evento1.setTipo(tipoEvento);
                    evento1.setFoto(foto);
                    evento1.setIdProfesor(4);

                    eventoDao.crearEvento(evento1);
                    response.sendRedirect(request.getContextPath() + "/EventoServlet?action=lista");

                } catch (NumberFormatException e) {
                    // Manejo de errores de formato de número
                    request.setAttribute("errorMessage", "El número de vacantes y la frecuencia deben ser números enteros.");
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                } catch (IllegalArgumentException e) {
                    // Manejo de errores de formato de fecha
                    request.setAttribute("errorMessage", "Formato de fecha inválido: debe ser yyyy-MM-dd.");
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                } catch (ParseException e) {
                    // Manejo de errores de formato de hora
                    request.setAttribute("errorMessage", "Formato de hora inválido: debe ser HH:mm.");
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                }
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
                System.out.println(evento1.getTipo());


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
                String idStrUsu = request.getParameter("IDusuario");
                String idStrEvento = request.getParameter("IDevento");
                Usuario acompanante= new Usuario();
                if (idStrEvento != null && !idStrEvento.isEmpty() && idStrUsu != null && !idStrUsu.isEmpty()){
                    int idUsuario3 = Integer.parseInt(idStrUsu);
                    int idEvento2 = Integer.parseInt(idStrEvento);
                    usuarioDao.inscribirEvento(idUsuario3,idEvento2);

                    // Obtener los acompañantes adicionales
                    for (int i = 1; i <= 3; i++) { // Suponiendo máximo 3 acompañantes
                        String i_str = String.valueOf(i); // Convertir el índice a String

                        String nombreAcomp = request.getParameter("nombreAcomp" + i_str);
                        String apellidoAcomp = request.getParameter("apellidoAcomp" + i_str);
                        String dniAcomp = request.getParameter("dniAcomp" + i_str);
                        if (nombreAcomp != null && !nombreAcomp.isEmpty() &&
                                apellidoAcomp != null && !apellidoAcomp.isEmpty() &&
                                dniAcomp != null && !dniAcomp.isEmpty()) {
                            acompanante.setNombre(nombreAcomp);
                            acompanante.setApellido(apellidoAcomp);
                            acompanante.setDni(dniAcomp);
                            usuarioDao.inscribirConAconpanante(acompanante,idUsuario3,idEvento2);
                        }
                        response.sendRedirect(request.getContextPath() + "/EventoServlet?action=listarEventoFiltrado");
                    }
                    /*try {
                        int idUsuario = Integer.parseInt(idStrUsu);
                        int idEvento = Integer.parseInt(idStrEvento);
                        usuarioDao.inscribirEvento(idUsuario, idEvento);
                        response.sendRedirect(request.getContextPath() + "/ruta/donde/quiere/redirigir");
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        response.sendRedirect(request.getContextPath() + "/ruta/error");
                    }*/
                } /*else {
                    response.sendRedirect(request.getContextPath() + "/ruta/error");
                }*/
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

        Usuario usuario = new Usuario();
        usuario.setId(id);
        usuario.setNumtelefono(telefono);
        usuario.setDireccion(direccion);
        usuario.setTipo(tipo);
        usuario.setTurnoSerenazgo(turno);
        usuario.setCorreo(correo);
        usuario.setClave(contrasenia);

        return usuario;
    }*/

}
