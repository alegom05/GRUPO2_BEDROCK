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
@WebServlet(name = "Sereno", value = "/Sereno")
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
                if (usuarioDao.listarPorId(Integer.parseInt(id)) != null) {
                    Usuario usuario = usuarioDao.listarPorId(Integer.parseInt(id));
                    if (usuario != null) {
                        request.setAttribute("usuarioSerenazgo", usuario);

                        view = request.getRequestDispatcher("/SerenazgoJSPS/actualizarInfo-Serenazgo.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                } else {
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
            //Vista Detallar Incidencia
            case "detallar":
                String id2 = request.getParameter("id");
                if (incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id2)) != null) {
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id2));
                    if (incidencia != null) {
                        request.setAttribute("incidencia", incidencia);

                        String estado = incidencia.getEstadoIncidencia();
                        request.setAttribute("mostrarEvaluar", "Nueva".equals(estado));
                        request.setAttribute("mostrarVerEvaluacion", "En proceso".equals(estado));
                        request.setAttribute("mostrarFalsaAlarma", "Nueva".equals(estado) || "En proceso".equals(estado));
                        request.setAttribute("mostrarCerrar", "En proceso".equals(estado));

                        /*view = request.getRequestDispatcher("/SerenazgoJSPS/detallesIncidencia-Serenazgo.jsp");
                        request.getSession().setAttribute("incidenciaParaExportar", incidencia);

                        view.forward(request, response);*/
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                } else {
                    response.sendRedirect("error.jsp");
                }
                /*view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);*/
                break;
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        RequestDispatcher view;

        switch (action) {
            case "borrar":
                String id = request.getParameter("id");
                String descripcion = request.getParameter("descripcion");
                if (id != null && descripcion != null) {
                    incidenciaDao.borrarIncidencia(id, descripcion);
                }
                //response.sendRedirect(request.getContextPath() + "/Sereno?action=lista");

                break;
            case "falsaAlarma":
                String idIncidencia = request.getParameter("idIncidencia");
                if (idIncidencia != null) {
                    incidenciaDao.editarEstadoFalsaAlarma(idIncidencia);
                    //response.sendRedirect(request.getContextPath() + "/Sereno?action=lista");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;

            case "incidenciaCerrada":
                String idIncidencia2 = request.getParameter("idIncidencia");
                if (idIncidencia2 != null) {
                    incidenciaDao.editarEstadoCerrado(idIncidencia2);
                    //response.sendRedirect(request.getContextPath() + "/Sereno?action=lista");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;
            //Vista Evaluar Incidencia
            case "evaluar":
                String criticidad = request.getParameter("criticidad");
                boolean requiereBomberos = Boolean.parseBoolean(request.getParameter("requiereBomberos"));
                boolean requierePolicia = Boolean.parseBoolean(request.getParameter("requierePolicia"));
                boolean requiereAmbulancia = Boolean.parseBoolean(request.getParameter("requiereAmbulancia"));
                String personalRefuerzo = request.getParameter("personalRefuerzo");
                String descripcionSolucion = request.getParameter("descripcionSolucion");
                String idIncidenciaEvaluacion = request.getParameter("id");

                Incidencia incidencia = new Incidencia();

                incidencia.setCriticidad(criticidad);
                incidencia.setRequiereBomberos(requiereBomberos);
                incidencia.setRequierePolicia(requierePolicia);
                incidencia.setRequiereAmbulancia(requiereAmbulancia);
                incidencia.setPersonalRefuerzo(personalRefuerzo);
                incidencia.setDescripcionSolucion(descripcionSolucion);
                incidencia.setIdIncidencia(Integer.parseInt(idIncidenciaEvaluacion));


                incidenciaDao.evaluarIncidencias(incidencia);
                //response.sendRedirect(request.getContextPath() + "/Sereno");

                break;

        }
    }
}
