package com.example.grupo2.Servlet;

import com.example.grupo2.Beans.CantidadIncidencias;
import com.example.grupo2.Beans.Incidencia;
import com.example.grupo2.daos.IncidenciaDao;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Part;

import javax.swing.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;

@MultipartConfig
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
                //detalle de incidencia para coordi
            case "detallar3":
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
            //para que el vecino cree una incidencia
            case "formCrear":
                view = request.getRequestDispatcher("/VecinosJSPS/reportarIncidencia-Vecino.jsp");
                view.forward(request, response);
                break;

            //Este case será en caso pasemos lo que es la parte de incidencias de CoordisServlet acá (es muy probable)
            case "formCrear2":
                view = request.getRequestDispatcher("/CoordinadorasJSPS/ReportarIncidenciaVerisonPRUEBA.jsp");
                view.forward(request, response);
                break;

            //para que el vecino pueda ver sus incidencias
            case "lista3":
                String idUsuario = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidencias3 = incidenciaDao.listarIncidenciasDeUnUsuario(idUsuario);
                request.setAttribute("incidencia", listaIncidencias3);

                view = request.getRequestDispatcher("/VecinosJSPS/listaIncidencias-Vecino.jsp");
                view.forward(request, response);
                break;

            //Este case será en caso pasemos lo que es la parte de incidencias de CoordisServlet acá (es muy probable)
            //Para que la coordinadora visualice sus incidencias
            case "listaCoordi":
                String idCoordi = request.getParameter("idUsuario");
                ArrayList<Incidencia> listaIncidenciasCoordi = incidenciaDao.listarIncidenciasDeUnUsuario(idCoordi);
                request.setAttribute("incidencia", listaIncidenciasCoordi);

                view = request.getRequestDispatcher("/CoordinadorasJSPS/ListaDeIncidencias.jsp");
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
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=lista3&idUsuario=" + idUsuario);

                break;

            //Para que coordinadora cree su incidencia
            case "crear2":
                String nombreIncidencia2 = request.getParameter("nombreIncidencia");
                String lugar2 = request.getParameter("lugarIncidencia");
                String referencia2 = request.getParameter("referencia");
                String descripcionIncidencia2 = request.getParameter("descripcion");
                String phoneNumber2 = request.getParameter("contacto");
                boolean ambulancia2 = Boolean.parseBoolean(request.getParameter("ambulancia"));

                Part filePart2 = request.getPart("imagen"); // Obtén la parte del archivo
                InputStream foto2 = null;
                if (filePart2 != null && filePart2.getSize() > 0) {
                    foto2 = filePart2.getInputStream(); // Lee el contenido del archivo como un InputStream
                }

                String tipoIncidencia2 = request.getParameter("tipo");
                System.out.println(tipoIncidencia2);
                int idUsuario2 = Integer.parseInt(request.getParameter("idUsuario"));

                Incidencia nuevaIncidencia2 = new Incidencia();

                nuevaIncidencia2.setNombreIncidencia(nombreIncidencia2);
                nuevaIncidencia2.setLugar(lugar2);
                nuevaIncidencia2.setReferencia(referencia2);
                nuevaIncidencia2.setDescripcion(descripcionIncidencia2);
                nuevaIncidencia2.setContacto(phoneNumber2);
                nuevaIncidencia2.setRequiereAmbulancia(ambulancia2);
                nuevaIncidencia2.setFotoIncidencia(foto2);
                nuevaIncidencia2.setIdTipoIncidencia(tipoIncidencia2);
                nuevaIncidencia2.setIdUsuario(idUsuario2);

                incidenciaDao.crearIncidencia(nuevaIncidencia2);
                System.out.println(nuevaIncidencia2.getNombreIncidencia());
                System.out.println(nuevaIncidencia2.getLugar());
                System.out.println(nuevaIncidencia2.getReferencia());
                System.out.println(nuevaIncidencia2.getDescripcion());
                System.out.println(nuevaIncidencia2.getContacto());
                System.out.println(nuevaIncidencia2.getIdTipoIncidencia());
                System.out.println(nuevaIncidencia2.getIdUsuario());
                response.sendRedirect(request.getContextPath() + "/IncidenciaServlet?action=listaCoordi&idUsuario=" + idUsuario2);

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
