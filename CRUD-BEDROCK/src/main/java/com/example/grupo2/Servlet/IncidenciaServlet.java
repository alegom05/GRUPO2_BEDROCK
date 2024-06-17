package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.CantidadIncidencias;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.daos.IncidenciaDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

@WebServlet(name = "IncidenciaServlet",value = {"/IncidenciaServlet","/Incidencias"})
public class IncidenciaServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        RequestDispatcher view;

        switch (action) {
            case "lista":
                ArrayList<Incidencia> listaIncidencias = incidenciaDao.listarIncidencias();
                request.setAttribute("lista", listaIncidencias);

                view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);
                break;
            case "detallar":
                String id = request.getParameter("id");
                if(incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id)) != null){
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id));
                    if (incidencia != null) {
                        request.setAttribute("incidencia", incidencia);

                        String estado = incidencia.getEstadoIncidencia();
                        request.setAttribute("mostrarEvaluar", "Nueva".equals(estado));
                        request.setAttribute("mostrarVerEvaluacion", "En proceso".equals(estado));
                        request.setAttribute("mostrarFalsaAlarma", "Nueva".equals(estado) || "En proceso".equals(estado));
                        request.setAttribute("mostrarCerrar","En proceso".equals(estado));


                        view = request.getRequestDispatcher("/SerenazgoJSPS/detallesIncidencia-Serenazgo.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);
                break;

            case "lista2":

                ArrayList<Incidencia> listaIncidencias2 = IncidenciaDao.listarIncidencias();
                request.setAttribute("lista2", listaIncidencias2);

                RequestDispatcher view2 = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
                view2.forward(request, response);
                break;
            case "detallar2":
                String id2 = request.getParameter("id");
                if(incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id2)) != null){
                    Incidencia incidencia = incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(id2));
                    if (incidencia != null) {
                        request.setAttribute("incidencia", incidencia);

                        String estado = incidencia.getEstadoIncidencia();
                        request.setAttribute("mostrarEvaluar", "Nueva".equals(estado));
                        request.setAttribute("mostrarVerEvaluacion", "En proceso".equals(estado));
                        request.setAttribute("mostrarFalsaAlarma", "Nueva".equals(estado) || "En proceso".equals(estado));
                        request.setAttribute("mostrarCerrar","En proceso".equals(estado));


                        view = request.getRequestDispatcher("/SerenazgoJSPS/detallesIncidencia-Serenazgo.jsp");
                        view.forward(request, response);
                    } else {
                        response.sendRedirect("error.jsp"); // Página de error en caso de que no se encuentre la incidencia
                    }
                }else{
                    response.sendRedirect("error.jsp");
                }

                view = request.getRequestDispatcher("/SerenazgoJSPS/tablaIncidencias-Serenazgo.jsp");
                view.forward(request, response);
                break;

            case "formCrear":
                view = request.getRequestDispatcher("/VecinosJSPS/reportarIncidencia-Vecino.jsp");
                view.forward(request, response);
                break;

            case "lista3":
                String idUsuario = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidencias3 = incidenciaDao.listarIncidenciasDeUnUsuario(idUsuario);
                request.setAttribute("incidencia", listaIncidencias3);

                view = request.getRequestDispatcher("/VecinosJSPS/listaIncidencias-Vecino.jsp");
                view.forward(request, response);
                break;

            //Borrado físico ahora se usa un borrado lógico
            /*case "borrar":
                String idd = request.getParameter("id");
                if(incidenciaDao.obtenerIncidenciaPorId(Integer.parseInt(idd)) != null){
                    incidenciaDao.borrarIncidencia(idd); //Agregar método a Daos
                }
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet");
                break;*/

            case "estadisticalizar":
                CantidadIncidencias cantidadIncidencias = incidenciaDao.hallarCantidadIncidencias();
                request.setAttribute("cantidad", cantidadIncidencias);

                view = request.getRequestDispatcher("/SerenazgoJSPS/dashboard-Serenazgo.jsp");
                view.forward(request, response);
                break;


        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action") == null ? "lista" : request.getParameter("action");
        IncidenciaDao incidenciaDao = new IncidenciaDao();
        RequestDispatcher view;

        switch(action) {
            case "crear":
                String nombreIncidencia = request.getParameter("nombreIncidencia");
                String lugar = request.getParameter("lugarIncidencia");
                String referencia = request.getParameter("referencia");
                String descripcionIncidencia = request.getParameter("descripcion");
                String phoneNumber = request.getParameter("contacto");
                boolean ambulancia = Boolean.parseBoolean(request.getParameter("ambulancia"));

                //byte [] foto = new byte[]{Byte.parseByte(request.getParameter("imagen"))};
                String tipoIncidencia = request.getParameter("tipo");
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

                Incidencia nuevaIncidencia = new Incidencia();
                nuevaIncidencia.setNombreIncidencia(nombreIncidencia);
                nuevaIncidencia.setLugar(lugar);
                nuevaIncidencia.setReferencia(referencia);
                nuevaIncidencia.setDescripcion(descripcionIncidencia);
                nuevaIncidencia.setContacto(phoneNumber);
                nuevaIncidencia.setRequiereAmbulancia(ambulancia);
                nuevaIncidencia.setFotoIncidencia(null);
                if(tipoIncidencia.equalsIgnoreCase("Accidente")){
                    tipoIncidencia = "AC";
                } else if (tipoIncidencia.equalsIgnoreCase("Alteracion_del_orden")) {
                    tipoIncidencia = "AL";
                } else if (tipoIncidencia.equalsIgnoreCase("Emergencia_medica")) {
                    tipoIncidencia = "EM";
                } else if (tipoIncidencia.equalsIgnoreCase("Robo")) {
                    tipoIncidencia = "RO";
                } else {
                    tipoIncidencia = "OT";
                }
                nuevaIncidencia.setTipoIncidencia(tipoIncidencia);
                nuevaIncidencia.setIdUsuario(idUsuario);

                incidenciaDao.crearIncidencia(nuevaIncidencia);

                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=lista3?idUsuario=" + idUsuario);

                break;
            case "borrar":
                String id = request.getParameter("id");
                String descripcion = request.getParameter("descripcion");

                if (id != null && descripcion != null) {
                    incidenciaDao.borrarIncidencia(id, descripcion);
                }
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=lista");

                break;

            case "falsaAlarma":
                String idIncidencia = request.getParameter("idIncidencia");
                if (idIncidencia != null) {
                    incidenciaDao.editarEstadoFalsaAlarma(idIncidencia);
                    response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=lista");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;

            case "incidenciaCerrada":
                String idIncidencia2 = request.getParameter("idIncidencia");
                if (idIncidencia2 != null) {
                    incidenciaDao.editarEstadoCerrado(idIncidencia2);
                    response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=lista");
                }else{
                    response.sendRedirect("error.jsp");
                }
                break;

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
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet");

                break;
        }
    }
}
