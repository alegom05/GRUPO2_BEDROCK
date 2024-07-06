package com.example.grupo2.Servlet.ServletsPorRolDespuesLoUsamos;

import com.example.grupo2.Beans.Evento;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.Beans.Usuario;
import com.example.grupo2.daos.EventoDao;
import com.example.grupo2.daos.IncidenciaDao;
import com.example.grupo2.daos.UsuarioDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet(name = "Coordis", value = "/Coordis")
public class CoordisRolServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Incidencia incidencia = new Incidencia();
        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        EventoDao eventoDao = new EventoDao();
        UsuarioDao usuarioDao = new UsuarioDao();
        RequestDispatcher view;

        switch (action) {
            case "listarin":
                String id = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidenciasDeUnUsuario(id);
                request.setAttribute("lista",listaIncidencias);

                view =request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request,response);
                break;

            //Pestaña Lista de vecinos ***
            case "listarve":
                ArrayList<Usuario> listaUsuario = usuarioDao.listarUsuarios();
                request.setAttribute("lista",listaUsuario);
                view =request.getRequestDispatcher("/CoordinadorasJSPS/VecinoSanmi.jsp");
                view.forward(request,response);
                break;
            //Pestaña Reportar incidencia ***
            case "formCrearInci":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidenciaVerisonPRUEBA.jsp");
                view.forward(request, response);
                break;
            //Pestaña Lista de incidencias -> Listar Coordis ***
            case "listaCoordi":
                String idCoordi = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidenciasCoordi = incidenciaDao.listarIncidenciasDeUnUsuario(idCoordi);
                request.setAttribute("incidencia", listaIncidenciasCoordi);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view.forward(request, response);
                break;
            //Detalle de incidencia -> Detalles de una incidencia para Coordis
            case "detallar3":
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
                break;
            //Pestaña Página Principal ***
            case "paginaPrincipal":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaPrincipal.jsp");
                break;
            case "Eventos":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaEventos.jsp");
                break;
            case "reportarIncidencia":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ReportarIncidencia.jsp");
                break;
            case "listarIncidencias":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                break;
            //Pestaña Mira tu calendario ***
            case "calendario":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/Calendario.jsp");
                break;
            //Pestaña Historial de Eventos ***
            case "historialEventos":
                response.sendRedirect(request.getContextPath() + "/CoordinadorasJSPS/PaginaEventos.jsp");
                break;
            //Crear evento -> vista
            case "crearev":
                RequestDispatcher view2 = request.getRequestDispatcher("/CoordinadorasJSPS/CrearEvento.jsp");
                view2.forward(request, response);
                break;
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("a") == null ? "listar" : request.getParameter("a");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        RequestDispatcher view;

        switch (action) {
            //Crear Incidencia
            case "crearInci":
                String nombreIncidencia = request.getParameter("nombreIncidencia");
                String lugar = request.getParameter("lugarIncidencia");
                String referencia = request.getParameter("referencia");
                String descripcionIncidencia = request.getParameter("descripcion");
                String phoneNumber = request.getParameter("contacto");
                boolean ambulancia = Boolean.parseBoolean(request.getParameter("ambulancia"));

                Part filePart = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream foto = null;
                if (filePart != null && filePart.getSize() > 0) {
                    foto = filePart.getInputStream(); // Lee el contenido del archivo como un InputStream
                }

                String tipoIncidencia = request.getParameter("tipo");
                System.out.println(tipoIncidencia);
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

                Incidencia nuevaIncidencia = new Incidencia();

                nuevaIncidencia.setNombreIncidencia(nombreIncidencia);
                nuevaIncidencia.setLugar(lugar);
                nuevaIncidencia.setReferencia(referencia);
                nuevaIncidencia.setDescripcion(descripcionIncidencia);
                nuevaIncidencia.setContacto(phoneNumber);
                nuevaIncidencia.setRequiereAmbulancia(ambulancia);
                nuevaIncidencia.setFotoIncidencia(foto);
                nuevaIncidencia.setIdTipoIncidencia(tipoIncidencia);
                nuevaIncidencia.setIdUsuario(idUsuario);

                incidenciaDao.crearIncidencia(nuevaIncidencia);
                System.out.println(nuevaIncidencia.getNombreIncidencia());
                System.out.println(nuevaIncidencia.getLugar());
                System.out.println(nuevaIncidencia.getReferencia());
                System.out.println(nuevaIncidencia.getDescripcion());
                System.out.println(nuevaIncidencia.getContacto());
                System.out.println(nuevaIncidencia.getIdTipoIncidencia());
                System.out.println(nuevaIncidencia.getIdUsuario());
                response.sendRedirect(request.getContextPath() + "/Coordis?action=listain&idUsuario" + idUsuario);

                break;
            //Crear Evento
            case "agregarev":
                Evento evento = new Evento();
                EventoDao eventoDao = new EventoDao();
                evento.setNombre(request.getParameter("nombre"));
                evento.setDescripcion(request.getParameter("descripcion"));
                evento.setMateriales(request.getParameter("materiales"));
                evento.setLugar(request.getParameter("lugar2"));
                evento.setNombreProfesor(request.getParameter("nombreProfesor"));
                evento.setVacantes(Integer.parseInt(request.getParameter("vacantes")));
                evento.setFechaInicial(Date.valueOf(request.getParameter("fechaInicial")));
                evento.setFechaFinal(Date.valueOf(request.getParameter("fechaFinal")));
                evento.setHora(Time.valueOf(request.getParameter("hora")));
                evento.setFrecuencia(Integer.parseInt(request.getParameter("frecuencia")));
                /*evento.setFoto(request.getParameter("foto2"));*/
                eventoDao.crearEvento(evento);
                response.sendRedirect(request.getContextPath() + "/Coordis");




        }
    }


}
