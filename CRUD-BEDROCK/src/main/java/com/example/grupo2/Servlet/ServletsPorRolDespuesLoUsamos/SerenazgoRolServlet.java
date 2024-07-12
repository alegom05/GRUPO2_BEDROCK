package com.example.grupo2.Servlet.ServletsPorRolDespuesLoUsamos;

import com.example.grupo2.Beans.*;
import com.example.grupo2.daos.EventoDao;
import com.example.grupo2.daos.IncidenciaDao;
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
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@MultipartConfig
@WebServlet(name = "Seren", value = "/Seren")
public class SerenazgoRolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "listar" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        EventoDao eventoDao = new EventoDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {
            //Pestaña Página Principal ***
            case "paginaPrincipal":
                //response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaPrincipal.jsp");
                break;

            //Pestaña Dashboard ***
            case "estadisticalizar":
                CantidadIncidencias cantidadIncidencias = incidenciaDao.hallarCantidadIncidencias();
                IncidenciasPorMes incidenciasPorMes = incidenciaDao.hallarIncidenciasPorMes();

                request.setAttribute("cantidad", cantidadIncidencias);
                request.setAttribute("porMes", incidenciasPorMes);

                /*view = request.getRequestDispatcher("/SerenazgoJSPS/dashboard-Serenazgo.jsp");
                view.forward(request, response);*/
                break;
            //Pestaña Actualizar Información ***
            case "actualizarS":
                String id = request.getParameter("id");
                if(usuarioDao.listarPorId(Integer.parseInt(id)) != null){
                    Usuario usuario = usuarioDao.listarPorId(Integer.parseInt(id));
                    if (usuario != null) {
                        request.setAttribute("usuarioSerenazgo", usuario);

                        view = request.getRequestDispatcher("/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp");
                view.forward(request, response);
                break;
            //Pestaña Incidencias***
            case "lista":
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidencias();
                request.setAttribute("lista", listaIncidencias);

                view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);
                break;


            //Este case será para el listado de eventos de coordinadora
            case "listaEventos":
                ArrayList<Evento> listaEventos2 = eventoDao.listarEventosParaCoordi();
                request.setAttribute("listaEventos",listaEventos2);

                view =request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventosNew.jsp");
                view.forward(request,response);
                break;

            //Case para crear eventos de coordinadoras
            case "formCrearEventos":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view.forward(request, response);
                break;

            //Case para editar eventos de coordinadoras
            case "editarEventos":
                String id2= request.getParameter("id");
                Evento evento = eventoDao.obtenerEventoPorId(id2);
                if (evento != null) {
                    request.setAttribute("evento", evento);
                    request.getRequestDispatcher("/CoordinadorasJSPS/ModificarEvento.jsp").forward(request,response);

                } else {
                    response.sendRedirect(request.getContextPath() + "/EventoServlet");
                }
                break;

            //Case para elminar eventos
            case "deleteEventos":
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

            //Este caso servirá para cuando la coordinadora desea revisar los detalles de alguno de sus eventos creados
            case "detallarParaCoordi":
                String idCoordi = request.getParameter("id");
                if(eventoDao.obtenerEventoPorId(idCoordi) != null){
                    Evento evento2 = eventoDao.obtenerEventoPorId(idCoordi);
                    if (evento2 != null) {
                        request.setAttribute("evento", evento2);

                        String estado = evento2.getEstadoEvento();
                        request.setAttribute("mostrarGuardar","Pronto".equals(estado));
                        request.setAttribute("mostrarIniciar", "Pronto".equals(estado));
                        request.setAttribute("mostrarCerrar","En curso".equals(estado));


                        view = request.getRequestDispatcher("/CoordinadorasJSPS/detallesEvento.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/HistorialDeEventosNew.jsp");
                view.forward(request, response);
                break;

            //Este case será para el listado de incidencias de coordinadora
            /*case "listaIncidencias":

                ArrayList<Incidencia> listaIncidencias2 = IncidenciaDao.listarIncidencias();
                request.setAttribute("lista2", listaIncidencias2);

                RequestDispatcher view2 = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view2.forward(request, response);
                break;*/

            case "detallarIncidencia":
                String id3 = request.getParameter("id");
                int idint = Integer.parseInt(id3);
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id3)) != null) {
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(idint);
                    request.setAttribute("incidencia", incidencia);
                    RequestDispatcher view1 = request.getRequestDispatcher("/CoordinadorasJSPS/detallesIncidencia.jsp");
                    view1.forward(request, response);
                }else {
                    System.out.println("Incidencia no encontrada para el ID: " + id3); // Log de incidencia no encontrada
                    //response.sendRedirect("error.jsp");
                }
                break;

            case "formCrearIncidencia":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidenciaVerisonPRUEBA.jsp");
                view.forward(request, response);
                break;

            //Para que la coordinadora visualice sus incidencias
            case "listaCoordi":
                String idCoordi2 = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidenciasCoordi = incidenciaDao.listarIncidenciasDeUnUsuario(idCoordi2);
                request.setAttribute("incidencia", listaIncidenciasCoordi);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request, response);
                break;

            //Pestaña Lista de vecinos ***
            case "listarve":
                ArrayList<Usuario> listaUsuario = usuarioDao.listarUsuarios();
                request.setAttribute("lista",listaUsuario);
                view =request.getRequestDispatcher("/CoordinadorasJSPS/VecinoSanmi.jsp");
                view.forward(request,response);
                break;
            //Pestaña Reportar incidencia ***
            /*case "formCrearInci":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidenciaVerisonPRUEBA.jsp");
                view.forward(request, response);
                break;*/
            //Pestaña Lista de incidencias -> Listar Coordis ***
            /*case "listaCoordi":
                String idCoordi = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidenciasCoordi = incidenciaDao.listarIncidenciasDeUnUsuario(idCoordi);
                request.setAttribute("incidencia", listaIncidenciasCoordi);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request, response);
                break;*/
            //Detalle de incidencia -> Detalles de una incidencia para Coordis
            /*case "detallar3":
                String id3 = request.getParameter("id");
                int idint = Integer.parseInt(id3);
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id3)) != null) {
                    Incidencia incidencia3 = incidenciaDao.obtenerIncidenciaPorId(idint);
                    request.setAttribute("incidencia", incidencia3);
                    RequestDispatcher view1 = request.getRequestDispatcher("/CoordinadorasJSPS/detallesIncidencia.jsp");
                    view1.forward(request, response);
                }else {
                    System.out.println("Incidencia no encontrada para el ID: " + id3); // Log de incidencia no encontrada
                    //response.sendRedirect("error.jsp");
                }
                break;*/
            //Pestaña Página Principal ***
            /*case "paginaPrincipal":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaPrincipal.jsp");
                break;*/
            /*case "reportarIncidencia":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ReportarIncidencia.jsp");
                break;*/
            /*case "listarIncidencias":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                break;*/
            //Pestaña Mira tu calendario ***
            case "calendario":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/Calendario.jsp");
                break;

            //Pestaña Historial de Eventos ***
            /*case "historialEventos":
                ArrayList<Evento> listaEventos = eventoDao.listarEventosCoordi2();
                request.setAttribute("listaEventos", listaEventos);
                view = request.getRequestDispatcher("/CoordinadorasJSPS/HistorialDeEventosNew.jsp");
                view.forward(request, response);
                break;*/
            //Vista Crear evento
            /*case "crearev":
                RequestDispatcher view22 = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view22.forward(request, response);
                break;*/
            /*case "detallarev":
                String id4 = request.getParameter("id");
                int idint4 = Integer.parseInt(id4);
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id4)) != null) {
                    Evento evento = eventoDao.obtenerEventoPorId(id4);
                    request.setAttribute("evento", evento);
                    RequestDispatcher view1 = request.getRequestDispatcher("/CoordinadorasJSPS/detallesEvento.jsp");
                    view1.forward(request, response);
                }else {
                    System.out.println("Incidencia no encontrada para el ID: " + id4); // Log de incidencia no encontrada
                    //response.sendRedirect("error.jsp");
                }
                break;*/
        }


    }


}
